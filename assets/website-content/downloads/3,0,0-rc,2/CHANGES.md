### 2013-05-08: __3.0.0-RC2__

* all : improved abstract support
* all : renamed HAXE_LIBRARY_PATH to HAXE_STD_PATH
* all : added inlinable constructors
* all : renamed haxe.ds.FastCell to GenericCell
* all : fixed >= operator in #if conditionals
* all : improved completion support for Unknown results
* all : allowed [] access for Map
* all : added haxe.ds.WeakMap (not yet supported on all platforms)
* all : all trace parameters are now printed by default
* all : added --help-metas
* all : improved completion
* all : improved pattern matching variable capture and GADT support
* js : cached $bind results (unique closure creation per instance)
* js : removed --js-modern (now as default)
* cpp : added socket.setFastSend
* flash : update player 11.7 api
* flash : improved @:font, @:sound and @:bitmap support
* neko/java/cs : improved Array performances when growing with []
* java : added -java-lib support
* java : added sys.net package implementation (alpha)
* java : complete java std library through hxjava haxelib
* java/cs : added support for overloaded function declarations
* java/cs : overload selection algorithm
* cs : operator overloading is now accessible through Haxe
* cs : source mapping; can be disabled with -D real_position
* as3 : fixed rare syntax ambiguity
* php : removed initialization of some inline fields
* macro : fixed several issues with 'using' a macro function
* macro : improved expression printing
