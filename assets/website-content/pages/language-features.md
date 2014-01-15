Haxe Language Features
=======


Abstract types
-------

An abstract type is a compile-time construct which is represented in a different way at runtime. This allows giving a whole new meaning to existing types. [Abstract](/manual/types-abstract.html)

Anonymous structures
-------

Data can easily be grouped in anonymous structures, minimizing the necessity of small data classes. [Anonymous Structure](/manual/types-anonymous-structure.html)


Classes, interfaces and inheritance
-------

Haxe allows structuring code in classes, making it an object-oriented language. Common related features known from languages such as Java are supported, including inheritance and interfaces. [Class Instance](/manual/types-class-instance.html)


Conditional compilation
-------

Conditional Compilation allows compiling specific code depending on compilation parameters. This is instrumental for abstracting target-specific differences, but can also be used for other purposes, such as more detailed debugging. [Conditional Compilation](/manual/lf-conditional-compilation.html)


(Generalized) Algebraic Data Types
-------

Structure can be expressed through algebraic data types (ADT), which are known as enums in the Haxe Language. Furthermore, Haxe supports their generalized variant known as GADT. [Enum Instance](/manual/types-enum-instance.html)


Inlined calls
-------

Functions can be designed as being inline, allowing their code to be inserted at call-site. This can yield significant performance benefits without resorting to code duplication via manual inlining. [Inline]](/manual/class-field-inline.html)

Iterators
-------

Iterating over a set of values, e.g. the elements of an array, is very easy in Haxe courtesy of iterators. Custom classes can quickly implement iterator functionality to allow iteration. [Iterators](/manual/#)

Local functions and closures
--------

Functions in Haxe are not limited to class fields and can be declared in expressions as well, allowing powerful closures. [Functions](/manual/expression-function.html)

Static Extensions
--------

Existing classes and other types can be augmented with additional functionality through `using` static extensions. [Static Extension](/manual/lf-static-extension.html)


Partial function application
--------

Any function can be applied partially, providing the values of some arguments and leaving the rest to be filled in later. [Function Bindings](/manual/lf-function-bindings.html)


Pattern Matching
--------

Complex structures can be matched against patterns, extracting information from an enum or a structure and defining specific operations for specific value combination. [Pattern Matching](/manual/lf-pattern-matching.html)


Properties
--------

Variable class fields can be designed as properties with custom read and write access, allowing fine grained access control. [Property]](/manual/class-field-property.html)

Type Parameters, Constraints and Variance
--------

Types can be parametrized with type parameters, allowing typed containers and other complex data structures. Type parameters can also be constrained to certain types and respect variance rules. [Type Parameters](/manual/type-system-type-parameters.html)
