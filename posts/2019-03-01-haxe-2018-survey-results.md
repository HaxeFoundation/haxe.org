title: Haxe 2018 survey results
author: ibilon
description: The results of the 2018 survey about Haxe
published: true
disqusID: 42
---

# Haxe 2018 survey results

Back in May 2018, we made a survey to help us better understand the Haxe community.

It was made of 21 questions, all optional, and got 605 answers.

And now it's time to see the results.

## How do you use Haxe?

The options were:

* It is one of the main tools I use professionally
* It is a tool I use occasionally for professional work
* I use Haxe for hobby projects
* I don't use Haxe but would like to

It had 603 answers with the following distribution:

![question 1 base graph](pie-base-usetype.png)

We can see that 22% of participants don't yet use Haxe.
If we look at the results only for those who do use Haxe:

![question 1 extended graph](pie-extended-usetype.png)

We are close to a 50/50 distribution between hobbyist and professional users.

## How long have you been programming?

The options were:

* 1-3 years
* 3-5 years
* 7-10 years
* 10-15 years
<li>&gt; 15 years</li>

It had 602 answers with the following distribution:

![question 2 base graph](pie-base-proglength.png)

Two thirds of the participants have more than 5 years of programming experience.
If we look only at those who use Haxe we get:

![question 2 extended graph](pie-extended-proglength.png)

Which is almost the same distribution.

Haxe is mostly used by experienced people, which could be explained by the fact that it's not taught in schools, making it mostly a language learned after knowing programming.

## How long have you been using Haxe?

The options were:

* < 1 year
* 1-2 years
* 2-4 years
* 4-6 years
* 6-8 years
<li>&gt; 8 years</li>

It had 600 answers with the following distribution:

![question 3 base graph](pie-base-haxelength.png)

Taking again only the participants who answered using Haxe:

![question 3 extended graph](pie-extended-haxelength.png)

Half have used Haxe for 2 years or less which is a sign that the Haxe community is growing.
And 12% have used it for more than 6 years, which means they've used it since Haxe 2!

## How big is your organization?

The options were:

* <= 1
* 2-10
* 10-25
* 26-100
* 101-500
* 501-1500
* 1501-10000
<li>&gt; 10000</li>
<li>Not Applicable</li>

It had 597 answers and the following distribution:

![question 4 base graph](pie-base-orgsize.png)

If we remove those who answered "Not Applicable":

![question 4 extended graph](pie-extended-orgsize.png)

Almost half, 47%, are only themselves. The other big half, 44%, are in organizations with less than 500 people. And a couple are in really big ones.

Looking at the Haxe users who use it professionally:

![question 4 extended 2 graph](pie-base-orgsizepro.png)

We have less people working alone and more small organizations.

## Where are you geographically located?

It had 541 answers, with 63 different countries mentioned!

The top 10 is as follows:

| Country | Count |
| --- | --- |
| United States | 104 |
| France | 57 |
| Russia | 44 |
| Germany | 39 |
| United Kingdom | 37 |
| Australia | 17 |
| Canada | 16 |
| Brazil | 16 |
| Japan | 14 |
| Ukraine | 13 |

See the [full list](https://github.com/ibilon/haxe-2018-survey-results/blob/master/generated/tables/base-country.txt).

## What is your primary desktop operating system?

The options were:

* Windows
* OSX
* Linux
* Other

It had 591 answers and the following distribution:

![question 6 base graph](pie-base-desktopos.png)

Without much surprise the majority use Windows, but there is a fairly big amount of OSX and Linux users.

The others are people who answered that they use multiple operating systems equally.

## What is your primary mobile operating system?

The options were:

* Android
* iOS
* Blackberry
* Windows Phone

It had 582 answers and the following distribution:

![question 7 base graph](pie-base-mobileos.png)

Same as the previous question, without surprise the majority of users use Android.

The others are people who don't own a phone.

## What is your primary web browser?

The options were:

* Chrome
* Firefox
* Edge
* Safari
* Internet Explorer
* Opera
* Other

It had 593 answers and the following distribution:

![question 8 base graph](pie-base-browser.png)

Yet again the distribution is similar to the global distribution of users.

The others mentioned the use of the Vivaldi web browser, which is a Chromium based browser.

## What is your annual salary (U.S. Dollars)?

The options were:

* < $30,000
* $30,000-$50,000
* $50,001-$70,000
* $70,001-$100,000
* $100,001-$150,000
<li>&gt; $150,000</li>
<li>I'd rather not say</li>

It had 567 answers and the following distribution:

![question 9 base graph](pie-base-salary.png)

A third chose not to say, if we remove them from the graph we get the following distribution:

![question 9 extended graph](pie-extended-salary.png)

With the majority being under $30.000, and 21% at more than $70.000.

## What do you use Haxe for?

With this question we're entering the interesting part ;)

The options were:

* Console Games
* Desktop Games
* Mobile Games
* Front-end Web
* Back-end Web
* Desktop Applications
* Mobile Applications
* Software Libraries
* Command Line Utilities
* Art
* Other

It had 604 answers and the following distribution:

![question 10 base graph](bar-base-usages.png)

Grouping by type, this gives us:

![question 10 group graph](pie-group-usages.png)

Haxe has been historically used for games and while it's still the biggest category it's not the majority anymore.

Among the other answers we have people using Haxe for data processing, prototyping and educational software.

If you want to know more about Haxe's use cases we have [a page about them](https://haxe.org/use-cases/) on the haxe.org website.

## Which Haxe targets do you use?

The options were:

* [JavaScript](https://haxe.org/manual/target-javascript.html)
* [C++](https://haxe.org/manual/target-cpp.html)
* [HashLink](https://haxe.org/blog/hashlink-indepth/)
* [Lua](https://haxe.org/manual/target-lua.html)
* [PHP](https://haxe.org/manual/target-php.html)
* [Java](https://haxe.org/manual/target-java.html)
* [C\#](https://haxe.org/manual/target-cs.html)
* Neko
* [Flash (SWF)](https://haxe.org/manual/target-flash.html)
* AS3 Source
* Python
* [--interp](https://haxe.org/blog/eval/)

It had 604 answers and the following distribution:

![question 11 base graph](bar-base-targets.png)

And we can see the distribution of the number of targets selected:

![question 11 histogram graph](histogram-targets.png)

There is a large amount of people who use more than one target, which is one of Haxe's main strengths.

## Do you use macros?

The options were:

* Yes
* No
* What's a macro?

It had 574 answers and the following distribution:

![question 12 base graph](pie-base-macros.png)

There is a big amount of macro users, and still a lot of people who don't know what it is. Being one of the most powerful but also most complex parts of the language it's not surprising.

If you want to learn more about macros, we have a sections about them in the [Manual](https://haxe.org/manual/macro.html) as well as the [Code Cookbook](https://code.haxe.org/category/macros/).

## How do you install Haxe?

The options were:

* [Official installer](https://haxe.org/download/)
* [Linux package manager](https://haxe.org/download/linux/)
* [NPM](https://www.npmjs.com/package/haxe)
* [Chocolatey](https://chocolatey.org/packages/haxe)
* [Build from source](https://github.com/HaxeFoundation/haxe)
* [Homebrew](https://formulae.brew.sh/formula/haxe)
* Other

It had 601 answers and the following distribution:

![question 13 base graph](bar-base-install.png)

The others:

| Install method | Count |
| --- | --- |
| [Lix](https://github.com/lix-pm) | 10 |
| Bundled with an IDE | 7 |
| Manually | 4 |
| [HVM](https://github.com/dpeek/hvm) | 2 |
| [Docker image](https://hub.docker.com/_/haxe/) | 2 |
| [Development Snapshot](http://build.haxe.org/builds/haxe/) | 1 |

Haxe is bundled with several IDE/projects, including [Kha](http://kha.tech/) and [Armory3D](https://armory3d.org/). [HaxeDevelop](https://haxedevelop.org/) allows installing it from its built-in App Manager.

Did you know that Haxe has official [docker images](https://hub.docker.com/_/haxe/)?

Using [development snapshots](http://build.haxe.org/builds/haxe/) is an easy way to test the latest Haxe without having to compile it yourself.

## Where do you publish your Haxe applications?

The options were:

* Steam
* iOS App Store
* Mac App Store
* Android App Store
* Windows App Store
* PlayStation 4
* PlayStation Vita
* Xbox One
* Nintendo Switch
* GOG.com
* Amazon App Store
* itch.io
* The Web

It had 604 answers and the following distribution:

![question 14 base graph](bar-base-publish.png)

We can see the number of publishing options selected:

![question 14 histogram](histogram-publish.png)

Most people only publish to one or two places. And there are a lot of people who don't publish anywhere, which was one of the others, the rest being:

| Publish | Count |
| --- | --- |
| GitHub | 9 |
| Web Portals | 9 |
| Internal | 5 |
| Facebook | 5 |
| Custom | 4 |
| Haxelib | 1 |

## What is your preferred Haxe IDE?

The options were:

* [FlashDevelop](http://www.flashdevelop.org/) / [HaxeDevelop](https://haxedevelop.org/)
* [IntelliJ](http://intellij-haxe.org/)
* [Visual Studio Code](https://github.com/vshaxe/vshaxe)
* [VIM](https://github.com/jdonaldson/vaxe)
* [Sublime Text](https://github.com/clemos/haxe-sublime-bundle)

It had 515 answers and the following distribution:

![question 15 base graph](pie-base-ide.png)

The others:

| IDE | Count |
| --- | --- |
| Atom | 19 |
| Emacs | 9 |
| [Kode Studio](https://github.com/Kode/KodeStudio) | 6 |
| None | 4 |
| Geany | 3 |
| Multiple | 2 |
| Notepad++ | 2 |
| TextMate | 1 |
| Web Based | 1 |

## How do you communicate with other Haxe users?

The options were:

* [Official Forum](https://community.haxe.org/)
* [Twitter](https://twitter.com/haxe_org)
* [Gitter.im](https://gitter.im/HaxeFoundation/haxe)
* [Facebook](https://www.facebook.com/haxe.org)
* \#haxe on irc
* Other

It had 603 answers and the following distribution:

![question 16 base graph](bar-base-communication.png)

This question had a lot of other responses, which gives us an interesting picture of the available communication options for the Haxe community.

| Communication | Count |
| --- | --- |
| Discord [OpenFL](https://discord.gg/tDgq8EE) and [Haxe](https://discord.gg/0uEuWH3spjck73Lo) | 34 |
| Nothing | 18 |
| Slack | 14 |
| [Telegram](https://t.me/haxe_ru) | 12 |
| [OpenFL forum](https://community.openfl.org/) | 7 |
| GitHub | 6 |
| [Stack Overflow](https://stackoverflow.com/questions/tagged/haxe) | 5 |
| Skype | 4 |
| [Reddit](https://www.reddit.com/r/haxe/) | 3 |
| Email | 2 |
| Other | 2 |
| Other Forum | 2 |
| YouTube | 2 |
| QQ | 1 |
| GoogleGroup | 1 |

The answers mention a strong Russian community, and someone who is looking for a French forum.
This shows the importance of local communities to go beyond the requirement of good English knowledge.

There's also a lot of people who didn't know, or don't use any of these.

## Do you know that the Haxe Foundation offers paid support plans?

The options were:

* Yes
* No

It had 576 answers and the following distribution:

![question 17 base graph](pie-base-knowpaid.png)

It seems like the majority aren't aware of the [support plans](https://haxe.org/foundation/support-plans.html), which is a point to improve for the Haxe Foundation.

## Are you currently a Haxe Foundation support partner?

The options were:

* Yes
* No

It had 577 answers and the following distribution:

![question 18 base graph](pie-base-partner.png)

This question is mostly for internal usage of non-anonymous data, and unsurprisingly the vast majority aren't Haxe Foundation partners. :)

## Which of the following support plans would you be interested in?

The options were:

* Free
* Professional
* Enterprise
* Elite
* Other

It had 520 answers and the following distribution:

![question 19 base graph](pie-base-planinterest.png)

This question wasn't well understood, we meant for people who weren't interested in a support plan to choose the free option, but it was easy to miss.

We had some interesting answers in the other category:

| Plan | Count |
| --- | --- |
| Bounty based, or for a specific target | 4 |
| If I could in the future | 3 |
| Something affordable by an individual | 2 |
| A paid plan | 2 |

Several of the other answers talk about having something more affordable for an individual, which could be done through a bounty program.
A target isn't a practical way of allocating money since most of the work is common to all targets.

## How much would you be willing to give to the Haxe Foundation to support them financially (U.S. Dollars)?

The options were:

* Nothing
* $1-$100
* $101-$500
* $501-$1000
* $1001-$5000
* $5001-$20,000
* $20,001-$100,000
<li>&gt; $100,000</li>

It had 522 answers and the following distribution:

![question 20 base graph](pie-base-support.png)

## What are the Haxe libraries you use?

There wasn't any pre-made option for this question, only a free form input.

It had 604 answers and 226 unique libraries were mentioned!

The top ten:

| Library | Count |
| --- | --- |
| [OpenFL](https://www.openfl.org/) | 173 |
| [HaxeFlixel](http://haxeflixel.com/) | 94 |
| [Lime](https://github.com/openfl/lime) | 44 |
| [Heaps](https://heaps.io/) | 44 |
| [Kha](http://kha.tech/) | 43 |
| [Tink](https://haxetink.github.io/) | 42 |
| [Actuate](https://lib.haxe.org/p/actuate/) | 28 |
| [HaxeUI](http://haxeui.org/) | 25 |
| [hxcpp](https://lib.haxe.org/p/hxcpp) | 23 |
| [hxnodejs](https://lib.haxe.org/p/hxnodejs/) | 15 |

The list is game programming heavy, but it includes the [Tinkerbell ecosystem](https://haxetink.github.io/#/), the HaxeUI library and the support library for the NodeJS target.

See the [full list](https://github.com/ibilon/haxe-2018-survey-results/blob/master/generated/tables/base-libraries.txt).

To discover more libraries go to [lib.haxe.org](https://lib.haxe.org/).

## Conclusion

There's a lot to unpack here, a lot of interesting information. But it's great to see the Haxe community growing and evolving.

You can find all the data on [GitHub](https://github.com/ibilon/haxe-2018-survey-results/), you can find the [full dump](https://github.com/ibilon/haxe-2018-survey-results/blob/master/data.csv) and a [cleaned](https://github.com/ibilon/haxe-2018-survey-results/blob/master/generated/clean.csv) version which is easier to process but doesn't have all the details in the open answers. Both are under the [Open Database License](https://opendatacommons.org/licenses/odbl/index.html).

Want to see how Haxe is changing in 2019? Participate in the [community 2019 survey](https://community.haxe.org/t/haxe-survey-2019-open-results/1521) or view its [early results](https://community.haxe.org/t/haxe-survey-2019-final-results-and-discussion/1536).
