Haxe Language Features
=======

* __Abstract types:__ An abstract type is a compile-time construct which is represented in a different way at runtime. This allows giving a whole new meaning to existing types. __See [Abstract](/manual/types-abstract.html).__

* __Anonymous structures:__ Data can easily be grouped in anonymous structures, minimizing the necessity of small data classes. __See [Anonymous Structure](/manual/types-anonymous-structure.html).__


* __Classes, interfaces and inheritance:__ Haxe allows structuring code in classes, making it an object-oriented language. Common related features known from languages such as Java are supported, including inheritance and interfaces. __See [Class Instance](/manual/types-class-instance.html).__


* __Conditional compilation:__ Conditional Compilation allows compiling specific code depending on compilation parameters. This is instrumental for abstracting target-specific differences, but can also be used for other purposes, such as more detailed debugging. __See [Conditional Compilation](/manual/lf-conditional-compilation.html).__


* __(Generalized) Algebraic Data Types:__ Structure can be expressed through algebraic data types (ADT), which are known as enums in the Haxe Language. Furthermore, Haxe supports their generalized variant known as GADT. __See [Enum Instance](/manual/types-enum-instance.html).__


* __Inlined calls:__ Functions can be designed as being inline, allowing their code to be inserted at call-site. This can yield significant performance benefits without resorting to code duplication via manual inlining. __See [Inline](/manual/class-field-inline.html).__

* __Iterators:__ Iterating over a set of values, e.g. the elements of an array, is very easy in Haxe courtesy of iterators. Custom classes can quickly implement iterator functionality to allow iteration. __See [Iterators](/manual/#).__

* __Local functions and closures:__ Functions in Haxe are not limited to class fields and can be declared in expressions as well, allowing powerful closures. __See [Functions](/manual/expression-function.html).__

* __Static Extensions:__ Existing classes and other types can be augmented with additional functionality through `using` static extensions. __See [Static Extension](/manual/lf-static-extension.html).__


* __Partial function application:__ Any function can be applied partially, providing the values of some arguments and leaving the rest to be filled in later. __See [Function Bindings](/manual/lf-function-bindings.html).__


* __Pattern Matching:__ Complex structures can be matched against patterns, extracting information from an enum or a structure and defining specific operations for specific value combination. __See [Pattern Matching](/manual/lf-pattern-matching.html).__


* __Properties:__ Variable class fields can be designed as properties with custom read and write access, allowing fine grained access control. __See [Property](/manual/class-field-property.html).__

* __Type Parameters, Constraints and Variance:__ Types can be parametrized with type parameters, allowing typed containers and other complex data structures. Type parameters can also be constrained to certain types and respect variance rules. __See [Type Parameters](/manual/type-system-type-parameters.html).__
