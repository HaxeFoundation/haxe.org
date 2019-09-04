
## 2019-09-04: 4.0.0-rc.4

__Standard Library__:

* all : added Map.clear ([#8681](https://github.com/HaxeFoundation/haxe/issues/8681))
* all : improved Date API ([#8508](https://github.com/HaxeFoundation/haxe/issues/8508))
* all : added JSON-RPC protocol types to haxe.display package ([#8610](https://github.com/HaxeFoundation/haxe/issues/8610))
* all : added default timeout to HTTP sockets ([#8646](https://github.com/HaxeFoundation/haxe/issues/8646))
* macro : added Context.info ([#8478](https://github.com/HaxeFoundation/haxe/issues/8478))
* macro : added Context.getMessages and Context.filterMessages ([#8471](https://github.com/HaxeFoundation/haxe/issues/8471))
* macro : added function kind to EFunction ([#8653](https://github.com/HaxeFoundation/haxe/issues/8653))
* macro : added string literal kind to CString ([#8668](https://github.com/HaxeFoundation/haxe/issues/8668))
* flash : added flash.AnyType ([#8549](https://github.com/HaxeFoundation/haxe/issues/8549))

__General improvements and optimizations__:

* all : allowed enum constructors without arguments as static inline var ([#8187](https://github.com/HaxeFoundation/haxe/issues/8187))
* all : improved handling of default values when inlining ([#8397](https://github.com/HaxeFoundation/haxe/issues/8397))
* all : made various improvements to the display API as usual
* all : detect invalid #tokens in inactive code ([#7108](https://github.com/HaxeFoundation/haxe/issues/7108))
* all : allowed function types in @:generic ([#3697](https://github.com/HaxeFoundation/haxe/issues/3697))
* all : improved --help-defines and --help-metas
* all : improved overall file finding ([#8202](https://github.com/HaxeFoundation/haxe/issues/8202))
* all : improved server reaction to added and removed files ([#8451](https://github.com/HaxeFoundation/haxe/issues/8451))
* all : improved memory handling of the compilation server (8727)
* all : improved handling of native libraries on the compilation server ([#8629](https://github.com/HaxeFoundation/haxe/issues/8629))
* all : support partial completion results ([#8642](https://github.com/HaxeFoundation/haxe/issues/8642))
* all : improved support of hovering over inactive conditional compilation blocks
* all : improved completion support in .platform.hx files
* all : support hovering conditional compilation identifiers
* all : improved and unified identifier checks for names, fields and types ([#8708](https://github.com/HaxeFoundation/haxe/issues/8708))
* all : improved --times performance ([#8733](https://github.com/HaxeFoundation/haxe/issues/8733))
* all : remove some redundant cast expressions ([#8725](https://github.com/HaxeFoundation/haxe/issues/8725))
* all : added --server-connect ([#8730](https://github.com/HaxeFoundation/haxe/issues/8730))
* lua : improved -D lua-vanilla
* js : improved HTML externs

__Bugfixes __:

* all : fixed various position and replace ranges in the display API
* all : fixed compiler hang related to @:arrayAccess ([#5525](https://github.com/HaxeFoundation/haxe/issues/5525))
* all : fixed bug regarding abstract `this` modification in inline methods ([#8454](https://github.com/HaxeFoundation/haxe/issues/8454))
* all : fixed `from Dynamic` on abstracts ([#8425](https://github.com/HaxeFoundation/haxe/issues/8425))
* all : fixed overeager recursive inline check ([#8489](https://github.com/HaxeFoundation/haxe/issues/8489))
* all : fixed the pattern matcher allowing inexhaustive switches in value-places ([#8277](https://github.com/HaxeFoundation/haxe/issues/8277))
* all : fixed pattern matcher allowing invalid abstract unification ([#8579](https://github.com/HaxeFoundation/haxe/issues/8579))
* all : fixed local variable type information being lost on the compilation server ([#8511](https://github.com/HaxeFoundation/haxe/issues/8511))
* all : don't generate return expressions in Void lambda functions ([#6503](https://github.com/HaxeFoundation/haxe/issues/6503))
* all : fixed unification of recursive typedefs again ([#8523](https://github.com/HaxeFoundation/haxe/issues/8523))
* all : fixed various hangs related to abstracts ([#8588](https://github.com/HaxeFoundation/haxe/issues/8588))
* all : fixed various GADT-related problems ([#7672](https://github.com/HaxeFoundation/haxe/issues/7672))
* all : fixed macro `@:from` methods allowing any return type ([#8463](https://github.com/HaxeFoundation/haxe/issues/8463))
* macro : fixed Sys.programPath assertion failure ([#8466](https://github.com/HaxeFoundation/haxe/issues/8466))
* js : fixed typed array APIs ([#8422](https://github.com/HaxeFoundation/haxe/issues/8422))
* java : fixed Std.is on non-reference and unrelated types ([#5168](https://github.com/HaxeFoundation/haxe/issues/5168))
* java/macro : fixed null-pointer exception in Reflect.getProperty ([#4934](https://github.com/HaxeFoundation/haxe/issues/4934))
* java/jvm : fix switch on null string ([#4481](https://github.com/HaxeFoundation/haxe/issues/4481))
* jvm : fixed boxed vs. unboxed comparison ([#8577](https://github.com/HaxeFoundation/haxe/issues/8577))
* jvm : generate toplevel types to haxe.root like genjava does ([#8590](https://github.com/HaxeFoundation/haxe/issues/8590))
* jvm : improved 32bit support ([#8601](https://github.com/HaxeFoundation/haxe/issues/8601))
* cs/python : fixed various issues with code generation
* cs : fixed NativeArray casting ([#3949](https://github.com/HaxeFoundation/haxe/issues/3949))
