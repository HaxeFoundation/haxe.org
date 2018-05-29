title: FlowPlay's Vegas World Haxe Conversion Case Study
author: pchertok
description: A dive into how FlowPlay converted their AS3 codebase to Haxe and ported Vegas World to the web and mobile. 
published: true
background: vegasworld.jpg
tags: events
disqusID: 38
---

## Farewell Flash, Hello Haxe

Recently, Haxe Foundation partner [FlowPlay](https://www.flowplay.com/) had to move their Flash project [Vegas World](https://www.vegasworld.com) out of Flash and into HTML5 and native mobile. They rejected the idea of implementing a separate codebase for HTML5, Android and iOS due to the long term loss of productivity this would cause, so  they chose instead to convert their project to Haxe. Their Chief Architect Scott Pultz’s gave a [talk on the subject](https://www.youtube.com/watch?v=wbqRb5HW9l4) at this year’s Haxe US Summit.  The following summarizes Scott's talk and FlowPlay's experience during this transition.

First, it’s important to understand where they were coming from. Vegas World was developed on top of a codebase that was roughly 10 years old, had more than a million lines of ActionScript and was entirely made using Flash vector art. 

Before they even started porting to Haxe, they began with a roadmap that involved first
rewriting the game in ActionScript to use just bitmap art instead of vector art.. Then once that was complete the goal was to convert to Haxe to initially target SWF, followed by HTML5 then finally native iOS and Android. They would do so by making use of the popular [OpenFL library](http://www.openfl.org/) which provides a familiar API to anyone starting from an ActionScript code base and moving to Haxe. 

Because FlowPlay was continuing to add new features to Vegas World, it was extremely important that they keep their new Haxe code and legacy AS code in sync. If the act of porting the game introduced game logic changes, that would substantially increase the cost of testing the game so it was important that the port be one-for-one identical to the original.

## Converting the Code

For converting the ActionScript syntax to Haxe, FlowPlay had a couple of options. The first was to use the [as3hx](https://github.com/HaxeFoundation/as3hx) tool to convert their `.as` files to `.hx`. This tool works by parsing the ActionScript code and generating equivalent Haxe code whenever possible. The second option involved using simple text replacement. Initially they’d rename their `.as` files to `.hx`, then they’d search and replace any AS3-specific text with Haxe equivalents before finally searching through the new code and fixing any problems. 

The as3hx solution seemed like the ideal one because it automatically fixed many of the most glaring problems and automated much of the work. However, there were some major drawbacks.  Code formatting is lost, some comments are removed and code generation is wrong in some subtle but important cases.  The code formatting changes mean that much of the code would need to be manually reformatted to make it clearly readable again.  But more importantly the incorrect code generation would introduce potentially very hard to find bugs - bugs which might not be discovered for weeks or months. 

Because of the aforementioned issues with as3hx, FlowPlay chose text replacing, even though it had its own drawbacks (mainly lots of manual labor).

## Making things Better

Once they began the process, it took about 2 months to port the first 100,000 lines of code. This was the bare minimum needed to get Vegas World running. Due to the nature of Haxe’s type system, FlowPlay wasn’t merely converting their code, they were improving it.

The addition of certain Haxe features improved the runtime safety and performance of their application. Some of these included:

* Typed function signatures
* Private constructors
* Improved access modifiers via the `:allow()` metadata 
* Typed arrays

Of course, it wasn’t all smooth sailing, many differences between Haxe and AS3 did cause some problems for the conversion process. Some of the things causing trouble included Haxe’s different for loop syntax, the lack of [E4X support](https://en.wikipedia.org/wiki/ECMAScript_for_XML) for XML and the nature of Haxe switch statements. 

_Haxe switch statement_
```haxe
for (i in 0...10) {
  switch(i){
      case 5: 
        //Because Haxe switch statements don't support the break keyword 
        //the following break command would exit the 'for loop'
        break;
  }
}
```
None of these issues were major roadblocks and in some cases, Haxe syntax proved to be an improvement where converted code was actually reduced, as was the case with read-only properties:

_AS3_
```haxe
private var _isReady:Boolean = false;
public function get isReady():Boolean{
    return _isReady;
}
```
_Haxe_
```haxe
public var isReady(default,null):Bool = false;
```

Once they had the syntax problems sorted out they were able to move on to specific platform issues. These mostly involved display rendering (Vegas World was not using the Flash Display list), native storage classes and file system APIs. 

Once everything was sorted out and thoroughly tested, FlowPlay was ready to go live with their HTML5 version of Vegas World and the results speak for themselves:

_Flash_
![Vegas World Flash](vegasflash.png)
_HTML5_
![Vegas World HTML5 - Made with Haxe](vegashaxe.png)
_Native mobile_
![Vegas World Native Mobile - Also Made with Haxe](vegasmobile.png)


## Jackpot!

As you can see, the differences between the two platform are negligible. Needless to say, converting their Flash project to Haxe turned out to be a big success for FlowPlay, especially now that Vegas World is [available natively for iOS](https://itunes.apple.com/us/app/vegas-world-casino-slots-blackjack-and-more/id587547471?mt=8).

By choosing Haxe, FlowPlay had a clear path to porting their existing Flash project onto modern platforms. Haxe offered improved performance, safety and readability and allowed existing developers to transition onto a familiar yet superior language. 

