Compiler Targets
=======

The following table gives an overview of available Haxe targets:

Name | Tier | Kind | Static typing | Sys  | Since Haxe version
--- | --- | --- | --- | --- | ---
[JavaScript](/manual/target-javascript-getting-started.html) | 1 | source | No | No | beta (2006)
[HashLink](/manual/target-hl-getting-started.html) | 1 | byte code + source | Yes | Yes | 3.4 (2016)
Eval | 1 | interpreter | No | Yes | 4.0 (2019)
[JVM](/manual/target-jvm-getting-started.html) | 1 | byte code | Yes | Yes | 4.0 (2019)
[PHP7](/manual/target-php-getting-started.html) | 1 | source | No | Yes | 3.4 (2016)
[C++](/manual/target-cpp-getting-started.html) | 2 | source | Yes | Yes | 2.4 (2009)
[Lua](/manual/target-lua-getting-started.html) | 2 | source | No | Yes | 3.3 (2016)
C# | 3 | source | Yes | Yes | 2.10 (2012)
[Python](/manual/target-python-getting-started.html) | 3 | source | No | Yes | 3.2 (2015)
Java | 3 | source | Yes | Yes | 2.10 (2012)
Flash | 3 | byte code | Yes | No | alpha (2005)
[Neko](/manual/target-neko-getting-started.html) | 3 | byte code | No | Yes  | alpha (2005)
ActionScript 3 | - | source | Yes | No | 1.12 (2007), removed in 4.0 (2019)
PHP5 | -  | source | No | Yes | 2.0 (2008), removed in 4.0 (2019)


### Notes

- Static typing: Yes - means the target platform natively [supports static typing](https://haxe.org/manual/types-nullability.html); Haxe code itself is statically typed no matter what target it is compiled to
- Sys: Yes - means the target supports the [System API](http://api.haxe.org/Sys.html)
- String encoding - see the [Encoding section](https://haxe.org/manual/std-String-encoding.html) of the manual for target-specifics.

### Tiers

- Tier 1: actively maintained by the core compiler team with a strong focus from the Haxe Foundation
- Tier 2: mostly maintained by individuals, but still managed by the Haxe Foundation
- Tier 3: kept up-to-date, but not much active development
