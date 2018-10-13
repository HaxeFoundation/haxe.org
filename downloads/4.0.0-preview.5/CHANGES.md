
## 2018-10-13: 4.0.0-preview.5

__New features__:

* all : support Unicode strings properly on all targets
* all : support `for (key => value in e)` syntax for key-value iterators
* all : added keyValueIterator to Map and its implementations
* all : support loop-unrolling on `for (i in 0...5)` ([#7365](https://github.com/HaxeFoundation/haxe/issues/7365))
* all : added support for write-mode `@:op(a.b)`
* all : support `inline call()` and `inline new` expressions ([#7425](https://github.com/HaxeFoundation/haxe/issues/7425))
* all : support `@:using` on type declarations ([#7462](https://github.com/HaxeFoundation/haxe/issues/7462))
* all : support XML literal strings but require them to be macro-processed ([#7438](https://github.com/HaxeFoundation/haxe/issues/7438))
* all : allow enum values without arguments as default function argument values ([#7439](https://github.com/HaxeFoundation/haxe/issues/7439))
* lua : add -D lua-vanilla, which emits code with reduced functionality but no additional lib dependencies

__General improvements and optimizations__:

* all : [breaking] reserved `operator` and `overload` as keywords ([#7413](https://github.com/HaxeFoundation/haxe/issues/7413))
* all : made `final` on structure fields invariant ([#7039](https://github.com/HaxeFoundation/haxe/issues/7039))
* all : [breaking] disallowed static variables that have no type-hint and expression ([#6440](https://github.com/HaxeFoundation/haxe/issues/6440))
* all : added display/typeDefinition to display protocol ([#7266](https://github.com/HaxeFoundation/haxe/issues/7266))
* all : fixed various display-related problems
* all : made parser in display mode much more tolerant
* all : allowed assigning `[]` where `Map` is expected ([#7426](https://github.com/HaxeFoundation/haxe/issues/7426))
* all : unified various parts of the String API across all targets
* php : Optimized haxe.ds.Vector (VectorData is not Array anymore)
* php : Optimized `Map.copy()` and `Array.copy()`
* php : Optimized iterators of `Map` and native arrays.
* php : Support native PHP generators. See `php.Syntax.yield()` and `php.Generator`
* js : Updated jQuery extern (js.jquery.*). Supporting jQuery up to 3.3.1.
* js : updated HTML externs
* eval : improved object prototype field handling ([#7393](https://github.com/HaxeFoundation/haxe/issues/7393))
* eval : optimized int switches ([#7481](https://github.com/HaxeFoundation/haxe/issues/7481))
* eval : improved IntMap and StringMap performance
* eval : improved performance of instance calls

__Removals__:

* all : disallowed get_x/set_x property syntax, use get/set instead ([#4699](https://github.com/HaxeFoundation/haxe/issues/4699))
* all : disallowed default values on interface variables ([#4087](https://github.com/HaxeFoundation/haxe/issues/4087))
* all : disallowed `implements Dynamic` on non-extern classes ([#6191](https://github.com/HaxeFoundation/haxe/issues/6191))
* all : warn about expressions in extern non-inline fields ([#5898](https://github.com/HaxeFoundation/haxe/issues/5898))
* all : removed `-D use-rtti-doc`, always store documentation instead ([#7493](https://github.com/HaxeFoundation/haxe/issues/7493))
* all : disallowed macro-in-macro calls ([#7496](https://github.com/HaxeFoundation/haxe/issues/7496))

__Bugfixes__:

* all : fix GC compacting too often in server mode
* all : [breaking] `function () { }(e)` is no longer parsed as a call ([#5854](https://github.com/HaxeFoundation/haxe/issues/5854))
* all : fixed various minor inlining issues
* all : disallowed `return null` from Void-functions ([#7198](https://github.com/HaxeFoundation/haxe/issues/7198))
* all : fixed various pattern matching problems
* all : fixed compiler hang in display mode ([#7236](https://github.com/HaxeFoundation/haxe/issues/7236))
* all : fixed the XML printer trimming CDATA content ([#7454](https://github.com/HaxeFoundation/haxe/issues/7454))
* all : fixed invalid visibility unification with statics ([#7527](https://github.com/HaxeFoundation/haxe/issues/7527))
* php : Escape `$` in field names of anonymous objects ([#7230](https://github.com/HaxeFoundation/haxe/issues/7230))
* php : Generate `switch` as `if...else if...else...` to avoid loose comparison ([#7257](https://github.com/HaxeFoundation/haxe/issues/7257))
* cs : fixed bad evaluation order in structures ([#7531](https://github.com/HaxeFoundation/haxe/issues/7531))
* eval : fixed various problems with the debugger
* eval : fixed Vector.fromArrayCopy ([#7492](https://github.com/HaxeFoundation/haxe/issues/7492))
* eval : fixed bad string conversions on invalid + operations

__Standard Library__:

* all : [breaking] made Lambda functions return Array instead of List ([#7097](https://github.com/HaxeFoundation/haxe/issues/7097))
* all : added haxe.iterators package
* all : improved StringTools.lpad/rpad/htmlEscape implementation
