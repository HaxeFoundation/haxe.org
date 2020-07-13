title: The type inference mystery novel part 2
author: simn
description: Will Detective Haxe redeem himself and overcome his inner demons?
background: SsoKppt2pqY.jpg
published: true
disqusID: 57
---

# The type inference mystery novel part 2

[Last time we spoke](https://haxe.org/blog/type-inference-mystery-novel/), Detective Haxe was in a bad spot. The villains had managed to lead him astray by overloading his deductive process. There was a misconception, a glaring contradiction that could only mean that an invalid assumption had been made. And although there was a glimmer of hope at the end, the audience was left wondering if our protagonist would persevere.

Now, a month later, Detective Haxe has again assembled everyone in the room and is about to announce the culprit. It seems like a déjà vu, the recurrence of an event that took place in the past. This would be about the same case, the same suspects, and the same detective. But something had changed... In order to understand what transpired, we have to travel back in time.

No monomorphs were harmed during the making of this article.

## The Freedom of Constraints

[Paul Watzlawick](https://en.wikipedia.org/wiki/Paul_Watzlawick) asserted that "every communication has a content and relationship aspect". This implies that we can't simply take any given content and detach it from its context without losing its overall meaning. I can jokingly call a friend a "stupid idiot", but if I try the same with a random stranger on the street, the results might be quite different, even if the delivery in terms of tonality and such is identical. In a similar fashion, while the term "dying infants" might offend or shock a lot of people, it is a perfectly acceptable thing to discuss among developers of generational garbage collectors.

I asked a non-programmer friend if the term "constraint" has a negative connotation for him, and he agreed that it does. This didn't surprise me, because we generally associcate a constraint with a limitation, and that's generally something negative. However, the interpretation is likely more favorable when asking a programmer, mathematician, or BDSM practitioner.

That brings me to the topic of **Constrained Monomorphs**, which were [implemented](https://github.com/HaxeFoundation/haxe/pull/9549) shortly after the last type inference article. In that article, we learned that monomorphs can be *bound*, which is the process of associating a type with them. Now, we can also constrain them, which is a bit more gentle.

We use this, for example, when dealing what used to be "open structures":

```haxe
class Main {
	static function main() {}

	static function test(a) {
		a.age = 24;
		$type(a); // Unknown<0> : { age : Int }
	}
}
```

Inside the `test` function, after the `a.age = 24` assignment, we know that `a` has a structure which has (at least) a field `age` of type `Int`. However, we don't know what _exactly_ the type is, hence it is still "unknown". This is what the print tells us.

The notation is borrowed from how [type parameter constraints](https://haxe.org/manual/type-system-type-parameter-constraints.html) are defined, and we indeed use constrained monomorphs for those as well:

```haxe
class Main {
	static function main() {
		var a = test();
		$type(a); // Unknown<0> : Float
	}

	static function test<T:Float>():T {
		return null;
	}
}
```

Again, we don't know what exactly the type is, but it is _at least_ `Float`. It could be `Int`, or something else that can be assigned to `Float`. In general, constraints are very useful whenever we want to describe some sort of lower bound.

There is, however, a slight risk here: If our constraints are too liberal, they could <strike>enroll in an American college campus</strike> create a type-hole. Imagine if, in the open structure example, we would just allow further and further structural constraints to be added, even outside the function in question. This would weaken our typing, as a typo like `agee` would create a new field constraint instead of a compilation error. Intuitively, we have to stop allowing additional constraints once we're done typing the function.


## Free Spirits

Honestly, Detective Haxe is a bit of a dolt sometimes. He conducts all these fancy investigations, weaves this beautiful web of relationships between various actors, and grows trees that reach the heavens and span the horizon - and yet he never even kept a proper list of the monomorphic suspects he's observing. They are free spirits that roam the Haxian Plains, which is very romantic, but not very pratical when you actually want to get a hold of them.

And we do want to get a hold of them. We just established that we have to stop allowing additional inference - that the constrained monomorph has to be _closed_. In order to do so, we need to know how to contact it so that we can turn towards them after typing a function and say "Just one more thing..." Fortunately, this was straightforward for the open structure case because there's only a single place where these monomorphs are created, so it was [part of the original pull request](https://github.com/HaxeFoundation/haxe/pull/9549/files#diff-7751fb5a214587d52bb38306d17d7dbbR518).

We can observe that this works as advertised:

```haxe
class Main {
	static function main() {
		var x = null;
		$type(x); // Unknown<0>
		$type(test); // (a : { age : Int }) -> Void
		test(x);
		$type(x); // { age : Int }
		x.agee; // { age : Int } has no field agee (Suggestion: age)
	}

	static function test(a) {
		a.age = 24;
		$type(a); // Unknown<0> : { age : Int }
	}
}

```

We assign the monomorph that belongs to `x` to the argument of the `test` function. While `a` inside that function is still a constrained monomorph, we can see that the argument type of the `test` function is `{ age : Int }` from the outside - a good old plain structure type. Thus, the monomorph of `x` ends up being bound to the structure type and a typo like `x.agee` is detected as expected. All this is a consequence of Haxe keeping track of the monomorph of `a` while typing `test`, and then *closing* the monomorph afterwards.

Closing a monomorph means looking at its constraints and determining a type that it should be bound to. Currently, this happens in two situations:

1. If the monomorph is structurally constrained like in the example here, bind it to a structure type that contains all the structural constraint fields.
2. If the monomorph is constrained to a single type, bind it do that type.

This is all that was needed for these open structure monomorphs. But there are others. Monomorphs are everywhere. One might be right behind you as you're reading this, waiting for you to be so immersed in this story that you stop paying attention to your surroundings, and then...

But fear not, for Detective Haxe is ahead of the curve. He equipped his trusty bug net and went ahead [catching all those critters](https://github.com/HaxeFoundation/haxe/commit/5fad913a1c843fe413ae3df214ed137c60f764f4). Well, not all of them, but most of them. Some remain free and might be plotting their revenge, but that's a problem for another day. For now, it's time for the climax.


## Reductio ad Impossibile

We are back in the present time. Detective Haxe has just laid out the original example again:

```haxe
extern class Extern {
    @:overload static function itWasYou(i1:Int, i2:Int):Void;
    @:overload static function itWasYou(s1:String, s2:String):Void;
    @:overload static function itWasYou(f1:Float, f2:Float):Void;
}

function main() {
    var a = null;
    $type(a); // Unknown<0>
    Extern.itWasYou(a, "foo");
}
```

Just like before, he starts his deduction. Looking at the first overload, he again concludes that `a` must be `Int`. At this point, the true culprit quietly snickers. "He's falling for the same trick again. What a stupid idiot." The detective again tries to unify `"foo"` with `i2:Int`, and, again, this unification doesn't work. The culprit can barely contain his laughter.

But then it happens.

> "Therefore, I have indirectly proven that `a` cannot be `Int`, because that assumption leads to a contradiction!"

A dramatic pause

> "I was just **pretending** to be retarded!"

The culprit gasps.

> "Now, I shall [**reset**](https://github.com/HaxeFoundation/haxe/pull/9696) that assumption and start over!"

There it is.

> "If we assume that `a` is actually `String` from the second overload, then we can assign `"foo"` to `s2:String` - the unification works! This is the truth of this case!"

And with that, the mystery was solved.


## Aftermath

In the end, the actual change was quite minor: once we had a list of all the monomorphs, all we needed to do is remember their state before unifying the call to an overloaded function and then resetting it upon failure. I already had this idea when writing the last article, but actually finding these dreaded monomorphs was more annoying than I thought.

Technically, the whole constrained monomorph business is not strictly related to this overload reset problem. However, reorganizing monomorph handling like that made it a lot simpler to deal with this problem, too. We also got [type parameter constraints on local function](https://github.com/HaxeFoundation/haxe/issues/9559) as a fallout from this change, and there are some [plans](https://github.com/HaxeFoundation/haxe/issues/9553) to further extend this.

Overall, I think Haxe's type inference is heading in the right direction and I look forward to further improvements (and writing about them)! If you have suggestions for future articles, please let me know.

... and if you see Detective Haxe at the bar, don't buy him a drink. Last time somebody did that, he ended up hopping through the precinct with his pants at his ankles while repeatedly yelling "Int should be Int!"