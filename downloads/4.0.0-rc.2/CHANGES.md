
## 2019-03-22: 4.0.0-rc.2

__New features__:

* all : added strictness settings for the null-safety checker, using loose checking by default ([#7811](https://github.com/HaxeFoundation/haxe/issues/7811))
* js : added ES6 class generation with `-D js-es=6` ([#7806](https://github.com/HaxeFoundation/haxe/issues/7806))

__General improvements and optimizations__:

* all : inherit `@:native` for overriden methods ([#7844](https://github.com/HaxeFoundation/haxe/issues/7844))
* all : standardized identifiers allowed in markup literals ([#7558](https://github.com/HaxeFoundation/haxe/issues/7558))
* all : show typo suggestions when declaring `override` field ([#7847](https://github.com/HaxeFoundation/haxe/issues/7847))
* all : improved parser error messages ([#7912](https://github.com/HaxeFoundation/haxe/issues/7912))
* all : improved diagnostics of syntax errors ([#7940](https://github.com/HaxeFoundation/haxe/issues/7940))
* all : improved positions of `switch` and `case` expressions ([#7947](https://github.com/HaxeFoundation/haxe/issues/7947))
* all : allow parsing `#if (a.b)` ([#8005](https://github.com/HaxeFoundation/haxe/issues/8005))
* eval : improved performance of various string operations ([#7982](https://github.com/HaxeFoundation/haxe/issues/7982))
* eval : fixed many error positions
* eval : greatly improved debugger interaction ([#7839](https://github.com/HaxeFoundation/haxe/issues/7839))
* eval : properly support threads when debugging ([#7991](https://github.com/HaxeFoundation/haxe/issues/7991))
* eval : improved handling of capture variables ([#8017](https://github.com/HaxeFoundation/haxe/issues/8017))
* js : generate dot-access for "keyword" field names ([#7645](https://github.com/HaxeFoundation/haxe/issues/7645))
* js : optimized run-time type checking against interfaces ([#7834](https://github.com/HaxeFoundation/haxe/issues/7834))
* js : skip generation of interfaces when no run-time type checking needed ([#7843](https://github.com/HaxeFoundation/haxe/issues/7843))

__Standard Library__:

* all : unified various Thread APIs in sys.thread ([#7999](https://github.com/HaxeFoundation/haxe/issues/7999))
* all : moved typed arrays from `js.html` to `js.lib` ([#7894](https://github.com/HaxeFoundation/haxe/issues/7894))
* all : added `iterator()` to `haxe.DynamicAccess` ([#7892](https://github.com/HaxeFoundation/haxe/issues/7892))
* all : added `keyValueIterator()` to `haxe.DynamicAccess` ([#7769](https://github.com/HaxeFoundation/haxe/issues/7769))
* eval : completed Thread API

__Bugfixes__:

* all : fixed argument default value checking for externs ([#7752](https://github.com/HaxeFoundation/haxe/issues/7752))
* all : fixed optional status of overloaded arguments with default values ([#7794](https://github.com/HaxeFoundation/haxe/issues/7794))
* all : fixed DCE compilation server state issue ([#7805](https://github.com/HaxeFoundation/haxe/issues/7805))
* all : fixed compilation server module dependency issue related to macros ([#7448](https://github.com/HaxeFoundation/haxe/issues/7448))
* all : fixed call-site inlining on abstracts ([#7886](https://github.com/HaxeFoundation/haxe/issues/7886))
* all : fixed Constructible not checking constraints properly ([#6714](https://github.com/HaxeFoundation/haxe/issues/6714))
* all : fixed @:structInit not being compatible with `final` fields ([#7182](https://github.com/HaxeFoundation/haxe/issues/7182))
* all : fixed capture variables being allowed in `.match` ([#7921](https://github.com/HaxeFoundation/haxe/issues/7921))
* all : fixed infinite recursion on `@:generic` field access ([#6430](https://github.com/HaxeFoundation/haxe/issues/6430))
* all : fixed `-D no-deprecation-warnings` for typedefs and enums
* js : fixed bad stack handling on `Map` constraint checks ([#7781](https://github.com/HaxeFoundation/haxe/issues/7781))
* js : fixed DCE issues related to haxe.CallStack ([#7908](https://github.com/HaxeFoundation/haxe/issues/7908))
* cpp : fixed Socket flags not being preserved ([#7989](https://github.com/HaxeFoundation/haxe/issues/7989))
* lua : fixed broken output when compiling through the compilation server ([#7851](https://github.com/HaxeFoundation/haxe/issues/7851))
* lua : fixed `StringTools.fastCodeAt` with `-D lua-vanilla` ([#7589](https://github.com/HaxeFoundation/haxe/issues/7589))
* lua : fixed `@:expose` for classes inside packages ([#7849](https://github.com/HaxeFoundation/haxe/issues/7849))
