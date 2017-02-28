title: Nicolas about Haxe #3 - Macros 101
author: fiene
description: In this week's stream, Nicolas gave a short introduction to the macro system, the most advanced features in Haxe.
background: nicolas_darker.png
published: true
tags: nicolas-about-haxe
disqusID: 10
---

If you have explored the Haxiverse for a bit, chances are that you have heard at least a whisper of the seemingly obscure occurrences called macros. While you may not be entirely certain what they are, you know that they exist and that supposedly they can be used to do some seriously awesome things.

In this week's stream episode, Nicolas explained the basics of macros in Haxe and I can tell you right now: Yes. They exist. And yes. You can do awesome things with them.

Here's the video:

<div style="text-align:center" markdown="1">
	<div style="position:relative;height:0;padding-bottom:56.25%"><iframe src="https://www.youtube.com/embed/SEYCmjtKlVw?ecver=2" width="640" height="360" frameborder="0" style="position:absolute;width:100%;height:100%;left:0" allowfullscreen><a href="https://www.youtube.com/watch?feature=player_embedded&v=SEYCmjtKlVw" target="_blank">
		<img src="https://img.youtube.com/vi/SEYCmjtKlVw/0.jpg" alt="Nicolas about Haxe Episode 3 Macros in Haxe" />
	</a></iframe></div>
</div>

##What is a Macro?

Let's google it and have a look at the definition first:

>a single instruction that expands automatically into a set of instructions to perform a particular task.

According to this definition, a macro has two parts:

1. The single instruction
2. The set of instructions it expands into

Just keep this little piece of information in the back of your head for now while we look at the first part of Nicolas' video.

## Run-Time and Compile-Time

Another useful piece of information to help make sense of macros is the distinction between run-time and compile-time. From the first line of code to the successful execution of your Haxe program, there are three phases:

1. The writing of the code
2. The compiling of the code
3. The running of the code

The first phase is what you are all very familiar with. It happens when you sit in front of your computer and actually type in the code. The second phase is what the Haxe compiler does when you press the compile button. It will assemble all the different bits and pieces of the code you have written into the intended output format. It will *compile*. The space in time while this is happening is what we call **compile-time**. The third phase is what happens when you actually run the program. The previously assembled (compiled) code is executed. The time-frame this happens in is called **run-time**.

## Macro-Calls vs. Normal Function-Calls

A macro works a lot like a normal function in that it is executed at a specific point. However, it does not return a value. It returns a program. So in essence, thinking of the definition above, it has a single instruction - the name of the macro  and its arguments - and some longer instructions - the little program that is executed when the macro is called.

A normal function-call is executed at run-time, that is to say, when you actually run your program. This happens way after phase one and phase two mentioned above. You have already written your program and compiled it. 

A macro-call, on the other hand, is executed at compile-time. It happens while the compiler is compiling all the bits and pieces your program consists of into something that can be run. While walking through your code, the compiler will come across the macro-call (the single instruction) and then execute the macro (the code it contains - the set of instructions mentioned above) and return an expression (some more code) which will then be executed at run-time.This happens before you ever run your application and can actually change the code output. 

In essence, a macro is a mini program with a single instruction that the compiler runs whenever it comes across a call to it while compiling. This mini program can do things to your functions and classes. It can add things to the code, remove things or check things.

In Haxe, you can define a macro with the `macro` keyword as shown in the first example:

```haxe
class Main {
	macro static funtion getDate() {
		return Date.now().toString();
	}

	static function main() {
		trace(getDate());
	}
}
```

If you look at the video, you can actually see how the time that was traced in this example was not updated when Nicolas ran the program the second time. This is because the macro was called at compile-time, so the macro was run and the time-stamp put in when the program was assembled (compiled). Upon running the program, the macro was not run again, thus the time was not updated.

## Other Macro Things

In the following examples, Nicolas showed how you could use build macros to trace and modify information about fields at compile-time, modify class code or insert and generate code. He also showed us how to access IDs on a google page and get them to be displayed as auto-completion options in his IDE:

```haxe
import haxe.macro.Context;
import haxe.macro.Expr;

class MyMacro {


	public static function build( url : String ) {
		
		var h = haxe.Http.requestUrl(url);
		
		var r = ~/id=["']([A-Za-z0-9]+)["']/;
		var ids = [];
		while ( r.match(h) ) {
			var id = r.matched(1);
			ids.remove(id);
			ids.push(id);
			h = r.matchedRight();
		}
		
		var fields = Context.getBuildFields();
		
		var gtype = TAnonymous([for ( id in ids ) {
                    name : id,
                    pos : Context.currentPos(), 
                    kind : FVar(macro : String)
                }]);
		
		var gids : Field = {
			name : "gids",
			pos : Context.currentPos(),
			kind : FVar(gtype),
			access : [AStatic],
		};
		fields.push(gids);
		
		return fields;
	}
	
}
```

Other examples would be Mark Knol's [Code Completion for Everything](http://blog.stroep.nl/2014/01/haxe-macros/) or Jeff Ward's [Less Glue via Haxe Lazy Props](http://jcward.com/Less+Glue+via+Haxe+Macro+Lazy+Props). Of course, macros are also documented in the [Haxe Manual](https://haxe.org/manual/macro.html)

## The Next Episode

The topic for the  next stream will be "An Intorduction to Haxe Compiler Sources" and will take place this **Friday, 25th of March at 1:30 pm CET (GMT+1)** over at [Nicolas' youtube channel](https://www.youtube.com/c/NicolasCannasse/live). 

See you there!
