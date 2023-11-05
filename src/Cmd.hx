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
		var process = new sys.io.Process(cmd, params);
		if (process.exitCode() != 0) {
			Sys.println(process.stdout.readAll().toString());
			Sys.println(process.stderr.readAll().toString());
			throw 'Error running $cmd $params';
		}
		process.close();
		#end
	}
}
