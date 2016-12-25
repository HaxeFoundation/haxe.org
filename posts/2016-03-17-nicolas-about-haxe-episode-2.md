title: Nicolas about Haxe #2 - Heaps
author: markknol
description: I this week's stream, Nicolas introduced his 2D/3D game framework Heaps, a platform agnostic game engine built with Haxe. 
background: nicolas_darker.png
published: true
tags: nicolas-about-haxe
disqusID: 8
---

This week, Nicolas showed us one of the technologies he uses when developing those pretty games of his - Heaps! 

If you missed the stream you can watch the recording here:

<div style="text-align:center" markdown="1">
    <a href="https://www.youtube.com/watch?feature=player_embedded&v=-WeGME_T9Ew" target="_blank">
        <img src="https://img.youtube.com/vi/-WeGME_T9Ew/0.jpg" alt="Nicolas about Haxe Episode 2 Heaps" />
    </a>
</div>

Nicolas will continue his weekly stream every Friday at 1:30 pm CET over at his [YouTube channel](https://www.youtube.com/user/MTwarp), where you can also watch recordings of the prior episodes.

##Episode 2 - Heaps

###A Short Introduction

Heaps is a cross platform game engine which can be used to create 2D and 3D games. If you want to check it out, head over to the [GitHub repository](https://github.com/ncannasse/heaps) and have a look around. It has different components:

* h2d - facilitates 2D display
* h3d - facilitates 3D display
* hxd - takes care of cross platform events, formats and resources
* hsxl - contains the high level 3D shader language for Haxe that is used with Heaps

The GitHub repository also contains several samples that you can run and try things out with.

The special thing about Heaps is that it is designed for the creation of 2D and 3D games that are optimized by the GPU. As such, it offers a little less control than other game frameworks but gives you full access to GPU optimization and acceleration.

Heaps is written almost entirely in Haxe. The exception to this are the platform specific classes like graphics drivers, abstract classes for platform specific events and controls. This makes Heaps very portable and eases the addition of more targets, since a biggest part of the engine is platform-agnostic.

Currently Heaps supports three targets:

* Flash with Stage3D
* JavaScript with WebGL
* hxcpp with SDL (experimental)

In the stream, Nicolas mentioned that the JavaScript target did only work if OpenGL was supported. It does not have a fallback option using Canvas. Also, the hxcpp target is still experimental and there are some issues, especially with sound support.

In addition to this, some developers at [Motion Twin](https://motion-twin.com/en/), the company Nicolas used to work with, also use Heaps and have added support for [Lime](https://github.com/openfl/lime), a low level framework for [OpenFL](http://www.openfl.org/). He mentioned that using Lime, it may even be possible to run OpenFL content in Heaps or at least use a mix of Heaps and OpenFL.

In the future, Nicolas is hoping to add DirectX and console support targeting the Playstation 4 since [Shiro Games](http://shirogames.com/) is also working to bring its latest game, [Evoland 2](http://www.evoland2.com/) (made with Heaps, of course), to the console.

###The Samples

After introducing Heaps, Nicolas walked us through a few samples showing how to make some cubes, skin texture, a 2D rendering and use shaders.

Here are some screenshots:

How to make the cubes:
![heaps 1.png](heaps_1.png)

![heaps 2.png](heaps_2.png)

What they looked like:
![heaps 4.png](heaps_4.png)

The skin texture:
![heaps 5.png](heaps_5.png)

Rendering something in 2D:
![heaps 6.png](heaps_6.png)

Shaders:
![heaps 3.png](heaps_3.png)

During one of the examples, he explained different ways to initialize resources and how to enable live updating. When live updating is enabled, changes made to the resources will be displayed in the live project.

While he was talking about how to create and use shaders, Nicolas also mentioned that Heaps combines all the shaders used and compiles them into one shader. The shader is then shared between instances and only has to be re-compiled when it is changed. 

All in all, we saw quite a few examples of Heaps in action and got a lot of details about how it works and why it is so efficient.

###Next Week's Episode

Next week, Nicolas will talk about Macros. They are one of the most advanced features Haxe has to offer but can be intimidating at first. If you have not used them before, this is your chance to learn!

The stream will be live on Friday, 18th March at 1:30 pm CET. Be sure to tune in!
