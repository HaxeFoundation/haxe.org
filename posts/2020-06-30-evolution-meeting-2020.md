title: Haxe Evolution meeting 2020
author: aurel300
description: Discussing the recent Haxe Evolution proposals
background: SsoKppt2pqY.jpg
published: true
disqusID: 55
---

After a long time, the Haxe Evolution team virtually met up to discuss the current [Haxe Evolution proposals](https://github.com/HaxeFoundation/haxe-evolution/pulls/). Anyone (even you!) can create a proposal, although it should be well motivated, described in sufficient detail, and generally useful to Haxe. Some examples of past successful proposals include [arrow functions](https://github.com/HaxeFoundation/haxe-evolution/blob/master/proposals/0002-arrow-functions.md), [key-value iteration](https://github.com/HaxeFoundation/haxe-evolution/blob/master/proposals/0005-key-value-iter.md), and the recently implemented [module-level functions](https://github.com/HaxeFoundation/haxe-evolution/blob/master/proposals/0007-module-level-funcs.md).

With that in mind, let's go over the 14 discussed proposals one by one! I'll try to summarise the context for each, how the proposal aims to improve the current situation, and what our decision was.

## [`Void` as unit type](https://github.com/HaxeFoundation/haxe-evolution/pull/76)

[`Void`](https://haxe.org/manual/types-void.html) is a basic type in Haxe that indicates the absence of data. Functions that return nothing have a `Void` return type, and, with the old function syntax, a function that is `Void->Foo` is a function that takes no arguments and returns a `Foo`. Actually having a variable of type `Void` generally doesn't make sense, and the compiler will generate appropriate errors when you try to do that.

However, type parameters make the situation a little bit more complicated. There are many design patterns and libraries that make use of functions with parametrised arguments. For example, "signals" (also known as "events"). The idea is to have some way to trigger handler functions whenever a particular event happens. In a very simplified form:

```haxe
interface Signal<T> {
  function emit(what:T):Void;
  function addHandler(handler:T->Void):Void;
}
```

This is fine if the `Signal` has data attached to it. Maybe a textbox was modified and the signal indicates its new contents (`Signal<String>`). But in the case where there is no meaningful data, the situation is a bit muddy. Libraries like [`haxetink`](https://github.com/haxetink/tink_core) use a dedicated [`Noise`](https://github.com/haxetink/tink_core/blob/master/src/tink/core/Noise.hx) type that also indicates the absence of a value. A button being pressed might be modelled as a `Signal<Noise>`. This avoids the compiler errors and side-steps the question: what would a `Signal<Void>` be?

Constructing such an object seems fine, but an issue immediately arises when one would like to use the `emit` method. It has an argument, but it is of a `Void` type, so it cannot really be called without a compiler error. The argument cannot be skipped, either. `addHandler` has similar issues.

The ["`Void` as unit type"](https://github.com/HaxeFoundation/haxe-evolution/pull/76) proposal aims to address this issue by making `Void` officially a [unit type](https://en.wikipedia.org/wiki/Unit_type), just like the `Noise` type from haxetink linked above. With this change, the `Signal<Void>` example would work fine, and we would emit events with `signal.emit(Void)` – `Void` would become the one valid expression of type `Void`.

Some open questions remain, however. The old Haxe syntax for functions taking 0 arguments is `Void->...`, and making `(Void)->...` behave differently could be confusing to users and potentially a breaking change. This problem may be addressable by making `Void` arguments always skippable. Other questions include:

 - Shall we allow variables of type `Void`? Should they be eliminated by the compiler since they never contain any data?
 - What is the result of `Array.map` with a `Void`-returning function?
 - How to represent the new unit-like `Void` on our targets?

Verdict: **open questions remain**.

## [Local variable metadata](https://github.com/HaxeFoundation/haxe-evolution/pull/74)

In Haxe, [everything is an expression](https://code.haxe.org/category/principles/everything-is-an-expression.html), and variable declarations are no exception. In this piece of code:

```haxe
var foo = 1, bar = "x";
```

The AST contains an [`EVars`](https://api.haxe.org/haxe/macro/ExprDef.html#EVars) expression, that in turn contains two variable declarations (instances of [`haxe.macro.Var`](https://api.haxe.org/haxe/macro/Var.html)). The issue is that every `EVars` expression may contain any number of variable declarations, so it is not possible to attach metadata to individual variables.

The ["Local variable metadata"](https://github.com/HaxeFoundation/haxe-evolution/pull/74) proposal suggests adding a metadata field to variable declarations, allowing metadata per variable. The proposed syntax is:

```haxe
var @:metadataForFoo foo = 1,
    @:metadataForBar bar = "x";
```

This change has [been implemented](https://github.com/HaxeFoundation/haxe/commit/e344635380a2645e3801542a1c7ef86d0f06da54) already!

Verdict: **accepted**.

## [Typed metadata](https://github.com/HaxeFoundation/haxe-evolution/pull/73)

Typed metadata is a topic that comes up again and again in discussions about Haxe. There are some notes about it in the Haxe Evolution [ideas page](https://api.haxe.org/haxe/macro/Var.html). In short, our metadata system could be better. A typo in metadata entries is not easy to spot, since the compiler is happy to accept any metadata, but just happens to perform special actions when triggered by a small set of [compiler metadata](https://haxe.org/manual/cr-metadata.html). Another issue is that defining and processing compile-time metadata globally using macros is somewhat slow, as it involves iterating through all the generated types and possibly all of their expressions as well.

The ["Typed metadata"](https://github.com/HaxeFoundation/haxe-evolution/pull/73) proposal introduces a new metadata syntax `@.module.path.to.Metadata` linked to the type system. Valid metadata are declared as `abstract`s which are themselves marked with the reserved `@.haxe.meta.MetadataType`. In the proposed form, this primarily solves the issue of catching typos at compile time. However, it does not solve the issue of type-safe argument types for metadata, or the issue of slow macro processing.

We decided to reject the given proposal. We would like to have typed metadata in the language, but not with the proposed syntax. As it is, there are two kinds of metadata syntax (`@:foo` for compile-time metadata, `@foo` for runtime metadata), and adding a third would be confusing. Module-level functions may be [a possible solution](https://github.com/HaxeFoundation/haxe-evolution/pull/73#issuecomment-634289234) without awkward syntax, but this needs to be investigated more in-depth.

Verdict: **rejected** (in the proposed form).

## [Multiple argument array access](https://github.com/HaxeFoundation/haxe-evolution/pull/72)

In Python, many libraries (e.g. `numpy`) make use of overloaded array access syntax to model interesting ways to work with multi-dimensional data. Here are a couple of examples from the ["Python Data Science Handbook"](https://jakevdp.github.io/PythonDataScienceHandbook/02.02-the-basics-of-numpy-arrays.html):

```python
>>> x2
array([[12,  5,  2,  4],
       [ 7,  6,  8,  8],
       [ 1,  6,  7,  7]])

>>> x2[:2, :3] # two rows, three columns
array([[12,  5,  2],
       [ 7,  6,  8]])

>>> x2[:3, ::2] # all rows, every other column
array([[12,  2],
       [ 7,  8],
       [ 1,  7]])

>>> x2[::-1, ::-1] # subarray dimensions reversed
array([[ 7,  7,  6,  1],
       [ 8,  8,  6,  7],
       [ 4,  2,  5, 12]])
```

The array access operator is overridable in Python, and the dynamic type system makes it possible to pass all kinds of objects as indices – integers, ranges, strings, and more.

The ["Multiple argument array access"](https://github.com/HaxeFoundation/haxe-evolution/pull/72) proposal takes a step towards enabling this kind of array indexing, by adding new multiple-index syntax, and a new way to overload such access for abstracts using the `@:op([_, _])` metadata.

There are some unresolved questions. The static type system of Haxe would make it more difficult to be able to pass a variety of types into integer accesses, and a variable-length array access is not discussed in the proposal at all. Although some good arguments (especially related to data science) for adding this new syntax were presented, [Nicolas is against](https://github.com/HaxeFoundation/haxe-evolution/pull/72#issuecomment-619552752) adding new syntax to the language in this case. We would also have to see just how large of a change this would require in the expression representation.

Verdict: **undecided**.

## [Macro instances](https://github.com/HaxeFoundation/haxe-evolution/pull/71)

The ["Macro instances"](https://github.com/HaxeFoundation/haxe-evolution/pull/71) proposal is essentially about wrapping macro state into variables. Such variables could only exist at compile time, and would be bound to the function when it is parsed, rather than when it is executed. The author's motivating example is probably better solved by making use of `@:genericBuild`, `@:const` type parameters, and macros.

Verdict: **rejected**.

## [Default implementation in interfaces](https://github.com/HaxeFoundation/haxe-evolution/pull/70)

This proposal is an alternative to the abstract classes proposal discussed further below. We decided to accept the latter proposal, so this one was rejected. Some of the preference stems from the fact that we believe interfaces should be completely independent from implementations. Although the detailed design document suggests generating "implementation" classes on the targets that don't natively support interface implementations, it is not clear how this would interact with classes that implement multiple interfaces.

Verdict: **rejected**.

## [Abstract classes](https://github.com/HaxeFoundation/haxe-evolution/pull/69)

There are often cases when the user has multiple classes that have a very similar interface, and share a lot of the same code. Such situations can be solved using base classes and inheritance.

```haxe
class Base {
  function new() {}
  function foo() {
    // complex implementation of foo here
  }
  public function read():Int throw "not implemented";
  public function write(_:Int):Void throw "not implemented";
}
class ChildReader extends Base {
  public function new() {
    super();
  }
  override public function read():Int {
    foo();
    return 0;
  }
}
class ChildWriter extends Base {
  public function new() {
    super();
  }
  override public function write(_:Int):Void {
    foo();
  }
}
```

In the above example, `foo` is implemented only once, in the `Base` class, and both `ChildReader` and `ChildWriter` can access it. `Base` cannot be instantiated directly, only the child classes can be. However, a `ChildReader` instance can be used where a `Base` type is needed, and likewise for `ChildWriter`. If a `Base` *could* be created directly, calling its `read` or `write` method would throw a runtime error.

This pattern is used in the Haxe standard library as well, for example in [`haxe.io.Input`](https://api.haxe.org/haxe/io/Input.html). In this case, however, the pattern is to have a minimal set of functions (such as `readByte`) be implemented by the child class, and, unless a more optimised version is provided by the child class, use the default implementations in the base class for everything else.

However, the boilerplate required in the base class is not pretty, and as always, compile-time errors are better than runtime errors. The ["Abstract classes"](https://github.com/HaxeFoundation/haxe-evolution/pull/69) aims to improve this situation. The above example would turn into:

```haxe
abstract class Base {
  function foo() {
    // complex implementation of foo here
  }
  abstract public function read():Int;
  abstract public function write(_:Int):Void;
}
class ChildReader extends Base {
  public function new() {}
  public function read():Int {
    foo();
    return 0;
  }
}
class ChildWriter extends Base {
  public function new() {}
  public function write(_:Int):Void {
    foo();
  }
}
```

Note the extra `abstract` keywords, the lack of any runtime exceptions, the fact that `read` and `write` have no `override` modifier (since there was no implementation to begin with), and that the two child classes do not need to call `super`.

We like this idea and we accepted the proposal. We hope it will make some parts of the standard library easier to look at. A small question that remains to be answered is whether the "abstractness" of a class should be inferred by the compiler (whenever there is at least one `abstract` method in the class) or whether it always needs to be specified explicitly by the user. For now, we will implement the latter.

Verdict: **accepted**.

## [`ReadOnlyArray` optimisation](https://github.com/HaxeFoundation/haxe-evolution/pull/68)

The Haxe compiler has an analyser that can generate more efficient code by folding constants, unrolling loops, inlining function calls, and more. The ["`ReadOnlyArray` optimisation"](https://github.com/HaxeFoundation/haxe-evolution/pull/68) proposal suggests an additional, simple optimisation in the specific case of a `ReadOnlyArray` that is declared `final`.

```haxe
class Foo {
  public static final someArray:ReadOnlyArray<Int> = [10, 20, 30, 40];
  public static function doStuff() {
    // do stuff
    return someArray[1]; // this can be changed into "20" directly
  }
}
```

The semantics of `final` prevent the array from being re-assigned, and the `ReadOnlyArray` type does not allow modifying its elements. In other words, unless reflection is (mis)used, `someArray[x]` will always be the same value throughout the lifetime of the program. As such, it should be safe to inline values in these cases.

A similar optimisation could be useful for `ReadOnlyMap` fields, particularly for maps with enum instances as keys. However, the Haxe AST does not have a dedicated node for map literals, which would make it more difficult to figure out whether a map field is actually constant and what its values are.

Verdict: **accepted**.

## [Carry comments through to target language](https://github.com/HaxeFoundation/haxe-evolution/pull/65)

The output of Haxe compilation, regardless of the target, is generally not expected to be particularly readable or nice to look at. This was never the intended use of Haxe, and allows the compiler to perform optimisations that result in better performance at the cost of uglier code in some cases. However, producing libraries that can be used from within the target language is a valid use case. Some of our target languages have conventions for using special comment syntax to annotate methods with documentation, argument explanation, etc. [Javadoc](https://en.wikipedia.org/wiki/Javadoc) is a format that is supported by many IDEs.

The ["Carry comments through to target language"](https://github.com/HaxeFoundation/haxe-evolution/pull/65) proposal suggests two changes:

1. emit documentation blocks on types and fields, and
2. keep comments from the Haxe source code in the generated output.

The first goal is something we would like to see. The PHP generator already behaves this way, so PHP-compatible IDEs can use Haxe-generated methods nicely. Aligning other source code-emitting generators to do the same thing should not be too difficult.

We reject the second change, however. Some use cases that mark positions within the generated code using marker comments might exists, but it is probably possible to solve this type of problem using source maps anyway. There are also cases when the output is quite different from the input (some exmaples include `for` loops turned into `while` loops with preambles, loop unrolling, variables that get optimised away, etc). As a result, it is not obvious where the Haxe comments should be placed in the end.

Verdict: **partially accepted**.

## [On-site getters and setters implementation](https://github.com/HaxeFoundation/haxe-evolution/pull/63)

It is extremely common to define Haxe properties with `inline` getters or setters:

```haxe
class Foo {
  var something:Int;
  var theProperty(get, set):Int;
  inline function get_theProperty() return something * 10;
  inline function set_theProperty(val) return something = Std.int(val / 10);
}
```

Such implementations are also often rather short, to the point that the syntax of defining a getter function is longer than the implementation of the getter itself. The ["On-site getters and setters implementation"](https://github.com/HaxeFoundation/haxe-evolution/pull/63) proposal suggests a possible solution, where the function is defined directly inside the property definition using an arrow function:

```haxe
class Foo {
  var something:Int;
  var theProperty(() -> something * 10, (val) -> Std.int(val / 10)):Int;
}
```

This declaration would be syntactic sugar and would be effectively the same as the previous example. Getters/setters that should not be inlined, or ones that override a parent class would be declared using the standard syntax.

We have thought for a long time that the property syntax needs some attention; perhaps remodelling it after the [C# property syntax](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/properties). In general, syntactic sugar to save a couple of keystrokes is not the best addition to a language. On the other hand, we agreed that this proposal would indeed solve the most common case of properties.

Verdict: **open questions remain**.

## [Self access for abstracts](https://github.com/HaxeFoundation/haxe-evolution/pull/62)

Inside Haxe abstracts, `this` is a keyword that always refers to an instance of the underlying type, rather than of the abstract itself. As an example:

```haxe
abstract Foo(Int) {
  public function new(i:Int) this = i;
  public function add(other:Int):Int {
    $type(this); // Int
    return this + other;
  }
}
```

However, sometimes an instance of the actual abstract type is needed. A very common solution is to create a private property to perform the casting automatically:

```haxe
abstract Foo(Int) {
  var self(get, never):Foo;
  function get_self():Foo return (cast this : Foo);
  // alternatively get_self might call a private constructor if there is one
}
```

We would like to reduce this boilerplate by simply allowing users to refer to the abstract instance directly. However, introducing a new keyword would be a potentially breaking change. The ["Self access for abstracts"](https://github.com/HaxeFoundation/haxe-evolution/pull/62) proposal suggests the syntax:

```haxe
abstract Foo(Int) as self {}
```

(where `self` would be a user-chosen identifier.)

We like the idea, but we are not convinced about the specific syntax yet.

Verdict: **open questions remain**.

## [Default type parameters](https://github.com/HaxeFoundation/haxe-evolution/pull/50)

When using Haxe classes that have a large number of type parameters, it is often convenient to provide a `typedef` that provides an alias to that class with reasonable defaults used for most of the type parameters:

```haxe
class Foo<T, U:SomeConstraint, V:SomethingComplex<U, Array<T>>> { /* ... */ }

class DefaultU implements SomeConstraint { /* ... */ }
class DefaultV<T, U> implements SomethingComplex<U, Array<T>> { /* ... */ }

typedef FooBasic<T> = Foo<T, DefaultU, DefaultV<T, DefaultU>>;
```

However, this is not a very scalable approach, since as soon as the user needs one non-default type parameter, all the others need to be specified as well. Providing a `typedef` for all combinations of default and non-default type parameters would be rather ugly.

The ["Default type parameters"](https://github.com/HaxeFoundation/haxe-evolution/pull/50) proposal adds a syntax for specifying the default type used for a type parameter.

```haxe
class Foo<T, U:SomeConstraint = DefaultU, V:SomethingComplex<U, Array<T>> = DefaultV<T, U>> { /* ... */ }
```

We like the solution, although there are some cases which are still unclear and should be resolved before we can implement this:

 - Do type parameter defaults take priority over type inference when calling the constructor? E.g. `new Foo(Bar, DefaultU, NonDefaultV)`
 - Can defaults be specified for parametrised methods?
 - Should type parameters with defaults only be allowed at the end of the list of type parameters?

Verdict: **open questions remain**.

## [Polymorphic `this` type](https://github.com/HaxeFoundation/haxe-evolution/pull/36)

Method chaining and class inheritance can sometimes lead to the following problem:

```haxe
class Base {
  public function doX():Base {
    // do X
    return this;
  }
  public function doY():Base {
    // do Y
    return this;
  }
}
class Child extends Base {
  public function doZ():Child {
    // do Z
    return this;
  }
}
```

The `Base` class can be method-chained without issues:

```haxe
new Base()
  .doX()
  .doX()
  .doY()
  .doX();
```

However, the same is not true of `Child`. As soon as one of the methods from `Base` is used, the returned value is of type `Base`, not `Child`:

```haxe
// this is ok:
new Child()
  .doZ()
  .doZ()
  .doZ();
// this is not:
new Child()
  .doZ()
  .doX() // <- this method returns a Base, not a Child!
  .doZ() // <- type error here: Base has no method doZ
  .doZ();
```

To resolve this issue, one has to cast the result of the base operations back to instances of the child class, which is not pretty and may lead to further hard-to-debug problems.

The ["Polymorphic `this` type"](https://github.com/HaxeFoundation/haxe-evolution/pull/36) suggests a solution that is already present in some programming languages, e.g. [`this` in TypeScript](https://www.typescriptlang.org/docs/handbook/advanced-types.html#polymorphic-this-types). Such a type always represents the current type, even when a child class is inheriting methods of a base class. The above example would turn into:

```haxe
class Base {
  public function doX():this { /* ... */ return this; }
  public function doY():this { /* ... */ return this; }
}
class Child extends Base {
  public function doZ():this { /* ... */ return this; }
}
```

Other applications include component systems with event listeners, or `copy`-style method that creates a clone of the current object instance.

This proposal was already [deemed useful in 2018](https://github.com/HaxeFoundation/haxe-evolution/pull/36#issuecomment-423598887), and our verdict has not changed. However, there is not yet a clear vision of how this would be implemented!

Verdict: **open questions remain**.

## [Type parameter variance of enum](https://github.com/HaxeFoundation/haxe-evolution/pull/28)

This proposal is somewhat old by now (originally opened in 2017), and suggest a small change to the Haxe type system with regards to enum type parameters and variance. As an example, allowing instances of `Option<Int>` where `Option<Float>` is expected (because `Int` values can become `Float`). We closed this proposal as the motivating example now compiles due to top-down inference, and because we acknowledge that the Haxe type system needs more work in terms of variance in general.

Verdict: **rejected**.

## Summary

That's it for now! We hope to have Haxe Evolution meetings more often, since they are very encouraging to keep taking the language further. If you saw anything you liked or disliked, feel free to join the discussion in the links above. Once again, anyone can [create proposals](https://github.com/HaxeFoundation/haxe-evolution/#what-needs-a-proposal), so don't hesitate to suggest improvements to Haxe. We look forward to seeing you there.
