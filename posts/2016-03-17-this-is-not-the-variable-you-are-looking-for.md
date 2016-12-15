title: Bugfix Adventures #1 - this is not the variable you are looking for
author: simn
description: Sometimes bugs are very hard to figure out, yet very easy to fix.
published: true
tags: tech
---

I like to classify issues by asking two questions: Is it easy to figure out the problem? And is it easy to address the problem? This classification can be visualized as a table:

easy to | figure out | address
------- | ---------- | -------
1.      | true       | true
2.      | true       | false
3.      | false      | true
4.      | false      | false

Category 1 is every maintainer's favorite, the kind of problem you can figure out and fix over lunch. Between number 2 and 4 there's not really much of a difference because the overall effort is likely going to be addressing-bound anyway. Category 3 on the other hand is the most interesting one by various metrics. It is not uncommon to spend a long time just trying to figure out what's wrong and then, once you finally do, addressing the problem comes down to changing just a few lines of code.

We came across such an issue yesterday. Nicolas was testing his Evoland 2 codebase on my [pattern matcher rewrite branch](https://github.com/HaxeFoundation/haxe/pull/4940) and got an error about some field not existing on some class. We started trying to make sense of it, he by looking at the offending code and me by looking at the changes made on that branch and thinking about how this affects the code. There was definitely something strange going on and after about an hour we decided that a small reproducible example would be necessary.




### The code in question

The problem was tricky to isolate as Nicolas confirmed in the following [quote](https://github.com/HaxeFoundation/haxe/issues/4949#issuecomment-197772098):

> it was tricky to isolate

However, he ultimately succeeded and presented me with this piece of Haxe code:

```haxe
class Main {
	var gems = [1,2,3];

	public function foo() {
		function onEnd(b) {
			next(b);
		}
		var f = function() {
			// Main has no field push
			var ids = [for (i in 0...gems.length) if(gems[i]> 5) i];
		}
	}

	function next(d) { }

	static function main() {
		var x = new Main();
		x.foo();
	}

	public function new() { }
}
```

You can try to compile this on Haxe 3.2 to confirm that there's indeed an error. Being vaguely familiar with the Haxe compiler, it was easy to tell that the problem came from the Array comprehension. To better understand it, we have to look at how array comprehension is handled by the compiler.




### Array comprehension

The Haxe manual [outlines how Array comprehension is used](https://haxe.org/manual/lf-array-comprehension.html) and also hints at how the code is generated. We can confirm this by compiling a small Array comprehension example to Javascript:

```haxe
class Main {
	static function main() {
		[for (i in 0...3) i];
	}
}
```

```javascript
var _g = [];
var _g1 = 0;
while(_g1 < 3) _g.push(_g1++);
```

Take note of the `_g` variable: This is a variable introduced by the compiler which represents the Array being built. It is initialized to the empty Array `[]` and then elements are `push`ed onto it in the loop body. Our original error was about the `push` field, so this seems related. But why would `_g` be of type `Main` instead of type `Array`? Clearly, in the erroring example something must happen between the `var _g = []` and the `_g.push` which causes `_g` to be resolved badly. This is very strange though because the compiler is supposed to ensure that the generated locals have unique names! We can see this if we duplicate the Array comprehension code:

```haxe
class Main {
	static function main() {
		[for (i in 0...3) i];
		[for (i in 0...3) i];
	}
}
```

Javascript output:

```javascript
var _g = [];
var _g1 = 0;
while(_g1 < 3) _g.push(_g1++);
var _g11 = [];
var _g2 = 0;
while(_g2 < 3) _g11.push(_g2++);
```

Indeed, all variables have different names which _should_ avoid any conflict. It looks like there's nothing wrong here, so let's randomly change the subject and talk about closures.



### Closures and the this-context

Haxe has very straightforward semantics when it comes to `this`: It always represents the current instance of the class it appears in. If you try to use `this` outside of class member methods, the compiler yells at you asking you to stop that. Unfortunately, some of our targets have different ideas of what `this` should refer to. We can easily verify this targeting Javascript by using `js.Lib.nativeThis`:

```haxe
class Main {
	static function main() {
		new Main().call();
	}

	function new() { }

	function call() {
		trace(this); // {}
		trace(js.Lib.nativeThis); // {}
		function test() {
			trace(this); // {}
			trace(js.Lib.nativeThis); // undefined
		}
		test();
	}
}
```

Within the `test` closure, Javascript's native `this` is undefined, which does not match Haxe's semantics. This requires Haxe to address the problem in some way, which it does by introducing a local variable holding the `this` value. We can observe this (and `this`) in the output:

```javascript
var _g = this;
console.log(this);
console.log(this);
(function() {
	console.log(_g);
	console.log(this);
})();
```

The output is unsurprising, but what happens if we have multiple closures?

```haxe
class Main {
	static function main() {
		new Main().call();
	}

	function new() { }

	function call() {
		function test() {
			trace(this); // {}
		}
		test();
		function test() {
			trace(this); // {}
		}
		test();
	}
}
```

Javascript output:

```javascript
var _g = this;
(function() {
	console.log(_g);
})();
(function() {
	console.log(_g);
})();
```

Again, unsurprising. The only noteworthy aspect here is that it uses the same `_g` variable in both closures. This suggests that the compiler somehow keeps track of this variable in order to not create multiple this-variables, which leads to our next chapter.



### The this-variable on the typing context

When typing something the Haxe compiler employs a typing *context*. That context keeps track of what class and field are being typed, what the expected return-type is and various other things. It also keeps track of the this-variable mentioned previously. Responsible for that is the context field `vthis : tvar option`. In Haxe, this would be `vthis : Option<TVar>`. Now, when the compiler needs a this-variable, it checks if `vthis` has one and uses it in that case. Otherwise it creates a new one and sets `vthis` accordingly. Let's express that in Haxe code:

```haxe
static function getThis(ctx:Context) {
	return switch (ctx.vthis) {
		case None:
			var v = generateLocal();
			ctx.vthis = Some(v);
			v;
		case Some(v):
			ctx.locals.set(v.name, v); // !
			v;
	}
}
```

The line marked with `// !` is not important. Okay, maybe it is. Pretend that `ctx.locals` is a `Map<String, TVar>`, a lookup table to resolve identifiers to variables. This means that if a this-variable already exists, we add it to the lookup table so it can be resolved. Now it's time to put everything together.



### Finale

Let's go through the `foo` method in the original example and see if we can figure out what's happening:

```haxe
function onEnd(b) {
	next(b);
}
```

The call to `next(b)` is supposed to be made on `this`. Since we are in a closure, we need a this-variable as discussed. At this point, we create a `_g` variable and set `ctx.vthis = Some(_g)` because there is no this-variable yet.

```haxe
var f = function() {
	var ids = [for (i in 0...gems.length) if(gems[i]> 5) i];
}
```

We enter another closure here and start typing the Array comprehension. We learned that the Array is bound to a generated variable which ensures that there are no naming conflicts. Here, we can freely use `_g` because it is not in the lookup. But then something happens!

While typing the right-side of the Array comprehension, we come across `gems.length`. With `gems` being a member field on `Main`, we again need a this-variable because we are in a closure. The `onEnd` closure already created this variable (recall that all closures in a method use the same this-variable), so we grab that *and add it to the `ctx.locals` lookup*. This shadows our Array `_g` variable and when typing `_g.push`, the compiler resolves `_g` to the this-variable which is typed as `Main`. This leads to the original "Main has no field push" error.

Mystery solved! As promised in the introduction, the actual fix is easy. In fact, it consists of [one line](https://github.com/HaxeFoundation/haxe/commit/82b7b249d45832d9121185e5d6bc481033dbe7c9) with which we ensure that the name of the this-variable does not get in the way of any other generated local. Between Nicolas and me, we spent 3 hours figuring this out and the fix itself was done in 10 seconds.
