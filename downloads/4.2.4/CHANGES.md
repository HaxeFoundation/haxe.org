
## 2021-10-22 4.2.4:

__New features__:

* hl : add clipboard support in hl 1.12 ([#10320](https://github.com/HaxeFoundation/haxe/issues/10320))

__General improvements__:

* all : improved error messages upon directory creation failures ([#10361](https://github.com/HaxeFoundation/haxe/issues/10361))
* eval : added `%` operator to `eval.numbers.Int64` and `eval.numbers.UInt64` ([#10411](https://github.com/HaxeFoundation/haxe/issues/10411))

__Bugfixes__:

* all : fixed errors on final vars modification with `+=`, `*=` etc operations ([#10325](https://github.com/HaxeFoundation/haxe/issues/10325))
* all : fixed hanging of MainLoop.add on threaded targets (#10308,([#10329](https://github.com/HaxeFoundation/haxe/issues/10329))
* all : fixed compiler crash when resolving overloads with not enough arguments ([#10434](https://github.com/HaxeFoundation/haxe/issues/10434))
* all : fixed non-static `@:to` methods on `@:multiType` abstracts ([#10145](https://github.com/HaxeFoundation/haxe/issues/10145))
* analyzer : fixed analyzer on overloads ([#10405](https://github.com/HaxeFoundation/haxe/issues/10405))
* analyzer : fixed issues with fields initialization expressions ([#10405](https://github.com/HaxeFoundation/haxe/issues/10405))
* display : improved code completion in anonymous objects declarations ([#10414](https://github.com/HaxeFoundation/haxe/issues/10414))
* js : fixed IntMap for keys greater than 2^31 ([#10316](https://github.com/HaxeFoundation/haxe/issues/10316))
* js : workaround to fix sourcemaps on Firefox in Windows ([#10217](https://github.com/HaxeFoundation/haxe/issues/10217))
* js : delayed truncation of the output file on `Compiler.setCustomJSGenerator` ([#10387](https://github.com/HaxeFoundation/haxe/issues/10387))
* cs/java : fixed rest arguments for cases when only one argument is provided ([#10315](https://github.com/HaxeFoundation/haxe/issues/10315))
* php : fixed type of `php.db.PDO.ATTR_DRIVER_NAME` ([#10319](https://github.com/HaxeFoundation/haxe/issues/10319))
* eval : fixed signature of `eval.luv.Tcp.noDelay([ metho](https://github.com/HaxeFoundation/haxe/issues/metho))
* lua : fixed `string.length` when `string` has type of a type parameter constrained to `String` ([#10343](https://github.com/HaxeFoundation/haxe/issues/10343))
* jvm : fixed `Reflect.compare()` for different number types ([#10350](https://github.com/HaxeFoundation/haxe/issues/10350))
* python : fixed exceptions on tracing some native values ([#10440](https://github.com/HaxeFoundation/haxe/issues/10440))