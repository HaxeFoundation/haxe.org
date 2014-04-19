### 2014-04-13: __3.1.3__

__Bugfixes__:

* all : fixed handling of abstract variance
* flash : ensure correct endianess in haxe.io.BytesBuffer
* cpp : fixed issue involving class paths with spaces
* php : fixed >>>
* macro : fixed haxe.macro.Compiler.keep

__General improvements and optimizations__:

* all : give @:deprecated warnings by default, allow -D no-deprecation-warnings
* cpp : optimized Vector implementation

__Standard Library__:

* all : renamed Bytes.readDouble/Float to getDouble/Float to avoid inheritance issues
* all : deprecated Bytes.readString in favor of getString
* all : added pretty-printing to haxe.format.JsonPrinter (and haxe.Json)