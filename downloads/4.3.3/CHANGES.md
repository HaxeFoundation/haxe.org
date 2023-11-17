
## 2023-09-17 4.3.3

__General improvements__:

* all : improve extra field error range ([#11335](https://github.com/HaxeFoundation/haxe/issues/11335))
* all : better error messages for --connect
* hl : improve error message when hl_version is missing ([#11086](https://github.com/HaxeFoundation/haxe/issues/11086))
* hl/c : compiler now adds hlc define when targeting hl/c ([#11382](https://github.com/HaxeFoundation/haxe/issues/11382))
* macro : update macro API restriction warnings when using -D haxe-next ([#11377](https://github.com/HaxeFoundation/haxe/issues/11377))

__Bugfixes__:

* all : handle non existing files for positions in pretty errors ([#11364](https://github.com/HaxeFoundation/haxe/issues/11364))
* all : metadata support for local static vars
* all : catch trailing invalid syntax in string interpolation ([#10287](https://github.com/HaxeFoundation/haxe/issues/10287))
* eval : fix Array.resize retaining values ([#11317](https://github.com/HaxeFoundation/haxe/issues/11317))
* eval/hl : fix catching haxe.ValueException ([#11321](https://github.com/HaxeFoundation/haxe/issues/11321))
* hl : make genhl respect Meta.NoExpr ([#11257](https://github.com/HaxeFoundation/haxe/issues/11257))
* hl : don't add bindings for non existing methods
* hl/c : add missing I64 mod support
* hl/c : rework reserved keywords (#11293, #11378)
* hl/c : fix Int64 unsigned right shift overflow ([#11382](https://github.com/HaxeFoundation/haxe/issues/11382))
* java/cs: fix stack overflow from closures constraints ([#11350](https://github.com/HaxeFoundation/haxe/issues/11350))
* js : DOMElement insertAdjacentElement should not be pure ([#11333](https://github.com/HaxeFoundation/haxe/issues/11333))
* macro : catch trailing invalid syntax in Context.parseInlineString ([#11368](https://github.com/HaxeFoundation/haxe/issues/11368))
* macro : fix TDAbstract without flags in haxe.macro.Printer
