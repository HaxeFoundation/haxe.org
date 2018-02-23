Dear Community,

On behalf of the Haxe Foundation, we are proud to announce the official release of the Haxe 4.0.0-preview.3! It is available along with the changelog at https://haxe.org/download.

As a preview release, it should not be considered stable. However, we appreciate anyone testing this version which will help us with the real Haxe 4 release. Please report any issues here:

 https://github.com/HaxeFoundation/haxe/issues.

Thank you very much for your help!

The most important change of this preview release is the new function type syntax. It was proposed by [Dan Korostelev](https://github.com/nadako) and successfully passed through [Haxe Evolution](https://github.com/HaxeFoundation/haxe-evolution/pull/23) process.

The new syntax provides a natural way for declaring function types with support for argument names which allows to create more readable self-explaining code:
```haxe
// no arguments
() -> Void

// single argument
(name:String) -> Void

// multiple (also, optional) arguments
(name:String, ?age:Int) -> Void

// unnamed arguments
(Int, String) -> Bool

// mixed arguments, why not
(a:Int, ?String) -> Void
```
While the old function type syntax is still supported, we would advise using the new one for writing new code.

Since this preview, the `final` keyword is allowed in anonymous structure syntax using class notation:
```haxe
{
	/** ordinary field */
	var field1:Int;
	/** Immutable field */
	final field2:String;
}
```

This release also makes a few steps towards replacing `untyped` code:

There are new `js.Syntax.code()`, `php.Syntax.code()` and other methods, which should be used for platform specific syntax that is not naturally achievable using Haxe syntax. The `Syntax` classe - unlike the  `untyped` keyword - is type-safe and analyzer-friendly.

The JavaScript target got performance optimizations for its `x.iterator()` and `Std.is(value, MyClass)` calls. The first one improves iteration over `Iterable<T>`, the second one is compiled to plain `value instanceof MyClass` instead of a function call where possible.

SSL support was added to HTTP requests for the Python target.

The PHP target does not need to call `Reflect.compareMethods()` anymore. Starting from this preview any functions can be compared with the `==` operator, just like it is done for most of the other targets.

Of course, numerous other improvements and bugfixes were implemented. For more details, please refer to the changelog.
