
## 2020-12-31 4.1.5

__General improvements__:

* all : added an argument to `haxe.CallStack.exceptionStack` to return full stack up to the topmost call ([#9947](https://github.com/HaxeFoundation/haxe/issues/9947))
* php : compatibility with PHP 8

__Bugfixes__:

* all : fixed empty object declarations in array comprehension ([#9971](https://github.com/HaxeFoundation/haxe/issues/9971))
* jvm : fixed equality checks for `Null<Float>` and `Null<Int>` ([#9897](https://github.com/HaxeFoundation/haxe/issues/9897))
* hl : fixed crash if a thread finishes without invoking `sendMessage`/`readMessage` ([#9920](https://github.com/HaxeFoundation/haxe/issues/9920))
* php : fixed local vars with certain names (_SERVER, _GET etc) overriding super global values ([#9924](https://github.com/HaxeFoundation/haxe/issues/9924))
* php : fixed generation with directories in `-D php-front`. For example `-D php-front=sub/index.php` ([#10037](https://github.com/HaxeFoundation/haxe/10037))issues/
* macro : added return type hint to haxe.macro.MacroStringTools.formatString ([#9928](https://github.com/HaxeFoundation/haxe/issues/9928))
* cs : fixed catching exceptions from static closures ([#9957](https://github.com/HaxeFoundation/haxe/issues/9957))
* eval : fixed `Std.random(arg)` for `arg` values of more than 30 bits ([#9974](https://github.com/HaxeFoundation/haxe/issues/9974))
* js : fixed `haxe.CallStack.exceptionStack` ([#9968](https://github.com/HaxeFoundation/haxe/issues/9968))