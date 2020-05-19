title: Module-level statics are here!
author: nadako
description: It is now possible to define functions and variables directly in Haxe modules
published: false
disqusID: 51
---
# Module-level functions and variables

I am happy to announce that we've [just merged](https://github.com/HaxeFoundation/haxe/pull/8460) a new Haxe feature: module-level static functions and variables (_module-statics_ in short)!

This means that Haxe now supports declaring static fields outside of classes, directly in modules next to type declarations:

```haxe
typedef Greeting = {phrase:String};

function greet(greeting:Greeting) {
	trace(greeting.phrase);
}

final defaultGreeting:Greeting = {phrase: "Hello, world!"};

function main() {
	greet(defaultGreeting);
}
```

The code above is more or less equivalent to the good old static fields:

```haxe
typedef Greeting = {phrase:String};

class MyModule {
	public static function greet(greeting:Greeting) {
		trace(greeting.phrase);
	}

	public static final defaultGreeting:Greeting = {phrase: "Hello, world!"};

	public static function main() {
		greet(defaultGreeting);
	}
}
```

In fact, the compiler internally transforms module-static declarations into static fields of an implicitly created class, so the behaviour is exactly the same. That is also why we call them "module-statics" :-)

From the usage standpoint, module-statics are as well not very different from static fields. However since they are declared at the _module-level_, they share some rules with the other kind of module-level declarations: _types_, most important to keep in mind being:

 - importing a module will also import all its module-statics together with all its types
 - module-statics are publicly available by default, but can be explicitly made `private`

We can also spot this duality if we take a look at the new macro structures:

 * In the *untyped* AST (`haxe.macro.Expr`) there is a new [`TypeDefKind`](https://api.haxe.org/v/development/haxe/macro/TypeDefKind.html) variant: `TDStatic(kind:FieldType, ?access:Array<Access>)`. Basically we use the old [`TypeDefinition`](https://api.haxe.org/v/development/haxe/macro/TypeDefinition.html) structure together with [`Context.defineType`](https://api.haxe.org/v/development/haxe/macro/Context.html#defineType) or [`Context.defineModule`](https://api.haxe.org/v/development/haxe/macro/Context.html#defineModule) to define a module-static in a macro (*it maybe argued that with the introduction of module-statics, the naming is a bit confusing, since it's not only about **type** definitions anymore, but it is not worth breaking existing macro code by changing the structures*).
 * In the *typed* AST (`haxe.macro.Type`) there a new [`ClassKind`](https://api.haxe.org/v/development/haxe/macro/ClassKind.html) variant: `KModuleStatics(module:String)`, which indicates that the class in question is the one containing all the statics defined for this `module`.

This implementation allowed for introducing this feature in the least invasive and breaking way and it automatically works on all targets!

Speaking of the targets, on the generator-side, they can choose to "flatten" module-static classes back into series of function/variable declarations. This is already implemented for the JavaScript target, so if our module is actually called "MyModule", the generated code for the module-statics from the example above will be:

```js
function MyModule_main() {
	MyModule_greet(MyModule_defaultGreeting);
}
function MyModule_greet(greeting) {
	console.log("src/MyModule.hx:4:",greeting.phrase);
}
var MyModule_defaultGreeting = { phrase : "Hello, world!"};
```

We believe this feature will make it more pleasant to develop code in non-OOP paradigms as well as write all kinds of scripts, utility methods and macros! Indeed, module-static methods can be used as `main()`, [static extensions](https://haxe.org/manual/lf-static-extension.html) and different kinds of [macro methods](https://haxe.org/manual/macro.html).

The feature will be available in the next minor Haxe release (4.2), but of course if you're living on the edge and don't want to wait, please grab a [nightly build](https://build.haxe.org/) and try it out (and don't forget to report any issues you find!)
