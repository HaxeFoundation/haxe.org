title: Shiro Games Technology Stack
author: nicolas
description: A complete introduction to the technology stack used to make games at Shiro
background: haxe-tips.jpg
published: true
tags: tech
disqusID: 48
---

# Shiro Games Stack

Our game engine Heaps.io and the underlying technology and toolset are born from twenty years spent creating games, before at [Motion-Twin](https://motion-twin.com) (the makers of Dead Cells) and since 2012 at [Shiro Games](https://shirogames.com) (Evoland, Northgard, Darksburg).

All of these games - 2D and 3D - have been made using a complete stack of libraries and tools that have been open source from the start, and are still evolving and being maintained.

Since I often get asked about how we are making games, I thought it would be nice to share details on all the elements of Shiro's technology stack. It works great for us, so maybe it could be useful for some other companies out there.

![image](https://user-images.githubusercontent.com/1022912/78460040-d1dc6580-76bd-11ea-88fb-b05342ded727.png)

**Haxe/Heaps Community**

In case you have any question or want to discuss parts of what I'm presenting here, you can get in touch with the Haxe/Heaps Community:
- Using [Discord](https://discord.gg/sWCGm33) **#heaps** channel
- With the [Haxe Forum](https://community.haxe.org/) for Haxe language questions
- With the [Heaps Forum](https://community.heaps.io/) for Heaps specific questions

![image](https://user-images.githubusercontent.com/1022912/78455515-258b8680-769f-11ea-8a3c-ae4f16fe3a72.png)

## Native Layer

The native layer is mostly written in C with bits of C++. For daily games development we rarely have to deal with it, since we are working instead with a high level languages where hard crashes (mostly) can't happen without having a nice error message.

Performance is critical to us because - while we don't do AAA kind of games - we still want to get great graphics and immersive 60 FPS gameplay, without having to spend our coder's precious time on micro optimizations because of the low level engine limits.

**HashLink VM**

The core component of this strategy is the [HashLink Virtual Machine](https://hashlink.haxe.org), which is a fast strictly typed VM for Haxe programming language. Think about it like JavaVM or Mono (used by Unity), but more oriented towards real time games.
 
The game gets compiled to a cross platform `.hl` file that can be run with HashlinkVM JIT. It can also be compiled to C directly and compiled using any native compiler, which we are using for our console ports on PlayStation, XBox and Nintendo Switch.

Hashlink VM performs very well for classic Object Oriented programming, but also for functional programming style. It's good too at floating point calculus which is important for games, and has been designed so that memory overhead is only minimal for the garbage collector. For instance our 3D game Northgard requires less than 500 MB of memory to run.

Because of the nature of the VM, it means that unless you compile your code to C, your game doesn't have Debug/Release builds like in C++. You can of course have compilation options to have a Development/Release version, but you will always run at full speed, exactly just like the game will be on players computers, and you also get precise call stack traces.

**Native libraries**

While HashLink alone does come with only a small standard library, it can be extended with additional libraries (written in C) to expose new APIs. This requires a bit of knowledge of the VM and to deal with the Garbage Collector, but it's quite a smooth process and if done right allows us to isolate bugs that might come from the low level layer from bugs in application logic.

So far we have native libraries that gets distributed with HashLink such as SDL2, DirectX11, OpenAL(sound), LibUV(sockets), SSL(encryption), and FMT which deals with Zip, Ogg, Png, Jpg and a few other low level file format libraries.

All of these are open source and part of the HashLink repository [here](https://github.com/HaxeFoundation/hashlink)

We also have additional platform API libraries for [Steam](https://github.com/HeapsIO/hlsteam), as well as consoles integration libraries that are only accessible if you have a registered developer.

So main point is that you can easily extend the VM with your own native libraries if you require any, making sure that you are never locked by waiting for support for a particular native feature.

**Native Tools**

Because of the VM nature, it's always necessary to have a good set of low level tools to be able to analyze performances. We have several of these for HashLink VM:

* Hashlink VM has a very efficient native [Debugger](https://github.com/vshaxe/hashlink-debugger) for best day-to-day coding experience, directly integrated into Visual Studio Code.
* for CPU performance, we have recently developed a [Hashlink CPU Profiler](https://github.com/HaxeFoundation/hashlink/wiki/Profiler) that can be used to get insights about where the CPU time is spent in your program. The profiler is non-intrusive so you will be able to profile your game without slowing it down.
* for Memory performance and leaks, you can either measure all allocations performed or dump the current whole process memory for later analysis using the [Memory Profile API](https://api.haxe.org/hl/Profile.html) - _still undocumented, I'll write later about this_
* for graphics performances, we are using the GPU vendor tools such as [NVidia NSight](https://developer.nvidia.com/nsight-visual-studio-edition).

![image](https://user-images.githubusercontent.com/1022912/78455515-258b8680-769f-11ea-8a3c-ae4f16fe3a72.png)

## Programming Language Layer

Now that we have dealt with the native layer (in green), we're moving up the technology stack to the programming language layer.

For all games code and tools development we are using [Haxe](https://haxe.org) programming language. Haxe offers the best mix of strictly typed object oriented, with bits of functional programming, and super-powerful [macro system](https://haxe.org/manual/macro.html) which is used extensively by several of the high level libraries we will present.

Of course as the main designer of Haxe language I'm a bit biased, but it's important to know that every developer at Shiro really enjoy developing with Haxe on a daily basis, and it's a critical tool for our daily productivity. Also, we have recruited developers with various programming backgrounds (C++, C#, Javascript, Python, Java, etc.) and they all have been able to quickly adapt to Haxe and write efficient code.

Haxe is a cross platform programming language, which can output code for many different targets. We are using mostly two targets at Shiro:
- the Hashlink target for our games
- the JavaScript target for our tools _(more on that as part of the tools section below)_

Some popular independent games were also made using Haxe (but not the HashLink or the whole tech stack I'm presenting here), such as: **Papers Please**, **Brawlhalla**, **Dicey Dungeons**, etc.

Haxe is maintained as an independent open source project, thanks to the [Haxe Foundation](https://haxe.org/foundation/), which gets funding by several big companies which are using Haxe for developing various cross platform applications, games but not only.

You can learn more about Haxe on it's [website](https://haxe.org)

![image](https://user-images.githubusercontent.com/1022912/78455515-258b8680-769f-11ea-8a3c-ae4f16fe3a72.png)

## Game Engine : Heaps.io

![image](https://heaps.io/img/h3d/pbr_1.jpg)

[Heaps.io](https://heaps.io) is the game engine that powers our games at Shiro. It covers the following:
- 2D rendering
- 3D rendering
- Sound handling
- Controls (keyboard, mouse, gamepad)
- Resource management 

It's been built to separate the low level platform implementation features from the mid level graphics logics/data. This architecture allows us to integrate new renderers or platforms by just porting a few classes given that the native libraries are been made available in HashLink. Heaps.io supports the following plaforms/renderer:
- HashLink with DirectX11
- HashLink with OpenGL/SDL2
- HashLink/C with NVN (Nintendo Switch SDK native graphics api)
- HashLink/C with GNM (PS4 SDK native graphics api)
- HashLink/C for XBoxOne SDK
- Javascript with WebGL2
*HashLink/C here means that we can only use the Hashlink C output, not the JIT VM

Heaps.io has been designed to be very lightweight and highly customizable. It provides a 2D/3D scene graph and each Object in the scene can be extended to enrich the behavior. The renderer and lighting system can also be entirely replaced, allowing to write a very game-specific rendering pipeline.

Both 2D and 3D are entirely GPU accelerated, and based on GPU shaders. Heaps comes with its own integrated shader language [HxSL](https://heaps.io/documentation/hxsl.html). HxSL is very powerful as instead of writing a single big shader, you will write little individual shader effects that gets assembled and optimized together at runtime.

Heaps.io also abstracts [Resources Management](https://heaps.io/documentation/resource-management.html) and [Baking](https://heaps.io/documentation/resource-baking.html) that allows to deal with all the packaging of raw resources coming from Photoshop, Maya, Blender, etc.

You can learn more about Heaps.io using dedicated website, or browsing its [Documentation](https://heaps.io/documentation/home.html).

![image](https://user-images.githubusercontent.com/1022912/78455515-258b8680-769f-11ea-8a3c-ae4f16fe3a72.png)

# HIDE Editor

![image](https://user-images.githubusercontent.com/1022912/78458863-e5cf9980-76b4-11ea-8663-ea38fa8f7f48.png)

[HIDE](https://github.com/HeapsIO/hide) (Heaps IDE) is a standalone application that allows to create viewers and editors for 2D/3D content.

HIDE is an HTML5 application running Heaps.io engine in WebGL2 mode, so you can very quickly develop user interface using Haxe and HTML/CSS.

At the moment HIDE supports:
- Resources tree explorer
- 2D texture viewer 
- 3D FBX model viewer and material editor
- 2D and 3D timeline-based effects editor
- 2D and 3D particles editor
- 3D level editor (screenshot above showing a Darksburg level)
- Prefabs editor
- Scripting editor (using hscript)
- Shader graph nodal editor [wip]

HIDE is data-oriented, based on a Prefab model (`hrt.prefab.Prefab` class) that holds the editor data and can create instances of the given effect/level/etc. on demand, but also allows the data to be inspected/consumed by game engine in order to do pretty much what you want with it.

The Prefab model being extensible, and HIDE having the ability to loading plugins, you can create your own custom components and editor into HIDE for your game.

[HIDE source code](https://github.com/HeapsIO/hide) separates between the package `hide` that contains IDE code and the `hrt` package that contains classes that can be used as part of the game runtime.

At the moment HIDE usage is sadly not much documented, this is something I want to work at some point.

![image](https://user-images.githubusercontent.com/1022912/78455515-258b8680-769f-11ea-8a3c-ae4f16fe3a72.png)

# DomKit UI Toolkit

![image](https://user-images.githubusercontent.com/1022912/78458574-af911a80-76b2-11ea-80cf-8196c4a73f53.png)

[DomKit](https://heaps.io/documentation/domkit.html) is our framework for writing User Interface components. It's our most recent addition to the technology stack so is still evolving.

It allows you to declare your UI in terms of XHTML directly in your code, which allows direct strictly typed data binding with your gameplay logic, then enables styling using CSS just like web development. 

The semantics of the CSS partly follows HTML5 standard but the layout model is specific to Heaps.io, and is more suitable for games UI/UX.

You can also declare your own components and even add extra properties and code that tells how the CSS values should be evaluated to map to your properties data.

Additionally, DomKit library itself is fully standalone so can be used for any UI framework, although Heaps.io benefits from a direct integration.

You can read more about DomKit using the [documentation](https://heaps.io/documentation/domkit.html). 

![image](https://user-images.githubusercontent.com/1022912/78455515-258b8680-769f-11ea-8a3c-ae4f16fe3a72.png)

# Castle DB

![image](https://user-images.githubusercontent.com/1022912/78459235-e3227380-76b7-11ea-88f8-07713a4f9d96.png)

Castle DB is one of the most important productivity tools we are using at Shiro. It's static structured database aimed at game designers in order to input all the gameplay data the game will consume, such as lists of items, places, npcs, tech trees, skills, etc.

Using the Castle DB IDE, you can create and modify at will the different data structures, and then input the data very easily. Think about it like a very powerful game dedicated spreadsheet editor.

Also, using Haxe macros, you can directly get into your Haxe code with a single file all the data structures that were declared in your CDB file, as well as enums for all unique identifiers for the different types of items/levels/etc. that are part of your database.

```haxe
// Data.hx
private typedef Init = haxe.macro.MacroType<[cdb.Module.build("data.cdb")]>;
```

The CDB structure and data are stored as a single multi line JSON text file allowing for multi user collaboration using code control systems (merge/diff/conflicts resolution etc.)

Castle DB used to be a standalone editor (you can download an old version of it on the [dedicated website](http://castledb.org/)) but has now been integrated into HIDE, which allows us to use CDB data input for some of the prefabs into level editors, etc.

You can read more about Castle DB on its [castledb.org](http://castledb.org/)

![image](https://user-images.githubusercontent.com/1022912/78455515-258b8680-769f-11ea-8a3c-ae4f16fe3a72.png)

# HScript

![image](https://user-images.githubusercontent.com/1022912/78459612-7eb4e380-76ba-11ea-820b-32ce1ecad0e0.png)

[HScript](https://github.com/haxeFoundation/hscript) is a small script parser and interpreter based on Haxe syntax. It's always useful to have some parts of the code that can scripted by game designers.

One of the nices things about HScript is that you can change the script between parsing and running it, allowing to make some tweaks to match your needs. For example the [Async](https://github.com/HaxeFoundation/hscript/blob/master/hscript/Async.hx) class transforms the script into asynchronous code (continuation passing style).

More recently, I have added the ability to type-check the scripts in a similar way the Haxe Compiler is doing. This allows HIDE HScript integration to be able to edit scripts with code completion and live type checking, ensuring less errors and more productivity by game designers, see [notes here](https://github.com/HeapsIO/hide/wiki/HScript-Notes)

HScript is also integrated within CDB/Hide, so one can have per-item scripts etc.

Full [sources](https://github.com/haxeFoundation/hscript) are available, and you can install the library with `haxelib install hscript`

![image](https://user-images.githubusercontent.com/1022912/78455515-258b8680-769f-11ea-8a3c-ae4f16fe3a72.png)

# HxBit

[HxBit](https://github.com/HeapsIO/hxbit) is a serialization and network synchronization library.
It allows you to tag your classes properties that needs to be serialized (for saves) and/or transmitted over network when changed (for multiplayer games).

A complete documentation is available [here](https://github.com/HeapsIO/hxbit)

**MPMan**

MPMan is built on top of HxBit for the network part, and contains additional utility classes.
It's the only closed source library as part of the framework, as it contains some confidential information regarding our multiplayer infrastructure.

It covers the following:
- player authentication across platforms
- multiplayer lobby system, rankings, game server instances query
- platform multiplayer invitations
- achievements
- DLCs detection and shop popups
- storage (cross platform user saves handling)

# Final Words

That's about it (for now). I hope this gave a better understanding on how we make games at Shiro, and hopefully you would be interested in trying out some - if not all - of the tools presented here.

I wrote and maintain much of these myself, with help from other Shiro developers and community contributions, in particular for HIDE and Heaps, thanks to them! I think it's important to have good tools to do great work, and each tool presented here has been proven useful over several projects. I'm quite satisfied with what we came up over the years so I thought it was about time to show the whole picture.

I also believe in collaboration, and making things open source helps even if no contribution is made back because it forces me to deal with important questions, such as writing a minimum of documentation or making things as smooth as possible. 

All of this technology stack has been used in real projects and are still used for developing ongoing yet-unannounced games at Shiro. They are quite stable with no big issues, but of course you might eventually find bugs for your particular usage. Since I deal with many different projects I might sometimes be slow to answer over Pull Requests or Issues reported, but you always have the whole sources to improves things when you need it. One of things I personally dislike the most is when there's a bug and I have no way to understand/fix it.

Enjoy and don't forget that while good tools help making good games, they are not the games themselves. 
