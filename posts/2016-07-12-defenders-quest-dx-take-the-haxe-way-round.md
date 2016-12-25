title: Defender's Quest DX - Take the Haxe Way Round
author: fiene
description: 
background: Defenders_Quest.jpg
published: true
tags: case-studies
disqusID: 17
---

A few years back (in 2012), before I got involved with Haxe, I came across a game called Defender's Quest on Steam. It sounded very much like something I would like so I bought it and promptly proceeded to spend a good 40 hours playing it. Twice. Then I recommended it to all my friends. About two years later, Simon mentioned to me that Lars Doucet, the developer of Defender's Quest, would actually use Haxe for the sequel and for the HD release of DQ I. By that time I had taken more interest in Haxe and its community (WWX will do that to you) and was getting more involved. Needless to say that I got very excited about a game that I loved a lot getting a sequel and said sequel getting made in Haxe. One thing followed another and at WWX 2015 Lars actually came to give a talk and we got to hang out quite a bit. Now, a year later, the HD release of DQ I is out and looks really, really nice. You should all go the check out the trailer, it is beyond hilarious. It all got DELUXIFIED!

---

<div style="text-align:center" markdown="1">
    <a href="https://www.youtube.com/watch?feature=player_embedded&v=QEarmXpMag8" target="_blank">
        <img src="https://img.youtube.com/vi/QEarmXpMag8/0.jpg" alt="Defender's Quest HD Trailer"  />
    </a>
</div>

---

Coinciding with the release, I reached out to Lars and asked him if he would like to answer some questions about the game and Haxe. Luckily, he agreed! So here they are:

---

## Do you remember how you first came across Haxe?

I actually first came across Haxe around the time it was first invented, what, 10 years ago? At the time I was using the Motion-Twin Actionscript 2.0 Compiler (MTASC) and I was awaiting a new version for Actionscript 3.0. Instead, Motion-Twin announced a whole new language called Haxe. It seemed weird to me at the time so I ignored it, only to find myself desperately seeking an alternative to Flash and Actionscript many years later. By that time there were many interesting programs and games being developed in Haxe and there was a new C++ target that seemed really useful.

The deal was sealed when I met up with [Grapefrukt](https://github.com/grapefrukt) and [Joshua Granick](https://github.com/jgranick) at GDC 2013 where they showed me what Haxe could do. I was sold pretty much on the spot and have never looked back.

---

## What was the original motivation for porting Defender's Quest to Haxe?

Moving from DQ1 to DQ2, we wanted an engine that could do high performance, full-screen HD without any compromises. Adobe AIR was really giving us problems, especially on Linux, and with Adobe signalling that they had no future plans for the technology we knew that we could very well get stuck if we didn't pivot. However, we didn't want to throw everything out the door and start from scratch in Unity, Unreal, or plain C# or C++. We were using the Flixel framework for DQ1, and were happy to see that not only was there a port called [HaxeFlixel](http://haxeflixel.com/), but that HaxeFlixel was the most vibrant and mature of all the various Flixel ports to different languages & platforms. Now HaxeFlixel is widely considered the successor to the original and might even be the most popular Haxe game framework.

Using [as3hx](https://github.com/HaxeFoundation/as3hx), we ported over the basics of the engine very quickly to Haxe, and then we just had to change our API calls from Flixel to HaxeFlixel, which were very similar. I also got some help from Tiago Ribeiro. The majority of the work going from the AS3 engine to the Haxe engine wasn't the language or API level translation - that went pretty quickly though it wasn't "magic". We spent most of the actual time just working on the new features for the engine and making sure everything could go high resolution, which is as it should be. 

>If I had started from scratch it would have taken twice as long.

I also wanted to make sure I could hit both the browser and the desktop. I'm looking forward to getting an HTML5 version of DQDX out soon and it's comforting to know I can always put out a flash version, too. I frequently use that to test because it's so fast to compile.

---

## What was the biggest challenge you had to overcome while porting?

Like I said before, the language and API changes weren't the biggest issue. The hardest challenge by far was making a new User Interface system that was resolution agnostic and flexible. The original game was totally hard coded. We didn't have any UI layout xml or anything -- just a bunch of `var btn = new Button(); btn.x = 245.6 + otherBtn.width + 10;` and other garbage like that, for the entire code base, for a game that was 90% user interface. All of these interfaces were hard coded for 800x600 and nothing else.

So right from the start I set to working on a better way of doing things which became the [flixel-ui library](https://github.com/HaxeFlixel/flixel-ui) and was eventually chosen as the official HaxeFlixel user interface system. It's not perfect and I can see so many things I would improve now that I know more, but I'm still quite proud of it and it gets the job done.

There were some other challenges - the transition from OpenFL legacy to OpenFL next and the road from HaxeFlixel 3.x to 4.0 had some bumps - but now that we're on the other side I'm very happy with the state of those two libraries.

---

## If you could travel back in time to when you started the Haxe port, what would you do differently?

I would definitely re-architect some of the messier stuff in flixel-ui and apply some sane naming conventions right from the start :). I would also have started working with the various libraries and communities sooner rather than just lurking on the sidelines. As it was, I was a bit shy and afraid I wasn't smart enough to contribute meaningfully in the early days. Later I found everyone was very welcoming and I was able to make a lot of contributions. This really helped me learn a lot about how the entire stack worked. I learned more than I ever thought I would, even though I started off knowing pretty much nothing.

In the early days, if something went wrong, I had so little confidence and I would just wait for someone to step in and tell me exactly what to do. Now, if there's a problem, I'm able to solve it myself most of the time and then share the answer with the community. Obviously, I still get stuck when I try to do very advanced things (usually trying to add new features to the lowest levels of the OpenFL and HaxeFlixel stacks). However, I know where to get help now and I can collaborate with those people and make sure the new features can get tested quickly. This could never have happened when I was just isolated on my own not talking with the community.

>Now, if there's a problem, I'm able to solve it myself most of the time and then share the answer with the community.

---

## If you had one free wish for something to be added to Haxe, what would that be?

What I would really like is the ability to create something like C/C++ Structs - classes without functions in a really compact syntax. Basically the same as using anonymous objects right now. It would also be cool if I could use those to emulate named parameters in a function but without the overhead of a dynamic object.

That and an interactive step-through debugger for all targets integrated with all the IDE's! (Though I'd settle for just a C++ step-through debugger integrated with either HaxeDevelop or VSCode)

---

## Did you use macros? :)

A little! I must confess I'm not very good at them yet but I've used them for some of my fancier abstract enums. Most recently, I was able to put one together to make my crashdumper library work better with OpenFL Next. We used a macro to detect if the crashdumper library is present, and if so, then wrap the core event pump in a try/catch block, and then only if a runtime flag is set. This way there's no overhead if crashdumper isn't being used and, if you are using it but have it switched off at runtime, the overhead is just a single if statement evaluating to false.

---

## What did you learn that is going to help you with the Defender's Quest 2 development?

Gee, I dunno, everything? :P

This whole journey has taken me from being a developer who would only use the API right in front of me (flixel at the time) to one who understands the whole stack (well, mostly). It's so much more empowering. Back with Flash, if I had a brick-wall problem where the API just wouldn't let me do it, that was it. Wait for Adobe to release a new version, I guess. Now, I have the power to fix it myself as the whole stack is open source. Even if my fix is ugly, I can at least fork everything and deploy a quick monkey patch for myself, then clean it up later for a proper pull request. As a practical example - we found a bug shortly after DQDX's release with bad unicode support in the haxe File API for windows, so Russian players couldn't save their games. I jumped on Slack and Twitter and poked the usual suspects (Hugh Sanderson, Valentin Lemiere, Patrick McCarthy, Joshua Granick) and before long we had a solution, tested it, and a pull request issued to the standard library for hxcpp. I was able to push the patch to my game the very same day.

But probably the biggest thing isn't very Haxe specific. DQ1 was a small flash game based around pixel art and locked to 800x600 resolution with hard-coded UI layouts. DQDX supports HD resolution and totally flexible UI, with hi-res HD sprites, and you can crank it up to x16 speed (the original only went to 4x). You find a lot of performance glitches when you scale up like that, and you're forced to learn how your program is actually working. So my debugging and profiling skills have gotten a lot better, aided by excellent tools like Jeff Ward's [HxScout](http://hxscout.com/) and James Gray's [HxCPPObjectGraphViewer](https://github.com/james4k/hxcppObjectGraphViewer). I was kind of embarrassed by some of the performance bottlenecks I found (most of them came from old code carried over from the flash days) but I instantly knew how to fix them. 

>Back when I first started, if I had looked at the same, I would not have known there was anything wrong with it.

---

## Wrapping Up

Thanks a lot for taking the time, Lars. It has been an absolute pleasure as always.

To all you readers: If you have an interesting project and would like to see it featured on the Haxe Blog, don't hesitate to contact me at the Haxe Foundation.

Cheers,

Fiene

P.S. Watch Lars' Blog and the Defender's Quest II Website for updates and interesting stuff.

https://www.fortressofdoors.com/

https://www.defendersquest.com/2/
