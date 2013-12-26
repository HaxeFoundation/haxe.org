### 2012-04-14: __2.09__

* all : optimized const == const and const != const (with different const types)
* all : add Type.allEnums(e)
* all : big improvements with completion speed and fixed many issues
* flash9 : fixed -D swfprotected with swc output
* neko : added ~ implementation
* js : upgraded jquery version, more api overloads
* sys : added "in" operator for spod macros, added relation access in expressions
* macro : added ECheckType
* macro : added TLazy for not-yet-typed class fields
* js/php/neko : added haxe.web.Request
* all : added Std.format
* js : trace() output fallback on console.log if no id="haxe:trace"
* all : ensure that Std.is(2.0,Int) returns true on all platforms
* js : replaced $closure by function.$bind + changes in output format
* all : allowed @:extern on static methods (no generate + no closure + force inlining)
* all : added documentation in --display infos + display overloads in completion
* js : removed --js-namespace, added $hxClasses
* flash : output traces to native trace() when using -D fdb or -D nativeTrace
* all : allowed abitrary string fields in anonymous objects
* all : allowed optional structure fields (for constant structs)
* all : allowed optional args in functions types (?Int -> Void)
* all : added Reflect.getProperty/setProperty (except flash8)
* all : added --wait and --cwd and --connect (parsed files and module caching)
* all : fixed completion in macros calls arguments
* all : fixed DCE removing empty but still used interfaces/superclasses
* all : added haxe.Utf8 (crossplatform)
* neko : Reflect now uses $fasthash (require neko 1.8.2)
* all : allow \uXXXX in regexp (although not supported everywhere)
* js : make difference between values and statements expressions in JSGenApi
* js : added source mapping with -debug (replace previous stack emulation)
* flash : added @:file("a.dat") class File extends flash.utils.ByteArray
* flash : added @:sound("file.wav|mp3") class S extends flash.media.Sound
* js : added --js-modern for wrapping output in a closure and ES5 strict mode
* all : null, true and false are now keywords
* all : neko.io.Path, cpp.io.Path and php.io.Path are now haxe.io.Path
* neko, cpp, php : added Sys class, sys.io and sys.net packages and "sys" define
* all : allow to access root package with std prefix (std.Type for example)
* all : added haxe.EnumFlags
* sys : io.File.getChar/stdin/stdout/stderr are now in Sys class
* cpp : Reflect.getField and Reflect.setField no longer call property functions.  Use Reflect.getProperty and Refelect.setProperty instead.
* cpp : Default arguments now use Null<T> for performance increase and interface compatibility
* cpp : Added metadata options for injecting native cpp code into headers, classes and functions
* php : added php.Lib.mail
* (hotfix) fixed bug in completion and disabled profiling on Linux
* (hotfix) fixed $ssize when doing new String(v) in neko
* (hotfix) fixed bug with properties in interfaces for Flash & PHP
