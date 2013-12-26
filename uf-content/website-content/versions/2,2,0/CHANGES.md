### 2008-11-23: __2.02__

* Std.is(MyInterface, Class) now returns true (haXe/PHP)
* php arrays are wrapped into _hx_array instances, fixes issues with references (array cast, access out of bounds ...)
* removed untested php classes (php.DBase, php.IniHash)
* added -D use_rtti_doc
* flash.Lib.getTimer() now returns Int and is inlined
* fixed php.FileSystem.stat
* added memory related functions to php.Sys
* added error when trying to extend Array, String, Date and Xml
* fixed handling of implements ArrayAccess
* fixed some minor things in flash10 api
* switch/for/while/do/try/if are no longer using parse_next (parenthesises requ. instead)
* fixed Type.typeof and Std.is in case of too much large integers for Flash6-8/JS
* haxe.xml.Check : treat comments the same as PCDATA spaces
* haxe.io.BytesData now uses strings instead of arrays for PHP
* compiler : optimized line calculus from ast position
* lexer : allow identifiers starting with _[0-9]
* fixed access to flash.Vector methods : use AS3 namespace (faster)
* bugfix in inline functions : modifying a parameter can't modify a real local var anymore
* bugfix in inline functions : handle class type parameters and method type parameters
* fixed issue with Int default value for Float parameter
* flash9 : bugfix when using the retval after setting a closure variable
* added flash.Memory API for flash10 alchemy opcodes access
* changed #if as3gen to #if as3 when generating as3 code
* fixed as3 flash.Vector generation
* fixed haxe.io.BytesOutput for flash9 : set default to little-endian
* some flash9 fixes related to extern enums
* updated flash.text.engine package with haxe enums
* flash9 : use target file path for Boot unique ID instead of random number
* as3 : fixed bug when anonymous field was a reserved identifier
* flash9 : added flash.Lib.vectorOfArray and vectorConvert for flash10
* added -D check-js-packages to allow several haxe-generated js files in same page
