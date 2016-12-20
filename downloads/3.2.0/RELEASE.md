Dear community,

On behalf of the Haxe Foundation, I am proud to announce that Haxe 3.2.0 is now
officially released! It is available at <https://haxe.org/download/version/3.2.0>.

We spent a lot of time ironing out the bugs that were found in the release
candidate. The following information is from that initial release.

This release introduces the new Python target which was developed by
Heinz Hölzer and Dan Korostelev. As with any new target it should be
considered to be in beta stage.

Another new feature is the static analyzer which can be activated by
compiling with `-D analyzer`. It applies various optimizations such as
constant propagation and expression-level DCE which improves the quality
of the generated code on targets such as JavaScript. We plan to make
this a default setting in the future once the implementation has stabilized.

There are quite a few other new features, improvements and bugfixes, so
make sure to check out the changelog. We addressed many issues that are
present in Haxe 3.1.3!

Haxe 3.2.0 has a few breaking changes. While we try to
avoid these in general, there are situations where that's not feasible.
We have prepared an overview of the breaking changes at
<https://github.com/HaxeFoundation/haxe/wiki/Breaking-changes-in-Haxe-3.2.0>.

Thank you for your support
