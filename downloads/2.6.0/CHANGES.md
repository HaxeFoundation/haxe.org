* neko : change serializer to be able to handle instances of basic classes from other modules
* js : add Document.createTextNode
* all : bugfix with inline when modifying var with same name as one of current local
* flash9 : classes implementing ArrayAccess<T> are now dynamic (including TypedDictionary)
* all : allow "using" on typedefs
* as3 : minor fixes in genas3 and --gen-hx-classes
* as3 : fix with readonly/writeonly properties accesses
* flash9 : list native getter/setters in Type API class/instance fields
* all : make haxe.rtti.Generic typing lazy (fix for self-recursion)
* all : allow haxe.rtti.Generic + inheritance
* all : added resource size limit to 12MB (ocaml max_string_size is 16MB + b64)
* flash : changes in swf handling to work with >16MB swfs
* flash9 : only init dynamic methods if not already defined (in subclass)
* std : added haxe.SHA1
* compiler : added TCast, allow cast optimization on flash9/cpp
* as3 : fixed Std.__init__ generating 'null'
* compiler : fixed -no-opt
* flash : allow several -swf-lib
* no longer support automatic creation of classes for f8 swfs in f9 mode
* classes defined in f9 swf are not redefinable in haXe code (use extern)
* flash9 : allow direct access and completion with classes defined in -swf-lib's
* flash9 : remove imported libraries debug infos when not compiled with -debug
* all : only display errors with --display if no completion matched
* all : some completion related errors fixed
* flash9 : added @:bind support
* all : fixed StringTools.hex with negative numbers
* flash9 : fixed Type.typeof(1<<28) was TFloat
* flash9 : use flash.XML parser for Xml class implementation
* neko : fixed Array.splice (was not setting null at end of array)
* neko : rewrote Array class using neko.NativeArray
* all : core classes implementation are now in std/(platform)/_std
* all : added @:final support
* all : added haxe.rtti.Meta
* flash9 : added flash.desktop.Clipboard* classes (added in flash10)
* as3 : fixed Date.toString issue in flash.Boot (now use .toStringHX instead)
* this will only work if .toString called explicitely on Date class
* all : only allow "using" on Dynamic if first parameter is Dynamic
* php : haxe.Http now supports Https connections when OpenSSL extension is enabled (issue 143)
* php : fixed enum constructors sequence (issue 142)
* php : added error message when using 2 fields with different cases in the same class/enum
* php : fixed field declaration for properties with getter and setter (issue 124)
* php : fixed comparison issues between strings (issue 132)
* php : enhanced FileInput.readLine using native fgets function (issue 103)
* flash9 : renamed flash.Error to flash.errors.Error
* php : removed eval() everywhere and simplified _hx_lambda
* php : fixed return type for Std.string() with integers and floats
* php : fixed php.Lib.rethrow
* all : added custom haXe serialization
* php : aligned php.Web.parseMultipart signature with neko implementation
* cpp : Added source location and stack dump for errors in debug mode
* cpp : Remapped more keywords
* cpp : Added templated fast iterator code for arrays and FastLists
* cpp : Added option for tracing GC references in debug mode
* cpp : Switch the native string implementation from wchar_t to utf8 - for regex speed
* cpp : Added extra "()" to ensure correct order of operations
* cpp : Fixed various bugs for unusual (and not so unusual) language constructs
* cpp : Fixed order of enum generation from index
* cpp : Added __unsafe_get and __unsafe_set to Array as possible optimizations
* cpp : Default to mult-thread compiling on windows for cl version >= 14
* cpp : Seed Math.random
* cpp : Use strftime for Dates
* cpp : Fix socket sellect passing _s
* cpp : Throw error when match count does not match regex
* cpp : Improve register capture in GC
* cpp : Fix Dynamic interger compare
* cpp : Implement makeVarArgs
* cpp : Fix toString for nulls in Enums and Arrays
* cpp : Added initial Android support
* cpp : Move initializers to entry functions in standard ndlls.
* cpp : Changes some CFFI register funtions to char*, from wchar_t*
* cpp : Added some initial support for v8 script target
* cpp : Use non-recursive GC marking to avoid overflow in big lists
* cpp : Added __hxcpp_obj_id
