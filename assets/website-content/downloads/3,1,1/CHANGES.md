### 2014-03-15: __3.1.1__

__New features__:

* all : added -D deprecation-warnings
* all : allowed \u escape sequences in strings
* cs : implemented haxe.CallStack

__Bugfixes__:

* all : fixed wrong handling of "" and null in haxe.io.Path.join
* all : fixed invalid cast-to-self generation on some abstracts
* all : removed @:to Dynamic from UInt to avoid issues in the Map selection algorithm
* all : fixed various issues with UInt
* all : fixed position setter in haxe.io.BytesInput
* all : fixed various issues with member/static extension macros
* flash : fixed invalid override involving single-constraint type parameters
* flash8 : fixed various bugs
* js : fixed a problem with Std.string(null) being optimized incorrectly
* js : fixed custom generators
* cpp : dealt with string literals that are too long for MSVC
* cs : fixed various issues with -net-lib