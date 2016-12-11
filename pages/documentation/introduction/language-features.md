Haxe Language Features
=======

__[Abstract types](/manual/types-abstract.html):__ An abstract type is a compile-time construct which is represented in a different way at runtime. This allows giving a whole new meaning to existing types. 

__[Anonymous structures](/manual/types-anonymous-structure.html):__ Data can easily be grouped in anonymous structures, minimizing the necessity of small data classes. 

```haxe
var point = { x: 0, y: 10 };
point.x += 10;
```

__[Array Comprehension](/manual/lf-array-comprehension.html):__ Create and populate arrays quickly using for loops and logic.

```haxe
var evenNumbers = [ for (i in 0...100) if (i%2==0) i ];
```

__[Classes, interfaces and inheritance](/manual/types-class-instance.html):__ Haxe allows structuring code in classes, making it an object-oriented language. Common related features known from languages such as Java are supported, including inheritance and interfaces. 

__[Conditional compilation](/manual/lf-condition-compilation.html):__ Conditional Compilation allows compiling specific code depending on compilation parameters. This is instrumental for abstracting target-specific differences, but can also be used for other purposes, such as more detailed debugging. 

```haxe
#if js
	js.Lib.alert("Hello");
#elseif sys
	Sys.println("Hello");
#end
```

__[(Generalized) Algebraic Data Types](/manual/types-enum-instance.html):__ Structure can be expressed through algebraic data types (ADT), which are known as enums in the Haxe Language. Furthermore, Haxe supports their generalized variant known as GADT. 

```haxe
enum Result {
	Success(data:Array<Int>);
	UserError(msg:String);
	SystemError(msg:String, position:PosInfos);
}
```

__[Inlined calls](/manual/class-field-inline.html):__ Functions can be designed as being inline, allowing their code to be inserted at call-site. This can yield significant performance benefits without resorting to code duplication via manual inlining. 

__[Iterators](/manual/lf-iterators.html):__ Iterating over a set of values, e.g. the elements of an array, is very easy in Haxe courtesy of iterators. Custom classes can quickly implement iterator functionality to allow iteration. 

```haxe
for (i in [1, 2, 3]) {
	trace(i);
}
```

__[Local functions and closures](/manual/expression-function.html):__ Functions in Haxe are not limited to class fields and can be declared in expressions as well, allowing powerful closures. 

```haxe
var buffer = "";
function append(s:String) {
	buffer += s;
}
append("foo");
append("bar");
trace(buffer); // foobar
```

__[Metadata](/manual/lf-metadata.html):__ Add metadata to fields, classes or expressions. This can communicate information to the compiler, macros, or runtime classes.

```haxe
class MyClass {
	@range(1, 8) var value:Int;
}
trace(haxe.rtti.Meta.getFields(MyClass).value.range); // [1,8]
```

__[Static Extensions](/manual/lf-static-extension.html):__ Existing classes and other types can be augmented with additional functionality through `using` static extensions. 

```haxe
using StringTools;
"  Me & You	".trim().htmlEscape();
```

__[String Interpolation](/manual/lf-string-interpolation.html):__ Strings declared with a single quotes are able to access variables in the current context.

```haxe
trace('My name is $name and I work in ${job.industry}');
```

__[Partial function application](/manual/lf-function-bindings.html):__ Any function can be applied partially, providing the values of some arguments and leaving the rest to be filled in later. 

```haxe
var map = new haxe.ds.IntMap();
var setToTwelve = map.set.bind(_, 12);
setToTwelve(1);
setToTwelve(2);
```		

__[Pattern Matching](/manual/lf-pattern-matching.html):__ Complex structures can be matched against patterns, extracting information from an enum or a structure and defining specific operations for specific value combination. 

```haxe
var a = { foo: 12 };
switch (a) {
	case { foo: i }: trace(i);
	default:
}
```

__[Properties](/manual/class-field-property.html):__ Variable class fields can be designed as properties with custom read and write access, allowing fine grained access control. 

```haxe
public var color(get,set);
function get_color() {
	return element.style.backgroundColor;
}
function set_color(c:String) {
	trace('Setting background of element to $c');
	return element.style.backgroundColor = c;
}
```

__[Type Parameters, Constraints and Variance](/manual/type-system-type-parameters.html):__ Types can be parametrized with type parameters, allowing typed containers and other complex data structures. Type parameters can also be constrained to certain types and respect variance rules. 

```haxe
class Main<A> {
	static function main() {
		new Main<String>("foo");
		new Main(12); // use type inference
	}

	function new(a:A) { }
}
```
