class Cmd {
	static public function cmd(cmd:String, ?params:Array<String>):Void {
		Sys.println('run: $cmd $params');
		var exitCode = Sys.command(cmd, params);
		if (exitCode != 0)
			throw 'Error running $cmd $params';
	}
}