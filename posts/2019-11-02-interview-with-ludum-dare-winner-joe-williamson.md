title: Interview with Ludum Dare 45 winner Joe Williamson
author: simn
description: We asked Joe how to become a Ludum Dare winner. Read this to find out!
background: joe-williamson.png
published: true
disqusID: 46
---


# Interview with Ludum Dare 45 winner Joe Williamson

Three times a year, game developers across the world lock themselves into their rooms, basements, offices or sheds in order to participate in the [Ludum Dare](https://ldjam.com/) game jam. They get a theme and 48 hours, and then proceed to develop a game under these constraints. Many don't make it, many more end up creating something which can best be described (usually by their own admission) as mediocre. But there are always a few gems, and being crowned the Ludum Dare winner after creating one of those is a prestigious honor.

I had the opportunity to talk to [Joe Williamson](https://twitter.com/joecreates), a long-time Haxe user and the winner of Ludum Dare 45, about himself, his game [World Collector](https://ldjam.com/events/ludum-dare/45/world-collector) and, of course, Haxe.


## About Joe

**Hey Joe, thank you for doing this interview and congratulations on your Ludum Dare success! I read your [tweet](https://twitter.com/JoeCreates/status/1189298363268845569) about the many unfinished attempts in the past, so this must feel great.**

Thank you! I'd been finishing Ludum Dare consistently up until a few years ago, but for various reasons I hit a run of misses. A couple of times I had just been too ambitious with very technically challenging ideas. Other times I hit a run of blocking bugs which took the entire jam to resolve. In one case my laptop keyboard stopped working mid-jam. I'm really over the moon just to have finally finished one again!

**Tell us a bit about yourself and how you found out about Haxe originally.**

I'm a game developer from Bristol, UK, mainly doing freelance pixel art, occasionally programming and audio, alongside working on my own projects. Over the last couple of years I've done a lot of work for Kongregate and most recently I'm doing art for the cyberpunk JRPG, Jack Move.

During my Computer Science degree I took part in a few game jams, including one with my good friend Sam Twidale using FlashPunk. Sam raised my attention to Haxe as a good option for getting up and running quickly in future jams, with the option to migrate existing AS3 projects, while also being cross platform for larger projects. We later collaborated on [Werewolf Tycoon](https://joecreates.co.uk/werewolftycoon/), which seemed to benefit greatly from a simultaneous release on mobile and web, as the web release made it very accessible to Youtubers.

I'm also a close-up magician, which is something I did part-time through university and continue to do as a hobby. I especially love to create my own effects and routines.

**It is often said that a good developer is a bad artist, but in your case that's clearly not true. What motivated you to become proficient in both crafts?**

I was trying to make games in my early teens and I didn't have anyone else to do assets, so I had to learn to do it myself. But generally I love to create and share things with other people. I also want to make the most of the fact that we have unprecedented access to resources for learning new skills thanks to the internet.

**I see that you also enjoy making music. Did you learn to play any instruments?**

I play guitar and a little keyboard for MIDI input. As with art, a significant motivation to study music was so that I could make games with it, but is also something I came to love in its own right. Music has such a close connection to our emotions, and is something I often prioritise when making a game--even in jams--as doing it early helps to define the tone of the game.

**When I was younger, I looked up to various video game composers. Is there anyone that inspired you in that area?**

Nobuo Umatsu comes to mind, not only for his emotive and diverse style, but because he is an exemplar of how one can truly excel at something while being self-taught. In film, I'm a great fan of the work of John Debney and Danny Elfman. I am also inspired by Romantic era composers such as Holst, Saint-Saëns and Rimsky Korsakov, for their mastery of story and emotion.


## About World Collector

![World Collector](full.png)

**Let's turn out attention to your Ludum Dare entry World Collector now. I just played through it and really enjoy the concept. What gave you the idea for this game?**

Whenever I have a game, story, visual or any kind of "cool thing" idea, regardless of how flawed it might be, I'll put it in a notebook. If it's a music idea, I'll hum it into a voice recorder. I have hundreds of game mechanic ideas in these notebooks of varying degrees of completeness and broken-ness. Sometimes I might realise some of these ideas work together well, or that I can apply one to a current project. For game jams, I'll typically have a handful of ideas already written down which might work for a theme, and the theme can help me view them in a new light. World Collector is based on one of these ideas which jumped out at me when I was considering a game which starts with no world.

**After Evoland won Ludum Dare 24, it was expanded into a full game with much more content. Do you have similar aspirations for World Collector?**

Yes! I'm very excited to continue developing this, and am scheduling time to do so. I'm especially excited to explore the implications of restricting all game progress to being achieved by collecting and using worlds, rather than simply adding player abilities or increasing stats. This includes avoiding any kind of "stage 1, stage 2" partitioning of levels. I would like the black space into which a player first arrives to be persistent through the full experience of playing the game, and allow for a long non-linear exploration of a diverse space of different worlds.

I have many ideas already, including some which I had to cut from the jam version of the game due to time constraints. These include power lines, mechanical features between worlds such as gears, gates which restrict access to worlds and paradigms shifts such as worlds of different tessellating shapes or perspectives. I'll also have to solve some pretty big challenges, such as figuring out how to make it feel natural to select from a much larger pool of worlds, especially using a gamepad.

I'm planning to continue to stream all development of World Collector on [Twitch](http://twitch.tv/JoeCreates) with an accompanying devlog on [YouTube](http://youtube.com/JoeCreates).

**Were there any specific challenges you had to overcome given the 48 hour time constraint?**

At first I had to figure out if there was actually a viable game in the idea. I had concerns that players might get stuck in a dead end with no way out, or that finding paths would be too easy. I sketched out some rough worlds in a tilemap editor so that I could experiment with moving worlds around, after which I was confident that I could at least make something a little more interesting than a static maze.

I spent a lot of time figuring out the feel. One decision I had to make in this regard was world size with respect to the character. Too small, and I wouldn't have enough room for meaningful variation. Too big, and it would become difficult to see how worlds interrelate, as well as removing emphasis from the connections they make.

Finally, implementing the main mechanics, art and sound took up most of the jam, leaving me with about an hour to actually do the level design. In that rush I ended up having to make some compromises and quick fixes to ensure the game was actually possible to complete, such as including the "crossroads" world. In hindsight I think that decision worked really well for the size of the game as it feels like a reward and still requires players to think a little differently to previous challenges.


## About Haxe

**You used the [HaxeFlixel](https://haxeflixel.com/) framework for this game. Are you familiar with any other Haxe frameworks such as [heaps](https://heaps.io/)?**

I gave heaps a try a while back. There was a lot I really liked about it, but some features were very volatile such as the 2D camera implementation, and it wasn't so easy to do mobile releases compared to [OpenFL](https://www.openfl.org/). For at least a couple of projects I'll be continuing to use HaxeFlixel, but I'm looking forward to trying heaps again in the future.

**Haxe games tend to do quite well in game jams. What do you think makes Haxe a good choice for these?**

Frameworks such as HaxeFlixel and heaps certainly make it easy to put small games together very quickly, and there is a wealth of libraries and examples available. It may also be that frameworks such as Unity and GameMaker see higher use by beginners, whereas Haxe has a higher proportion of more experienced users who know what a great thing haxe is!

**Do you have something like a favorite Haxe language feature?**

[Macros](https://haxe.org/manual/macro.html). Also [abstracts](https://haxe.org/manual/types-abstract.html). They make it possible to do things that feel like magic. Macros can help to remove huge amounts of boilerplate, or to repurpose syntax to make highly tailored for specific uses with concise code. I discovered the power of abstracts when writing a color (int) abstract for HaxeFlixel, in which color had previously been represented throughout as an int. This made it possible to manipulate and transform the color in terms of a variety of color spaces, including easily accessing their individual components, all without any significant changes to the existing code.

**Conversely, is there anything that Haxe is missing or could do better?**

I haven't yet found an ideal way of managing library versions across different projects, although I know I have some options still to explore there. On some occasions I've had to compromise on what library versions I use, having to use older versions missing fixes or features due to incompatibilities with other library versions which I require for their features or fixes. I also find that the main options for IDE are currently lacking in some areas.

**What IDE do you use?**

I'm currently mainly using [Visual Studio Code](https://code.visualstudio.com/), but occasionally opening a project in [HaxeDevelop](https://haxedevelop.org/) for some types of refactoring such as renaming fields through multiple files, which still seems to be missing in the vscode environment.

**Alright, thanks a lot again for doing this interview! Anything you'd like to add?**

Thanks for the opportunity!

-----

That concludes our interview! Make sure to follow [Joe on twitter](https://twitter.com/joecreates) to not miss any of his amazing creations! If this inspired you to give Haxe a try, head right over to the [Haxe download page](https://haxe.org/download/) to get started. If you have any questions, comment below or check out the [Haxe community forum](https://community.haxe.org/).