
## 2021-02-26 4.2.1:

__General improvements__:

* threads : changed main thread initialization to make main event loop available during static initialization ([#10114](https://github.com/HaxeFoundation/haxe/issues/10114))
* php : added extern for `number_format` function ([#10115](https://github.com/HaxeFoundation/haxe/issues/10115))
* python : rewrote `sys.thread.Thread`, `Mutex` and `Lock` as classes instead of abstracts.

__Bugfixes__:

* all : fixed compiler compatibility with OS X 10.13 ([#10110](https://github.com/HaxeFoundation/haxe/issues/10110))
* all : fixed compiler hanging on `switch` for abstracts with implicit casts involving type parameters and constraints ([#10082](https://github.com/HaxeFoundation/haxe/issues/10082))
* all : fixed inlining of `haxe.DynamicAccess.keyValueIterator` ([#10118](https://github.com/HaxeFoundation/haxe/issues/10118))
* all : fixed rest arguments typing against type parameters ([#10124](https://github.com/HaxeFoundation/haxe/issues/10124))
* analyzer : fixed side effect handling for enums ([#10032](https://github.com/HaxeFoundation/haxe/issues/10032))
* cpp : fixed handling of `cpp.ConstCharStar` with analyzer enabled ([#9733](https://github.com/HaxeFoundation/haxe/issues/9733))
* php : fixed failure with trailing slash in output dir ([#6212](https://github.com/HaxeFoundation/haxe/issues/6212))
* hl : fixed call stack of rethrown exceptions ([#10109](https://github.com/HaxeFoundation/haxe/issues/10109))