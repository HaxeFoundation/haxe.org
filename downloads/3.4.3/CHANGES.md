Bugfixes:

 * all : fixed DCE issue with interface fields ([#6502](https://github.com/HaxeFoundation/haxe/issues/6502))
 * cpp : fixed return typing for embedded closures ([#6121](https://github.com/HaxeFoundation/haxe/issues/6121))
 * php7: fixed `@:enum abstract` generation  without `-dce full` ([#6175](https://github.com/HaxeFoundation/haxe/issues/6175))
 * php7: fixed using enum constructor with arguments as a call argument ([#6177](https://github.com/HaxeFoundation/haxe/issues/6177))
 * php7: fixed accessing methods on dynamic values ([#6211](https://github.com/HaxeFoundation/haxe/issues/6211))
 * php7: fixed `null` property access ([#6281](https://github.com/HaxeFoundation/haxe/issues/6281))
 * php7: fixed setting values in a map stored in another map ([#6257](https://github.com/HaxeFoundation/haxe/issues/6257))
 * php7: implemented `php.Lib.mail()`
 * php7: implemented `php.Lib.loadLib()`
 * php7: implemented `php.Lib.getClasses()` ([#6384](https://github.com/HaxeFoundation/haxe/issues/6384))
 * php7: fixed exception on `Reflect.getProperty(o, field)` if requested field does not exist ([#6559](https://github.com/HaxeFoundation/haxe/issues/6559))
 * php/php7: fixed accessing enum constructors on enum type stored to a variable ([#6159](https://github.com/HaxeFoundation/haxe/issues/6159))
 * php/php7: fixed "cannot implement previously implemented interface" ([#6208](https://github.com/HaxeFoundation/haxe/issues/6208))
 * php: fixed invoking functions stored in dynamic static vars ([#6158](https://github.com/HaxeFoundation/haxe/issues/6158))
 * php: fixed field access on `new MyClass()` expressions wrapped in a `cast` ([#6294](https://github.com/HaxeFoundation/haxe/issues/6294))
 * macro : fixed bug in addClassPath that overwrites macro class paths with context class paths
