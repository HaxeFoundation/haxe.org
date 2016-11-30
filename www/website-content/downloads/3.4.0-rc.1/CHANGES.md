### 2016-11-30: __3.4.0-RC1__

__New features__:

* all : support metadata completion
* all : support type-hint completion
* all : added @signature display mode (#4758)
* all : finalized HashLink (HL) target

__Bugfixes__:

* all : fixed various optimization issues
* all : fixed various issues with side-effect detection
* all : fixed performance drain in the DCE implementation (#5716)
* all : fixed issue with assignments when inlining constructors (#5340)
* all : fixed major inlining issue when using compilation server (#5320)
* all : fixed pattern matching evaluation order issue (#5274)
* cpp : fixed various minor code generation issues
* js : fixed issue regarding iterating over abstracts (#5385)
* python : fixed evaluation order issue for array writing (#5366)

__General improvements and optimizations__:

* all : greatly improved support for display mode in general
* all : made --times output look much nicer
* all : remove calls to functions that have no side-effect
* all : hid private property accessors from completion (#5678)
* js : updated jQuery extern (js.jquery.*) for jQuery 1.12.4 / 3.1.0 support.
* js : jQuery extern (js.jquery.*) now includes deprecated fields marked with @:deprecated.
* js : no longer rewrite `o["s"]` to `o.s` (#5724)
* cpp : greatly improved ObjC output and integration options
* lua : greatly improved code output quality

__Standard Library__:

* all : added Any type (#5500)
* all : added haxe.extern.AsVar
* all : added haxe.macro.CompilationServer (experimental)
* all : fixed haxe.Template.resolve (#5301)