
## 2024-03-04 4.3.4

__General improvements__:

* all : allow @:using with Class and Enum ([#11553](https://github.com/HaxeFoundation/haxe/issues/11553))
* display : expose list of metadata/defines ([#11399](https://github.com/HaxeFoundation/haxe/issues/11399))

__Bugfixes__:

* all : typedef vs. GADT ([#11446](https://github.com/HaxeFoundation/haxe/issues/11446))
* all : don't double-throw exceptions ([#11175](https://github.com/HaxeFoundation/haxe/issues/11175))
* all : fix some abstract inlining failures ([#11526](https://github.com/HaxeFoundation/haxe/issues/11526))
* all : fix JsonPrinter empty parent class ([#11560](https://github.com/HaxeFoundation/haxe/issues/11560))
* all : dce: clean up operator handling ([#11427](https://github.com/HaxeFoundation/haxe/issues/11427))
* all : analyzer: deal with unreachable block in binops ([#11402](https://github.com/HaxeFoundation/haxe/issues/11402))
* all : analyzer: don't recursively check enum values when const propagating ([#11429](https://github.com/HaxeFoundation/haxe/issues/11429))
* all : analyzer: fix check for inlined purity meta
* display : fix errors from parser missing in diagnostics ([#8687](https://github.com/HaxeFoundation/haxe/issues/8687))
* display : fix display services with static extension ([#11285](https://github.com/HaxeFoundation/haxe/issues/11285))
* display : fix display services with safe navigation ([#11205](https://github.com/HaxeFoundation/haxe/issues/11205))
* hl : hlopt rework try-catch control flow ([#11581](https://github.com/HaxeFoundation/haxe/issues/11581))
* hl/c : fix reserved keywords ([#11408](https://github.com/HaxeFoundation/haxe/issues/11408))

__Deprecation / future version handling__:

* all : don't infer string on concat, when using -D haxe-next ([#11318](https://github.com/HaxeFoundation/haxe/issues/11318))
* all : handle optional arguments with bind, when using -D haxe-next ([#11533](https://github.com/HaxeFoundation/haxe/issues/11533))
* macro : build order vs inheritance, when using -D haxe-next ([#11582](https://github.com/HaxeFoundation/haxe/issues/11582))
* macro : deprecate some API from haxe.macro.Compiler (see #11540)
* java/jvm : warn about --java ... -D jvm vs --jvm ...
