### 2015-05-12: __3.2.0__

__New features__:

* all : added @:noPrivateAccess to re-enable access restrictions within @:privateAccess
* cpp : some support for @:nativeGen metadata

__Bugfixes__:

* all : fixed detection of @:generic classes with constructor constraints
* all : fixed variable initialization check issue in loop condition
* all : fixed pattern matching on @:enum abstracts via field access ([#4084](https://github.com/HaxeFoundation/haxe/issues/4084))
* all : fixed missing implicit casts in Map literals ([#4100](https://github.com/HaxeFoundation/haxe/issues/4100))
* all : fixed various minor issues in haxe.xml.Parser
* all : fixed class path issue when HAXE_STD_PATH is set ([#4163](https://github.com/HaxeFoundation/haxe/issues/4163))
* js : fixed DCE issue related to printing enums ([#4197](https://github.com/HaxeFoundation/haxe/issues/4197))
* js : fixed various issues with the new Bytes implementation
* php : fixed EOF handling in FileInput.readByte ([#4082](https://github.com/HaxeFoundation/haxe/issues/4082))
* cs/java : fixed Math.fround implementation ([#4177](https://github.com/HaxeFoundation/haxe/issues/4177))
* cs/java : fixed some cases of Std.parseInt failing ([#4132](https://github.com/HaxeFoundation/haxe/issues/4132))
* cpp : fixed compilation without -main ([#4199](https://github.com/HaxeFoundation/haxe/issues/4199))

__General improvements and optimizations__:

* all : --macro keep no longer causes types to be included for compilation
* php : support interpolation in __php__ code
* js : added variable number of arguments support in js.html.* classes
* js : refined new HTML externs

__Macro features and changes__:

* macro : [breaking] synced FClosure and FInstance with the compiler updates
