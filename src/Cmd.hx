class Cmd {
	static public function cmd(cmd:String, ?params:Array<String>):Void {
		Sys.println('run: $cmd ${params.join(" ")}');

		#if nodejs
		var result = js.node.ChildProcess.spawnSync(cmd, params == null ? [] : params, { shell: true });
		if (result.status != 0) {
			Sys.println(result.stdout);
			Sys.println(result.stderr);
			throw 'Error running $cmd $params';
		}
		#else
		var exitCode = Sys.command(cmd, params);
		if (exitCode != 0) {
			throw 'Error running $cmd $params';
		}
		#end
	}
}
