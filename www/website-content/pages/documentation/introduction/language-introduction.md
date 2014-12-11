Introduction to the Haxe Language
=======

The Haxe programming language is a very modern high level programming language. It is strictly typed and very easy to learn if you are already familiar with Java, C++, PHP, AS3 or any similar object oriented language. 

As the Haxe Language has been specially designed for the Haxe Toolkit, we have paid extra attention to its flexibility. As such, the language easily adapts the native behaviours of the different platforms you have targeted in your development project.  This enables extremely efficient cross-platform development, ultimately saving time and resources.


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

Save this into a file named `HelloWorld.hx`. With Haxe installed, this can be compiled from the commandline, for example to javascript:

	haxe -main HelloWorld -js HelloWorld.js

or to java:

	haxe -main HelloWorld -java path/to/java/out

Most Haxe code is organized in **classes** and **functions**, making Haxe an object-oriented language reminiscent of Java, Actionscript 3 and C#. However, Haxe has been designed with expressiveness in mind, yielding a powerful language through easily readable syntax.

