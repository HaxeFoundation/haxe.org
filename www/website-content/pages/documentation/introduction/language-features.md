Haxe Language Features
=======

* __[Abstract types](/manual/types-abstract.html):__ An abstract type is a compile-time construct which is represented in a different way at runtime. This allows giving a whole new meaning to existing types. 

* __[Anonymous structures](/manual/types-anonymous-structure.html):__ Data can easily be grouped in anonymous structures, minimizing the necessity of small data classes. 


* __[Classes, interfaces and inheritance](/manual/types-class-instance.html):__ Haxe allows structuring code in classes, making it an object-oriented language. Common related features known from languages such as Java are supported, including inheritance and interfaces. 


* __[Conditional compilation](/manual/lf-condition-compilation.html):__ Conditional Compilation allows compiling specific code depending on compilation parameters. This is instrumental for abstracting target-specific differences, but can also be used for other purposes, such as more detailed debugging. 


* __[(Generalized) Algebraic Data Types](/manual/types-enum-instance.html):__ Structure can be expressed through algebraic data types (ADT), which are known as enums in the Haxe Language. Furthermore, Haxe supports their generalized variant known as GADT. 


* __[Inlined calls](/manual/class-field-inline.html):__ Functions can be designed as being inline, allowing their code to be inserted at call-site. This can yield significant performance benefits without resorting to code duplication via manual inlining. 

* __[Iterators](/manual/lf-iterators.html):__ Iterating over a set of values, e.g. the elements of an array, is very easy in Haxe courtesy of iterators. Custom classes can quickly implement iterator functionality to allow iteration. 

* __[Local functions and closures](/manual/expression-function.html):__ Functions in Haxe are not limited to class fields and can be declared in expressions as well, allowing powerful closures. 

* __[Static Extensions](/manual/lf-static-extension.html):__ Existing classes and other types can be augmented with additional functionality through `using` static extensions. 


* __[Partial function application](/manual/lf-function-bindings.html):__ Any function can be applied partially, providing the values of some arguments and leaving the rest to be filled in later. 


* __[Pattern Matching](/manual/lf-pattern-matching.html):__ Complex structures can be matched against patterns, extracting information from an enum or a structure and defining specific operations for specific value combination. 


* __[Properties](/manual/class-field-property.html):__ Variable class fields can be designed as properties with custom read and write access, allowing fine grained access control. 

* __[Type Parameters, Constraints and Variance](/manual/type-system-type-parameters.html):__ Types can be parametrized with type parameters, allowing typed containers and other complex data structures. Type parameters can also be constrained to certain types and respect variance rules. 
