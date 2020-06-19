
## 2020-06-19 4.1.2

__Bugfixes__:

* all : added `contains` and `keyValueIterator` methods to haxe.ds.ReadOnlyArray
* all : fixed super constructor call when extending externs ([#7837](https://github.com/HaxeFoundation/haxe/issues/7837), [#9501](https://github.com/HaxeFoundation/haxe/issues/9501))
* all : fixed compiler crash for "--run" argument without a value ([#9513](https://github.com/HaxeFoundation/haxe/issues/9513))
* all : fixed local variable name collision in `try..catch` ([#9533](https://github.com/HaxeFoundation/haxe/issues/9533))
* all : fixed memory leak in completion server related to haxe.Exception ([#9537](https://github.com/HaxeFoundation/haxe/issues/9537))
* display : fixed completion for out-of-bounds argument in a call ([#9435](https://github.com/HaxeFoundation/haxe/issues/9435))
* display : fixed "find references" through interfaces ([#9470](https://github.com/HaxeFoundation/haxe/issues/9470))
* display : optimized "find references" ([#9504](https://github.com/HaxeFoundation/haxe/issues/9504))
* display : optimized "server/invalidate" requests ([#9509](https://github.com/HaxeFoundation/haxe/issues/9509))
* analyzer : fixed compiler crash upon handling code branches with enums with optional arguments ([#9591](https://github.com/HaxeFoundation/haxe/issues9591/))
* jvm : added "--java-lib-extern" to use jar files as externs without adding them to the compiled project ([#9515](https://github.com/HaxeFoundatio9515n/haxe/issues/))
* macro : fixed type intersection syntax in macro reification ([#9404](https://github.com/HaxeFoundation/haxe/issues/9404))
* eval : fixed exception message when catching compiler-generated `haxe.macro.Error` as `Dynamic` ([#9600](https://github.com/HaxeFoundation/haxe/issue9600s/))
* lua : fixed lua code generation without `--main` compilation argument ([#9489](https://github.com/HaxeFoundation/haxe/issues/9489))
* php : added an overload signature for `session_set_cookie_params` function ([#9507](https://github.com/HaxeFoundation/haxe/issues/9507))
* js : fixed name collisions for catch variables to avoid closure compiler errors ([#9617](https://github.com/HaxeFoundation/haxe/issues/9617))
* nullsafety : fixed various scenarios of `if..else` branching ([#9474](https://github.com/HaxeFoundation/haxe/issues/9474))