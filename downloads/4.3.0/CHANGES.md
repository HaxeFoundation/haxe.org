
## 2023-04-06: 4.3.0

__New features__:

* all : support defaults for type parameters (#10518)
* all : support @:op(a()) on abstracts (#10119)
* all : support abstract keyword to reference the abstract (#10513)
* all : support static var at expression-level (#10555)
* all : support ?. safe navigation operator (#10561)
* all : added ?? null coalescing operator (#10428)
* all : add -w compiler option to configure warnings (#10612)
* all : added new error reporting modes (#10863)
* all : support custom metadata and defines (#10858)

__General improvements__:

* all : made various optimizations in the analyzer
* all : made various improvements to diagnostics
* all : made various improvements to null-safety
* all : optimize `.bind` for instance methods (#10737)
* all : improved various parser error messages
* all : improved compilation server performance
* all : improved code generation for try/catch (#10519)
* all : infer property accessor type from the property (#10569)
* all : improved inference of local functions typed against abstracts (#10336)
* all : improved completion on module-level fields
* all : improved handling of native libraries on the compilation server
* all : improved performance when generating locals (#10648)
* all : made Std.parseInt more consistent across targets (#10664)
* all : infer null literals as Null<?> ([#7736](https://github.com/HaxeFoundation/haxe/issues/7736))
* all : made field access errors more consistent (#10896)
* all : consistently allow trailing commas (#11009)
* all : migrated all relevant targets to PCRE2 (#10491)
* all : made analyzer reconstruct do-while loops ([#7979](https://github.com/HaxeFoundation/haxe/issues/7979))
* all : improved restrictions on init macros (#11043)
* all : improved positions of @:structInit fields ([#9318](https://github.com/HaxeFoundation/haxe/issues/9318))
* macro : support map literals in Context.makeExpr (#10259)
* macro : added haxe.macro.Compiler.getConfiguration() (#10871)
* macro : added withImports and withOption to haxe.macro.Context
* macro : added getMacroStack and onAfterInitMacros to haxe.macro.Context (#11043)
* macro : added haxe.macro.Context.makeMonomorph (#10728)
* eval : added dictionary mode to objects, increasing performance in some cases (#10284)
* eval : fixed Sys.exit handling messing up the compilation server (#10642)
* eval : added -D eval-print-depth and -D eval-pretty-print (#10952, #10963)
* cpp : supported type parameters on extern classes (#10415)
* cpp : haxe.Int64 improvements ([#9935](https://github.com/HaxeFoundation/haxe/issues/9935))
* cpp : non-blocking process exit code reading (#10321)
* js : improved type names for debugger (#10894)
* lua : added SSL implementation (#10593)
* lua : fixed String API when -D no-inline was in place (#11057)
* lua : non-zero exit code in case of uncaught exception (#11082)
* java : deal with default implementations when loading extern libraries (#10466)
* jvm : improved closure naming (#10571)
* jvm : supported --jvm dir (#10614)
* jvm : added some missing TShort and TFloat handling (#10722)
* jvm : added experimental support for functional interfaces (#11019)
* php : added and fixed several extern functions

__Standard Library__:

* all : added atomic operations to several targets (#10610)
* all : added Vector.fill (#10687)
* sys : added sys.thread.Condition and Semaphore (#10503)
* sys : added Http.getResponseHeaderValues to deal with multiple values of same key (#10812)
* sys : make Sys.environment consistent between targets (#10460)
* sys : consistent way to unset environment variables with Sys.putEnv (#10402)

__Bugfixes__:

* all : properly disallowed macro reification in invalid places (#10883)
* all : fixed behavior when extending abstract classes with final fields (#10139)
* all : addressed some issues with constructor inlining (#10304)
* all : fixed pattern matcher bug related to null-guards (#10291)
* all : fixed weird parser behavior on first offset in files (#10322)
* all : fixed various issues related to the final modifier
* all : fixed various issues related to overload handling
* all : fixed precedence of => vs. ?: (#10455)
* all : made error positions in structure declarations more accurate ([#9584](https://github.com/HaxeFoundation/haxe/issues/9584))
* all : brought back proper check when accessing super fields (#10521)
* all : fixed @:publicFields on abstracts (#10541)
* all : inherited some metadata to @:generic implementation classes (#10557)
* all : fixed various problems in EventLoop and MainLoop
* all : fixed infinite recursion from invalid inheritance (#10245)
* all : fixed strange interaction between static extensions and macro functions (#10587)
* all : fixed problems with @:generic on the compilation server (#10635)
* all : fixed Context.onTypeNotFound being called multiple times for the same thing (#10678)
* all : fixed type parameter problem involving abstract classes and interfaces (#10748)
* all : fixed #if (a != b) yielding true for nonexistent values (#10868)
* all : fixed interaction between @:generic and abstract class (#10735)
* all : fixed @:using loading types too eagerly (#10107)
* all : fixed parser ignoring subsequent documentation comments (#10171)
* all : fixed parser function messing up unrelated file state in some cases (#10763)
* all : unified Map printing to always use [] ([#9260](https://github.com/HaxeFoundation/haxe/issues/9260))
* cpp : fixed problem with cpp.Pointer being used in enum arguments (#10831)
* macro : improved handling of macro this expressions (#10793)
* eval : fixed bit shift operations > 31 (#10752)
* eval : fixed Bytes.toString causing an internal exception (#10623)
* jvm : fixed @:native processing (#10280)
* jvm : fixed Type.getEnumConstructs on native enums (#10508)
* jvm : fixed @:volatile being ignored (#10594)
* jvm : fixed some hashing issue when pattern matching on emojis (#10720)
* jvm : fixed stack handling on return return (#10743)
* hl : fixed various code generation problems
* python : fixed SslSocket for newer python versions ([#8401](https://github.com/HaxeFoundation/haxe/issues/8401))
* python : fixed syntax issue related to Vector (#11060)
