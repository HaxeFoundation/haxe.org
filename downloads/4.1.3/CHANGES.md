
## 2020-07-22 4.1.3

__General improvements__:

* all : added an error on `return` outside of a function ([#9659](https://github.com/HaxeFoundation/haxe/issues/9659))
* php : support @:native("") for extern classes ([#6448](https://github.com/HaxeFoundation/haxe/issues/6448))
* python : support @:native("") for extern classes ([#6448](https://github.com/HaxeFoundation/haxe/issues/6448))

__Bugfixes__:

* all : fixed compilation server bug caused by removing `inline` from a method ([#9690](https://github.com/HaxeFoundation/haxe/issues/9690))
* macro : fixed compiler crash if `@:genericBuild` meta is removed by a macro during building ([#9391](https://github.com/HaxeFoundation/haxe/issues/9391))
* jvm : fixed "--java-lib-extern" ([#9515](https://github.com/HaxeFoundation/haxe/issues/9515))
* flash : fixed var shadowing issue for variables captured in a closure inside of a loop ([#9624](https://github.com/HaxeFoundation/haxe/issues/9624))
* flash : fixed `VerifyError` exception when `Void` end up as an argument type after inlining ([#9678](https://github.com/HaxeFoundation/haxe/issues/9678))
* php : fixed runtime error "cannot use temporary expression in write context" for call arguments passed by reference
* cs : fixed `cs.Lib.rethrow` ([#9738](https://github.com/HaxeFoundation/haxe/issues/9738))
* nullsafety : fixed `@:nullSafety(Off)` in closures inside of constructors ([#9643](https://github.com/HaxeFoundation/haxe/issues/9643))
* nullsafety : fixed "Type not found NullSafetyMode_Impl_" ([#9483](https://github.com/HaxeFoundation/haxe/issues/9483))