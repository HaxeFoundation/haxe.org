
## 2018-06-12: 4.0.0-preview.4

__New features__:

* all : added JSON-RPC-based display protocol
* all : allow `enum abstract` syntax instead of `@:enum abstract` ([#4282](https://github.com/HaxeFoundation/haxe/issues/4282))
* all : allow `extern` on fields instead of `@:extern`
* all : support signature completion on incomplete structures ([#5767](https://github.com/HaxeFoundation/haxe/issues/5767))
* all : support auto-numbering and auto-stringification in enum abstracts ([#7139](https://github.com/HaxeFoundation/haxe/issues/7139))
* all : support `Type1 & Type2` intersection syntax for type parameter constraints and structures ([#7127](https://github.com/HaxeFoundation/haxe/issues/7127))

__General improvements and optimizations__:

* all : reworked CLI usage/help output ([#6862](https://github.com/HaxeFoundation/haxe/issues/6862))
* all : implemented `for` loop unrolling ([#3784](https://github.com/HaxeFoundation/haxe/issues/3784))
* all : metadata can now use `.`, e.g. `@:a.b`. This is represented as a string ([#3959](https://github.com/HaxeFoundation/haxe/issues/3959))
* all : [breaking] disallow static extensions on implicit `this` ([#6036](https://github.com/HaxeFoundation/haxe/issues/6036))
* all : allow true and false expressions as type parameters ([#6958](https://github.com/HaxeFoundation/haxe/issues/6958))
* all : improved display support in many areas
* all : support `override |` completion
* all : make display/references and display/toplevel actually work sometimes
* all : allow `var ?x` and `final ?x` parsing in structures ([#6947](https://github.com/HaxeFoundation/haxe/issues/6947))
* all : improved overall robustness of the parser in display mode
* all : allow `@:commutative` on non-static abstract functions ([#5599](https://github.com/HaxeFoundation/haxe/issues/5599))
* js : added externs for js.Date ([#6855](https://github.com/HaxeFoundation/haxe/issues/6855))
* js : respect `-D source-map` flag to generate source maps in release builds
* js : enums are now generated as objects instead of arrays ([#6350](https://github.com/HaxeFoundation/haxe/issues/6350))
* eval : improved debugger, support conditional breakpoints

__Removals__:

* all : moved haxe.remoting to hx3compat
* js : moved js.XMLSocket to hx3compat
* neko : moved neko.net to hx3compat
* all : removed support for `T:(A, B)` constraint syntax

__Bugfixes__:

* all : fixed various issues with diagnostics
* all : fixed fields with default values for `@:structInit` classes ([#5449](https://github.com/HaxeFoundation/haxe/issues/5449))
* all : fixed `Null<T>` inconsistency in if/ternary expressions ([#6955](https://github.com/HaxeFoundation/haxe/issues/6955))
* all : fixed visibility check related to private constructors of sibling classes ([#6957](https://github.com/HaxeFoundation/haxe/issues/6957))
* all : fixed @:generic naming ([#6968](https://github.com/HaxeFoundation/haxe/issues/6968))
* all : fixed handling of type parameters in local functions ([#6560](https://github.com/HaxeFoundation/haxe/issues/6560))
* all : fixed resolution order between `untyped` and type parameters ([#7113](https://github.com/HaxeFoundation/haxe/issues/7113))
* all : fixed unification behavior in try/catch expressions ([#7120](https://github.com/HaxeFoundation/haxe/issues/7120))
* all : fixed field type being lost for Int expressions on Float fields ([#7132](https://github.com/HaxeFoundation/haxe/issues/7132))
* all : cleaned up `inline` handling ([#7155](https://github.com/HaxeFoundation/haxe/issues/7155))
* display : fixed completion in packages starting with underscore ([#5417](https://github.com/HaxeFoundation/haxe/issues/5417))
* php : fixed Reflect.callMethod with classes as first argument ([#7106](https://github.com/HaxeFoundation/haxe/issues/7106))
* eval : fixed internal exception surfacing in some context calls ([#7007](https://github.com/HaxeFoundation/haxe/issues/7007))
* eval : fixed Type.enumEq ([#6710](https://github.com/HaxeFoundation/haxe/issues/6710))
* flash : fixed silently swallowing exceptions in getters/setters when invoked with Reflect methods (#5460, #6871)

__Standard Library__:

* all : added `resize` to Array ([#6869](https://github.com/HaxeFoundation/haxe/issues/6869))
* all : [breaking] removed `return this` from some haxe.Http methods ([#6980](https://github.com/HaxeFoundation/haxe/issues/6980))
