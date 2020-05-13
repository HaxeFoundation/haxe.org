
## 2020-05-13: 4.1.0

__New features__:

* all : added tail recursion elimination ([#8908](https://github.com/HaxeFoundation/haxe/issues/8908))
* all : added unified exception handling ([#9124](https://github.com/HaxeFoundation/haxe/issues/9124))
* all : allow `try {} catch(e) {}` as a shortcut for `try {} catch(e:haxe.Exception) {}` ([#9269](https://github.com/HaxeFoundation/haxe/issues/9269))
* eval : added SSL support ([#9009](https://github.com/HaxeFoundation/haxe/issues/9009))
* jvm : the JVM target is no longer considered experimental

__General improvements__:

* all : implemented different display support approach ([#8962](https://github.com/HaxeFoundation/haxe/issues/8962))
* all : improved display services related to reference finding
* all : added go-to-implementation support ([#9043](https://github.com/HaxeFoundation/haxe/issues/9043))
* all : made various improvements to diagnostics
* all : support completion for map keys ([#9133](https://github.com/HaxeFoundation/haxe/issues/9133))
* all : improved parser robustness for incomplete syntax ([#9148](https://github.com/HaxeFoundation/haxe/issues/9148))
* all : disallowed the combination of `@:overload` and inline ([#3846](https://github.com/HaxeFoundation/haxe/issues/3846))
* all : improved renaming of local variables ([#9304](https://github.com/HaxeFoundation/haxe/issues/9304))
* all : better inlining of for-loops with anonymous iterators ([#8848](https://github.com/HaxeFoundation/haxe/issues/8848))
* all : remove redundant final `return` in `Void` functions ([#6420](https://github.com/HaxeFoundation/haxe/issues/6420))
* all : remove redundant `continue` in loops ([#8952](https://github.com/HaxeFoundation/haxe/issues/8952))
* all : improved various compilation errors reporting
* all : allowed `(get,default)` property access combination (#6195, #8825)
* all : allowed ++ and -- on member properties of abstracts ([#8930](https://github.com/HaxeFoundation/haxe/issues/8930))
* js : use abstract type name for generating its implementation class ([#9006](https://github.com/HaxeFoundation/haxe/issues/9006))
* js : improve haxe.ds.StringMap implementation ([#8909](https://github.com/HaxeFoundation/haxe/issues/8909))
* js : improve interface checking and make it more minifier-friendly ([#9178](https://github.com/HaxeFoundation/haxe/issues/9178))
* js : generate `let` instead of `var` when compiler with `-D js-es=6` ([#9280](https://github.com/HaxeFoundation/haxe/issues/9280))
* js : optimize `.bind` on constructors ([#9227](https://github.com/HaxeFoundation/haxe/issues/9227))
* jvm : rewrote function handling to me much faster and more portable ([#9208](https://github.com/HaxeFoundation/haxe/issues/9208))
* jvm : generate interfaces for typedefs for improved performance ([#9195](https://github.com/HaxeFoundation/haxe/issues/9195))
* jvm : added support for haxe.MainLoop
* jvm : support `@:jvm.synthetic` and use it to hide some generated fields ([#9213](https://github.com/HaxeFoundation/haxe/issues/9213))
* jvm : respect `@:private` and `@:protected`
* lua : improve error handling behavior when throwing objects/instances
* lua : optimize `haxe.iterators.StringIterator`
* php : optimize `Std.isOfType` for String, Bool and Float
* php : make Haxe Array implement native interfaces Iterator, IteratorAggregate, Countable (#8821, 9377)
* cs : support `@:assemblyMeta` and `@:assemblyStrict` ([#8347](https://github.com/HaxeFoundation/haxe/issues/8347))
* python : added `__contains__` and `__getitem__` implementations to generated python code for `_hx_AnonObject`, so it is subscribable and behaves like a python dict ([#9109](https://github.com/HaxeFoundation/haxe/issues/9109))

__Standard Library__:

* all : negative `startIndex` argument of `String.indexOf` and `String.lastIndexOf` is unspecified ([#8365](https://github.com/HaxeFoundation/haxe/issues/8365))
* all : changed Array.iterator() to return instances of haxe.iterators.ArrayIterator ([#8987](https://github.com/HaxeFoundation/haxe/issues/8987))
* all : added Array.contains ([#9179](https://github.com/HaxeFoundation/haxe/issues/9179))
* all : added Array.keyValueIterator ([#7422](https://github.com/HaxeFoundation/haxe/issues/7422))
* all : added haxe.Constraints.NotVoid ([#8357](https://github.com/HaxeFoundation/haxe/issues/8357))
* all : added Lambda.findIndex() ([#9071](https://github.com/HaxeFoundation/haxe/issues/9071))
* all : added Lambda.foldi() ([#9054](https://github.com/HaxeFoundation/haxe/issues/9054))
* all : added array access and key-value iteration support to haxe.ds.HashMap ([#9056](https://github.com/HaxeFoundation/haxe/issues/9056))
* jvm : added JVM-specific versions of sys.thread.Lock and sys.thread.Thread
* jvm : added JVM-specific version of haxe.ds.StringMap
* java/jvm : use native versions of MD-5, SHA-1 and SHA-256 for `haxe.crypto` modules ([#9298](https://github.com/HaxeFoundation/haxe/issues/9298))
* macro : added haxe.macro.Context.containsDisplayPosition(pos) ([#9077](https://github.com/HaxeFoundation/haxe/issues/9077))
* nullsafety : treat Strict as a single-threaded mode; added StrictThreaded ([#8895](https://github.com/HaxeFoundation/haxe/issues/8895))

__Deprecations__:

* all : deprecated `Std.is`; use `Std.isOfType` instead ([#2976](https://github.com/HaxeFoundation/haxe/issues/2976))
* all : added a warning for an uninitialized variable usage captured in a closure ([#7447](https://github.com/HaxeFoundation/haxe/issues/7447))
* js : deprecated `untyped __js__(code, args)`; use `js.Syntax.code(code, args)` instead
* php/neko : deprecated neko.Web and php.Web; will be moved to hx4compat library later ([#9153](https://github.com/HaxeFoundation/haxe/issues/9153))

__Bugfixes__:

* all : fixed display support for static imports ([#9012](https://github.com/HaxeFoundation/haxe/issues/9012))
* all : fixed completion in macro mode picking up the wrong type ([#7703](https://github.com/HaxeFoundation/haxe/issues/7703))
* all : fixed wonky analyzer transformation related to locals captured in closures ([#9305](https://github.com/HaxeFoundation/haxe/issues/9305))
* all : allow `return;` in abstract constructors ([#7809](https://github.com/HaxeFoundation/haxe/issues/7809))
* all : fixed static @:op([]) functions ([#9347](https://github.com/HaxeFoundation/haxe/issues/9347))
* all : fixed `@:optional` handling in the inheritance of `@:structInit` classes ([#7559](https://github.com/HaxeFoundation/haxe/issues/7559))
* all : support negative numbers as constant type parameters for `@:generic` types ([#9149](https://github.com/HaxeFoundation/haxe/issues/9149))
* all : fixed false positive compilation server error with empty methods in inheritance ([#9029](https://github.com/HaxeFoundation/haxe/issues/9029))
* all : fixed default values for manually defined @:structInit constructors (#9177, #9258)
* all : fixed inference of `Void` return type for arrow functions ([#9181](https://github.com/HaxeFoundation/haxe/issues/9181))
* all : fixed inconsistencies in wildcard imports resolution (#9189, #9190)
* all : fix array comprehension for a chain of `if..else if` without final `else` ([#9040](https://github.com/HaxeFoundation/haxe/issues/9040))
* all : prohibit @:structInit on interfaces ([#9017](https://github.com/HaxeFoundation/haxe/issues/9017))
* macro : fixed handling `TAnonymous` in `haxe.macro.TypeTools.map` ([#9147](https://github.com/HaxeFoundation/haxe/issues/9147))
* eval : fixed EReg.matchSub handling with negative length ([#9333](https://github.com/HaxeFoundation/haxe/issues/9333))
* eval : fixed extern classes being generated and causing errors in some cases ([#9366](https://github.com/HaxeFoundation/haxe/issues/9366))
* eval : fixed StringBuf.addSub unicode handling ([#9382](https://github.com/HaxeFoundation/haxe/issues/9382))
* jvm : fixed Void being generated with the wrong casing ([#8717](https://github.com/HaxeFoundation/haxe/issues/8717))
* jvm : fixed debugging-related data being generated in the wrong place
* jvm : fixed switches on string values being too optimistic
* jvm : fixed problems with Std.parseInt and Std.parseFloat
* jvm : made sure type parameter types are boxed
* jvm : fixed dynamic access on `null` yielding `null` ([#8452](https://github.com/HaxeFoundation/haxe/issues/8452))
* cpp : fixed native compilation if there is a `hx` package in a project ([#8543](https://github.com/HaxeFoundation/haxe/issues/8543))
* cs : fixed `null` to `0` conversion in parametrized functions for `Null<Int>` params ([#7428](https://github.com/HaxeFoundation/haxe/issues/7428))
* cs : fixed integer division handling ([#9232](https://github.com/HaxeFoundation/haxe/issues/9232))
* php : fixed closure creation out of fields with `null` value ([#9316](https://github.com/HaxeFoundation/haxe/issues/9316))
* js : fixed interface generation for minification with Google Closure Compiler in advanced mode ([#9172](https://github.com/HaxeFoundation/haxe/issues/9172))
* js : fixed a crash at startup in IE8 ([#9062](https://github.com/HaxeFoundation/haxe/issues/9062))
* hl : fixed BLOB handling in SQLite ([#9048](https://github.com/HaxeFoundation/haxe/issues/9048))
