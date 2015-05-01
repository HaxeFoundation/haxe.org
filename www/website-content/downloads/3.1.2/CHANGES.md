### 2014-03-29: __3.1.2__

__Bugfixes__:

* all : disallowed spaces between >>, >>>, >>= and >>>=
* all : fix branching issue when switching on Dynamic values with only one case
* all : added missing abstract cast call when checking for equality
* all : fixed member fields initializations on parent classes that have no constructor
* all : fixed toString usage of abstracts which are argument to Std.string
* flash : avoid rare FP 12 PPAPI JIT crash
* cpp : fixed bug in side-effect handler which caused incorrect behavior of while loops
* js : fixed missing print function for enum values with DCE
* macro : make sure member field initializations are respected

__General improvements and optimizations__:

* all : cached file exist checks to speed up compilations with a lot of class paths
* all : improved completion related to super class fields
* all : allowed iterating on abstract which have get_length and @:arrayAccess fields
* js : improved Type.allEnums implementation to avoid issues with obfuscation

__Standard Library__:

* all : added haxe.io.Bytes.readDouble/Float
* all : added haxe.io.BytesBuffer.addString/Float/Double