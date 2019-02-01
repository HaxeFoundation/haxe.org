
## 2018-02-01: 4.0.0-rc.1

__New features__:

* all : added experimental null-safety feature through `--macro nullSafety("package")` ([#7717](https://github.com/HaxeFoundation/haxe/issues/7717))

__General improvements and optimizations__:

* all : improved unification error messages ([#7547](https://github.com/HaxeFoundation/haxe/issues/7547))
* all : added `haxe4` define
* all : do not require semicolon for XML literals ([#7438](https://github.com/HaxeFoundation/haxe/issues/7438))
* all : made `@:expose` imply `@:keep` ([#7695](https://github.com/HaxeFoundation/haxe/issues/7695))
* all : unified cast, catch and Std.is behavior of null-values ([#7532](https://github.com/HaxeFoundation/haxe/issues/7532))
* macro : static variables are now always re-initialized when using the compilation server ([#5746](https://github.com/HaxeFoundation/haxe/issues/5746))
* macro : support `@:persistent` to keep macro static values across compilations
* js : improve js.Promise extern: now `then` callback argument types can be properly inferred ([#7644](https://github.com/HaxeFoundation/haxe/issues/7644))

__Bugfixes__:

* all : fixed various pattern matching problems
* all : fixed various wrong positions when encoding data to macros
* all : specified String.indexOf with out-of-bounds indices ([#7601](https://github.com/HaxeFoundation/haxe/issues/7601))
* all : fixed various problems related to DCE and feature-handling ([#7694](https://github.com/HaxeFoundation/haxe/issues/7694))
* all : fixed bad unary operator optimization ([#7704](https://github.com/HaxeFoundation/haxe/issues/7704))
* js : fixed syntax problem related to `instanceof` ([#7653](https://github.com/HaxeFoundation/haxe/issues/7653))
* flash : fixed var field access on interfaces being uncast ([#7727](https://github.com/HaxeFoundation/haxe/issues/7727))
* cpp : fixed various issues related to casts
* cpp : fixed some leftover unicode issues
* php : fixed class naming conflicts ([#7716](https://github.com/HaxeFoundation/haxe/issues/7716))
* eval : fixed Socket.setTimeout ([#7682](https://github.com/HaxeFoundation/haxe/issues/7682))
* eval : fixed int switch bug related to overflows

__Removals__:

* macro : deprecated Context.registerModuleReuseCall and onMacroContextReused ([#5746](https://github.com/HaxeFoundation/haxe/issues/5746))
