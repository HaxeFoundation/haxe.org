title: Nicolas about Haxe #1 - The Compilation Server
author: fiene
description: In this first episode of his new weekly stream Nicolas will tell you more about the compilation server and how to use it to improve compile time and completion time.
background: nicolas_darker.png
published: true
tags: nicolas-about-haxe
---

Did you know that Nicolas has taken up a weekly stream about Haxe? Of course you did! You are following all things [#Haxe](https://twitter.com/search?q=%23haxe&src=typd) on twitter after all. The stream will take place weekly on Friday at 13:30 CET (Paris time) over at [Nicolas' Youtube Channel](https://www.youtube.com/c/NicolasCannasse/live).

The avid follower will also point out that last week's episode was actually episode two and not episode one. Unfortunately, however, the first episode was not recorded due to some technical issues and thus we decided to start over. So here it is:

<div style="text-align:center" markdown="1">
    <a href="http://www.youtube.com/watch?feature=player_embedded&v=ckdOSCqUV6U" target="_blank">
        <img src="http://img.youtube.com/vi/ckdOSCqUV6U/0.jpg" alt="Nicolas about Haxe Episode 1 The Compilation Server" />
    </a>
</div>


## Episode 1 -  The Compilation Server

###Some News

Before diving into the topic of the week, Nicolas quickly commented on the launch of the [Haxe Blog](https://haxe.org/blog/) and the release of [HaxeDevelop](http://haxedevelop.org). He also showed off the blog's other two articles, a reposting of his [update on the Haxe Foundation](https://haxe.org/blog/some-words-about-the-haxe-foundation/) and a [case study about TiVo](https://haxe.org/blog/tivo-using-haxe-to-improve-user-experience-for-millions-of-customers/) that I wrote last year. Head on over and check them out.

### How to use the Compilation Server

First off, Nicolas explained how to accurately measure compilation time using `--times`. He further commented that the Haxe compiler already has excellent compilation time and that you may not always find it necessary to improve on it further. However, even our speedy Haxe compiler can rack up some serious time compiling larger projects which is where some speed upgrades come in handy.

He then walked us through starting the compilation server from the console  and connecting to it. When connecting to the server, the compilation is run on the compilation server instead of locally. After running the first compilation, the server actually caches the information on already compiled files, classes, macros and methods. On the second compile, the server will re-use as much of the already compiled information as possible. It will only have to recompile those parts that are dependent on the things that changed. This will significantly reduce the compilation time of your project. In Nicolas' example, the compilation time was reduced by 90%.

The compilation server will cache the information based on your compilation parameters. If you change one of the parameters, you will have another "first compile". However, after the compilation is run, the server will cache the data. It will also keep the data of compilations run with other settings.

After showing what the compilation server can do for your compilation time, Nicolas    went on to demonstrate how it could also significantly improve the completion time in HaxeDevelop. Using only the compiler for completion can be pretty slow. If you change your settings and have the compilation server do the completion for you, you get almost instant completion.

The Haxe 3.3 release will contain a new fix of the compilation server for HaxeDevelop and FlashDevelop, so please go and check it out and report any issues on the [Haxe GitHub repository](https://github.com/HaxeFoundation/haxe). 

##Next Week's Episode  - Heaps

In next week's episode, Nicolas will introduce his [Game Framework Heaps](https://github.com/ncannasse/heaps). Don't forget to tune in next Friday at 13:00 CET at [Nicolas' Youtube Channel](https://www.youtube.com/c/NicolasCannasse/live).

Heaps is a high performance cross platform graphics engine which was used for for both  [Until Dark](http://untildark.net/) and [Evoland 2](http://www.evoland2.com/).

<div style="text-align:center" markdown="1">
    <a href="http://www.youtube.com/watch?feature=player_embedded&v=wQR3MHLkAUo" target="_blank">
        <img src="http://img.youtube.com/vi/wQR3MHLkAUo/0.jpg" alt="Evoland 2 Trailer" />
    </a>
</div>
