### 2011-01-30: __2.07__

* all : fixed completion support with --remap
* all : added macros, added --interp
* all : removed 'here' special identifier
* neko : fixed neko.Web.getParamsString() returning "null" instead of ""
* flash9 : fixed issue with @:bind
* flash9 : added some missing errors
* flash9 : fixed TypedDictionary.exists
* all : added @:build and @:autoBuild for enums and classes
* neko : Std.parseFloat now returns NaN with invalid string
* php: fixed Array.push must return the current length (issue 219)
* php: fixed EReg.replace (issue 194)
* php: FileSystem.readDirectory now skips '.' and '..' to be consistent with neko (issue 226)
* flash9 : add trace text on stage (always over current and subclips)
* flash9 : delay SWF initialization until it's added on stage and stageWidth > 0
*          (this can be disabled with -D dontWaitStage)
* all : added haxe.Timer.measure
* all : added Lambda.indexOf and Lambda.concat
* all : no longer allow inline vars as metadata values
* neko : added getFieldsNames to neko.db.ResultSet (supported in Neko 1.8.2 mysql driver)
* all : added --macro and haxe.macro.Compiler
* all : allow macro type patches
* flash9 : changed --gen-hx-classes implementation
* now use 'haxe -swf-lib lib.swf --gen-hx-classes' instead
* flash9 : added @:getter and @:setter
* all : added @:require
* flash9 : moved vector utils functions from flash.Lib to flash.Vector
* flash9 : added support for FP 10.1 and 10.2
* flash9 : added @:meta(Meta(k="v")) support
* all : improved #if support (fixed ! precedence)
* all : lookup unqualified types in all package hierarchy and not only in current package
* flash : set default flash version to 10 (-swf9 deprecated, use -swf-version 8 for avm1)
* php : added --php-lib to allow to rename the destination path of the generated lib
* all : added --dead-code-elimination, removes unused functions from the output
*      (beta feature could not make in the final release)
* all : added @:keep to prevent --dead-code-elimination of class/method
* flash9 : fixed issues with loading a haXe SWF (boot_XXXX class extends flash.Boot)
* all : allow to inline override methods (if the superclass method is not inlined already)
* all : fixed escape sequences in literal regular expressions
* flash9 : fixed Xml.setNodeValue
* all : removed -excluded, replaced by --macro excludeFile('filename')
* all : added --macro exclude('package') and --macro include('package')
* all : importing a typedef of an enum allow to access its constructors
* all : removed String.cca (replaced by StringTools.fastCodeAt + StringTools.isEOF)
* flash9 : fixed use of default values when null is passed for nullable basic types
* all : fixed issues with inlining and class/function type parameters
* all : big speedup for compiler internal completion
* all : added --macro keepClass('classname')
* flash9 : fixed Xml.nodeValue for comments (does not include <!--/-->)
* all : added named local functions (allow self-recursion)
* all : use left-assoc for (==,!=,>,>=,<,<=)(==,!=,>,>=,<,<=) (&&)(&&) and (||)(||)
* all : give prefix unary operators higher priority than ?:
* php : fixed XML parsing
* cpp : many fixes
