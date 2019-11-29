
## 2019-11-29: 4.0.3

__General improvements and optimizations__:

* hl : profiler API

__Bugfixes__:

* all : fixed EnumValue handling in constant propagation with analyzer enabled ([#8959](https://github.com/HaxeFoundation/haxe/issues/8959))
* all : fixed compiler crash upon Void items in array declarations ([#8972](https://github.com/HaxeFoundation/haxe/issues/8972))
* hl : fixed `sys.thread.Lock` implementation for Hashlink 1.11+ ([#8699](https://github.com/HaxeFoundation/haxe/issues/8699))
* js/eval/java/jvm/cs/python/lua : fixed `Std.parseInt()` for hexadecimals with leading whitespaces ([#8978](https://github.com/HaxeFoundation/haxe/issues/8978))
* java/cs : fixed `Reflect.callMethod(o, method, args)` for `args` not containing optional arguments ([#8975](https://github.com/HaxeFoundation/haxe/issues/8975))
* cs : fixed Json.stringify for @:struct-annotated classes ([#8979](https://github.com/HaxeFoundation/haxe/issues/8979))
* cs : fixed bitwise shifts for `cs.types.Int64` ([#8978](https://github.com/HaxeFoundation/haxe/issues/8978))
* python : fixed invalid generation of some inlined code blocks ([#8971](https://github.com/HaxeFoundation/haxe/issues/8971))
* std : fixed an exception from `haxe.zip.Huffman` on reading a zip ([#8875](https://github.com/HaxeFoundation/haxe/issues/8875))
* windows : workaround windows installer being detected as a malware by some anti-virus software ([#8951](https://github.com/HaxeFoundation/haxe/issues/8951))
* windows : fix PATH env var modification when running windows installer without admin privileges ([#8870](https://github.com/HaxeFoundation/haxe/issues/8870))
* all : fixed null-safety checker for field access on a call to inlined function