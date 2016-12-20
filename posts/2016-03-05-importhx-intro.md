title: New language feature: import.hx
author: nadako
description: A short introduction to the new Haxe language feature: import.hx
published: true
tags: tech
disqusID: 6
---

# New feature in Haxe language: import.hx

Out of tons of improvements coming in Haxe 3.3 (which will be released quite soon), I'd like to write a small intro for a completely new feature: `import.hx` AKA [defaults](https://github.com/HaxeFoundation/haxe/issues/1138).

This feature allows us to define `import`s and `using`s that will be applied for all modules inside a directory, which is particularly handy for large code bases with a lot of helpers and static extensions.

Imagine we have some `DataTypes` module containing types common to the whole project:

DataTypes.hx
```haxe
typedef Person = {
    var name:String;
    var age:Int;
}

typedef Company = {
    var name:String;
    var employees:Array<Person>;
}
```

Then we also have `Logger` module containing static logging function that we also want to use across our project:

Logger.hx
```haxe
class Logger {
    public static function log(msg:String):Void { /* ... */ }
    public static function warn(msg:String):Void { /* ... */ }
}
```

And finally, we have some handy static extensions in the `Tools` module:

Tools.hx
```haxe
class Tools {
    public static function hasEmployee(company:Company, person:Person) {
        return company.employees.indexOf(person) != -1;
    }
}
```

To use all these in a module with our actual logic, we'd have to add imports and usings to our module, like this:

```haxe
import Logger.*; // import all statics from the Logger class
import DataTypes; // import types from the DataTypes module
using Tools; // enable static extensions from the Tools class
```

That is 3 lines that you have to add in all your modules which can become quite annoying when you have a lot of them. Thankfully, with a new `import.hx` feature, you can create a special `import.hx` file (note the lowercase name!) in the directory where your code lies, place those imports in that file, and they will be applied to all Haxe modules in this directory and its subdirectories.

So, if we move those imports into the `import.hx` file, then we can write our code without `import`/`using` directives and still have them applied, e.g.

Main.hx
```haxe
// look, no import or using directives!

class Main {
    static function main() {
        // use a static method from the Logger class
        log("Hello");

        // use Person type from the DataTypes module
        var sarah:Person = {name: "Sarah", age: 23};
        var john:Person = {name: "John", age: 38};

        // use Company type from the DataTypes module
        var company:Company = {
            name: "Bricks & Blocks",
            employees: [john, sarah]
        };

        // use `hasEmployee` extension method from the Tools class
        var johnIsEmployee = company.hasEmployee(john);

        // user another static method from the Logger class
        warn('John is employee: $johnIsEmployee');
    }
}
```

Cool, right? :)
