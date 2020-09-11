
## 2020-09-11 4.1.4

__General improvements__:

* all : allowed `Any` as type parameter in `catch(e:SomeType<Any>)` ([#9641](https://github.com/HaxeFoundation/haxe/issues/9641))
* all : improved compilation speed for `try..catch` expressions ([#9848](https://github.com/HaxeFoundation/haxe/issues/9848))

__Bugfixes__:

* all : fixed `switch` typing error for arrow functions with `Void` return type ([#9813](https://github.com/HaxeFoundation/haxe/issues/9813))
* all : fixed typing of arrow functions with empty blocks as bodies ([#9843](https://github.com/HaxeFoundation/haxe/issues/9843))
* macro : fixed `haxe.macro.Context.getResources()` ([#9838](https://github.com/HaxeFoundation/haxe/issues/9838))
* php : fixed false detection of `catch` vars in anonymous functions as captured from outer scope
* php : fixed return type of extern definition for `fseek` function
* cs,java : fixed generation of `@:generic` classes with anonymous functions ([#9799](https://github.com/HaxeFoundation/haxe/issues/9799))
* jvm : fixed sending/reading messages with `sys.thread.Threads` for threads created outside of Haxe ([#9863](https://github.com/HaxeFoundation/hax9863e/issues/))
* jvm : fixed multiplication of `Null<Float>` and `Int` ([#9870](https://github.com/HaxeFoundation/haxe/issues/9870))
* flash : fixed loading swc libraries containing `Vector` without a type parameter ([#9805](https://github.com/HaxeFoundation/haxe/issues/9805))
* hl : fixed messages being send to wrong threads with `sendMessage`/`readMessage` in `sys.thread.Thread` ([#9875](https://github.com/HaxeFoundatio9875n/haxe/issues/))
* cpp : fixed `cpp.Lib.stringReference()` (#8457)