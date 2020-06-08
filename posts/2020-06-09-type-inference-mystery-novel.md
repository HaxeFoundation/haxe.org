title: The type inference mystery novel
author: simn
description: Detective Haxe is on the case but meets an unexpected adversary
background: SsoKppt2pqY.jpg
published: true
disqusID: 53
---

# The type inference mystery novel

Recently I've spent some time investigating our type inference again. A few years back, type inference was one of our selling points. We would commonly describe Haxe as "Kind of like ActionScript 3, but with _type inference_." The concept is vast, but most programmers are content with knowing that they can just write `var a = new Array()` without having to add an explicit type-hint for the local variable `a`.

Of course there has been a lot of development in this regard. Type inference used to be something functional programming wizards would channel, creating enchanted code in languages such as Haskell or ML. Nowadays, many of the programming languages used by the proletariat support it as well. It is no longer special, which means this is the perfect time to talk about it in more detail.

## The monomorphic culprits

When you work on something for a long time, related terminology becomes very natural and you sometimes forget that not everyone is familiar with it. In the context of Haxe's type inference, it is impossible to not get used to the term "monomorph", which surprisingly only gets you raised eyebrows at dinner conversations. The [Haxe Manual page on type inference](https://haxe.org/manual/type-system-type-inference.html) describes it as "a type that is not yet known". Let us unpack that!

First of all, we're talking about "a type". Even if you can't always see them, [types](https://haxe.org/manual/types.html) are everywhere in Haxe because we're a proper programming language. The purpose of a type is to let the compiler know what one can do with a value of that type. Some types allow arithmetic operations, others support structural access and many of them are related to each other in various ways, like families in Alabama.

Then there is the "not yet known" part. The "not yet" suggests that there is temporal flow, which we can easily verify in a simple example:

```haxe
function main() {
	var a = null;
	$type(a); // Unknown<0>
	a = "value";
	$type(a); // String
}

```

The compiler reads the code of a function like a story, each expression representing a chapter. In the first chapter, the mystery is created by declaring a local variable `a` with an unknown type. We are fascinated by the unknown, and so is the compiler. So much so that it even prints `Unknown<0>` when [asked the type](https://haxe.org/manual/type-system-type-inference.html#define-type) in chapter 2. Detective Haxe is now on the job and determined to find the true identity of the culprit.

That culprit is a monomorph. It is created because while reading the story, the compiler comes across something unknown. Instead of complaining about it, a placeholder is created. This is just like saying "the culprit did something" in a real mystery novel. We might not yet know the identity of the culprit, but we can reason about their actions and methods by using "the culprit" as a placeholder.

When the string `"value"` is assigned to `a` in chapter 3, the mystery is solved. It was String all along! Sherlock Haxe figures this out by employing [unification](https://haxe.org/manual/type-system-unification.html): When an assignment like `a = "value"` is made, the compiler checks if the types of `a` and `"value"` can be _unified_. In this case, it is a straightforward unification of our monomorph `Unknown<0>` and the type `String`, which is resolved by _binding_ the type to the monomorph.

In chapter 4, we assemble everyone in a room to prove via `$type(a)` that we found the identity of the monomorph/culprit. At this point, our monomorph has essentially _morphed_ into the type `String`. It is now forever married to that type - a _mono_-gamous relationship has been established.

... but what if there's a plot twist and we were wrong?

## Overloading the detective

Mystery novels often contain a lot of distractions. We need plenty of characters and motives in order to keep the mystery alive and various possibilities open. In a good story, the reader is encouraged to pursue multiple lines of thought, eliminating them one by one as more information is discovered. This is also true for the detective himself, as both he and the reader are misled in various ways. A clever culprit might even manage to create enough diversions to _overload_ his pursuer.

Naturally, the same can happen to the compiler. Haxe supports overloaded functions for extern definition, which is necessary to interact with native APIs on targets like Java and C#. Overloads represent a choice: Depending on which types we call a function with, the compiler could pick one function or another. We can see that in a simple example:

```haxe
extern class Extern {
	@:overload static function callMe(i:Int):Void;
	@:overload static function callMe(s:String):Void;
	@:overload static function callMe(f:Float):Void;
}

function main() {
	Extern.callMe("value");
}
```

Here we're clearly calling the middle function with the `String` argument. This is easy to see, but in the general case a compiler has to figure this out first. It has to check each candidate function, and then find one that is compatible with our provided call arguments. Unfortunately, this can cause anger and sadness if we let our monomorphs return:

```haxe
extern class Extern {
	@:overload static function itWasYou(i1:Int, i2:Int):Void;
	@:overload static function itWasYou(s1:String, s2:String):Void;
	@:overload static function itWasYou(f1:Float, f2:Float):Void;
}

function main() {
	var a = null;
	$type(a); // Unknown<0>
	// Int should be String
	// For function argument 's1'
	Extern.itWasYou(a, "foo");
}


```

Clearly we intend to call the middle function again, but Detective Haxe is led astray and finds the wrong culprit in the `a` case. This happens because it looks at the `itWasYou(i1:Int, i2:Int)` function first. Upon comparing the first argument, it unifies `Unknown<0>` with `Int`, and just like before that leads to the monomorph being bound to `Int`. It is only when comparing the second argument that a harsh realization is made: The type `String` of value `"foo"` cannot be assigned to `i2:Int`.

At this point the compiler knows that it went wrong, but it's already too late: Because the monomorph has been bound to `Int`, it fails to unify the call arguments when attempting to make the call to the `itWasYou(s1:String, s2:String)` function. This causes the `Int should be String` error, as `a` is now bound to `Int`. Our compiler is so locked into thinking that the culprit is `Int` that it never reconsiders.

## Awaiting the redemption arc

Unfortunately, there is no happy ending to this particular tale. Poor Detective Haxe never manages to recover from his lapse of judgement. His wife leaves him, he is fired from his job and becomes an alcoholic, occassionally muttering to himself "Where did I go wrong?" while seeing his former colleagues solve cases like this effortlessly.

One evening the barkeeper looks at this poor excuse of a compiler, shaking his head in disbelief. "You need a reset, my friend," he says with a concerned voice. Detective Haxe snorts while processing these words. Then, he fixes his gaze on nothing in particular, as if having a realization. "A reset..." he mumbles with squinted eyes. His head suddenly jerks upwards, focusing his friend's slightly startled face. "A reset!" he repeats with determination, before jumping up, slamming  an unspecified currency on the counter, and leaving with a stern stride.

To be continued...
