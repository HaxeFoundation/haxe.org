
## 2025-05-09 4.3.7

__General improvements__:

* all : update bundled haxelib version to 4.1.1
* all : update bundled neko version to 2.4.1 ([#12183](https://github.com/HaxeFoundation/haxe/issues/12183))
* all : use -w rules instead of defines to configure warnings (#11826, #12013)

__Bugfixes__:

* all : fix compiler hanging issue ([#11820](https://github.com/HaxeFoundation/haxe/issues/11820))
* all : local statics fixes (#11803, #11849)
* all : fix for inline constructor bug triggering "Unbound variable" ([#12169](https://github.com/HaxeFoundation/haxe/issues/12169))
* all : check caught error position when recovering from match typing failure ([#12098](https://github.com/HaxeFoundation/haxe/issues/12098))
* macro : local statics vs ExprTools.map ([#12030](https://github.com/HaxeFoundation/haxe/issues/12030))
* eval : https fixes (mbedtls update) ([#11646](https://github.com/HaxeFoundation/haxe/issues/11646))
* eval : ssl cert verification failures on windows ([#11838](https://github.com/HaxeFoundation/haxe/issues/11838))
* hl/c : fix comparison of HArray,HArray and HBytes,HBytes ([#11610](https://github.com/HaxeFoundation/haxe/issues/11610))
* cppia : generate scriptable functions for overriden functions ([#11773](https://github.com/HaxeFoundation/haxe/issues/11773))
