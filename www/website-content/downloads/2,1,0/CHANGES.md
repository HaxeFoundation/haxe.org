### 2008-10-04: __2.01__

* fixed php.Sys
* added neko.NativeString and neko.NativeArray
* fixed php.Boot.__string_rec() when invoked from toString
* fixed null references in class constructors for array arguments
* fixed Type.enumParameters() and Type.typeOf() for PHP
* fixed SPOD/MySql for PHP
* fixed php.net.Socket.setTimeout(), php.io.Process
* fixed php.Web.setCookie() for expire time
* fixed php rethrow in catches and added the possibility to catch native exceptions
* added runttime check for php.io.Socket.shutdown (uses fclose in php 5.1.x)
* allowed optional Context in remoting connections
* fixed extern classes for flash < 8
* fixed inherited protected/private properties in as3 SWF library
* fixed haxe.io float/double in Neko (when bigEndian was null)
* added __FSCommand2__ support
* optimized haxe.Unserializer (use faster buffer access)
* use "Dynamic" instead of Dynamic->Void for flash9 IEventDispatcher
* always use full classes paths for genAS3
* prevent different get/set property accesses when implementing an interface
* fixed assign of dynamicfunction references in PHP
* haXe/PHP now generates code for extern classes __init__
* added strings literal support in haxe.Template
* fixed Process arguments and exitCode() in haXe/PHP
* fixed hierarchy problem for classes with the name from different packages haXe/PHP
* php.db.Mysql now throws an exception when tries to connect to an unexistant DB
* fixed blocks in if statements for haXe/PHP
* added php check on the full hierarchy for colliding names
* added support for "g" modifier in EReg for PHP
* PHP now generates __toString for classes that have toString defined
* implemented php.Lib.getClasses()
* fixed duplicate fields in Type.getInstanceFields on subclass
* Enum is no longer defined inside Type but is standalone class
* fixed Date.getDay on Neko/Windows (use %w instead of %u)
* fixed memory leak with PHP closures
* fixed wrong scope in PHP closures
* fixed Array.reverse() in PHP
* fixed Reflect.compareMethods in Neko (require Neko 1.8.0)
* fixed flash7-8 register usage for __init__ and static variables initialization
* moved StringTools.baseEncode/Decode to haxe.BaseCode
* fixed binary resources for Flash, JS and PHP outputs
* fixed compiler bug with inline + optional arguments
* fixed Type.createInstance and createEmptyInstance with Array for flash6-8
