Introduction to the Haxe Standard Library
=======

The Haxe Standard Library provides common purpose tools without trying to be an exhaustive collection of data structures and algorithms. A Haxe distribution comes with a `std` directory containing the Haxe Standard Library. Its contents can be categorized like so:

* **Target-specific**: Each Haxe target has a distinct sub-directory containing target-specific APIs. These can only be accessed when compiling to the given target.
* **System**: The `sys` sub-directory contains APIs related to file systems and database. Additionally, the `Sys` top-level class allows various interaction with the operating system. They can only be accessed when compiling to a target of the `sys`-category (C++, C#, Java, Neko, PHP).
* **General purpose**: The `std` directory itself contains a few top-level classes such as `Array`, `Map` or `String` which can be used on all targets. The `haxe` sub-directory provides additional data structures, input/output APIs and many more tools.

Details on sys API:
--------------

* Sys: Execute native commands; interact with stdin, stdout and stderr; various other native operations (<http://api.haxe.org/Sys.html>)
* sys.FileSystem: Read and modify directories; obtain information on files and directories (<http://api.haxe.org/sys/FileSystem.html>)
* sys.db: APIs for working with MySQL and SQLite databases (<http://api.haxe.org/sys/db/Mysql.html>, <http://api.haxe.org/sys/db/Sqlite.html>).
* sys.io.File: Read and write file content; copy files (<http://api.haxe.org/sys/io/File.html>)
* sys.io.Process: Use native processes (<http://api.haxe.org/sys/io/Process.html>)

Details on the general purpose API:
--------------

Top-level:

* Array: Typed collection which defines several ECMA-compliant operations (<http://api.haxe.org/Array.html>)
* Date, DateTools: Operations related to dates and timestamps (<http://api.haxe.org/Date.html>)
* EReg: Regular Expressions (<http://api.haxe.org/EReg.html>)
* Lambda: Operations over iterables (<http://api.haxe.org/Labda.html>)
* Map: Key-to-value mapping data structure (<http://api.haxe.org/Map.html>)
* Math: ECMA-compliant mathematical functions (<http://api.haxe.org/Math.html>)
* Reflect: Field-related reflection (<http://api.haxe.org/Reflect.html>)
* Std: Runtime type-checking; numerical parsing; conversion to Int and String (<http://api.haxe.org/Std.html>)
* String: Basic operations on String (<http://api.haxe.org/String.html>)
* StringBuf: Optimized for building Strings (<http://api.haxe.org/StringBuf.html>)
* StringTools: Various extensions to String (<http://api.haxe.org/StringTools.html>)
* Type: Type-related reflection (<http://api.haxe.org/Type.html>)
* Xml: Cross-platform XML (<http://api.haxe.org/Xml.html>)
 
The haxe package:

* haxe.Http: HTTP requests (<http://api.haxe.org/haxe/Http.html>)
* haxe.Json: Encoding and decoding JSON (<http://api.haxe.org/haxe/Json.html>)
* haxe.Resource: Work with Haxe resources (<http://api.haxe.org/haxe/Resource.html>)
* haxe.Serializer: Serialize arbitrary objects as String (<http://api.haxe.org/haxe/Serializer.html>)
* haxe.Template: Simple templating system (<http://api.haxe.org/haxe/Template.html>)
* haxe.Timer: Repeated/delayed execution; measuring (<http://api.haxe.org/haxe/Timer.html>)
* haxe.Unserializer: Complement to haxe.Serializer (<http://api.haxe.org/haxe/Unserializer.html>)
* haxe.Utf8: Cross-platform UTF8 strings (<http://api.haxe.org/haxe/Utf8.html>)
* haxe.crypto: Various encryption algorhtms (<http://api.haxe.org/haxe/crypto/index.html>)
* haxe.macro: Types for working with Haxe macros (<http://api.haxe.org/haxe/macro/index.html>)
* haxe.remoting: Remoting between various client and server types (<http://api.haxe.org/haxe/remoting/index.html>)
* haxe.rtti: Run-time type information (<http://api.haxe.org/haxe/rtti/index.html>)
* haxe.unit: Basic unit-test framework (<http://api.haxe.org/haxe/unit/index.html>)
* haxe.web: Map URLs to operations (<http://api.haxe.org/haxe/web/index.html>)
* haxe.xml: Complementary XML tools (<http://api.haxe.org/haxe/xml/index.html>)
* haxe.zip: Support of the ZIP-format (<http://api.haxe.org/haxe/zip/index.html>)

The haxe.ds package:

* haxe.ds.ArraySort: Stable, cross-platform array sorting (<http://api.haxe.org/haxe/ds/ArraySort.html>)
* haxe.ds.BalancedTree: Balanced tree data structure (<http://api.haxe.org/haxe/ds/BalancedTree.html>)
* haxe.ds.EnumValueMap: Map type supporting enum value keys (<http://api.haxe.org/haxe/ds/EnumValueMap.html>)
* haxe.ds.GenericStack: Stack data structure which is optimized on static targets (<http://api.haxe.org/haxe/ds/GenericStack.html>)
* haxe.ds.IntMap: Map type supporting Int keys (<http://api.haxe.org/haxe/ds/IntMap.html>)
* haxe.ds.ObjectMap: Map type supporting object keys (<http://api.haxe.org/haxe/ds/ObjectMap.html>)
* haxe.ds.StringMap: Map type supporting string keys (<http://api.haxe.org/haxe/ds/StringMap.html>)
* haxe.ds.Vector: Fixed-size data structure (<http://api.haxe.org/haxe/ds/Vector.html>)

The haxe.io package:

* haxe.io.Bytes: Byte operations on native representations (<http://api.haxe.org/haxe/io/Bytes.html>)
* haxe.io.BytesBuffer: Optimized for building Bytes (<http://api.haxe.org/haxe/io/BytesData.html>)
* haxe.io.Path: Operations on path strings (<http://api.haxe.org/haxe/io/Path.html>)
