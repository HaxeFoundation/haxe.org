title: Meet HaxeDevelop
author: fiene
description: The FlashDevelop Team and the Haxe Foundation have joined forces to release a Haxe-specific version of FlashDevelop: HaxeDevelop.
background: header-haxedevelop.png
published: true
tags: announcements
disqusID: 4
---

##HaxeDevelop is here!

Every year after the WWX we all go home with lots of ideas, promises, plans and happy thoughts of the future. While not all of these things make it into reality, some of them do. One of the projects that came up at WWX 2015 was a Haxe-specific version of FlashDevelop. After some back and forth and a lot of help from the founders of the FlashDevelop Project, [Mika](http://meychi.com) and [Philippe](https://github.com/elsassph), as well as our design go-to guy, [Mark](http://blog.stroep.nl), we are happy to share the result with you!

[Meet HaxeDevelop - a custom FlashDevelop distribution for Haxe](http://haxedevelop.org/)

[![haxedevelop-interface.jpg](haxedevelop-interface.jpg)](http://haxedevelop.org/)

Being a custom version of FlashDevelop, HaxeDevelop maintains the great features of FlashDevelop; including its extensibility with plugins and custom themes that are available via AppMan.

Some of the features are:

* Great and fast code completion
* Debugging
* Lots of project templates
* Integrated source-control support
* Plugin support
* Snippets


Head over to the [website](http://haxedevelop.org/) to check out all the features and get the latest build.



##How did this happen?

While HaxeDevelop has just been released, the FlashDevelop Project has been around for some time and celebrated it's 10 year anniversary last year.

###The FlashDevelop Project

When ActionScript two was released back in 2004, there was no good editor to use with it. In 2005, Philippe connected with Mika who was making a simple editor script editor in .NET. Seeing the future potential, Philippe suggested to add a plugin system and further develop the script editor into a functional ActionScript 2 editor - the FlashDevelop Project was born. 

The project saw many improvements, contributions and releases over the next years. In 2006, a project panel and ActionScript 3 support were added and when ActionScript 3 was released, FlashDevelop was the very first publicly available IDE with ActionScript 3 support. Around the same time, Haxe's creator [Nicolas](https://github.com/ncannasse) was working on a haxefd plugin to add Haxe support to FlashDevelop 2. 

In the following year (2007), The FlashDevelop team added Haxe support and released FlashDevelop 3. Compared to the AS3 support, the Haxe support in FlashDevelop was not that great and progressed slowly. The main reason for this was that the developers were making their living with AS3, which thus remained the main focus of the development efforts for the project up until 2011. 

Over the years, FlashDevelop became a very popular IDE for Flash developers with another major version release in 2011 (FlashDevelop 4). However, Flash coding would soon hit a wall when Adobe's further support and development started to dwindle. Developers all over had to re-think their tooling and find alternatives and new technologies to use.

Reacting to these changes, the FlashDevelop Project saw a major change of direction in 2013. They moved to GitHub, which significantly increased the amount of contributions to the project, and they added continuous integration via AppVeyor so that there would always be a fresh build available.

Most importantly, though, Mika and Philippe both started using Haxe full time in their professional lives which naturally increased the motivation to have better Haxe support in FlashDevelop. 

>We aim to provide a great IDE for any developer. We have put in quite a lot of effort to make it possible to plug anything in to FD let it be new languages, themes or tools.
>
><cite>Philippe Elsass, Co-Founder of the FlashDevelop Project</cite>

The resulting Version 5 of FlashDevelop, lovingly nicknamed 10-year-anniversay-edition, and the history of the project were part of Philippe's talk at last year's WWX:


<div style="text-align:center" markdown="1">
    <a href="https://www.youtube.com/watch?feature=player_embedded&v=myRUlJ0KFcc" target="_blank">
        <img src="https://img.youtube.com/vi/myRUlJ0KFcc/0.jpg" alt="Philippe Elsass - You don't know FlashDevelop - wwx2015" />
    </a>
</div>

###Taking FlashDevelop to HaxeDevelop

The plan to make a Haxe-specific version of FlashDevelop was one of the things that hatched during WWX 2015. But while everyone agreed that it would be great to have HaxeDevelop, there was still some discussion around how different HaxeDevelop would be from FlashDevelop and how best to go about this venture.

Floating on a motivational post-conference-high, people suggested to take this opportunity to make FlashDevelop cross platform, re-write it in Haxe and make it "everything-you-could-possibly-want-in-a-Haxe-IDE". The problem with this is, of course, that the manpower, or developer-power, if you will, is limited and that "everything-you-could-possibly-want" tends to be different for each and every user. 

After a few rounds of discussion, we decided to keep with the initial plan of releasing HaxeDevelop as a slightly trimmed and re-branded version of FlashDevelop. All the non-Haxe parts were taken out and the distribution got a new name and a website with a Haxe-y logo and design.

The main goal is, to make it clear that HaxeDevelop is a really good IDE for all Haxe developers who use Windows. You do not have to be working with Flash for HaxeDevelop to be a great choice. In fact, the "for Flash" tag has been cause for some confusion over why you would use a Flash IDE with Haxe, especially for new users of both Haxe and HaxeDevelop. The new branding and distribution will help avoiding that caveat and show that yes, there are great IDE choices for Haxe.

If you are interested, you can review the whole discussion around this project in our [GitHub Project](https://github.com/HaxeFoundation/Project-Management/issues/20) and read up on why and how certain decisions were made. 


### A few Words on the Future

At this juncture, it is important to make it clear, that HaxeDevelop is a custom distribution of FlashDevelop but not a split project. Fixes, improvements and features that are added to FlashDevelop will also be in the HaxeDevelop distribution. In fact, they are both maintained in the same [GitHub repository](https://github.com/fdorg/flashdevelop/tree/distro_haxedevelop) by the FlashDevelop Team. This is also the place to go when you want to log an issue or contribute to HaxeDevelop.

According to the FlashDevelop Team, the development rate has increased significantly over the last year and the community is more active than ever. The team is also actively trying to channel contributions into AppMan as it is easier for users to find and manage new extras for both HaxeDevelop and FlashDevelop.

The support for Mac and Linux has been improved significantly with Crossover/Wine and thanks to the new Bridge you can now use native Mac or Linux tools with FlashDevelop and HaxeDevelop.


>We have had lots of contributors jump in with us and the rate of development is now faster than ever. Our community is active and we hope we can continue running FD and HD forward for the years to come.
>
><cite>Mika Palmu, Co-Founder of the FlashDevelop Project</cite>

One of the biggest future milestones is true cross platform support. Although the team has been working on it for some time, they have not yet found a good solution. However, they got very close with their latest attempt, so keep watching their updates and contribute to help make Flashdevelop and HaxeDevelop even better! Come help us make the crossplatform IDE happen!
