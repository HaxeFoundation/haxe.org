
## 2021-02-09 4.2.0:

__New features__:

* all : implemented "classic" abstract classes and functions (see [haxe-evolution#69](https://github.com/HaxeFoundation/haxe-evolution/pull/69)) ([#9716](https://github.com/HaxeFoundation/haxe/issues/9716))
* all : module-level static declarations ([#8460](https://github.com/HaxeFoundation/haxe/issues/8460))
* all : implemented rest arguments (variadic functions) for all targets with `haxe.Rest` type ([#9961](https://github.com/HaxeFoundation/haxe/issues/9961))
* all : per-thread event loops `sys.thread.Thread.events` ([#9868](https://github.com/HaxeFoundation/haxe/issues/9868))
* all : added `@:inheritDoc` meta to inherit documentation for a type or field from another type or field ([#9817](https://github.com/HaxeFoundatio9817n/haxe/issues/))
* all : support method overloading for extern methods on all targets ([#9793](https://github.com/HaxeFoundation/haxe/issues/9793))
* all : constructors forwarding for abstracts with `@:forward.new` ([#9735](https://github.com/HaxeFoundation/haxe/issues/9735))
* all : added `EIs` constructor to `haxe.macro.Expr` ([#9689](https://github.com/HaxeFoundation/haxe/issues/9689))
* all : added variance forwarding with `@:forward.variance` ([#9741](https://github.com/HaxeFoundation/haxe/issues/9741))
* all : treat `Any` as `Dynamic` in variance unification ([#6649](https://github.com/HaxeFoundation/haxe/issues/6649))
* all : added some common exception types to `haxe.exceptions` package
* all : support metadata in var declaration syntax ([#9618](https://github.com/HaxeFoundation/haxe/issues/9618))
* all : added `StringTools.unsafeCharAt` ([#9467](https://github.com/HaxeFoundation/haxe/issues/9467))
* eval : added libuv bindings under `eval.luv` package ([#9903](https://github.com/HaxeFoundation/haxe/issues/9903))
* eval : added bindings to native `Int64` and `UInt64` implementations under `eval.integers` package ([#9903](https://github.com/HaxeFoundation/hax9903e/issues/))
* cs : UDP socket implementation ([#8498](https://github.com/HaxeFoundation/haxe/issues/8498))
* cs : added `cs.Syntax` module ([#10051](https://github.com/HaxeFoundation/haxe/issues/10051))
* jvm : added `-D jvm.dynamic-level` to control the amount of dynamic support code being generated. 0 = none, 1 = field read/write optimization (default), 2 = compile-time method closures
* java,jvm : support `--java-lib <directory>` ([#9551](https://github.com/HaxeFoundation/haxe/issues/9551))
* python : threading API implementation ([#9754](https://github.com/HaxeFoundation/haxe/issues/9754))

__General improvements__:

* all : `expr is SomeType` doesn't require parentheses anymore ([#9672](https://github.com/HaxeFoundation/haxe/issues/9672))
* all : increased priority of @:using extensions ([#9681](https://github.com/HaxeFoundation/haxe/issues/9681))
* all : allowed usage of static extensions with super ([#10062](https://github.com/HaxeFoundation/haxe/issues/10062))
* all : allow @:noDoc on fields too ([#9893](https://github.com/HaxeFoundation/haxe/issues/9893))
* all : made `Map` abstract transitive ([#9877](https://github.com/HaxeFoundation/haxe/issues/9877))
* all : support `@:native` on enum constructors ([#9806](https://github.com/HaxeFoundation/haxe/issues/9806))
* all : support `@:using` on typedefs ([#9749](https://github.com/HaxeFoundation/haxe/issues/9749))
* all : changed multiline errors format to use "..." as a prefix for subsequent lines ([#9651](https://github.com/HaxeFoundation/haxe/issues/9651))
* all : improved type inference with constrained monomorphs ([#9549](https://github.com/HaxeFoundation/haxe/issues/9549))
* all : print no-argument function types as `()->...` instead of `Void->...` ([#8148](https://github.com/HaxeFoundation/haxe/issues/8148))
* all : allow `function` as package name
* all : improved object inlining ([#9599](https://github.com/HaxeFoundation/haxe/issues/9599))
* display : narrow range for hover on parametrized types ([#8073](https://github.com/HaxeFoundation/haxe/issues/8073))
* cs : added .NET 5.0 support ([#10043](https://github.com/HaxeFoundation/haxe/issues/10043))
* cpp : support native constructors on extern classes ([#9516](https://github.com/HaxeFoundation/haxe/issues/9516))
php: `php.Syntax.customArrayDecl` ([#9113](https://github.com/HaxeFoundation/haxe/issues/9113))
* php : added externs for various php functions and classes
* php : optimized anonymous objects instantiation ([#7916](https://github.com/HaxeFoundation/haxe/issues/7916))
* hl : skip compilation if no module has been changed ([#9922](https://github.com/HaxeFoundation/haxe/issues/9922))
* lua : use hx-lua-simdjson for Lua json parsing ([#9885](https://github.com/HaxeFoundation/haxe/issues/9885))
* jvm : less CPU consuming `sys.thread.Lock` implementation

__Bugfixes__:

* all : fixed Template.resolve when current context is not an object ([#9372](https://github.com/HaxeFoundation/haxe/issues/9372))
* all : `get` and `set` functions of `haxe.io.Float64Array` actually use 64-bit floats now ([#9972](https://github.com/HaxeFoundation/haxe/issues/9972))
* all : treat empty blocks `{}` as object declarations in array comprehension (fixes #9971)
* all : `haxe.format.JsonParser`: preserve Float-typed values when they are written as such in JSON (ie. "5.0" or "0.0") ([#9844](https://github.co9844m/HaxeFoundation/haxe/issues/))
* all : fixed priority of forwarded static extensions ([#9680](https://github.com/HaxeFoundation/haxe/issues/9680))
* all : fixed some inconsistency in variance unification for abstracts ([#9743](https://github.com/HaxeFoundation/haxe/issues/9743))
* display : fixed completion with platform-specific files ([#9423](https://github.com/HaxeFoundation/haxe/issues/9423))
* cpp : fixed conversion of `cpp.Int64` to/from `haxe.Int64` ([#10101](https://github.com/HaxeFoundation/haxe/issues/10101))
* cpp : fixed extending extern classes with `@:nativeGen` classes ([#9431](https://github.com/HaxeFoundation/haxe/issues/9431))
* php : fixed generation with subdirectories in `-D php-front=subdir/index.php` ([#10037](https://github.com/HaxeFoundation/haxe/issues/10037))
* php : fixed local vars with the same names as super global vars ([#9924](https://github.com/HaxeFoundation/haxe/issues/9924))
* eval : allow full range of 32bit integers in `Std.random` ([#9974](https://github.com/HaxeFoundation/haxe/issues/9974))
* js : fixed `haxe.CallStack.exceptionStack` ([#9968](https://github.com/HaxeFoundation/haxe/issues/9968))
* js : fixed compatibility issue with closure compiler upon unused `catch` vars ([#9617](https://github.com/HaxeFoundation/haxe/issues/9617))
* lua : fixed anonymous object printing issue with null fields on tables
* hl : drop data of terminated threads ([#9875](https://github.com/HaxeFoundation/haxe/issues/9875))
* macro : fixed `haxe.macro.Context.storeTypedExpr` for enum constructs ([#9828](https://github.com/HaxeFoundation/haxe/issues/9828))
* macro : emit a deprecation warning upon a macro call instead of upon a macro function declaration ([#9425](https://github.com/HaxeFoundation/hax9425e/issues/))
* macro : fixed uncatchable error from `haxe.macro.Context.getType` ([#9449](https://github.com/HaxeFoundation/haxe/issues/9449))
* jvm : fixed `Type.resolveEnum` for enums in the root package ([#9809](https://github.com/HaxeFoundation/haxe/issues/9809))
* jvm : fixed `Type.resolveEnumName` for enums in the root package ([#9759](https://github.com/HaxeFoundation/haxe/issues/9759))
* cs : fixed cs.Lib.rethrow ([#9738](https://github.com/HaxeFoundation/haxe/issues/9738))
* nullsafety : respect `@:nullSafety(Off)` on var declarations: `var @:nullSafety(Off) v`
* nullsafety : respect `@:nullSafety(Off)` in closures in constructors ([#9643](https://github.com/HaxeFoundation/haxe/issues/9643))
* nullsafety : fixed error "Type not found : haxe.macro._Compiler.NullSafetyMode_Impl_" ([#9483](https://github.com/HaxeFoundation/haxe/issues/9483))