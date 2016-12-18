* js : added js.Scroll
* js : package names are now checked at runtime to avoid clashes with existing libs
* js : added --js-namespace to create a namespace for types that are defined in the root
* all : updated xml output and html doc - add inline, override, dynamic functions support
* all : added error when comparing enum with arguments
* all : optimize constant equality for enums
* flash9 : fixed verify error with inline + null type
* flash9 : bugfix when overriding/implementing an method with an applied type parameter
* php : fixed issues with classes that implement Dynamic
* all : ignore #! line at beginning of the hx file
* haxelib : added tags, added documentation
* flash8 : don't use b64 encoding for text ressources
* php : fixed bug in Hash.exists for null values and Reflect.callMethod
* js/flash9 : throw exception in Xml.parse when unclosed node
* all : improve return type progagation in inlined expression (fix some VerifyErrors)
* all : optimize {const} into const
* all : added structure / Dynamic<T> subtyping
* all : fixed List.map2 error when inline + optional args
* flash9 : encode all ISO constant strings into UTF8 at compilation time
* all : allow hxml with only -cmd statements
* spod : moved Manager.addQuote to Connection.addValue
* flash9 : removed .iterator() from Vector (not implementable)
* all : fixed haxe.rtti.Generic on interfaces
* php : fixed issue with Reflect.callMethod
* php : fixed issue with PHP reserved word used in callbacks
* all : bugfix with non-constant enums in switches
* flash9 : fix for interfaces (use namespace)
* all : "using" now works for identifiers in member methods
* flash9 : bugfix with switch on some big integers
* all : bugfix when optimizing (function(x) return x)(x)
* neko : improved speed of Xml.toString()
* all : added -D dump (for debugging purposes)
* neko : added neko.Web.isTora
* php : added php.db.PDO (php.db.Sqlite is now deprecated)
* php : fixed bug in Type.getClassFields() that reported duplicated entries
* php : fixed errror in XML error reporting
* all : allow sub-types declarations everywhere (pack.Type.Sub)
* all : added completion for sub-types declarations
* all : improved completion with lambda function
* as3 : several generation fixes
* all : bugfix haxe.rtti.Generic on private class
* php/js/cpp : sanitize binary expressions to prevent inlining errors
* spod : remove object from cache when deleted
