
## 2017-09-12: 4.0.0-preview.1

__New features__:

* all : reworked macro interpreter
* all : added support for arrow functions

__General improvements and optimizations__:

* js : improved generation of `break` inside `switch` inside loops ([#4964](https://github.com/HaxeFoundation/haxe/issues/4964))
* cs : improved generation of enum classes ([#6119](https://github.com/HaxeFoundation/haxe/issues/6119))
* sys : the `database` parameter of `Mysql.connect` is now optional
* js : updated jQuery extern (js.jquery.*) for jQuery 1.12.4 / 3.2.1 support.
* Makefile : default Unix installation location $(INSTALL_DIR) changed from /usr to /usr/local.
* Makefile : default Unix std location $(INSTALL_STD_DIR) changed from $(INSTALL_LIB_DIR)/std to $(INSTALL_DIR)/share/haxe/std.

__Removals__:

* all : removed --eval command line argument
* sys : SPOD (sys.db.Object, sys.db.Manager and friends) was moved into a separate library `record-macros` (https://github.com/HaxeFoundation/record-macros)
* js : js.JQuery and js.SWFObject were moved into hx3compat library (https://github.com/HaxeFoundation/hx3compat),
* it's recommended to use more modern js.jquery.JQuery and js.swfobject.SWFObject classes.
* all : moved haxe.web.Dispatch into hx3compat library (https://github.com/HaxeFoundation/hx3compat).

__Bugfixes__:

* php7: fix Reflect.field() for strings ([#6276](https://github.com/HaxeFoundation/haxe/issues/6276))
* php7: fix `@:enum abstract` generation  without `-dce full` ([#6175](https://github.com/HaxeFoundation/haxe/issues/6175))
* php7: fix using enum constructor with arguments as a call argument ([#6177](https://github.com/HaxeFoundation/haxe/issues/6177))
* php7: fix `null` property access ([#6281](https://github.com/HaxeFoundation/haxe/issues/6281))
* php7: fix setting values in a map stored in another map ([#6257](https://github.com/HaxeFoundation/haxe/issues/6257))
* php7: fix haxe.io.Input.readAll() with disabled analyzer optimizations ([#6387](https://github.com/HaxeFoundation/haxe/issues/6387))
* php/php7: fixed accessing enum constructors on enum type stored to a variable ([#6159](https://github.com/HaxeFoundation/haxe/issues/6159))
* php/php7: fix "cannot implement previously implemented interface" ([#6208](https://github.com/HaxeFoundation/haxe/issues/6208))
* php: fix invoking functions stored in dynamic static vars ([#6158](https://github.com/HaxeFoundation/haxe/issues/6158))
* php: fix field access on `new MyClass()` expressions wrapped in a `cast` ([#6294](https://github.com/HaxeFoundation/haxe/issues/6294))

__Standard Library__:

* all : added `EReg.escape` ([#5098](https://github.com/HaxeFoundation/haxe/issues/5098))
* all : `BalancedTree implements `haxe.Constraints.IMap` ([#6231](https://github.com/HaxeFoundation/haxe/issues/6231))
