
## 2019-11-04: 4.0.1

__Bugfixes__:

* haxelib : fixed git dependencies in haxelib.json
* neko : updated windows & osx installer to install Neko 2.3.0 ([#8906](https://github.com/HaxeFoundation/haxe/issues/8906))
* jvm : fixed compilation failure caused by a specific usage of `Array<Dynamic>` ([#8872](https://github.com/HaxeFoundation/haxe/issues/8872))
* all : fixed compiler crash on loops with `continue` in all branches of the body ([#8912](https://github.com/HaxeFoundation/haxe/issues/8912))
* all : fixed erasing typedef in AST on field access to forwarded abstract fields ([#8919](https://github.com/HaxeFoundation/haxe/issues/8919))
