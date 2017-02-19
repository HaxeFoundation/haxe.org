title: Haxe coding tips
author: nadako
description: Here's a couple of neat quality-of-life Haxe features that might not be obvious for people that are new to Haxe.
published: true
background: haxe-tips.jpg
tags: tech
disqusID: 25
---
# Haxe coding tips

Here's a couple of neat quality-of-life Haxe features that might not be obvious for people that are new to Haxe.


## Static imports

Unlike e.g. JavaScript, Haxe doesn't support module-level variable/function definitions,
and the closest possible thing are static class fields. This may seem inconvenient
at first, but it's almost totally negated by the static import feature. With static imports, we
can import any static field (be it `var` or `function`) into the current module's namespace:

_Globals.hx_
```haxe
class Globals {
    public static var VERSION = "1.0";

    public static function sayHello() {
        trace("Hello");
    }
}
```

_Main.hx_
```haxe
import Globals.VERSION;
import Globals.sayHello;

class Main {
    static function main() {
        if (VERSION == "1.0")
            sayHello();
    }
}
```

We can also import a static field with a different name using `as` (e.g. to prevent naming clashes):

```haxe
import Globals.VERSION as APP_VERSION;
```

Note that wildcard (asterisk) imports also work for statics, so if we write `import Globals.*`
there, all statics of the `Globals` class would be imported into our module.

**Read more about import in the [manual](https://haxe.org/manual/type-system-import.html).**


## Typedefs

The `typedef` keyword is often associated with structure types in the Haxe community, since it's a handy (and the only)
way to define a named structure type. But people often seem to forget that `typedef` is more than that. Well, in fact
it's *less* than that, since it's merely an alias for a type. But knowing that it can alias ANY type, not just
structures, opens a lot of opportunities for writing more concise and descriptive code.

For example, if we have a long function type, such as `String->(Bool->Void)->Void` (or worse), it's a good idea
to "typedef" it:

```haxe
/**
    A handler function for a command, takes command name and a callback
    that should be called when command execution is complete.
**/
typedef CommandHandler = String->(Bool->Void)->Void;
```

As seen in this example, typedefs also support documentation, which is great for any public API. Moreover,
typedefs also support type parameters, so you can define generic types easily:

```haxe
typedef MenuItem<T> = {title:String, value:T}
```
(yes, we used typedef with a structure type)

Typedefs can even be used to alias simple types, like `String` or `Array`, to make the code
more descriptive and self-documenting. For example:

```haxe
/** An unique identifier of an user **/
typedef UserId = String;

/** Interval of time in milliseconds **/
typedef TimeInterval = Int;

/** A collection of menu items to show **/
typedef Menu = Array<MenuItem>;

function showMessage(user:UserId, text:String, duration:TimeInterval, menu:Menu)
```

Arguably, using [abstract types](https://haxe.org/manual/types-abstract.html) is even better for these things,
since we could control type unification and add more features to those types (remember `typedef` is just an alias).
Still, these simple type aliases with descriptive names and documentation can improve the quality of your code, compared to
using primitive types everywhere.

**Read more about typedefs in the [manual](https://haxe.org/manual/type-system-typedef.html).**


## Type inference

Type inference is great, make friends with it! Yes, there are places where you'd want to add some explicit type hinting
(like initializing empty arrays, complex structures, or when you want to have implicit type casting kick in). However,
most of the time, blindly adding explicit type hints everywhere only increases the token count without adding any value, while
hurting readability and maintainability of the code. Good, high-level code should focus on what it actually *does*, not
what specific types are involved in it.

In other words, this is redundant and makes code arguably _less_ readable:
```haxe
var person:Person = new Person();
var listeners:Map<String,Array<String->Void>> = new Map<String,Array<String->Void>>();
```

while this is acceptable and useful:
```haxe
var fields:Array<Field> = [];
var player:Player = {name: "Dan", level: 85, items: [{type: "sword"}, {type: "potion"}]};
```

Note that even though the type must be specified for class fields, you can still omit explicit type hints if the field
has an initializer (and thus type can be inferred). This is particularly useful for inline constants, e.g.:

```haxe
class Settings {
    static inline var WIDTH = 800;
    static inline var HEIGHT = 600;
    static inline var TITLE = "Hello";
}
```

A common argument for explicit type hinting is that it's easier to know the type IF needed, however I believe
that this is solved by virtually any code editor out there. For example the [Haxe extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=nadako.vshaxe)
reports types for any expressions on hover:

![vshaxe type hints](vshaxe-type-hints.gif)

**Read more about type inference in the [manual](https://haxe.org/manual/type-system-type-inference.html).**


## Inline local functions

You might be familiar with the concept of [inline methods](https://haxe.org/manual/class-field-inline.html) and
[inline constructors](https://haxe.org/manual/lf-inline-constructor.html) in Haxe. However there's one more kind
of inline functions in Haxe: inline local functions. They can be used to further increase the readability of your Haxe
code without taking any performance hit.

Let's take a look at this real-world-ish example of a function that calculates combat stats in a game,
based on some base values and a given level, using common formulas and settings.

```haxe
function calculateStats(def, level) {
    var statSettings = getSettings();

    inline function calcStat(x) {
        return x * Math.pow(statSettings.levelGrowth, level);
    }

    return {
        health: calcStat(def.baseHealth),
        damage: calcStat(def.baseDamage),
        armor: calcStat(def.baseArmor),
    }
}
```

Looks fairly readable, right? Now if we look at the JavaScript output, we'll see that the local `calcStat` function was inlined and its definition were erased from the final function:

```js
calculateStats: function(def,level) {
    var statSettings = this.getSettings();
    return {
        health : def.baseHealth * Math.pow(statSettings.levelGrowth,level),
        damage : def.baseDamage * Math.pow(statSettings.levelGrowth,level),
        armor : def.baseArmor * Math.pow(statSettings.levelGrowth,level)
    };
}
```

<hr/>

That's all for now. :-) I think I'll write a couple more posts like this, because Haxe is a beautiful language
and there's more niceties like the above. If you're interested, please take some time to read the [official manual](https://haxe.org/manual/introduction.html). Also check out the awesome [Cookbook](http://code.haxe.org/), which has many
useful examples. In fact, I think I'm going to add the samples from this article
to the cookbook. If you have some of your own - feel free to [contribute](https://github.com/HaxeFoundation/code-cookbook) as well!
