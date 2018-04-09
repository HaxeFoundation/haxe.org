__New features__:

* all : added --display mode for toplevel completion
* all : added --display mode for position and usage information
* all : allowed @:callable on abstracts to forward calls to their underlying type
* all : allowed pattern matching on getters
* all : allowed @:native on class fields
* all : added static analyzer with constant propagation
* all : added Haxe-based XML implementation
* python : added python target
* flash : flash player 12-14 support
* js : added @:jsRequire and js.Lib.require
* js : support haxe.CallStack.exceptionStack
* cs : added @:bridgeProperties
* cs : added -D erase_generics
* cs : added -D dll_import to import haxe-generated dlls
* java/cs : added `sys.db` package
* java/cs : clean unused files in output folder, unless `-D keep_old_output` is defined
* java/cs : added `-c-arg` to add C#/Java compiler arguments
* cpp : inititial implementation of cppia scripting

__Bugfixes__:

* all : fixed nullability of abstracts over functions
* all : fixed some equality checks between UInt and Int
* all : fixed rare issue with abstract casts
* all : fixed some internal code which relied on unspecified evaluation order
* all : fixed exhaustiveness checks involving guards
* all : fixed issue involving recursively constrained type parameters and @:generic
* all : fixed type inference issue in map literals
* all : fixed type inference issue when calling abstract method from within the abstract
* all : fixed several abstract variance issues
* all : fixed DCE issues with interface properties
* all : fixed variance issue with function variables and dynamic methods on interfaces
* all : fixed pattern matching on empty arrays that are typed as Dynamic
* all : fixed various @:generic issues
* all : fixed default cases on @:enum abstract being omitted
* all : fixed various expression positions
* all : disallowed break/continue in closures in loops
* all : disallowed inline functions in value places
* all : fixed parsing of cast followed by parentheses
* all : fixed resource naming in case of invalid file system characters
* all : fixed issue with inlined array declarations with field access
* cpp : fixed issue with the side-effect handler
* cpp : fixed issue with NativeArray in --no-inline mode
* php : fixed issue with invalid references for closures in for-loops
* php : fixed Reflect.compare and string comparison for numeric strings
* cs/java : fixed various issues with -java-lib and -net-lib.
* cs/java : added @:libType to skip checking on -java-lib / -net-lib types
* cs/java : compilation server now works with C#/Java [experimental support]
* cs : fixed Type.enumIndex / switch on C# native enums
* cs : fixed reflection on COM types
* java : fixed sys.net.Socket server implementation
* spod : various fixes - working now on cpp, java, neko, php and c#
* cpp : improved boot order, with enums constants first

__General improvements and optimizations__:

* all : disallowed using `super` in value positions
* all : check exhaustiveness of explicit Null types
* all : resolve unqualified identifiers to @:enum abstract constructors
* all : determine @:generic type parameters from constructor call if possible
* all : properly disallowed field redefinition in extending interface
* all : properly disallowed leading zeroes for Int and Float literals
* all : allowed variance on interface variables
* all : allowed pattern matching on arrays if they are typed as Dynamic
* all : allowed pattern matching on fields of parent classes
* all : -D doc-gen no longer implies -dce no
* all : allowed matching against null on any enum instance
* flash/js: optimized haxe.ds.StringMap
* neko : create output directory if it does not exist
* js : inline Math methods and fields
* cs/java : optimized Reflect.fields on dynamic structures
* cs/java : haxe will now clear output directory of old files (use -D keep-old-output to keep them)
* cs : optimized field lookup structure
* cs : optimized casting of parametrized types
* cs : beautify c# code output
* cs : added `cs.Flags` to manipulate C# enums that can be also flags
* xml : improved documentation generation and fixed missing entity escaping
* cpp : property access via Dynamic variables now requires property to be declared with @:nativeProperty
* cpp : allow injection of code from relative paths using @:sourceFile and @:cppInclude
* cpp : stronger typing of native functions via cpp.Function + cpp.Callable
* cpp : moved 'Class' implementation to hx namespace to improve objective C interaction
* cpp : added file_extension define to change the output filename extension (eg, ".mm")
* cpp : added pre-calculated hashes to string constants to allow faster lookups
* cpp : map implementation allows strongly typed interactions in some cases (avoids boxing)
* cpp : added native WeakMap implementation
* cpp : put each resource into own cpp file to allow more data/smaller files

__Standard Library__:

* all : added typed arrays to haxe.io package
* all : added haxe.ds.Either
* all : added haxe.extern.Rest type for representing "rest" arguments in extern method signatures
* all : added haxe.extern.EitherType abstract type for dealing with externs for dynamic targets
* all : added haxe.DynamicAccess type for working with dynamic anonymous structures using a Map-like interface
* all : [breaking] changed haxe.ds.Vector.get to return T instead of `Null<T>`
* all : added haxe.macro.Compiler.addGlobalMetadata
* all : changed haxe.Int64 to be an abstract type instead of a class
* js : updated HTML externs

__Macro features and changes__:

* macro : added Context.getLocalTVars
* macro : added TypedExprTools.iter
* macro : added Context.getCallArguments
* macro : changed @:genericBuild macros to prefer ComplexType returns
* macro : [breaking] extended TAnonymous structures now have AExtend status instead of AClosed
* macro : added Context.getDefines
* macro : fixed file_seek from end (position was inversed)
* macro : added Context.storeTypedExpr
* macro : allowed type name reification

__Deprecations__:

* all : deprecated structurally extending classes and interfaces
* sys : Sys.command shell special chars (&|<>#;*?(){}$) are now properly escaped
* java/cs : Lib.nativeType is now renamed to Lib.getNativeType
* The Flash 8 target has been removed