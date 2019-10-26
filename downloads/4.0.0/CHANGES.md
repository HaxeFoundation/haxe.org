
## 2019-10-26: 4.0.0

__General improvements__:

* js : updated externs for `Float32Array` and `Float64Array` ([#8864](https://github.com/HaxeFoundation/haxe/issues/8864))
* php : added array access to `php.NativeStructArray` ([#8893](https://github.com/HaxeFoundation/haxe/issues/8893))

__Bugfixes__:

* cs : fixed "This expression may be invalid" false warning ([#8589](https://github.com/HaxeFoundation/haxe/issues/8589))
* php : fixed iterator fields on maps being removed ([#8851](https://github.com/HaxeFoundation/haxe/issues/8851))
* php : fixed `-2147483648` as init value for static vars ([#5289](https://github.com/HaxeFoundation/haxe/issues/5289))
* python : fixed modulo by a negative number ([#8845](https://github.com/HaxeFoundation/haxe/issues/8845))
* java : fixed backslash escaping on `EReg.replace` ([#3430](https://github.com/HaxeFoundation/haxe/issues/3430))
* lua : fixed `EReg.map` for unicode ([#8861](https://github.com/HaxeFoundation/haxe/issues/8861))
* hl : fixed sqlite connection on OSX/Linux ([#8878](https://github.com/HaxeFoundation/haxe/issues/8878))