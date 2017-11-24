title: Abstracting primitives
author: nadako
description: Let's talk about abstract types and how they can bring meaning to primitive values
published: true
background: haxe-tips.jpg
tags: tech
disqusID: 31
---
# Abstracting primitives

Most modern programming languages provide at least two kinds of data types: primitive (string, number, boolean, etc) and composite (structures, classes, etc). Using these can get you pretty far, since it allows for describing complex domain entities by combining primitive (and composite) types as member fields of a composite type.

In addition to these two, Haxe also provides a higher-level concept of [abstract types](https://haxe.org/manual/types-abstract.html) a.k.a. abstracts. They are called like this because they provide an _abstraction_ over some concrete type, effectively hiding it from the user and allowing for defining completely new semantics for it, without introducing new type at run-time.

This has a lot of applications, since in addition to adding methods to any type, abstracts provide [ways to define unification and conversion rules](https://haxe.org/manual/types-abstract-implicit-casts.html) between types (i.e. you can control what types are assignable _from_ and _to_ your abstract type and what actions are required for that).

I already wrote a [post about using abstracts over composite types](https://haxe.org/blog/zero-cost-abstracts/) before, but in this post I'd like to talk about another interesting use case: **abstracting primitives**.

## Primitives in type system

As I said in the beginning, primitive types are your strings, numbers, booleans and other "basic" types. But a string, for example, could mean thousands of different things: person name, file path, ip address, locale key, object identifier, html tag, you name it. A number could mean anything too: time stamp, time interval, object id, different object id, counter, resource amount, hash value, file handle, http status code, etc.

A set of operations allowed for all these things is different and they are rarely compatible with each other, so you don't want to pass one where another is expected. This sounds like they should be different types, and they totally should - distinguishing and controlling data is what type systems in programming languages are for!

In a lot of languages, the only way to achieve this is wrapping a primitive type in a composite type (i.e. a single-field "value object" class), which is often annoying to write or awkward to use or brings run-time overhead, or all three altogether. Because of these reasons, people tend to "keep things simple" and just use primitives, which in the long term results in a mess, called [Primitive Obsession](http://blog.ploeh.dk/2011/05/25/DesignSmellPrimitiveObsession/), where it becomes not easy to say what meaning does e.g. some particular integer have and what values are allowed for it.

Haxe abstracts provide a graceful way to deal with this, providing a concise and error-proof syntax to define completely new types based on existing ones without introducing any run-time overhead.

## Use case: locale keys

For example, let's take a look at a situation with translations: there are strings to display in the UI, and there are locale keys to be translated by some mechanism so they become strings for displaying. Essentially they are both strings, but passing a locale key to the UI without translation will result in displaying a key instead of a proper message to the user, so it's an error. Let's solve this with Haxe abstracts!

```haxe
function displayMessage(message:String) {
    // some implementation here
}

function translate(key:LocaleKey):String {
    // some implementation here
}

abstract LocaleKey(String) {}
```

The `LocaleKey` abstract type is defined "over" a `String`, but it has no `from/to` implicit casts defined, meaning it's not compatible with regular `String`s when it comes to type checking, so passing a value of `LocaleKey` to the `displayMessage` function will result in a compile-time error: `LocaleKey should be String`. Similarly, you cannot pass a random `String` to the `translate` function, which, again, protects you from accidentally trying to translate already translated messages, which is not an uncommon in real world.

## Use case: time arithmetic

Another interesting example from my experience is representing time in game logic. For performance reasons, time in games is often represented as simple integer, e.g. seconds passed since start of the game. In fact, there is another kind of integer related to time in this scenario - _time interval_. Representing both of these concepts as integers can lead to bugs and confusion, because unlike random integers, set of operations that make sense for time and intervals is much smaller and their result often change the meaning of the number in question (for example subtracting one _time_ value from another results in an _interval_ between them, adding _interval_ to _time_ results in a new _time_ value, adding two _time_ values does not make sense at all). So why don't we represent those as distinct types with clearly defined operations?

```haxe
/** Absolute time value */
abstract Time(Int) {
    // Addition of Time and Interval values is defined, commutative and results in a modified Time value
    @:commutative
    @:op(a + b) static function _(a:Time, b:Interval):Time;

    // Subtraction of Interval from Time is defined and results in a modified Time value
    @:op(a - b) static function _(a:Time, b:Interval):Time;

    // Subtraction of two Time values is defined and results in Interval between them
    @:op(a - b) static function _(a:Time, b:Time):Interval;
}

/** Relative time interval */
abstract Interval(Int) {
    // Addition and subtraction if Interval values results in a new Interval value
    @:op(a + b) static function _(a:Interval, b:Interval):Interval;
    @:op(a - b) static function _(a:Interval, b:Interval):Interval;
}
```

Here we define allowed operations using [operator overloading](https://haxe.org/manual/types-abstract-operator-overloading.html), supported by abstract types. We also use the [underlying type operator exposing](https://haxe.org/manual/types-abstract-operator-overloading.html#exposing-underlying-type-operations) feature: since `Int` supports addition and subtraction natively and we want to simply forward them to the underlying integer - we don't specify operator function body (its name is also unused, so we just use `_` for all of the overloads).

## Use case: object identifiers

In my code I almost never use plain integers or strings as object identifiers. Instead I define specific abstract types that describe particular identifier value type, so when you have a function that takes multiple ids of different entities, it's not a function that takes a bunch of integers, it's a properly typed function with clear signature and its usages are checked for correctness at compile-time:

```haxe
abstract WorkerId(Int) {}
abstract BuildingId(Int) {}
abstract ToolId(Int) {}

function orderBuildingRepair(worker:WorkerId, building:BuildingId, tool:ToolId) {}
```

The compiler will obviously complain if we pass arguments in a wrong order or pass some random integer as an argument, which makes code more error-proof and also more readable.

It's the same with object types, e.g.:

```haxe
class RepairOrder {
    var worker:WorkerId;
    var building:BuildingId;
    var tool:ToolId;
}
```

## Use case: data validation with macros

The last example from the previous section is particularly interesting, because if we define the structure, with Haxe macros we can easily analyze it and generate validation code that checks if some actual data (e.g. a JSON file) is compliant with the structure (i.e. objects have all the required fields with proper types).

Unlike generic primitive types, your defined abstract types actually have specific meaning in the domain of your project, which means you can add custom validation to each abstract type that does additional checks. Here are some examples:

 * value typed with `LocaleKey` must be present in the translation data (in other words - detect untranslated values)
 * value typed with `Time` must be greater or equals 0 (because negative values don't make sense for this type)
 * value typed with `WorkerId`/`BuildingId`/`ToolId` must be present in some specific collection of worker/building/tool
   objects (so one cannot have an id of an inexistant object and thus broken reference)

The cool thing here is that if you add another structure that uses your validated abstract types for its fields you get advanced consistency validation for free (since your system already knows how to validate values of your abstract type).

I think this is a really good DRY (don't repeat yourself) practice, using which you can be sure that your data is consistent without writing checks by hand every time. Also, for data that comes from reliable sources (i.e. your app/game settings), you can move the checks to the compile-time completely and gain some performance by removing unnecessary run-time checks. For data that comes from unreliable sources (e.g. user input) you can macro-generate correct run-time checks without having to write them by hand.

## Creation of the abstract type values

So, if abstract types over primitives (or any other types, actually) are completely new types and not assignable from their underlying type by default, how do we create a value of such a type? I'd say that largely depends on the use case, there are different ways to do that:

### Using constructor syntax:

```haxe
abstract LocaleKey(String) {
	public inline function new(key:String) {
		this = key;
	}
}

// and then...
var myLocaleKey = new LocaleKey("myLocaleKey");
```
This is the most explicit and straightforward way. You can add some run-time value validation calls in the constructor, or you can make it private and define static methods for creating a value with or without validation, just like with classes.

If you're wondering what's `this` in the context of abstracts and why we're assigning to it - `this` represents the actual value typed with the underlying type (`String` in this case), and assigning to it is basically creating a value of this abstract type. See more in [Haxe Manual](https://haxe.org/manual/types-abstract.html).

### Using direct implicit casts:

```haxe
abstract LocaleKey(String) from String {}

// and then
var myLocaleKey:LocaleKey = "myLocaleKey";
```

This is implicit and less safe, because it makes any `String` assignable to our `LocaleKey` type, which is often not what we want. But if the creation of such values is strictly controlled and encapsulated in your code, you might get away with this. :)

### Using method implicit casts:

```haxe
abstract LocaleKey(String) {
	inline function new(key) this = key;

	@:from static function fromString(key:String):LocaleKey {
		// could add some run-time checks here
		return new LocaleKey(key);
	}
}

// and then
var myLocaleKey:LocaleKey = "myLocaleKey";
```

This is similar to the example above, but for each unification the `fromString` function will be called. With `@:from` methods you can provide additional run-time checks or transformations to your value and you can have several `@:from` methods that will do different things depending on the input value type (which also means that you can implicitly assign values of types that are incompatible with the underlying type of your abstract).

This can be useful sometimes, however most of the time I personally like the explicit constructor/methods better, as they give the reader better idea of what's going on and when the conversion function calls kick in.

### Using unsafe casts:

As with any other type, one can subvert Haxe type system with [unsafe cast](https://haxe.org/manual/expression-cast-unsafe.html) or by using [Dynamic](https://haxe.org/manual/types-dynamic.html). While generally it's not advised to do so, it can be useful in cases where the creation of values happen in a very limited number of places, e.g. deserialization of trusted data:

```haxe
abstract WorkerId(Int) {} // no way to create one from "normal" code

class RepairOrder {
	var worker:WorkerId;
	// other fields skipped for brevity

	static function deserialize(rawData:{worker:Int}) {
		var instance = Type.createEmptyInstance(RepairOrder);
		instance.worker = cast rawData.worker; // we know that `rawData` contains a valid value, so we just cast
		return instance;
	}
}
```

Unsafe casts like this can be particularly useful when you're not actually writing this code by hand but generating it with a macro, since you can simplify your macro code without sacrificing much safety.

## Conclusion

I presented some nice use-cases for abstracts in this post, but there are more! For example, check out [this Haxe Cookbook article](https://code.haxe.org/category/abstract-types/abstracts-with-type-params.html) about using type parameters with abstracts over primitives as well as the whole [section about abstract types](https://code.haxe.org/category/abstract-types/). Abstracts are very powerful feature in Haxe and I would like to see more its usages in the wild! :)
