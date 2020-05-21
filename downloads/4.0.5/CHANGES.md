
## 2019-12-17: 4.0.5

__Bugfixes__:

* java : fix boolean arguments for `Type.createInstance(cls, args)` ([#9025](https://github.com/HaxeFoundation/haxe/issues/9025))
* jvm : fix static overloads ([#9034](https://github.com/HaxeFoundation/haxe/issues/9034))
* java/cs : fixed `Reflect.makeVarArgs(fn)` for calls of `fn` without arguments ([#9037](https://github.com/HaxeFoundation/haxe/issues/9037))
* js : fix multiple appearances of the first object added to `ObjectMap` is passed to `ObjectMap.set(obj, v)` multiple times ([#9026](https://github.com/HaxeFoundation/haxe/issues/9026))
* js : automatically wrap compound expressions with parentheses when passed to `js.Syntax.code()` ([#9024](https://github.com/HaxeFoundation/haxe/issues/9024))
* windows : fix adding neko to PATH env var when running windows installer ([#9021](https://github.com/HaxeFoundation/haxe/issues/9021))