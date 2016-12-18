* java/cs : added two new targets (beta)
* all : fixed List and `Null<T>` for first, last, pop
* js : added `js.Lib.debug()`
* flash : fixed `Xml.parent()` when no parent
* flash : fixed `haxe.io.Bytes.blit` when `len=0`
* js/php/flash8 : fixed `haxe.Int32.mul` overflow on 52 bits
* js : fixed `haxe.Utf8` usage (static 'length' issue)
* all : does not allow overriding var/prop
* flash : removed wrapping for Xml nodes, use instead specific compare when comparing two typed nodes
* js : use new `haxe.xml.Parser` (faster, not based on Regexp)
* flash : fixed completion issue with `for( x in Vector )`
* all : optimized `Std.int(123)` and `Std.int(123.45)`
* flash : bugfix for `@:bitmap` with 24-bits PNG (flash decode wrong colors)
* as3 : fixed EnumValue becomes Object
* js : removed js.Lib.isIE/isOpera (not complete, use js.JQuery.browser instead)
* all : function parameters are nullable if they are declared with `?`
* all : added support for finding common base types of multiple types (unify_min) for array, switch, if
* php : do not implement duplicate interfaces
* haxelib : added git support through haxelib git
* all : allow derived classes to widen method visibility
* macro : added `haxe.macro.Context.getLocalMethod`
* macro : improved support of `using` macro functions
* php : optimized Xml implementation
* php : fixed Reflect.get/setProperty not working on PHP < 5.3
* all : support for `callback(f, _, x)`
* all : allow private access between classes that have a common base class
* all : added Output.writeFloat/Double and Input.readFloat/Double
* all : support for `var:{x:Float} = { x = 1 }` constant structure subtyping
* all : allow contravariant function arguments and covariant function returns in overrides
* macro : support for final `Array<Expr>` argument as rest argument
* macro : use top-down inference on macro calls
* all : made "using" imply "import"
* all : made String concat more consistent across platforms (add Std.string wrappers)
* all : allow direct member variable/property and static property initialization
* js : greatly reduced amount of generated code by using smarter DCE
* php : made modulo operations more consistent
* all : allow local functions to have both type parameters and be inlined
* all : functions type parameters can be constraint (will be checked at end of compilation)
* macro : use NekoVM runtime for regexps, process and xml parsing
* flash : allow @:getter/@:setter in interfaces
* flash : added support for "arguments" in methods
* all : not used enums and inline var/methods are now removed by DCE
* all : allow @:overload to use type parameters and not-absolute type paths
* all : ensure that Std.string of arrays and enums are now consistent across platforms
* all : allow to inline functions containing other functions
* xml : added metadata output to xml generator
* macro : added macro `<expr>` and `macro : <type>` reification
* all : renamed `type(e)` to `$type(e)`
* as3 : support for metadata and resources, and other fixes
