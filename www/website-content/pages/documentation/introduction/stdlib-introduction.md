Introduction to the Haxe Standard Library
=======

The Haxe Standard Library provides common purpose tools without trying to be an exhaustive collection of data structures and algorithms. A Haxe distribution comes with a `std` directory containing the Haxe Standard Library. Its contents can be categorized like so:

* [**General purpose**](#general-purpose-api): The `std` directory itself contains a few top-level classes such as `Array`, `Map` or `String` which can be used on all targets. The `haxe` sub-directory provides additional data structures, input/output APIs and many more tools.

* [**System**](#sys-api): The `sys` sub-directory contains APIs related to file systems and database. Additionally, the `Sys` top-level class allows various interaction with the operating system. They can only be accessed when compiling to a target of the `sys`-category (C++, C#, Java, Neko, PHP).

* [**Target specific**](#target-apis): Each Haxe target has a distinct sub-directory containing target-specific APIs. These can only be accessed when compiling to the given target.

<a class="anch" id="general-purpose-api"></a>

General purpose API:
--------------

Available on all targets.

Top-level:

* [Array](http://api.haxe.org/Array.html): Typed collection which defines several ECMA-compliant operations
* [Date, DateTools](http://api.haxe.org/Date.html): Operations related to dates and timestamps
* [EReg](http://api.haxe.org/EReg.html): Regular Expressions
* [Lambda](http://api.haxe.org/Lambda.html): Operations over iterables
* [Map](http://api.haxe.org/Map.html): Key-to-value mapping data structure
* [Math](http://api.haxe.org/Math.html): ECMA-compliant mathematical functions
* [Reflect](http://api.haxe.org/Reflect.html): Field-related reflection
* [Std](http://api.haxe.org/Std.html): Runtime type-checking; numerical parsing; conversion to Int and String
* [String](http://api.haxe.org/String.html): Basic operations on String
* [StringBuf](http://api.haxe.org/StringBuf.html): Optimized for building Strings
* [StringTools](http://api.haxe.org/StringTools.html): Various extensions to String
* [Type](http://api.haxe.org/Type.html): Type-related reflection
* [Xml](http://api.haxe.org/Xml.html): Cross-platform XML
 
The haxe package:

* [haxe.Http](http://api.haxe.org/haxe/Http.html): HTTP requests
* [haxe.Json](http://api.haxe.org/haxe/Json.html): Encoding and decoding JSON
* [haxe.Resource](http://api.haxe.org/haxe/Resource.html): Work with Haxe resources
* [haxe.Serializer](http://api.haxe.org/haxe/Serializer.html): Serialize arbitrary objects as String
* [haxe.Template](http://api.haxe.org/haxe/Template.html): Simple templating system
* [haxe.Timer](http://api.haxe.org/haxe/Timer.html): Repeated/delayed execution; measuring
* [haxe.Unserializer](http://api.haxe.org/haxe/Unserializer.html): Complement to haxe.Serializer
* [haxe.Utf8](http://api.haxe.org/haxe/Utf8.html): Cross-platform UTF8 strings
* [haxe.crypto](http://api.haxe.org/haxe/crypto/index.html): Various encryption algorhtms
* [haxe.macro](http://api.haxe.org/haxe/macro/index.html): Types for working with Haxe macros
* [haxe.remoting](http://api.haxe.org/haxe/remoting/index.html): Remoting between various client and server types
* [haxe.rtti](http://api.haxe.org/haxe/rtti/index.html): Run-time type information
* [haxe.unit](http://api.haxe.org/haxe/unit/index.html): Basic unit-test framework
* [haxe.web](http://api.haxe.org/haxe/web/index.html): Map URLs to operations
* [haxe.xml](http://api.haxe.org/haxe/xml/index.html): Complementary XML tools
* [haxe.zip](http://api.haxe.org/haxe/zip/index.html): Support of the ZIP-format

The haxe.ds package:

* [haxe.ds.ArraySort](http://api.haxe.org/haxe/ds/ArraySort.html): Stable, cross-platform array sorting
* [haxe.ds.BalancedTree](http://api.haxe.org/haxe/ds/BalancedTree.html): Balanced tree data structure
* [haxe.ds.EnumValueMap](http://api.haxe.org/haxe/ds/EnumValueMap.html): Map type supporting enum value keys
* [haxe.ds.GenericStack](http://api.haxe.org/haxe/ds/GenericStack.html): Stack data structure which is optimized on static targets
* [haxe.ds.IntMap](http://api.haxe.org/haxe/ds/IntMap.html): Map type supporting Int keys
* [haxe.ds.ObjectMap](http://api.haxe.org/haxe/ds/ObjectMap.html): Map type supporting object keys
* [haxe.ds.StringMap](http://api.haxe.org/haxe/ds/StringMap.html): Map type supporting string keys
* [haxe.ds.Vector](http://api.haxe.org/haxe/ds/Vector.html): Fixed-size data structure

The haxe.io package:

* [haxe.io.Bytes](http://api.haxe.org/haxe/io/Bytes.html): Byte operations on native representations
* [haxe.io.BytesBuffer](http://api.haxe.org/haxe/io/BytesData.html): Optimized for building Bytes
* [haxe.io.Path](http://api.haxe.org/haxe/io/Path.html): Operations on path strings

<a class="anch" id="sys-api"></a>

System API:
--------------

Available on C++, C#, Java, Neko and PHP.

* [Sys](http://api.haxe.org/Sys.html): Execute native commands; interact with stdin, stdout and stderr; various other native operations
* [sys.FileSystem](http://api.haxe.org/sys/FileSystem.html): Read and modify directories; obtain information on files and directories
* [sys.db](http://api.haxe.org/sys/db/index.html): APIs for working with MySQL and SQLite databases
* [sys.io.File](http://api.haxe.org/sys/io/File.html): Read and write file content; copy files
* [sys.io.Process](http://api.haxe.org/sys/io/Process.html): Use native processes

<a class="anch" id="target-apis"></a>

Target Specific APIs:
--------------------------------

* [cpp](http://api.haxe.org/cpp/index.html):

	* [cpp.Lib](http://api.haxe.org/neko/Lib.html): Low level interactions with cpp target
	* [cpp.net](http://api.haxe.org/neko/net/index.html): Tools for interacting with networks and running servers
	* [cpp.vm](http://api.haxe.org/neko/vm/index.html): Thread API, debugger, profiler etc.
	* [cpp.zip](http://api.haxe.org/neko/zip/index.html): API for working with zip compression  

* [cs](http://api.haxe.org/cs/index.html): API for C# target

* [flash](http://api.haxe.org/flash/index.html):

	* [flash](http://api.haxe.org/flash/index.html) Externs for Flash API
	* [flash.Lib](http://api.haxe.org/flash/Lib.html) Basic interactions with the Flash platform
	* [flash.Memory](http://api.haxe.org/flash/Memory.html) Extern for Flash Memory API
	* [flash.Vector](http://api.haxe.org/flash/Vector.html) Extern for Flash Vectors  

* [flash8](http://api.haxe.org/flash8/index.html): 

	* [flash8](http://api.haxe.org/flash8/index.html) Externs for Flash 8 API  

* [java](http://api.haxe.org/java/index.html): API for Java target

* [js](http://api.haxe.org/js/index.html): 

	* [js.Browser](http://api.haxe.org/js/Browser.html): Shortcuts for common browser functions
	* [js.Cookie](http://api.haxe.org/js/Cookie.html): Helpers for interacting with HTTP cookies in the browser
	* [js.JQuery](http://api.haxe.org/js/JQuery.html): Extern class and helpers for [jQuery](http://jquery.com/)
	* [js.Lib](http://api.haxe.org/js/Lib.html): Shortcuts for `alert()`, `eval()` and `debugger`
	* [js.html](http://api.haxe.org/js/html/index.html): Externs for interacting with the browser DOM  

* [neko](http://api.haxe.org/neko/index.html):

	* [neko.Lib](http://api.haxe.org/neko/Lib.html): Low level interactions with neko platform
	* [neko.Web](http://api.haxe.org/neko/Web.html): Work with HTTP requests and responses
	* [neko.net](http://api.haxe.org/neko/net/index.html): Tools for interacting with networks and running servers
	* [neko.vm](http://api.haxe.org/neko/vm/index.html): API for multi-threaded applications
	* [neko.zip](http://api.haxe.org/neko/zip/index.html): API for working with zip compression  

* [php](http://api.haxe.org/php/index.html): 

	* [php.Lib](http://api.haxe.org/php/Lib.html): Low level interactions with PHP platform
	* [php.Session](http://api.haxe.org/php/Session.html): Work with native PHP sessions
	* [php.Web](http://api.haxe.org/php/Web.html): Work with HTTP requests and responses
	* [php.db.PDO](http://api.haxe.org/php/db/PDO.html): Additional PDO driver for database interactions  
