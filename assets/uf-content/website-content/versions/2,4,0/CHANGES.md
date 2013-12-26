### 2009-07-26: __2.04__

* flash9 : fixed get_full_path error with -D fdb
* js : fixed Array.remove on IE
* flash8 : removed extra empty AS3 tag (causing some issue with F8 loadMovie)
* improved speed of Bytes unserializing (no need for BytesBuffer)
* flash9 : bugfix, Null<Typedef> was generating dynamic code
* flash9 : added error message in flash.Vector if used without flash 10
* flash9 : fixed some "never" property access issues
* all : added "never" property access support for all platforms
* js : small syntax fix with value-blocks
* js : fixed Type.enumEq with null values
* js/flash8 : use &0xFF in haxe.io.Bytes.set
* flash9 : fixed switch on Null<Int> verify error
* flash9 : fixes related to UInt type + error when using Int/UInt comparison
* as3 : improved Vector support, inline flash.Lib.as
* as3 : bugfix with skip_constructor
* as3 : added Enum.__constructs__ (allow Type.getEnumConstructs)
* as3 : make all constructor parameters optional (allow Type.createEmptyInstance)
* as3 : bugfix with property access inside setter (stack overflow)
* all : Enum is now Enum<T>
* all : added Type.createEnumIndex
* all : forbid same name for static+instance field (not supported on several platforms)
* all : renamed haxe.Http.request to "requestUrl"
* all : renamed neko.zip.Compress/Uncompress.run to "execute"
* spod : fix very rare issue with relations and transactions
* compiler : added TClosure - optimize closure creation and ease code generation
* cpp : added CPP platform
* all : added 'using' syntax
* neko : added 'domains' optional param to ThreadRemotingServer to answer policy-file-request
* php : fixed php.db.Mysql so that getResult is consistent with Neko behavior
* php : fixed __toString for anonymouse objects
* php : fixed bug in overridden dynamic functions
* php : fixed round to be consistent with other platforms
* php : fixed bug concatenating two dynamic variables
* php : php.Lib.rethrow now works as expected
* flash9 : fixed bug with SWC output and recursive types
* flash8 : fixed inversed arguments in __new__
* neko : added neko.net.Socket.setFastSend
* php: fixed String.charCodeAt
* php: minor optimization (removed foreach from std code)
* php: implemented haxe.Stack
* php: changed exception handler to use haXe call stack
* php: changed special vars to use the » prefix instead of __
* php: fixed use of reserved keywords for var names
* php: List iterator is now class based (faster)
* php: fixed behavior of class variables having assigned functions
* php: fixed php.db.Manager (was uncorrectly removing superclass fields)
* php: added support for native Iterator and IteratorAggregate interfaces
* all : added --display classes and --display keywords
* all : fixed issue with optional parameters in inline functions
* all : allow implementing interfaces with inline methods
* all : enable inlining for getter/setter/iterator/resolve/using
