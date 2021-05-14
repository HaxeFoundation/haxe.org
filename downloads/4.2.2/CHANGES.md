
## 2021-05-14 4.2.2:

__Bugfixes__:

* all : fixed piping stdin/stdout in `--cmd` ([#4669](https://github.com/HaxeFoundation/haxe/issues/4669), [#6726](https://github.com/HaxeFoundation/haxe/issues/6726))
* all : fixed rest args typing for overloaded functions ([#10143](https://github.com/HaxeFoundation/haxe/issues/10143))
* all : fixed using `var` fields as static extensions ([#10144](https://github.com/HaxeFoundation/haxe/issues/10144))
* all : fixed completion for a type in `expr is Type` ([#10167](https://github.com/HaxeFoundation/haxe/issues/10167))
* all : fixed subtypes in `expr is Module.SubType` expressions ([#10174](https://github.com/HaxeFoundation/haxe/issues/10174))
* all : fixed typing chains of calls with constrained type params ([#10198](https://github.com/HaxeFoundation/haxe/issues/10198))
* all : fixed mixed constraints of anonymous structures and other types ([#10162](https://github.com/HaxeFoundation/haxe/issues/10162))
* all : fixed operator overloading for enum abstracts ([#10173](https://github.com/HaxeFoundation/haxe/issues/10173))
* hl : fixed debugging of `catch` blocks ([#10109](https://github.com/HaxeFoundation/haxe/issues/10109))
* jvm : fixed manifest generation for cases with a lot of jar libraries ([#10157](https://github.com/HaxeFoundation/haxe/issues/10157))
* js : fixed extending extern classes for es5 ([#10192](https://github.com/HaxeFoundation/haxe/issues/10192))
* js : fixed checking `this` before `super` for es6 ([#10193](https://github.com/HaxeFoundation/haxe/issues/10193))
* eval : fixed null pointer exception in `eval.NativeString.fromString(null)`
* eval : fixed multiple locks of `sys.thread.Mutex` from the same thread ([#10249](https://github.com/HaxeFoundation/haxe/issues/10249))