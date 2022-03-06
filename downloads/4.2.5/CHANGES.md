## 2022-03-06 4.2.5:

__New features__:

* php : support PHP attributes generation [#9964](https://github.com/HaxeFoundation/haxe/issues/9964)

__Bugfixes__:

* all : fixed compiler crash in complex constraints chains [#10445](https://github.com/HaxeFoundation/haxe/issues/10445)
* all : fixed timers execution order for timers with small time delta [#10567](https://github.com/HaxeFoundation/haxe/issues/10567)
* js : fixed constructors with rest arguments when compiling for ES3, ES5 [#10490](https://github.com/HaxeFoundation/haxe/issues/10490)
* php : excluded E_DEPRECATED notices from error reporting [#10502](https://github.com/HaxeFoundation/haxe/issues/10502)
* php : fixed safe casts to native arrays [#10576](https://github.com/HaxeFoundation/haxe/issues/10576)
* nullsafety : fixed false error on extern var fields without initialization [#10448](https://github.com/HaxeFoundation/haxe/issues/10448)