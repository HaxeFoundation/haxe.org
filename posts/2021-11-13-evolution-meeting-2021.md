title: Haxe Evolution meeting 2021
author: aurel300
description: Discussing the recent Haxe Evolution proposals
background: dna-1811955_1920.jpg
published: true
disqusID: 58
---

Once again, the Haxe Evolution team virtually met up to discuss the current [Haxe Evolution proposals](https://github.com/HaxeFoundation/haxe-evolution/pulls/). You can read about the previous meeting in [this blog post](https://haxe.org/blog/evolution-meeting-2020/). Before we get into the concrete proposals, let me once again remind you that we welcome Evolution proposals from anyone in the community, as long as they are clearly motivated and describe the *design* of the feature in depth.

This time we discussed 16 proposals, of which 7 were accepted, 7 were rejected, and 2 remain open.

## [`haxe.Int64` numeric literal suffix](https://github.com/HaxeFoundation/haxe-evolution/pull/92)

Big numeric literals can be a bit confusing in Haxe:

```haxe
var x = 1000000000;
var y = 10000000000;
```

The declarations for `x` and `y` look similar enough, but `x` is typed as an `Int`, whereas `y` is typed as `Float`. The cutoff point seems a little bit arbitrary, but stems from the largest signed 32-bit integer, so `2147483647` is an `Int`, but `2147483648` becomes a `Float`.

This can be awkward when one wants to simply write a large number that would fit into a 64-bit integer, for example. Similarly, one might want to store the number `2147483648` in an *unsigned* 32-bit integer.

There are multiple issues coming to light here:

- Haxe does not take the expected type into account when parsing number literals,
- there is no syntax for `Int64` literals at all (instead, `Int64.make` or similar workarounds must be used), and
- there is no syntax to indicate that a particular literal should be forced to be of a particular type.

The ["`haxe.Int64` numeric literal suffix"](https://github.com/HaxeFoundation/haxe-evolution/pull/92) proposal suggests suffixes on number literals as a solution to the second and third issue at least. Such suffixes already exist in other languages and we will concretely use the suffixes used in the Rust language:

```haxe
10000i32;       // Int
2147483648u32;  // UInt
10000000000i32; // haxe.Int64
5f64;           // Float
```

The complete list includes more suffixes (e.g. `u8` for an unsigned byte), but until we have a better variety of integer types in the Haxe standard library, these will probably not be parsed yet.

Verdict: **accepted**.

## [Number separators](https://github.com/HaxeFoundation/haxe-evolution/pull/90)

Still on the topic of potentially large number literals, there might be cases where a numeric constant in the code is simply too large to read comfortably:

```haxe
final VERY_MUCH = 123000987456123i64;
```

The ["Number separators"](https://github.com/HaxeFoundation/haxe-evolution/pull/90) proposal suggests a way to make number literals more readable by allowing underscores as optional separators in any position:

```haxe
final VERY_MUCH = 123_000_987_456_123i64;
```

This syntax could also be combined with hexadecimal literals to make ARGB colour literals easier to read:

```haxe
final GRAYISH_RED = 0xFF_E8_68_5A;
```

Verdict: **accepted**.

## [Null-safe navigation operator](https://github.com/HaxeFoundation/haxe-evolution/pull/89)

With the relatively recent addition of [null safety](https://haxe.org/manual/cr-null-safety.html) in Haxe 4, nullable values are less likely to cause unexpected runtime issues in Haxe code. However, especially when dealing with `extern`-based code, it might be common to see types like this:

```haxe
type Foo = {
  ?bar:{
    ?baz:{
      ?num:Int,
    },
  },
};
```

Accessing `foo.bar.baz.num` while appeasing null safety checks can be a bit clunky:

```haxe
var foo:Null<Foo> = ...;

var result = null;
if (foo != null
  && foo.bar != null
  && foo.bar.baz != null) {
  result = foo.bar.baz.num;
}

// alternative using the ternary operator
result = foo != null ?
  (foo.bar != null ?
  (foo.bar.baz != null ?
  foo.bar.baz.num
  : null) : null) : null;
```

Neither version is great!

The ["Null-safe navigation operator"](https://github.com/HaxeFoundation/haxe-evolution/pull/89) proposal suggests adding the `?.` syntax to get rid of such boilerplate checks. This operator already exists in multiple modern programming languages.

Its behaviour can be summarised as:

```haxe
a?.b;
// is the same as
a != null ? a.b : null;
```

With this, our first example becomes simply:

```haxe
var result = foo?.bar?.baz?.num;
```

The proposal also mentions null-safe array access and function calls, using the `?.[ ... ]` and `?.( ... )` syntax, respectively. For the time being, however, we are accepting the null-safe field access only, and we will see later if the other variants might make a good addition.

Verdict: **accepted**.

## [Destructors](https://github.com/HaxeFoundation/haxe-evolution/pull/88)

[Destructors](https://en.wikipedia.org/wiki/Destructor_(computer_programming)) are user-defined functions that run just before an object is "cleaned up" or goes out of scope. In targets with a garbage collector this feature would typically be used to clean up auxiliary resources that the garbage collector does not manage. As an example, you might imagine a [`FileOutput`](https://api.haxe.org/sys/io/FileOutput.html) that automatically closes the file it refers to when it goes out of scope. The goal is generally to make a language safer to use – it is less likely that programmers will forget to release resources.

The ["Destructors"](https://github.com/HaxeFoundation/haxe-evolution/pull/88) suggests a syntax to define destructors in Haxe classes.

Although a number of Haxe targets support destructors, it is certainly not possible to support destructors in all of them. JavaScript in particular is an important Haxe target that provides no API to the garbage collector (neither in the browser nor NodeJS), so destructors could at best be emulated at a heavy performance penalty.

Verdict: **rejected**.

## [`enum abstract` over `enum` constructors](https://github.com/HaxeFoundation/haxe-evolution/pull/87)

[This proposal](https://github.com/HaxeFoundation/haxe-evolution/pull/87) suggests a way to define `enum abstract` types over the constructors of another `enum`. This could be used to limit the constructors to a particular subset:

```haxe
enum Crud {
  Create(id:String, data:Any);
  Read(id:String);
  Update(id:String, data:Any);
  Delete(id:String);
}
enum abstract ReadAndUpdate(Crud) to Crud {
  final ReadData = Read;
  final UpdateData = Update;
}
```

Such a subset definition would still be a compile-time feature, however, so for example, code size would not be increased at all because of the `ReadAndUpdate` type.

We have not reached a conclusion about this proposal. We were not really sure about the exact motivation for this proposal, or if the workarounds proposed in the PR comments are acceptable.

Verdict: **open questions remain**.

## [`enum abstract` instances](https://github.com/HaxeFoundation/haxe-evolution/pull/86)

`enum abstract` can be used to define an `enum`-like type which is represented by a specific underlying type at runtime:

```haxe
enum abstract Sign(Int) {
  var Negative = -1;
  var Zero = 0;
  var Positive = 1;
}
```

Haxe will treat the type as only having a limited set of possible values, which is reflected when it is used in `switch` statements:

```haxe
function foo(x:Sign) {
  // this switch is considered exhaustive
  switch (x) {
    case Negative: trace("a");
    case Zero: trace("b");
    case Positive: trace("c");
  }
}
```

Like other `enum` types, its constructors can be used without importing them when the type is already expected.

```haxe
foo(Positive);
```

However, it is not possible to declare an `enum abstract` over an object type, such as `{x:String}`. The ["`enum abstract` instances"](https://github.com/HaxeFoundation/haxe-evolution/pull/86) proposal suggests to remove this limitation:

```haxe
@:forward
enum abstract Style({ final colour:UInt; final borderWidth:Int; }) {
  final PlainRed = {colour: 0xFFFF0000, borderWidth: 0};
  final FramedWhite = {colour: 0xFFFFFFFF, borderWidth: 2};
}
```

Any instance of such an `abstract` would then be one of the statically initialised "constructors".

```haxe
function applyStyleToComponent(style:Style) {
  this.colour = style.colour;
  this.borderWidth = style.borderWidth;
  if (style == PlainRed) {
    trace("this component must be important!");
  }
}

applyStyleToComponent(PlainRed);
```

We have not reached a conclusion about this proposal. Once again, we were not really sure about the exact motivation for this proposal, and there remain some questions about equality checks for instances of such `abstract` types.

Verdict: **open questions remain**.

## [Null-coalescing operator](https://github.com/HaxeFoundation/haxe-evolution/pull/85)

Just like the null-safe navigation operator proposal above, [this proposal](https://github.com/HaxeFoundation/haxe-evolution/pull/85) makes using nullable types and null safety in Haxe a bit more practical. However, instead of defaulting to a `null` value, the null-coalescing operator lets the user decide what the default value should be.

Its behaviour can be summarised as:

```haxe
a ?? b;
// is the same as
a != null ? a : b;
```

Since this will become a binary operator in Haxe, we will also allow it in the combined operation + assignment form:

```haxe
a ??= b;
// is the same as
a = (a != null ? a : b);
```

We have decided to accept this proposal as well. In fact, a [PR implemething this operator](https://github.com/HaxeFoundation/haxe/pull/10428) is already in the works!

Verdict: **accepted**.

## [Local static](https://github.com/HaxeFoundation/haxe-evolution/pull/84)

[`static` variables](https://haxe.org/manual/class-field-static.html) store state related to a particular class and such state is attached to the type itself, not its instances. This can be useful when implementing unique counters or caching, for example:

```haxe
class Texture {
  static var loadedTextures:Map<String, Texture> = [];
  public static function loadTexture(path:String):Texture {
    if (loadedTextures.exists(path)) {
      return loadedTextures[path];
    }
    var texture = new Texture();
    // perform actual texture load (expensive operation)
    loadedTexture[path] = texture;
    return texture;
  }
}
```

However, it might happen that such `static` fields are only ever meant to be used from a single method. In the example, `loadedTextures` might not be read or written at all by any other method of `Texture`. Why should it be accessible at all then?

The ["Local static"](https://github.com/HaxeFoundation/haxe-evolution/pull/84) proposal suggests `static` variables could be tied to function-local scopes, just like other variables. The example could then be changed to:

```haxe
class Texture {
  public static function loadTexture(path:String):Texture {
    static var loadedTextures:Map<String, Texture> = [];
    // ...
  }
}
```

We have decided to accept this proposal, as it is not a breaking change and can enable generally cleaner code.

Verdict: **accepted**.

## [Allow enums to opt out of publishing their constructors in the implicit global scope](https://github.com/HaxeFoundation/haxe-evolution/pull/83)

(That's a mouthful!)

Suppose there is a Haxe library that defines an `enum` type:

```haxe
package my.great.library;
enum Foo {
  Bar(x:Int);
}
```

Constructing a `Foo.Bar` can be done in client code by typing out the full module path:

```haxe
trace(my.great.library.Foo.Bar(42));
```

Naturally, we might want to import `Foo` so we don't have to type out that path every time:

```haxe
import my.great.library.Foo;
// then
trace(Foo.Bar(42));
```

However, that import does more than it seems. We can actually type just `Bar`:

```haxe
trace(Bar(42));
```

Great, less to type! ... Unless you happen to also have a type called `Bar`. Unfortunately, the constructors of the imported `enum` shadow even locally defined types:

```haxe
import my.great.library.Foo;

class Bar {
  public static function blah():Void {}
}

class Main {
  public static function main():Void {
    trace(Foo.Bar(2)); // ok

    trace(Bar(2));     // still refers to the enum constructor

    Bar.blah();        // this is an error! `Bar` still refers to the enum
                       // constructor, not the `Bar` class

    Main.Bar.blah();   // we have to refer to it like so
  }
}
```

This makes naming `enum` constructors a bit tricky. Constructor names without unique prefixes would look nicer, but they would pollute the global namespace too much. For example, in the macro APIs, the [`ExprDef` constructors](https://api.haxe.org/haxe/macro/ExprDef.html) are all prefixed with `E`, otherwise `Array` would refer to the array access expression kind rather than the built-in `Array` type.

[The proposal](https://github.com/HaxeFoundation/haxe-evolution/pull/83) suggests that the `enum` could be marked with a new metadata (`@:qualified_enum_access`) to opt out of this behaviour.

While we agree that this is a problem in Haxe, we have decided to reject this proposal, as we feel that the proposed solution is not general enough. We would like to see a cleaner approach, and probably one that lets the programmer decide how the `enum` should be imported at the *import* site, not the *declaration* site.

Verdict: **rejected**.

## [Shorthand nullable-type syntax](https://github.com/HaxeFoundation/haxe-evolution/pull/77)

Yet another one to do with nullable types and yet again involving a `?`.

The [Shorthand nullable-type syntax](https://github.com/HaxeFoundation/haxe-evolution/pull/77) proposal suggests a shorter syntax to define nullable types:

```haxe
var a: Int?;
var b: Array<Int?>?;
var c: (Foo?, Bar?)->String;

// equivalent to
var a: Null<Int>;
var b: Null<Array<Null<Int>>>;
var c: (Null<Foo>, Null<Bar>)->String;
```

We have decided to reject this proposal. Its only benefit is saving a couple of characters, and the explicit `Null` syntax might even be easier to understand (it is harder to miss that the type might be `null`). Accepting this proposal might also lead to some syntactic ambiguities when combined with the other null-safety operators mentioned above, or when dealing with functions types returning nullable values (is `()->Int?` a nullable function or is it a function that returns a nullable `Int`?).

Verdict: **rejected**.

---

The remaining 6 proposals were already discussed in the last meeting and have now been definitely rejected or accepted. Please see the [previous blog post](https://haxe.org/blog/evolution-meeting-2020/) for more context for these!

## [`Void` as unit type](https://github.com/HaxeFoundation/haxe-evolution/pull/76)

In the end, we have decided to reject this proposal. The fact that `Void` was ever accepted as a type parameter has cause many issues, including the one motivating the original proposal (e.g. a `Signal<Void>` type). Due to `Void` semantics in Haxe, the following two functions types accept a different number of arguments:

```haxe
Void->Int; // 0 arguments
Int->Int; // 1 argument
```

This is a problem because one can define a generic type with a parametrised function:

```haxe
class Foo<T> {
  public var func:T->Int;
}
```

If `Foo` is instantiated with `Void` as its type parameter, `func` becomes a 0-argument function. Any other type would result in the expected 1-argument `func`.

So, to not make the problem any deeper than it has to be, we will not be making `Void` a unit type. Instead, we will add a separate `Unit` type to the standard library in the future.

Verdict: **rejected**.

## [Multiple argument array access](https://github.com/HaxeFoundation/haxe-evolution/pull/72)

Although parsing array accesses with multiple arguments should be possible without changing too much of the parser, this feature would still require significant changes to our AST representation. In particular, should array access with a single argument remain as its own variant of `ExprDef` (`EArray`), as opposed to anything with multiple arguments? This is less breaking for macros, but also not great design overall.

We have decided to reject this proposal, because we don't want to introduce too much syntax that does not make sense in the Haxe language itself (i.e. without requiring a macro preprocessing step).

Verdict: **rejected**.

## [Onsite getters and setters implementation](https://github.com/HaxeFoundation/haxe-evolution/pull/63)

The property syntax in Haxe can use improvements – in particular, splitting the declaration of the property from its getters or setters is not ideal. However, we have decided to reject the syntax described in this proposal. A proposal using [syntax similar to C#](https://github.com/HaxeFoundation/haxe-evolution/pull/63#issuecomment-526764168) is welcome!

Verdict: **rejected** (in the proposed form).

## [Self access for abstracts](https://github.com/HaxeFoundation/haxe-evolution/pull/62)

There have been [**many** syntax ideas](https://github.com/HaxeFoundation/haxe-evolution/pull/62#issuecomment-964104845) in the comments for this proposal. We decided for one of the non-breaking alternatives, without a method to specify custom identifiers for accessing either `this` or its abstract version: `abstract` used as a keyword:

```haxe
abstract Foo(Int) {
  public function plusOne():Int {
    // here, `this` refers to the underlying instance of type `Int`
    return this + 1;
  }
  public function singletonArray():Array<Foo> {
    // here, `abstract` refers to the abstract instance of type `Foo`
    return [abstract];
  }
}
```

Verdict: **accepted** (in a modified form).

## [Default type parameters](https://github.com/HaxeFoundation/haxe-evolution/pull/50)

We have decided to accept this proposal. Although the issues mentioned in the last blog post are still valid, we would like to see an implementation to either resolve them or perhaps limit the feature a little bit, for example to only support default type parameters on types, not methods.

Verdict: **accepted**.

## [Polymorphic `this` types](https://github.com/HaxeFoundation/haxe-evolution/pull/36)

Although the proposal shows a "nice to have" feature, it has remained open for a long time with relatively little activity and some unresolved questions. Given that we are unsure how exactly to proceed with an implementation, we have decided to reject the proposal in the current form. A PR implementing the feature or a more detailed proposal for it would still be considered.

Verdict: **rejected** (in the proposed form).
