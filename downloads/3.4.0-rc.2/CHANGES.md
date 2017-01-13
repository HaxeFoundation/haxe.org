2016-12-24: 3.4.0-RC2

__New features__:

* js : added API documentation to HTML externs ([#5868](https://github.com/HaxeFoundation/haxe/issues/5868))
* php : added php7 target, enabled with `-D php7`

__Bugfixes__:

* all : fixed top-down inference infinite recursion issue ([#5848](https://github.com/HaxeFoundation/haxe/issues/5848))
* all : fixed regression in `Compiler.include` ([#5847](https://github.com/HaxeFoundation/haxe/issues/5847))
* all : fixed Not_found exception related to try/catch ([#5851](https://github.com/HaxeFoundation/haxe/issues/5851))
* all : fixed metadata completion showing up in trace arguments ([#5775](https://github.com/HaxeFoundation/haxe/issues/5775))
* all : fixed problem with useless pattern detection ([#5873](https://github.com/HaxeFoundation/haxe/issues/5873))
* all : fixed issue with toString handling in trace arguments ([#5858](https://github.com/HaxeFoundation/haxe/issues/5858))
* all : fixed inline constructor scoping ([#5855](https://github.com/HaxeFoundation/haxe/issues/5855))
* cpp : fixed issue with cpp.Pointer variables being eliminated ([#5850](https://github.com/HaxeFoundation/haxe/issues/5850))
* js : added Notification API to HTML externs ([#5852](https://github.com/HaxeFoundation/haxe/issues/5852))
* js : fixed several options structures in HTML externs ([#5849](https://github.com/HaxeFoundation/haxe/issues/5849))
* php/cs : `FileSystem.deleteFile()` and FileSystem.deleteDirectory() now throw on non-existent path ([#5742](https://github.com/HaxeFoundation/haxe/issues/5742))
* php/lua : fixed field access on `null` ([#4988](https://github.com/HaxeFoundation/haxe/issues/4988))
* php : fixed static field access on a `Class<T>` stored to a field ([#5383](https://github.com/HaxeFoundation/haxe/issues/5383))
* php : fixed invalid detection of `NativeArray` by `Std.is()` ([#5565](https://github.com/HaxeFoundation/haxe/issues/5565))
* php : fixed `stdin()`, `stdout()`, `stderr()` of `Sys` to use predefined constants for corresponding channels ([#5733](https://github.com/HaxeFoundation/haxe/issues/5733))
* php : fixed `Std.parseInt()` on hexstrings for PHP7+ ([#5521](https://github.com/HaxeFoundation/haxe/issues/5521))
* php : fixed typed cast in assign operations ([#5135](https://github.com/HaxeFoundation/haxe/issues/5135))
* php : fixed exception thrown by `Reflect.fields(o)` when `o` is `Class<T>` ([#5608](https://github.com/HaxeFoundation/haxe/issues/5608))
* php : fixed json encoding of empty objects ([#5015](https://github.com/HaxeFoundation/haxe/issues/5015))
* php : fixed checking floats for equality ([#4260](https://github.com/HaxeFoundation/haxe/issues/4260))
* php : throw if invalid json string supplied to `Json.parse()` ([#4592](https://github.com/HaxeFoundation/haxe/issues/4592))
* php : fixed ssl connections ([#4581](https://github.com/HaxeFoundation/haxe/issues/4581))
* php : fixed writing bytes containing zero byte to MySQL & SQLite ([#4489](https://github.com/HaxeFoundation/haxe/issues/4489))
* php : fixed `call()()` cases for PHP5 ([#5569](https://github.com/HaxeFoundation/haxe/issues/5569))
