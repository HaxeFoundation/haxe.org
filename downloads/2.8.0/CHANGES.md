* js : added js.JQuery
* all : added @:overload
* js : upgraded js.SWFObject from 1.4.4 inlined to 1.5 embedded
* js : code generator beautify
* all : ensure that modifying returned Type.getEnumConstructs array does not affect enum
* all : allow macro typed parameters (other than Expr)
* flash : added flash11 apis
* neko : added support for https to haxe.Http (using hxssl library)
* all : added haxe.Int64
* all : added haxe.Int32 isNeg,isZero,ucompare, fixed overflows for js/flash8/php
* all : bugfix when optimizing inlined immediate function call
* all : fixed "using" on macro function
* all : allowed member macros functions (called as static)
* neko : allowed serialization of haxe.Int32 (as Int)
* all : fixed invalid optimization of two constant numbers comparison
* flash8 : bugfix Std.parseInt with some hex values
* flash9 : added flash.utils.RegExp
* all : changed @:build behavior, now takes/returns a var with anonymous fields
* all : added @:native support for enums
* neko : changed the result of array-assign expression (was null)
* flash9 : no longer auto create enums from SWF classes
* (need explicit "enum" type patch)
* all : optimized variable tracking/renaming
* all : optimized macro engine (speed x2)
* all : added -D macrotimes support
* flash9 : store resources in bytes tag instead of bytecode
* all : allow $ prefixed identifiers (for macros usage only)
* all : allow to access modules subtype statics with pack.Mod.Type.value
* and fixed identifier resolution order
* flash9 : added @:bitmap("file") for simple embedding
* all : added haxe.web.Dispatch
* js : added js.Storage
* all : allow this + member variables access in local functions
* added untyped __this__ support and transition error
* all : added haxe.macro.MacroType
* neko : neko.Lib.serialize/unserialize now returns bytes
* neko : added sys.db package (crossplatform with -D spod_macro support)
* spod_macro now uses wrappers for Bytes (require neko 1.8.2)
* php : added --php-prefix for prefixing generated files and class names
* all : added type_expr_with_type enum support
* php/js : fixed adding 'null' to StringBuf
* all : added haxe.macro.Context.defineType
