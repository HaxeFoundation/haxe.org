2017-01-31: 3.4.0

__General improvements and optimizations__:

* all : support completion for static extensions ([#5766](https://github.com/HaxeFoundation/haxe/issues/5766))
* all : removed neko dependency for macros, use PCRE instead
* all : disabled analyzer optimizations by default, re-enable with -D analyzer-optimize
* php7 : generate native `$v instanceof MyType` instead of `Std.is(v, MyType)` where possible for better performance
* php7 : added @:phpNoConstructor meta for externs which do not have native php constructors and yet can be constructed
* php7 : greatly reduced amount of generated tmp vars
* php7 : `Array` performance improvements
* hl : made various improvements

__Bugfixes__:

* all : fixed `using` picking up non-static abstract functions ([#5888](https://github.com/HaxeFoundation/haxe/issues/5888))
* all : fixed issue with side-effect detection when optimizing ([#5911](https://github.com/HaxeFoundation/haxe/issues/5911))
* all : fixed issue with zlib bindings causing zlib_deflate errors ([#5941](https://github.com/HaxeFoundation/haxe/issues/5941))
* php7 : Allow user-defined modules in `php` package ([#5921](https://github.com/HaxeFoundation/haxe/issues/5921))
* php7 : Dereference some of `php.Syntax` methods if required ([#5923](https://github.com/HaxeFoundation/haxe/issues/5923))
* php : fixed assigning a method of dynamic value to a variable ([#5469](https://github.com/HaxeFoundation/haxe/issues/5469))
* php : fixed missing initialization of dynamic methods in classes with empty constructors ([#4723](https://github.com/HaxeFoundation/haxe/issues/4723))