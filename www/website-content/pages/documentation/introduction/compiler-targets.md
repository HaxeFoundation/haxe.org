Compiler Targets
=======

The following table gives an overview of available Haxe targets:


Name | Kind | Static typing | Sys | Use Cases | Since
--- | --- | --- | --- | --- | ---
Flash | byte code | Yes | No | Games, Mobile | alpha (2005)
Neko | byte code | No | Yes | Web, CLI | alpha (2005)
JavaScript | source | No | Yes | Web, Desktop, API, CLI | beta (2006)
ActionScript 3 | source | Yes | No | Games, Mobile, API | 1.12 (2007)
PHP | source | No | Yes | Web | 2.0 (2008)
C++ | source | Yes | Yes | Games, CLI, Mobile, Desktop | 2.04 (2009)
Java | source | Yes | Yes | CLI, Mobile, Desktop | 2.10 (2012)
C# | source | Yes | Yes | Mobile, Desktop | 2.10 (2012)
Python | source | No | Yes | CLI, Web, Desktop | 3.2 (2015)
Lua | source | No | Yes | Games, CLI, Web, Desktop | 3.3 (2016)

> **Note:**
> 
> - "Static typing: Yes" means the target platform natively supports static typing. Haxe code itself is statically typed no matter what target it is compiled to.
> - "Sys: Yes" means the target supports the [System api](http://api.haxe.org/Sys.html).
> - "Javascript Sys: Yes" via [hxnodejs](https://github.com/HaxeFoundation/hxnodejs).
