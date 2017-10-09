Dear Community,

On behalf of the Haxe Foundation I am proud to announce that Haxe 4.0.0-preview.2 is now officially released! It is available along with the changelog at <https://haxe.org/download>.

This release removes the old PHP target, which means Haxe is going to output only PHP7 from now on. Furthermore, we are removing some parts of the standard library. For easier transition, they are still available in this haxelib: <https://lib.haxe.org/p/hx3compat/>

The major new feature of this release is the addition of the `final` keyword, which can be used in place of `var` for class fields. For static fields, it behaves like `var name(default, never)`. For instance fields, it allows assignment to the variable only from the class constructor. Further refinements and documentation will follow.

There have also been, of course, various bugfixes. We will make an effort to have monthly preview releases for the remainder for 2017, and then move on to RC releases once we are happy with where Haxe 4 is.

Please test your Haxe code with this version and let us know if you come across any problems at <https://github.com/HaxeFoundation/haxe/issues>.

Thank you for your support
