import haxe.*;

class RunCi {
	static function successMsg(msg:String):Void {
		Sys.println('\x1b[32m' + msg + '\x1b[0m');
	}
	static function failMsg(msg:String):Void {
		Sys.println('\x1b[31m' + msg + '\x1b[0m');
	}
	static function infoMsg(msg:String):Void {
		Sys.println('\x1b[36m' + msg + '\x1b[0m');
	}

	/**
		Run a command using `Sys.command()`.
		If the command exits with non-zero code, exit the whole script with the same code.

		If `useRetry` is `true`, the command will be re-run if it exits with non-zero code (3 trials).
		It is useful for running network-dependent commands.
	*/
	static function runCommand(cmd:String, ?args:Array<String>, useRetry:Bool = false, allowFailure:Bool = false):Void {
		var trials = useRetry ? 3 : 1;
		var exitCode:Int = 1;
		var cmdStr = cmd + (args == null ? '' : ' $args');

		while (trials-->0) {
			Sys.println('Command: $cmdStr');

			var t = Timer.stamp();
			exitCode = Sys.command(cmd, args);
			var dt = Math.round(Timer.stamp() - t);

			if (exitCode == 0)
				successMsg('Command exited with $exitCode in ${dt}s: $cmdStr');
			else
				failMsg('Command exited with $exitCode in ${dt}s: $cmdStr');

			if (exitCode == 0) {
				return;
			} else if (trials > 0) {
				Sys.println('Command will be re-run...');
			}
		}

		if (!allowFailure)
			Sys.exit(1);
	}

	static function deploy():Void {
		switch (Sys.getEnv("TRAVIS_BRANCH")) {
			case null:
				throw "unknown branch";
			case "master", "staging":
				//pass
			case _:
				Sys.println("branch is not master or staging, skip deploy");
				Sys.exit(0);
		}

		switch (Sys.getEnv("TRAVIS_TEST_RESULT")) {
			case "0":
				// pass
			case _:
				Sys.println("test failed, skip deploy");
				Sys.exit(0);
		}

		switch (Sys.getEnv("TRAVIS_PULL_REQUEST")) {
			case "false":
				// pass
			case _:
				Sys.println("it is a pull request build, skip deploy");
				Sys.exit(0);
		}

		switch ([
			Sys.getEnv("DOCKER_EMAIL"),
			Sys.getEnv("DOCKER_USERNAME"),
			Sys.getEnv("DOCKER_PASSWORD"),
		]) {
			case [null, _, _] | [_, null, _] | [_, _, null]:
				Sys.println('missing a docker env var, skip deploy');
				Sys.exit(0);
			case [
				docker_email,
				docker_username,
				docker_password
			]:
				if (Sys.command("docker", ["login", '-u=$docker_username', '-p=$docker_password']) != 0)
					throw "docker login failed";
		}

		var commit = Sys.getEnv("TRAVIS_COMMIT");
		var target = 'haxe/haxe.org:${commit}';
		runCommand("docker", ["tag", "haxeorg_web", target]);
		runCommand("docker", ["push", target]);

		sys.io.File.saveContent("Dockerrun.aws.json", Json.stringify({
			"AWSEBDockerrunVersion": "1",
			"Image": {
				"Name": target
			}
		}));
	}

	static function main():Void {
		switch (Sys.args()) {
			case ["deploy"]:
				deploy();
			case _:
				throw "missing command";
		}
	}
}