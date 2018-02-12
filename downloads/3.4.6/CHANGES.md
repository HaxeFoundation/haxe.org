
## 2018-02-12: 3.4.6

__Bugfixes__:

* all : fixed a bug when Haxe compiler couldn't find std lib on Linux if executed by another program
* all : fixed "Unix.Unix_error" compiler failure if output directory contains a trailing slash ([#6212](https://github.com/HaxeFoundation/haxe/issues/6212), [#6768](https://github.com/HaxeFoundation/haxe/issues/6768))
* php7 : fixed an issue with "Object" used as a class name for PHP 7.2 (it's a new keyword in php) ([#6838](https://github.com/HaxeFoundation/haxe/issues/6838))
* as3 : fixed "inifinite recursion" compiler error for classes named "Object"