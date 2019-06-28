Introduction to the Haxe Language
=======

The Haxe programming language is a very modern, high-level programming language. It is very easy to learn if you're already familiar with Java, C++, PHP, AS3, or any similar object-oriented language. More features of the Haxe language:

  * general-purpose
  * strictly-typed, with type inferencing
  * compiled (to multiple language targets/platforms, including VM bytecode)
  * lexically-scoped
  * everything is an expression
  * exceptions for error handling
  * standard library includes modules specific to the target-platform, in addition to
    modules common to all targets
  * supports object-oriented, generic, and functional programming
  * familiar syntax
  * Haxe the language is purposely kept fairly simple, elegant, and practical to
    accommodate compilation to the large number of different target platforms.

As the Haxe Language has been specially designed for the Haxe Toolkit, we have paid extra attention to its flexibility. As such, the language easily adapts the native behaviours of the different platforms you have targeted in your development project.  This enables extremely efficient cross-platform development, ultimately saving time and resources.

See the [Haxe Language Features Introduction](https://haxe.org/documentation/introduction/language-features.html)
for a tour of some major language features.


Hello World
-------

The Haxe Programming Language was designed to be simple yet powerful. Its syntax largely follows the ECMAScript standard, but deviates where necessary. The following program demonstrates "Hello World" written in Haxe:

```haxe
class HelloWorld {
	static public function main() {
		trace("Hello World");
	}
}
```

With Haxe installed and this program saved in a file called "HelloWorld.hx", this can be compiled from the commandline, for example to JavaScript:

	haxe --main HelloWorld --js HelloWorld.js

or to Java:

	haxe --main HelloWorld --java path/to/java/out

Most Haxe code is organized in **classes** and **functions**, making Haxe an object-oriented language reminiscent of Java, ActionScript 3 and C#. However, Haxe has been designed with expressiveness in mind, yielding a powerful language through easily readable syntax.

See [Introduction](https://haxe.org/manual/introduction-hello-world.html) chapter in Haxe manual for more info.
