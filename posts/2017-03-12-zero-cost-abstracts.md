title: Zero-cost abstracts
author: nadako
description: Abstract types in Haxe is a powerful mechanism providing means of abstraction with no run-time overhead
published: false
background: haxe-tips.jpg
tags: tech
disqusID: 27
---
# Zero-cost abstracts

[Abstract types](https://haxe.org/manual/types-abstract.html) in Haxe is a powerful mechanism providing means of abstraction
with no run-time overhead.

They are particularly good for avoiding [primitive obsession](http://wiki.c2.com/?PrimitiveObsession)
without introducing unnecessary object allocations, as demonstrated in many examples, like the canonical [Color](http://code.haxe.org/category/abstract-types/color.html)
abstract. And indeed, almost all usage examples for abstracts on the net show wrapping of some primitive type like String
or Int, emphasizing the [implicit casting](https://haxe.org/manual/types-abstract-implicit-casts.html) and
[operator overloading](https://haxe.org/manual/types-abstract-operator-overloading.html) features, currently unique to abstract
types in Haxe.

But abstracts can be defined over any type (even other abstracts) and that fact seems to be often forgotten in a code design
process. Combine it with a possibility to actually restrict implicit casting (as opposed to introducing it as in most examples)
and we'll have a type-safe and zero-cost way to define new types.

For example, let's write a very simple generic Signal type. Basically, it's just a collection of listeners with a nice
API for adding and calling them, so how about we just use a simple array to represent it at run-time?

```haxe
abstract Signal<T>(Array<T->Void>) {
    public inline function new() {
        this = [];
    }

    public inline function listen(listener:T->Void) {
        this.push(listener);
    }

    public inline function dispatch(data:T) {
        for (listener in this)
            listener(data);
    }
}
```

Quite neat, right? For the consumers, this type has nothing to do with Array:

```haxe
var signal = new Signal();
signal.listen(function(i) trace(i));
signal.dispatch("hi");
```

But if we look at e.g. generated JavaScript, we'll see that at run-time it's a simple array:
```js
var signal = [];
signal.push(function(i) {
	console.log(i);
});
var _g = 0;
while(_g < signal.length) {
	var listener = signal[_g];
	++_g;
	listener("hi");
}
```

(note how all the methods were fully inlined thanks to the [`inline`](https://haxe.org/manual/class-field-inline.html) modifier)

## Even more free abstraction

The `Signal` example above, while very simple, has a design issue: usually, listening to a signal and dispatching it are
handled by completely different subsystems (that's the very idea of the observer pattern), so combining `listen` and `dispatch` methods in a single API is not very clean, since we don't want to allow listening parties to dispatch the signal.

With `abstract`s we can split the API in two without introducing any run-time costs, such object allocation and dynamic dispatching through interface methods. We just wrap the same Array with two abstract types:

```haxe
abstract SignalDispatcher<T>(Array<T->Void>) {
    public inline function new() {
        this = [];
    }

    public inline function dispatch(data:T) {
        for (listener in this)
            listener(data);
    }

    public inline function getSignal():Signal<T> {
        return cast this;
    }
}

abstract Signal<T>(Array<T->Void>) {
    public inline function listen(listener:T->Void) {
        this.push(listener);
    }
}
```

Now the APIs are separated properly: we create a signal dispatcher which can dispatch signals, and from it we can get a
signal to add listeners to:

```haxe
var dispatcher = new SignalDispatcher();

var signal = dispatcher.getSignal();
signal.listen(function(i) trace(i));

dispatcher.dispatch("hi");
```

While at run-time it'll be the same good old array object:

```js
var dispatcher = [];
dispatcher.push(function(i) {
	console.log(i);
});
var _g = 0;
while(_g < dispatcher.length) {
	var listener = dispatcher[_g];
	++_g;
	listener("hi");
}
```

## Putting it together

In the end, I'd like to demonstrate how it could be nicely used in conjunction with inline `get,never` propeties:

```haxe
class Player {
    public var health(default,null):Int;

    public var healthChanged(get,never):Signal<Int>;
    inline function get_healthChanged() return onHealthChanged.getSignal();
    
    var onHealthChanged:SignalDispatcher<Int>;

    public function new() {
        health = 100;
        onHealthChanged = new SignalDispatcher();
    }

    public function takeDamage(damage) {
        health -= damage;
        onHealthChanged.dispatch(health);
    }
}

class Main {
    static function main() {
        var player = new Player();
        player.healthChanged.listen(function(health) trace('Player health is now $health'));
        player.takeDamage(30);
    }
}
```

Let's take a look at the generated JavaScript code:

```js
var Player = function() {
	this.health = 100;
	this.onHealthChanged = [];
};
Player.prototype = {
	takeDamage: function(damage) {
		this.health -= damage;
		var this1 = this.onHealthChanged;
		var data = this.health;
		var _g = 0;
		while(_g < this1.length) {
			var listener = this1[_g];
			++_g;
			listener(data);
		}
	}
};
var Main = function() { };
Main.main = function() {
	var player = new Player();
	player.onHealthChanged.push(function(health) {
		console.log("Player health is now " + health);
	});
	player.takeDamage(30);
};
```

We avoided any unncecessary overhead while still using clean and type-safe interfaces.
