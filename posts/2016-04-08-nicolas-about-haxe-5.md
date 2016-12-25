title: Nicolas about Haxe #5 - The Inspector
author: fiene
description: The inspector is a clever little framework that you can integrate into your game to enable live viewing, debugging and modification of your games.
background: nicolas_darker.png
published: true
tags: nicolas-about-haxe
disqusID: 14
---

In last week's stream, Nicolas introduced a new piece of technology that he uses for for game development at Shiro Games. He likes to call it "The Inspector" although, in actuality, it is more than just an inspector. While it can read information about your game, it also allows live modification and manipulation of your game.

## Video Summary

Here is a quick overview of the video contents:

[00:00 - Intorduction](https://youtu.be/K8g-1dkBrxk)

[01:57 - The IDE-centered approach](https://youtu.be/K8g-1dkBrxk?t=122)

[05:12 - The preference for specific tools](https://youtu.be/K8g-1dkBrxk?t=312)

[06:56 - What the inspector does](https://youtu.be/K8g-1dkBrxk?t=416)

[16:05 - Starting the demo](https://youtu.be/K8g-1dkBrxk?t=965)

[22:51 - Does this work with non-heaps renderers?](https://youtu.be/K8g-1dkBrxk?t=1387)

[25:00 - A look at the code](https://youtu.be/K8g-1dkBrxk?t=1512)

[35:35 - Questions](https://youtu.be/K8g-1dkBrxk?t=2150)

And the video itself:

<div style="text-align:center" markdown="1">
    <a href="https://www.youtube.com/watch?feature=player_embedded&v=K8g-1dkBrxk" target="_blank">
        <img src="https://img.youtube.com/vi/K8g-1dkBrxk/0.jpg" alt="Nicolas about Haxe Episode 3 Macros in Haxe" />
    </a>
</div>


## The Problem with the IDE-Centered Approach

If you have an IDE-centered workflow, you are using one big IDE, like Unity, at the core of your process. Inside the IDE, you have a lot of UI options, all your assets and lots of possibilities to interact with your game scene. The IDE will allow you to add, remove and edit objects, change shaders and light and preview the changes. This approach works very well for static games with different levels. You can edit levels directly and see what you are doing in your preview.

Unfortunately, this does not work so well for more dynamic games. For instance, when you are using a level generator to generate a level, the specific changes you make afterwards would be lost, because the generator would just overwrite them. You would have to go and edit the level generator so that the changes remain when you generate a new map.

Instead of using one big tool, Nicolas prefers to have smaller, more flexible and game-specific tools that work well together. In this case, he wanted to have the excellent usability of an IDE, but still maintain the flexibility of working with different tools.

## Enter: The Inspector

The inspector is a piece of technology that you can integrate into any game development workflow. It is entirely made with Haxe and can be made to work with Haxe games. It consists of three parts:


1. The Inspector logic implemented in your game
2. The actual UI, a browser with a DOM
3. The connection between the two


In order to give the Inspector access to your game, it needs to be compiled into the game. It is not a separate entity reading your game from the outside, but rather a part of the game that you are making. Because of this, the Inspector can access your game data from inside the game.

The next step is getting a UI. It is hard to put a whole UI framework into your game and it would also not be platform agnostic, effectively defeating the purpose of using Haxe. To solve this, the Inspector operates separately from the UI. It sits inside your game and sends all UI interactions to the actual UI outside of the game via a network link. To do this, it creates a virtual UI inside the game consisting of a virtual DOM and jQuery to access and manipulate that DOM. This works a lot like normal web applications and retains almost all the functionality you would have with a normal web application. All of this happens entirely virtually, inside of the game, without any display.

To display the DOM state and interact with the game through the Inspector, you need a client consisting of a browser with an actual DOM. In Nicolas' case, the client is the web application called [castleDB](http://castledb.org/). The Inspector and castleDB connect via a specific port and synchronize the DOM states. This way, he can send changes from outside of the game (castleDB) into the game (to the Inspector).

I like to imagine this as having a remote controlled agent inside the game that will do whatever I ask him. To ask him to do things, I send him briefings through the network. I look at my UI and make changes, the changes are sent via a network to the agent, the agent then executes the instructions (changes or display queries) and sends back the information about the state of the game which then show up in my UI.

## The Example

In the example, Nicolas is running a part of the game he is working on in one window and the html5 application castleDB in another. At the moment, you can not yet overlay the actual UI over the game. This is not a problem, though, because he works with two monitors so he will run the game on one and castleDB on the other. He showed that you can change things in the scene, like color and brightness. The state of the UI is saved in the game and not in the UI (castleDB). 

## Release

At the moment, the Inspector is still early technology and comes as a ibrary that is part of castleDB. It has not yet been released separately. Nicolas will continue to develop it and eventually make it available as a separate tool.

## The next Episode

Because of a speaking engagement at [Game of Code](http://www.gameofcode.eu/), there hasn't been a stream today. We should be back up next week, **Friday, 15th of April 2016, 1:30 pm CET** at [Nicolas' Youtube Channel](https://www.youtube.com/c/NicolasCannasse/live)

See you there!
