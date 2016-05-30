### 2016-05-27: __3.3.0-RC1__

__New features__:

* all : support @:resolve on abstracts ([#3753](https://github.com/HaxeFoundation/haxe/issues/3753))
* all : support extern abstracts and extern @:enum abstracts ([#4862](https://github.com/HaxeFoundation/haxe/issues/4862))
* all : support completion on { if the expected type is a structure ([#3907](https://github.com/HaxeFoundation/haxe/issues/3907))
* all : support (expr is Type) with mandatory parentheses ([#2976](https://github.com/HaxeFoundation/haxe/issues/2976))
* all : allowed passing package dot-paths on command line ([#4227](https://github.com/HaxeFoundation/haxe/issues/4227))
* all : support import.hx modules that define per-directory import/using directives ([#1138](https://github.com/HaxeFoundation/haxe/issues/1138))
* all : support parsing of postfix ! operator (can be used by abstract operator overloading and macros) ([#4284](https://github.com/HaxeFoundation/haxe/issues/4284))
* all : support parsing of ||= and &&= operators (can be used by abstract operator overloading and macros) ([#4427](https://github.com/HaxeFoundation/haxe/issues/4427))
* all : support @:structInit classes ([#4526](https://github.com/HaxeFoundation/haxe/issues/4526))
* all : reworked static analyzer and enabled it by default
* flash : update flash externs to version 21
* hl : added HL target (interpreter and C output)
* lua: added lua target
* js : introduced new jQuery extern (js.jquery.*) for jQuery 1.12.4 / 2.2.4 support. ([#4377](https://github.com/HaxeFoundation/haxe/issues/4377))
* js : introduced new SWFObject extern (js.swfobject.SWFObject) for SWFObject 2.3.20130521 ([#4451](https://github.com/HaxeFoundation/haxe/issues/4451))
* js : added js.Lib.rethrow ([#4551](https://github.com/HaxeFoundation/haxe/issues/4551))
* cs/java : added -D fast_cast as an experimental feature to cleanup casts

__Bugfixes__:

* all : properly disallowed assigning methods to structures with read-accessors ([#3975](https://github.com/HaxeFoundation/haxe/issues/3975))
* all : fixed a bug related to abstract + Int/Float and implicit casts ([#4122](https://github.com/HaxeFoundation/haxe/issues/4122))
* all : disallowed duplicate type parameter names ([#4293](https://github.com/HaxeFoundation/haxe/issues/4293))
* all : made UInt's >>> behave like >> ([#2736](https://github.com/HaxeFoundation/haxe/issues/2736))
* all : fixed various type loading issues
* all : fixed code generation problems with `inline` ([#1827](https://github.com/HaxeFoundation/haxe/issues/1827))
* php/as3 : support run-time metadata on interfaces ([#2042](https://github.com/HaxeFoundation/haxe/issues/2042))
* php : fixed argument passing to closures ([#2587](https://github.com/HaxeFoundation/haxe/issues/2587))
* neko/cpp : fixed various sys.Filesystem issues with Windows drive paths ([#3266](https://github.com/HaxeFoundation/haxe/issues/3266))
* as3 : fixed problem with covariant return types ([#4222](https://github.com/HaxeFoundation/haxe/issues/4222))
* as3 : fixed rare problem with static initialization order ([#3563](https://github.com/HaxeFoundation/haxe/issues/3563))
* python : fixed various reflection problems

__General improvements and optimizations__:

* all : added support for determining minimal types in Map literals ([#4196](https://github.com/HaxeFoundation/haxe/issues/4196))
* all : allowed @:native on abstracts to set the name of the implementation class ([#4158](https://github.com/HaxeFoundation/haxe/issues/4158))
* all : allowed creating closures on abstract inline methods ([#4165](https://github.com/HaxeFoundation/haxe/issues/4165))
* all : type parameter declarations can now have metadata ([#3836](https://github.com/HaxeFoundation/haxe/issues/3836))
* all : optimize Math.ceil/floor on constant arguments ([#4223](https://github.com/HaxeFoundation/haxe/issues/4223))
* all : allowed extern classes to have field names being used for both static and instance ([#4376](https://github.com/HaxeFoundation/haxe/issues/4376))
* all : added haxe.Constraints.Constructible ([#4761](https://github.com/HaxeFoundation/haxe/issues/4761))
* all : rewrote pattern matcher to improve output in many cases ([#4940](https://github.com/HaxeFoundation/haxe/issues/4940))
* python : use spaces instead of tabs to indent the output ([#4299](https://github.com/HaxeFoundation/haxe/issues/4299))
* cpp : reworked backend to improve overall code output quality and fix various issues
* swf : added scene-tag to allow creating accessible SWF files

__Standard Library__:

* all : added Lambda.flatten and Lambda.flatMap ([#3553](https://github.com/HaxeFoundation/haxe/issues/3553))
* all : added haxe.Constraints.Constructible ([#4761](https://github.com/HaxeFoundation/haxe/issues/4761))
* sys : proper quoting/escaping (can be opt-out) for Sys.command and sys.io.Process ([#3603](https://github.com/HaxeFoundation/haxe/issues/3603))
* js : added position parameter to haxe.macro.Compiler.includeFile
* js : removed -D embed-js ([#4074](https://github.com/HaxeFoundation/haxe/issues/4074))
* js : updated HTML externs

__Macro features and changes__:

* macro : added overloads field to ClassField ([#3460](https://github.com/HaxeFoundation/haxe/issues/3460))
* macro : added Context.getLocalImports ([#3560](https://github.com/HaxeFoundation/haxe/issues/3560))
* macro : added Context.onAfterTyping ([#4714](https://github.com/HaxeFoundation/haxe/issues/4714))
* macro : added Context.resolveType
