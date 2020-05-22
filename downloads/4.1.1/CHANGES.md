
## 2020-22-05 4.1.1

__New features__:

* jvm : added `--jvm path/to.jar` CLI argument

__Bugfixes__:

* all : fixed arguments ordering for @:structInit constructors ([#9418](https://github.com/HaxeFoundation/haxe/issues/9418))
* all : fixed display/references completion server request for static fields ([#9440](https://github.com/HaxeFoundation/haxe/issues/9440))
* all : fixed "Module not found" error reporting during macro execution in display requests ([#9449](https://github.com/HaxeFoundation/haxe/issues/9449))
* all : fixed module name completion for target-specific modules like `Mod.js.hx` ([#9423](https://github.com/HaxeFoundation/haxe/issues/9423))
* all : fixed completion for packages named "function" ([#7697](https://github.com/HaxeFoundation/haxe/issues/7697))
* all : fixed recursive typedefs with optional arguments in `@:overload` functions ([#9455](https://github.com/HaxeFoundation/haxe/issues/9455))
* cpp : fixed StringTools.endsWith() for unicode characters ([#8980](https://github.com/HaxeFoundation/haxe/issues/8980))
* cpp : fixed broken externs in `cpp` package ([#9452](https://github.com/HaxeFoundation/haxe/issues/9452))
* js/cpp : fixed catch var naming collision ([#9413](https://github.com/HaxeFoundation/haxe/issues/9413))
* interp : fixed throwing `haxe.macro.Error` outside of a macro context ([#9390](https://github.com/HaxeFoundation/haxe/issues/9390))
* lua : fixed lua.PairTools.ipairsMap method
* php : fixed an edge case in String methods generation ([#9464](https://github.com/HaxeFoundation/haxe/issues/9464))