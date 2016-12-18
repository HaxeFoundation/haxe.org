* optimized Type.enumEq : use index instead of tag comparison for neko/flash9/php
* bugfix for flash.display.BitmapDataChannel and GraphicsPathCommand (allow inline static)
* resolve environment variable in -cmd commands
* added flash.Vector.indexOf and lastIndexOf
* fixed bug in interfaces that define the method toString (haXe/PHP)
* fixed bug in haxe.io.BytesInput.readBytes in Flash9 (was throwing Eof if full buffer can't be readed)
* fixed implements/extends special classes when they are imported
* StringBuf now uses an array for JS implementation (around same on FF, faster on IE)
* fixed assignment of field length in anonym objects (haXe/PHP)
* fixed addEventListener typing for flash9
* fixed __vector__ generation for AS3 target
* fix with inline functions : position is now the inserted position and not the original one (better error reporting)
* added SWC output support
* fixed issues with unset of values in for loops and executing blocks that return functions (haXe/PHP)
* "throw" type is now Unknown instead of Dynamic (prevent type-hole in "if A else if B else throw")
* added __foreach__ for flash9/as3
* fixed f9 verify error with different kind of functions
* moved eof() from neko.io.FileOutput to FileInput
* added haxe.rtti.HtmlEditor
* added neko.db.Manager.setLockMode
* genAS3 : fixed Error classes issues
* genAS3 : fixed default basic type value in interfaces
* flash9 : fixed UInt default parameter verify error
* flash9 : fixed issue with flash.* string enums verify error
* compiler : allowed \r line separators for HXML files
* flash9 : fixed verify error with loop variable beeing a specific class
* compiler : prevent truncating float dynamic values to int when using numerical operations
* neko.db.Manager fix : synchronize fields after locking an unlocked cached object
* compiler : fixed issue with cascading inline+haxe.rtti.Generic
* optimizer : reduce constant int/float/bool expressions and immediate function calls
* flash9/as3/php : don't add Boot.skip_constructor test if no side effects in constructor
* compiler : added --no-opt to disable expr reduction
* compiler : separated basic and advanced commandline options
* compiler : fixed printing of sub-function types
* genHX : fixed generation of classes that extends another class (shouldn't be turned into enums)
* speedup Array.remove on flash9/js
