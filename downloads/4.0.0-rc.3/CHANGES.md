
## 2019-06-13: 4.0.0-rc.3

__New features__:

* all : added JVM target

__General improvements and optimizations__:

* all : create temp vars in pattern matcher to avoid duplicate access ([#8064](https://github.com/HaxeFoundation/haxe/issues/8064))
* all : support parsing dots in conditional compilation, e.g. `#if target.sys`
* all : added `@:bypassAccessor`
* all : improved various aspects of the display API
* all : properly error on `@:op(a = b)` ([#6903](https://github.com/HaxeFoundation/haxe/issues/6903))
* all : made `@:using` actually work
* all : properly disallowed some modifier combinations related to `final` ([#8335](https://github.com/HaxeFoundation/haxe/issues/8335))
* all : support `@:pure(false)` on variable fields ([#8338](https://github.com/HaxeFoundation/haxe/issues/8338))
* flash : updated Flash externs to version 32.0 (now using `final`, `enum abstract` and `haxe.extern.Rest`)
* flash : rework support for native Flash properties ([#8241](https://github.com/HaxeFoundation/haxe/issues/8241))
* php : improved performance of various parser implementations ([#8083](https://github.com/HaxeFoundation/haxe/issues/8083))
* cs : support .NET core target ([#8391](https://github.com/HaxeFoundation/haxe/issues/8391))
* cs : generate native type parameter constraints (#8311, #7863)

__Standard Library__:

* all : added StringTools.contains ([#7608](https://github.com/HaxeFoundation/haxe/issues/7608))
* all : turned sys.thread.Thread into abstracts ([#8130](https://github.com/HaxeFoundation/haxe/issues/8130))
* all : introduced `Std.downcast` as replacement for `Std.instance` ([#8301](https://github.com/HaxeFoundation/haxe/issues/8301))
* all : introduced `UnicodeString`, deprecated `haxe.Utf8` ([#8298](https://github.com/HaxeFoundation/haxe/issues/8298))
* java : added java.NativeString ([#8163](https://github.com/HaxeFoundation/haxe/issues/8163))
* cs : added sys.thread implementations ([#8166](https://github.com/HaxeFoundation/haxe/issues/8166))
* js : moved various classes to js.lib ([#7390](https://github.com/HaxeFoundation/haxe/issues/7390))
* Bugfixes
* all : fixed issue with `@:generic` type parameters not being bound to Dynamic ([#8102](https://github.com/HaxeFoundation/haxe/issues/8102))
* all : fixed various issues related to `@:structInit`
* all : fixed top-down inference on abstract setters ([#7674](https://github.com/HaxeFoundation/haxe/issues/7674))
* all : fixed DCE issue related to closures ([#8200](https://github.com/HaxeFoundation/haxe/issues/8200))
* all : fixed and restricted various Unicode-related issues in String literals
* all : fixed various priority issues regarding loops and iterators
* all : fixed cast handling in try-catch expressions ([#8257](https://github.com/HaxeFoundation/haxe/issues/8257))
* all : fixed `inline new` handling ([#8240](https://github.com/HaxeFoundation/haxe/issues/8240))
* all : fixed pattern matcher issue with wildcards in or-patterns ([#8296](https://github.com/HaxeFoundation/haxe/issues/8296))
* all : fixed `@:allow(package)` allowing too much ([#8306](https://github.com/HaxeFoundation/haxe/issues/8306))
* all : fixed various issues with startIndex handling on String.indexOf and String.lastIndexOf
* all : fixed infinite recursion related to printing of objects with circular references ([#8113](https://github.com/HaxeFoundation/haxe/issues/8113))
* sys : fixed various Unicode issues ([#8135](https://github.com/HaxeFoundation/haxe/issues/8135))
* macro : fixed Array.pop handling ([#8075](https://github.com/HaxeFoundation/haxe/issues/8075))
* macro : fixed assertion failure when throwing exception ([#8039](https://github.com/HaxeFoundation/haxe/issues/8039))
* macro : fixed various uncatchable exceptions being thrown
* php : error on case-insensitive name clashes ([#8219](https://github.com/HaxeFoundation/haxe/issues/8219))
* lua : fixed issue where Process output occasionally is missing some data
* hl : fixed various String Unicode issues
* java : fixed null exception in CallStack.exceptionStack ([#8322](https://github.com/HaxeFoundation/haxe/issues/8322))
* js : fixed code generation issue related to negative abstract values ([#8318](https://github.com/HaxeFoundation/haxe/issues/8318))
* flash : fix various issues, including native `protected` handling and method overloading

__Removals__:

* all : remove support for `@:fakeEnum` enums
* all : disallowed `\x` with values > 0x7F ([#8141](https://github.com/HaxeFoundation/haxe/issues/8141))
* all : consistently disallowed metadata in lambda function arguments ([#7800](https://github.com/HaxeFoundation/haxe/issues/7800))
* all : removed `--gen-hx-classes` ([#8237](https://github.com/HaxeFoundation/haxe/issues/8237))
