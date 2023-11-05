import js.node.ChildProcess;

class Cmd {
	static public function cmd(cmd:String, ?params:Array<String>):Void {
		Sys.println('run: $cmd ${params.join(" ")}');
		var result = ChildProcess.spawnSync(cmd, params == null ? [] : params, { shell: true });
		if (result.status != 0) {
			Sys.println(result.stdout);
			Sys.println(result.stderr);
			throw 'Error running $cmd $params';
		}
	}
}
