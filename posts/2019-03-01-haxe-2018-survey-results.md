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
If we look at the results only for those wo do we haxe:

![question 1 extended graph](pie-extended-usetype.png)

We are close to a 50/50 distribution between hobbyist and professional users.

## How long have you been programming?

The options were:

* 1-3 years
* 3-5 years
* 7-10 years
* 10-15 years
* \> 15 years

It had 602 answers with the following distribution:

![question 2 base graph](pie-base-proglength.png)

Two thirds of the participants have more than 5 years of programming experience.
If we look only at those who use Haxe we get:

![question 2 extended graph](pie-extended-proglength.png)

Which is almost the same distribution.

Haxe is mostly used by experienced people. Which can be explained by the fact that it's not taught in schools, making it mostly a language learned after knowing programming.

## How long have you been using Haxe?

The options were:

* < 1 year
* 1-2 years
* 2-4 years
* 4-6 years
* 6-8 years
* \> 8 years

It had 600 answers with the following distribution:

![question 3 base graph](pie-base-haxelength.png)

Taking again only the participant who answered using Haxe:

![question 3 extended graph](pie-extended-haxelength.png)

Half have used Haxe for 2 years or less, and 12% have used it for more than 6 years, which means they've used it since Haxe 2!

## How big is your organization?

The options were:

* <= 1
* 2-10
* 10-25
* 26-100
* 101-500
* 501-1500
* 1501-10000
* \> 10000
* Not Applicable

It had 597 answers and the following distribution:

![question 4 base graph](pie-base-orgsize.png)

If we remove those who answered "Not Applicable":

![question 4 extended graph](pie-extended-orgsize.png)

Almost half, 47%, are only themselves. The other big half, 44%, are in organizations with less than 500 people. And a couple are in really big ones.

## Where are you geographically located?

It had 541 answers, with 63 different country mentioned!

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

You can find the full list at %TODO%.

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

Same as the previous question, without surprise the majority of user use Android.

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

The others mentioned the use of the Vivaldi web browser, which is a chromium based browser.

## What is your annual salary (U.S. Dollars)?

The options were:

* < $30,000
* $30,000-$50,000
* $50,001-$70,000
* $70,001-$100,000
* $100,001-$150,000
* \> $150,000
* I'd rather not say

It had 567 answers and the following distribution:

![question 9 base graph](pie-base-salary.png)

A third chose to not say, if we remove them from the graph we get the following distribution:

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

Which gives us if we group by type:

![question 10 group graph](pie-group-usages.png)

Haxe has been historically used for games and while it's still the biggest category it's not the majority anymore.

## Which Haxe targets do you use?

The options were:

* JavaScript
* C++
* HashLink
* Lua
* PHP
* Java
* C#
* Neko
* Flash (SWF)
* AS3 Source
* Python
* --interp

It had 604 answers and the following distribution:

![question 11 base graph](bar-base-targets.png)

And we can see the distribution of the number of target selected:

![question 11 histogram graph](histogram-targets.png)

There is a large of amount of people who use more than one target, which is one of Haxe's strength.

## Do you use macros?

The options were:

* Yes
* No
* What's a macro

It had 574 answers and the following distribution:

![question 12 base graph](pie-base-macros.png)

There is a big amount of macro user, and still a lot of people who don't know what it is. Being one of the most powerful but also most complex part of the language it's not surprising.

## How do you install Haxe?

The options were:

* Official installer
* Linux package manager
* NPM
* Chocolatey
* Build from source
* Homebrew
* Other

It had 601 answers and the following distribution:

![question 13 base graph](bar-base-install.png)

The others:

| Install method | Count |
| --- | --- |
| Lix | 10 |
| Bundled with an IDE | 7 |
| Manually | 4 |
| HVM | 2 |
| Docker image | 2 |
| Development Snapshot | 1 |

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

We can see the number of publication selected:

![question 14 histogram](histogram-publish.png)

Most people only publish to one or two places. And there is a lot of people who don't publish anywhere, which was one of the others, the rest being:

| Publish | Count |
| --- | --- |
| Github | 9 |
| Web Portals | 9 |
| Internal | 5 |
| Facebook | 5 |
| Custom | 4 |
| Haxelib | 1 |

## What is your preferred Haxe IDE?

The options were:

* FlashDevelop/HaxeDevelop
* IntelliJ
* Visual Studio Code
* VIM
* Sublime Text

It had 515 answers and the following distribution:

![question 15 base graph](pie-base-ide.png)

## How do you communicate with other Haxe users?

The options were:

* Official Forum
* Twitter
* Gitter.im
* Facebook
* #haxe on irc
* Other

It had 603 answers and the following distribution:

![question 16 base graph](bar-base-communication.png)

This question had a lot of other responses which gives us an interesting knowledge about the available communication option for the Haxe community.

* Telegram
* Slack
* Github
* Discord
* Reddit
* Email
* Skype
* Openfl's Forum
* StackOverflow
* Youtube
* None
* Google Groups
* QQ
* Other Forum

## Do you know that the Haxe Foundation offers paid support plans?

The options were:

* Yes
* No

It had 576 answers and the following distribution:

![question 17 base graph](pie-base-knowpaid.png)

It seems like the majority aren't aware of those, which is a point to improve for the Haxe Foundation.

## Are you currently a Haxe Foundation support partner?

The options were:

* Yes
* No

It had 577 answers and the following distribution:

![question 18 base graph](pie-base-partner.png)

This question is mostly for an internal usage of non anonymous data, and unsurprisingly the vast majority aren't Haxe Foundation partners :)

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
| Bounty based, or for a specific target |  4 |
| If I could in the futur |  3 |
| Something affordable by an individual|  2 |
| A paid plan |  2 |

## How much would you be willing to give to the Haxe Foundation to support them financially (U.S. Dollars)?

The options were:

* Nothing
* $1-$100
* $101-$500
* $501-$1000
* $1001-$5000
* $5001-$20,000
* $20,001-$100,000
* \>$100,000

It had 522 answers and the following distribution:

![question 20 base graph](pie-base-support.png)

## What are the Haxe libraries you use?

There wasn't any option for this question, only a free form input.

It had 604 answers and there was 226 libraries mentioned!
