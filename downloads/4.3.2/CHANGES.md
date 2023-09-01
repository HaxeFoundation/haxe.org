
## 2023-09-01 4.3.2

__General improvements__:

* all : do not raise error on no-op reification outside macro

__Bugfixes__:

* all : don't infer Null<?> if it already is Null<?> ([#11286](https://github.com/HaxeFoundation/haxe/issues/11286))
* all : fix ?? inference and precedence ([#11252](https://github.com/HaxeFoundation/haxe/issues/11252))
* all : bring back forced inline ([#11217](https://github.com/HaxeFoundation/haxe/issues/11217))
* all : allow non constant "inline" var init with -D no-inline ([#11192](https://github.com/HaxeFoundation/haxe/issues/11192))
* all : improve @:enum abstract deprecation warning handling ([#11302](https://github.com/HaxeFoundation/haxe/issues/11302))
* all : fix some stack overflow with pretty errors
* display : fix go to definition with final ([#11173](https://github.com/HaxeFoundation/haxe/issues/11173))
* display : fix completion requests with @:forwardStatics ([#11294](https://github.com/HaxeFoundation/haxe/issues/11294))
* eval : fix MainLoop.add not repeating ([#11202](https://github.com/HaxeFoundation/haxe/issues/11202))
* hl/eval/neko : fix exception stack when wrapping native exceptions ([#11249](https://github.com/HaxeFoundation/haxe/issues/11249))
* macro : map `this` when restoring typed expressions ([#11212](https://github.com/HaxeFoundation/haxe/issues/11212))
* macro : safe navigation fix for ExprTools.map ([#11204](https://github.com/HaxeFoundation/haxe/issues/11204))
* macro : safe navigation fix for haxe.macro.Printer ([#11206](https://github.com/HaxeFoundation/haxe/issues/11206))
* macro : macro generated EVars position fixes ([#11163](https://github.com/HaxeFoundation/haxe/issues/11163))
* macro : fix abstract casts for local statics ([#11301](https://github.com/HaxeFoundation/haxe/issues/11301))
* macro : add flags to TDAbstract to be able to construct enum abstracts ([#11230](https://github.com/HaxeFoundation/haxe/issues/11230))
* nullsafety : make break/continue expressions not-nullable ([#11269](https://github.com/HaxeFoundation/haxe/issues/11269))
* nullsafety : handle return in assignment ([#11114](https://github.com/HaxeFoundation/haxe/issues/11114))
