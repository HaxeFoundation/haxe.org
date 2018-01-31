
## 2018-01-31: 3.4.5

__General improvements and optimizations__:

* dce : optimized DCE performance (#6181)

__Bugfixes__:

* dce : don't remove constructor if any instance field is kept ([#6062](https://github.com/HaxeFoundation/haxe/issues/6062))
* js : fixed saving setter to `tmp` var before invocation ([#6672](https://github.com/HaxeFoundation/haxe/issues/6672))
* php7 : don't fail on generating import aliases for classes with the similar names ([#6680](https://github.com/HaxeFoundation/haxe/issues/6680))
* php7 : fixed appending "sqlite:" prefix to the names of files created by `sys.db.Sqlite.open()` ([#6692](https://github.com/HaxeFoundation/haxe/issues/6692))
* php7 : made php.Lib.objectOfAssociativeArray() recursive ([#6698](https://github.com/HaxeFoundation/haxe/issues/6698))
* php7 : fixed php error on parsing expressions like `a == b == c` ([#6720](https://github.com/HaxeFoundation/haxe/issues/6720))
* php7 : fixed `Math.min()` and `Math.max()` for NAN on PHP 7.1.9 and 7.1.10
* php/php7 : fixed `sys.net.Socket.bind()` ([#6693](https://github.com/HaxeFoundation/haxe/issues/6693))