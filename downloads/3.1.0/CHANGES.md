__New features__:

* all : allowed null-patterns in pattern matching
* all : allowed extractors in pattern matching using `=>` syntax
* all : allowed extending generic type parameters
* all : allowed `(expr : type)` syntax (ECheckType)
* all : allowed @:enum and @:forward on abstracts
* all : allowed using abstracts as static extension
* all : allowed Class.new
* all : added EnumValue.match
* all : allow multiple structural extension using `{ > T1, > T2, fields }`
* all : inline array and structure declarations if possible
* cs : added -net-lib
* cs : support for native delegates
* cs : support for attributes
* cs : support for events

__Standard Library__:

* all : support abstract types in haxe.rtti.XmlParser
* all : added Std.instance
* all : added length field to BytesBuffer, BytesOutput, BytesInput and StringBuf
* all : added UInt for all targets
* all : added Array.indexOf and Array.lastIndexOf
* all : added haxe.xml.Printer
* all : added haxe.Int32 as abstract type
* all : added haxe.format.JsonParser/Printer

__General improvements and optimizations__:

* all : optimized pattern matching output
* all : allowed recursive type parameter constraints
* all : improved support of custom @:coreType abstracts
* all : evaluate conditional expressions in @:require
* all : improved inline constructors by detecting more cases where it can be applied
* js : improved inlining
* js : always use JSON extern (compile with -D old-browser to disable)
* js : added -D js-flatten
* js : added -D js-es5
* cpp : improved side-effect detection

__Bugfixes__:

* all : inlining a parameter which has side effects will not remove it even if not used
* all : implemented constraints check on enum and enum field type parameters
* all : fixed memory leak in compilation server and optimized caching in general
* all : fixed issue with invalid lowercase class name in Windows completion
* flash : fixed font embedding with UTF8 chars
* flash : give error if non-nullable basic types are skipped in a call
* flash : give error if assigned parent class field values would be overwritten by super()

__Macro features and changes__:

* macro : add Context.onAfterGenerate
* macro : add Context.typeExpr
* macro : add Context.getExpectedType
* macro : add ExprTools.getValue
* macro : allowed `$v{(c:Float|Int|String)}`
* macro : resolve error line number in external files
* macro : rewrote macros used as static extension
* macro : exposed typed AST
* macro : added @:genericBuild
* macro : [breaking] first argument of `ComplexType.TExtend` is now `Array<TypePath>` instead of `TypePath`
* macro : improved expression printing