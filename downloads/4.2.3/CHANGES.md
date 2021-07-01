
## 2021-07-01 4.2.3:

__General improvements__:

* all : analyzer optimizations
* macro : support maps in `haxe.macro.Context.makeExpr` ([#10259](https://github.com/HaxeFoundation/haxe/issues/10259))
* js : added `-D js-global=globalThis` to customize global object name ([#10282](https://github.com/HaxeFoundation/haxe/issues/10282))
* php : added externs for `quoted_printable_decode`, `quoted_printable_encode`, `Attribute`, `NumberFormat`, `IntlCalendar` and other `Intl*` classes

__Bugfixes__:

* all : fixed compiler crash on some unreachable code blocks ([#10261](https://github.com/HaxeFoundation/haxe/issues/10261))
* jvm : fixed `@:native` ([#10280](https://github.com/HaxeFoundation/haxe/issues/10280))
* jvm : fixed `--xml` generation ([#10279](https://github.com/HaxeFoundation/haxe/issues/10279))