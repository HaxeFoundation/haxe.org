title: Bugfix Adventures #2 - How to forge signatures using a compiler
author: simn
description: What you display is what you get, but sometimes it shouldn't be.
published: true
tags: tech
disqusID: 21
---

These past weeks and months, I've been working a lot on improving the Haxe compiler's IDE support. It all started with Dan's exploration into the world of [Visual Studio Code extensions](https://github.com/vshaxe/vshaxe) back in April. We quickly realized that Microsoft did a really good job on the design of that, and initial experiments were very promising. By now, it is one of the most feature-rich Haxe IDEs out there, despite the original author starting it as a mere experiment:

> TBH I had no idea this little experiment will gain so much traction...

The development of the extension from a small idea to a respectable application is very similar to that of the Haxe compiler itself. What was just a window with syntax-highlighting a few months ago is now a usable IDE with features such as document/workspace-symbols and code diagnostics. The extension is designed as a language server: VS Code itself sends requests to the language server and processes the replies. This allows, in theory, other IDEs to utilize the Haxe language server by connecting to it in a similar fashion and using the [protocol](https://github.com/Microsoft/language-server-protocol). In turn, the language server sends requests to a Haxe compilation server instance. A Haxe compilation server is, in essence, still what Nicolas originally [implemented in Haxe 2.09](https://haxe.org/manual/cr-completion-server.html) many years ago.

### Compilation vs. completion

It became apparant that Haxe was still lacking in some areas and that some work was required. A problem with compiler-based IDE support is getting the performance right. A compiler should be fast anyway, to be sure, but when it comes to normal compilation the annoyance threshold is much higher. So what if it takes a second longer sometimes, right? It's even a [traditional joke](https://xkcd.com/303/) among programmers that compiling takes quite long in the first place. However, we don't want to wait that extra second before we get completion support while coding, as that would feel very unresponsive.

Fortunately for us, the Haxe compiler has always been a fast compiler. Over the course of the years, however, the ever increasing number of language and compiler features has made it challenging to keep this high performance standard. In real projects that utilize features such as macros, using the Haxe compilation server might become outright necessary in order to have responsive display results. Unfortunately, the compilation server has been known to have some issues, to the point where Haxe developers joked about it "only working for Nicolas".

A few days ago I finally decided to sit down and figure out what's wrong with it (and, for that matter, how the dreaded thing actually works to begin with). The [first issue](https://github.com/HaxeFoundation/haxe/issues/5676) took me several hours to reduce, understand and address. It had to do with the (mutable) state of an obsolete context sticking around and being used in a callback, which would make a good horror story at the functional programming boyscouts campfire. All in all, I would rather forget about some callback not forgetting about some context it should forget about, so let's instead look at something more fun.

### Of signatures and caches

Today's issue has to do with caches. In general, we cache something so we don't have to calculate it again. It's the classic tradeoff: We sacrifice some memory in order to save some processing time. For instance, the Haxe compilation server has a cache for parsed files. It's simple in theory: If we already parsed a given file during compilation 1, we don't have to do it again during compilation 2 unless the file changed, or unless something that could influence the parsing of the file changed. This is usually straightforward:

* A file changed if its modification time on the disk is newer than the time we have seen it last.
* The parsing of a file can be influenced by a different environment, such as an additional or missing `-D` flag and the use of [conditional compilation](https://haxe.org/manual/lf-condition-compilation.html).

We want to use the same Haxe compilation server for multiple environments, for instance to compile to JavaScript and C++. To that end, we work with a *signature*, which is basically just some hash of all `-D` flags mashed together to a string. We can observe this by starting a Haxe compilation server:

```
>haxe -v --wait 6000
```

And then we connect to it in another terminal:

```
>haxe --connect 6000 -js js.js DoesNotMatter
>haxe --connect 6000 -cpp cpp DoesNotMatter
```

The server prints something like this, among other output:

```
Using signature 17cd26d71ab2e75262f3d221fa295b20
Using signature 41c51aafcdb48f5c93a9d3db7f4e704a
```

We can consider the first one to be "the JavaScript" context, with the second one being "the C++ context". Furthermore, we can observe that adding additional `-D` flags changes the signature (for brevity, I'll merge the command line input and relevant server print from now on):

```
>haxe --connect 6000 -js js.js DoesNotMatter -D some-define
Using signature c0bd35fcafc572da20b93ca701139d09
>haxe --connect 6000 -js js.js DoesNotMatter -D some-define -D some-other-define
Using signature 68a250216164117c8abb2414f53918ca
```

Each of these signatures can be considered to represent a distinct context with a distinct cache. This is convenient because it means we don't have to worry about defines at all: If some define changes we'll get a different signature, and thus a different cache.

### Compilation vs. completion revisited

Of course, there's an exception to this rule. In order to understand this, we need a little insight as to how Haxe display modes work. As initially mentioned, compiler-based IDE services have to be very fast to be usable. This is why the compiler tries to do as little typing-work as possible when a display request is made (note that parsing on the other hand is performed and cached normally). Ideally, it deals with the file provided in the `--display` argument and nothing else. Even if it has to look at other files, it tries to avoid looking at the gory details (that is, fields) of the types defined there. And even in the display file itself, it only really cares about about the field in question. And even within that field, it only (mostly) cares about the expression we're interested in.

So, what can we do with compilation state that knows barely any modules, of which it knows barely any types, of which it knows barely any fields, of which it knows barely any expressions? For starters, we sure as hell cannot cache any types! Remembering that utter mess as the official state of the file would be disastrous and subsequent compilations would rightfully complain; a lot. So we can rule out writing to the cache, but what about reading it? Surprisingly (or not so surprisingly, else the cache would be pointless), this is no problem at all, assuming the cache was written from a sane, normal compilation.

This leads to a natural 2-step process of working with the compilation server:

1. Compile your project normally in order to fill the cache.
2. Make `--display` requests which now can utilize the cache.

However, there is a small detail here: Using `--display` automatically defines `-D display`. And that should change the context signature, thus using a different cache, right?

### Wrong

The reasoning is sound, so let's just quickly show that it doesn't apply regardless:

```
>haxe --connect 6000 -js js.js DoesNotMatter
Defines dce=std,haxe3=1,haxe_ver=3.3,true=1
Using signature 17cd26d71ab2e75262f3d221fa295b20
>haxe --connect 6000 -js js.js DoesNotMatter --display Main.hx@0
Defines dce=std,display=1,haxe3=1,haxe_ver=3.3,true=1
Using signature 17cd26d71ab2e75262f3d221fa295b20
```

Despite the defines being different, the signature is the same. This is because `-D display` is one of the few defines that do not influence the context signature. The reason for that is what we described in the last section: We want a `--display` request to utilize the cached information that comes from a normal build. This requires them to use the same cache, which requires them to have the same signature.

### From the depths of OpenFL

The actual issue was reported to me by [Gama11](https://github.com/Gama11), an awesome Haxe user who has contributed to every other Haxe repository in existence. He was trying to compile some [HaxeFlixel](http://haxeflixel.com/) application to Flash through the compilation server. It crashed and burned with `VerifyError: Error #1014: Class openfl.display::Sprite could not be found`. My initial reaction to errors that mention framework files is to blame the framework and head off for lunch. Sadly, it was past lunch time, so I actually had to deal with it.

What was immediately strange about this error was that `Sprite` is [typedef](https://haxe.org/manual/type-system-typedef.html), [defined here](https://github.com/openfl/openfl/blob/3.6.1/extern/openfl/display/Sprite.hx#L148) as:

```haxe
typedef Sprite = flash.display.Sprite;
```

Why would the _run-time_ complain about a typedef, which is supposed to be resolved at compile-time? At first, I thought there were some `--remap` shenanigans going on, but that investigation lead nowhere. Ultimately, we realized something:

```
<simn> Try the following: 1. Set -D dump=pretty 2. Compile 3. Delete dump directory 4. Compile again
<simn> And see if/what openfl.display.Sprite is in the dump file.
<gama11> on first compile, there's a `openfl.display.Sprite` with `typedef openfl.display.Sprite = flash.display.Sprite`
<gama11> what the hell..
<gama11> openfl.display.Sprite.dump looks completely different after the compile that causes the error
```

Indeed, the new dump file showed that `Sprite` now suddenly was a _class_ instead of a typedef. Specifically, it was clearly the class [defined here](https://github.com/openfl/openfl/blob/3.6.1/extern/openfl/display/Sprite.hx#L22). But wait, that's within a section guarded by `#if (display || !flash)`, which shouldn't hold when compiling to Flash. Unless `display` is true, but that shouldn't be the case unless... oh!

### Revelation

At that point it all came together. There's one missing piece to the puzzle, which is the diagnostics check that vshaxe makes. When you open a file, vshaxe sends a `--display ThatFile.hx@0@diagnostics` request to the Haxe server in order to get some information about it. So here is what happened:

1. We open our HaxeFlixel project's Main.hx which happens to `extend openfl.display.Sprite`.
2. Vshaxe, in its eagerness to be useful, sends a diagnostics `--display Main.hx@0@diagnostics` request to the Haxe compilation server.
3. The Haxe compilation server parses Main.hx and starts typing it, comes across `extends Sprite` and parses `openfl.display.Sprite`.
4. Since we're in display mode, the file is parsed as its class-version.
5. It is parser-cached, *using the non-display signature* because these are identical.
6. A normal compilation is invoked.
7. Haxe grabs the parsed `openfl.display.Sprite` from the cache and proceeds.
8. But it is now an extern class, not the typedef that it should be.
9. Boom

The solution was to never parser-cache any file that has `display` in its conditional compilation. As usual, [it was a small change](https://github.com/HaxeFoundation/haxe/commit/70c209238d40f0b6a3c429fbef8ba404260b972a) that was preceded by a lenghty investigation. On the bright side, the original project actually works with the compilation server again and the future is looking bright!
