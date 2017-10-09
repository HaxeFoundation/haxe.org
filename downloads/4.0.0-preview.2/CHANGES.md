
## 2017-10-08: 4.0.0-preview.2

__New features__:

* all : added final keyword ([#6596](https://github.com/HaxeFoundation/haxe/issues/6596))

__General improvements and optimizations__:

* all : replaced some occurrences of List with Array
* all : changed haxe.xml.Fast to an abstract
* all : improved optimization when comparing against `null`
* all : added support for `case var x` syntax and detect possible typos ([#6608](https://github.com/HaxeFoundation/haxe/issues/6608))
* php : changed `--php-prefix`, `--php-front` and `--php-lib` to `-D php-prefix=`, `-D php-front=` and `-D php-lib=` respectively

__Removals__:

* all : moved haxe.unit to hx3compat
* all : moved haxe.web.Request to hx3compat
* php : dropped php5 support; minimum supported php version is 7.0 now

__Bugfixes__:

* all : fixed issue with various functions not being displayed in macro context ([#6000](https://github.com/HaxeFoundation/haxe/issues/6000))
* all : fixed invalid  static extension lookup on `super` ([#3607](https://github.com/HaxeFoundation/haxe/issues/3607))
* all : fixed typing error when constructing enums with abstracts over functions ([#6609](https://github.com/HaxeFoundation/haxe/issues/6609))
* all : fixed bug that skipped checking @:from typing in some cases ([#6564](https://github.com/HaxeFoundation/haxe/issues/6564))
* all : fixed Int64 parsing of negative numbers that end in a zero ([#5493](https://github.com/HaxeFoundation/haxe/issues/5493))
* all : fixed top-down inference when constructing enums ([#6606](https://github.com/HaxeFoundation/haxe/issues/6606))
* eval : fixed bug with equality handling
* eval : fixed issue with file creation not defaulting to binary
* eval : fixed invalid override detection ([#6583](https://github.com/HaxeFoundation/haxe/issues/6583))
* eval : fixed infinite recursion when printing arrays/vectors
* cs/java : fixed DCE bug that would lose toString method of thrown objects
* php/python : fixed some bit operators for Int32 ([#5938](https://github.com/HaxeFoundation/haxe/issues/5938))
* php : fixed accessing `static inline var` via reflection ([#6630](https://github.com/HaxeFoundation/haxe/issues/6630))
* php : fixed Math.min() and Math.max() for NAN on PHP 7.1.9 and 7.1.10
* js : fixed js syntax error for `value.iterator--` ([#6637](https://github.com/HaxeFoundation/haxe/issues/6637))

__Standard Library__:

* macro : added have.display.Position and PositionTools.toRange ([#6599](https://github.com/HaxeFoundation/haxe/issues/6599))
* all : moved List to haxe.ds ([#6610](https://github.com/HaxeFoundation/haxe/issues/6610))
