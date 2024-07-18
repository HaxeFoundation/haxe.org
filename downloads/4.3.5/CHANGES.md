
## 2024-07-18 4.3.5

__General improvements__:

* all : macOS universal binaries ([#11572](https://github.com/HaxeFoundation/haxe/issues/11572))
* display : migrated diagnostics to Json RPC ([#11707](https://github.com/HaxeFoundation/haxe/issues/11707))
* macro : expose TVar VStatic flag in macros. ([#11683](https://github.com/HaxeFoundation/haxe/issues/11683))

__Bugfixes__:

* all : fix `@:structInit` with getter + setter ([#11662](https://github.com/HaxeFoundation/haxe/issues/11662))
* all : add missing recursion when checking abstract casts ([#11676](https://github.com/HaxeFoundation/haxe/issues/11676))
* all : fail nicer if unify_min can't find a common type ([#11684](https://github.com/HaxeFoundation/haxe/issues/11684))
* all : fix pretty errors failure ([#11700](https://github.com/HaxeFoundation/haxe/issues/11700))
* all : disallow local statics when inlining ([#11725](https://github.com/HaxeFoundation/haxe/issues/11725))
* display : unused pattern variables should be marked as unused ([#7282](https://github.com/HaxeFoundation/haxe/issues/7282))
* display : diagnostics miss "used without being initialized" errors ([#7931](https://github.com/HaxeFoundation/haxe/issues/7931))
* display : recursive inline is not supported on enum abstract constructor ([#11177](https://github.com/HaxeFoundation/haxe/issues/11177))
* display : Void as value error disappears on second compilation ([#11184](https://github.com/HaxeFoundation/haxe/issues/11184))
* display : false positives of "This cast has no effect, but some of its sub-expressions" ([#11203](https://github.com/HaxeFoundation/haxe/issues/11203))
* cpp : inherit `@:unreflective` on generic classes
* hl : fix bit shift + assignment in while loop header ([#10783](https://github.com/HaxeFoundation/haxe/issues/10783))
* hl : fix do-while loop in genhl+hlopt ([#11461](https://github.com/HaxeFoundation/haxe/issues/11461))
* hl/c : use uint64 instead of uint64_t for shift cast ([#11721](https://github.com/HaxeFoundation/haxe/issues/11721))
* macro : don't choke on namePos for reification pattern matching ([#11671](https://github.com/HaxeFoundation/haxe/issues/11671))

__Deprecation / future version handling__:

* macro : `Compiler.include()` warning when used outside init macros
