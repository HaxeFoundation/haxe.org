
## 2019-11-11: 4.0.2

__General improvements and optimizations__:

* php : improved performance of `haxe.io.Bytes.get()` ([#8938](https://github.com/HaxeFoundation/haxe/issues/8938))
* php : improved performance of serialization/unserialization of `haxe.io.Bytes` ([#8943](https://github.com/HaxeFoundation/haxe/issues/8943))
* php : improved performance of enum-related methods in `Type` class of standard library

__Bugfixes__:

* haxelib : Fixed too strict requirements to haxelib.json data for private libs
* all : fixed `@:using` static extensions on `Null<SomeType>` ([#8928](https://github.com/HaxeFoundation/haxe/issues/8928))
* php : fixed static methods with the same name in parent and child classes ([#8944](https://github.com/HaxeFoundation/haxe/issues/8944))