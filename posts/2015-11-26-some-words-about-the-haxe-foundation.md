title: Some words about the Haxe Foundation
author: nicolas
description: Nicolas Cannasse reflects on the first 3 years of the Haxe Foundation, and what the next steps are. TLDR: We're hiring a CEO!
background: 9-ugmonk.jpg
published: true
tags: announcements
disqusID: 2
---

Time is flying!

Really, it is.

I can’t believe it will soon be 10 years since I started designing the Haxe language, writing the compiler and getting the first typing errors.

It has also been 3 years since Haxe Foundation was setup!

Anniversaries are always good occasions for me to look back, see what I did well, what I did wrong, then look forward and decide to continue or change direction. So let’s do that for Haxe Foundation!

But first, let’s start with a bit of history.

## The creation of the Haxe Foundation

The Haxe Foundation was created almost three years ago for several reasons:

At that time I was leaving Motion-Twin, a company I co-founded back in 2001. While most of the time spent developing Haxe was on my spare time, there was still a significant time spent on Haxe (and Neko) while working at Motion-Twin. Motion-Twin was also hosting the Haxe and Neko websites and I was introducing the work I was making with Haxe at Motion-Twin when I was going to conferences, etc. So it was necessary at that time to clarify Haxe’s ownership.

First I created Haxe Foundation then we transferred all the rights that Motion-Twin had to it. I also made sure that all compiler contributors signed a “contributor license agreement” so that nobody could decide to suddenly take back his source code and put it closed source. Keeping Haxe open source has been and will always be my primary goal.

Another reason to create the Haxe Foundation was that while quitting Motion-Twin I was starting a new venture at Shiro Games, which would take most of my day time. Simon was ready to take over daily compiler maintenance while I would focus on the high (and very low) level issues but given it required a lot of work I needed to find a way to compensate him.

Actually several significant companies were already using Haxe at that time and wanted to make sure that in case of bugs or problems they would have someone to help them. I then put together support plans and we soon got Area9, TiVo, Prezi and Motion-Twin signing up for them, with some other companies that are listed on our partners page and that I want to thank once more because without them we would not have any kind of budget.

The Haxe Foundation was born: we had people (me and Simon at first, Jason joined us afterwards, and more recently Andy and Josefiene), we had plans (make Haxe a big success) we even had a bit of money (~60K€).

What did we make out of it?

## Getting things done!

My first goal was to finalize and release Haxe 3.0. Each 2.x release came with its breaking changes, sometimes in ways that required significant changes in a lot of classes.

I wanted the Haxe 3.x series to be as stable as possible so people could write and share code that would still compile several years after. Simon worked on adding abstracts to the language, documenting and specifying the standard library.

We finally released Haxe 3.0 in May 2013

(We also changed the spelling and haXe became Haxe)

After that we started working with Jason who was hired by HF to work on a brand new haxe.org website (still remember the old one ?). The previous site was a wiki which had turned into a big mess of outdated information with 3.0 and required a full revamp.

Simon worked on writing the Haxe manual with a complete language specification, much more in-depth details about the various constructs and we worked on Haxe 3.1.

We finally released new Haxe.org a bit after Haxe 3.1 in May 2014

Look at this graph, which shows the commit activity since the start of Haxe:

![Haxe Commit Activity](HaxeCommitActivity.png)

From a purely data-oriented point of view, we have done great work since the start of Haxe Foundation.

And still, I’m not happy with the way we are now.

## The missing parts

One of the original goals of Haxe Foundation was to bring Haxe to the “next step”. From a technical point of view, I think we succeeded.

However we failed in the following areas:

### Getting people involved:

From the start of Haxe, while we have a very active community of people contributing libraries, there’s been very few people contributing to other aspects of the language such as documentation, tools, standard library, or just wishing to help in other areas.

I guess it’s the same in every technology, there’s always a small ratio of contributors / users.

But in Haxe’s case, the contributions are split among many different technologies : for instance, people contributing to OpenFL might not be interested in UFront.

I was thinking that creating the Haxe Foundation would help people to contribute more by having them talk to each other.

There was some initial spike in discussions, and every year after each WWX (the annual conference), everybody would get hyped to contribute, new ideas would fly, but things were soon back to everyone having to cope with their daily busy schedule and good intentions faded out.

We still had some successes by getting new great contributors such as Andy Li (which now works for HF) and Mark Knol, but I wish there was much more of them.

### Communication:

Haxe is very hard to communicate with because it can do so many things.

When you have a JS game framework, for instance, your target audience is well defined, you know how to address it.

Who is the target audience for Haxe? You can do so many things with it. While it’s been always strong in the game developers industry, I’m sure there’s much more growth to be found in other areas.

But being a game developer myself I’m not familiar with how a technology such as Haxe should be marketed to other areas.

Also, we are mostly developers at HF, so marketing is not our main job.

Knowing that, I tried several times to look for help outside. But getting someone to help with marketing, part time, overseas, with a very small budget, and who needed to understand Haxe in the first place, proved to be mission impossible. Maybe I should have tried more, but TBH the energy it took for the absence of results was disheartening, so it didn’t happen.

Earlier this year we started working with Josefiene to see how we could improve things in that area, but it didn’t have much impact, for the reason described in the next point.

### Organization:

As I said in a previous point, getting — and especially keeping — people involved is a hard task.

It’s not that hard when you work full time in a company. You make a daily standup / weekly meetings to make sure everybody is aligned towards the same goal, that no blind spot is unaddressed, etc. Business as usual.

But when it comes to organizing a team, however small it is, which doesn’t work full time, and might have other priorities depending on other client’s work, remotely and in such different timezones that you can’t have regular meetings with everybody at the same time, it becomes very, very hard.

TBH, I’m much more passionate about building great technologies and new games than having to make sure X or Y is done and that A has talked to B about W’s issues.

At first I expected people to have the maximum of autonomy in their work, but often in HF organization, it leads to simply nothing moving until I kick in, which I did from time to time, but not as much as I should have done, and definitely not as much as it would have been necessary.

In the end, while I wanted to build some organization that was sustaining itself, it became something requiring a lot of time for daily management, while I was more focused on high level strategical decision.

To be clear, I’m not blaming any of the people involved in HF for anything here. In the end, it’s my responsibility to get things moving, I just clearly underestimated to amount of energy it requires to do that.

### Failed expectations:

As I stated earlier, HF was originally created without any big plan behind it. I was not ready to dedicate my full time to it, I was starting another company at the same time, we had limited investment and budget, etc.

But while I stated several things that didn’t go well, there were others that worked out good.

If you look at the time since we have HF compared to the years before that, you can see that there’s been definitely a great improvement in terms of things-getting-done, simply because there’s more people involved.

So could we not just rejoice instead?

Not so easy.

Because it seems that once HF was born, people (maybe you, reading this, and other Haxe developers) started having expectations about what should be done and even how it should be done in some cases.

When I was the only one person steering Haxe’s development, people understood that I couldn’t do it all by myself. When there’s an organization, then suddenly it becomes reasonable to ask much more. As a side effect, it also becomes much easier to blame the organization than to blame someone personally.

Also, the tech world around us has been evolving a lot and some things that were quite strong points in Haxe, such as the mix between OO and functional, the type inference, and some others have been integrated in more recent languages such as Swift, with more or less success.

This can create frustration in the Haxe community, people getting impatient or tired of waiting Haxe to grow and become the Next Big Thing.

The sad news is, that while we had a lot of people telling us we should do X or Y, almost nobody jumped in to actually help us. We got many issues or posts telling us “it-would-be-nice-to” or “why-is-there-no”, but again almost no actual contribution in these areas.

This sometimes created a very bad feeling and a sense of being overwhelmed by unfair criticism, within our small team which was already doing its best delivering you a great tool. That’s not to say we are not open to criticism. As I said earlier in this post there are a lot of things we could have done better.

Again, I’m not blaming Haxe community here, I think it shows how much people are passionate about Haxe, which is a great thing.

But if we want to overcome that, we are at a point now where we need to make drastic changes in order to take Haxe to the next step.

## The Next Step

Based on what I said earlier, I think it’s important to make significant changes in the way the Haxe Foundation is run. We need to improve our skills in the areas we are lacking, we need new people to bring Haxe to the next step.

I have now decided to find a full time CEO for Haxe Foundation.

I’ll of course still be involved a lot with Haxe. The role of the CEO will be to help us establish and execute a strategy to develop Haxe further, to define priories, assign tasks, coordinate people and make sure things are getting done in due time. The CEO will also seek new partners for Haxe Foundation in order to enhance our financial capacities and will also be in direct contact with Haxe community and stakeholders to explain, discuss and improve the strategy. Of course, the actual balance between each of these roles will depend on the profile of the candidate we choose.

I’ll then myself be able to focus exclusively on technical challenges, language design and tools as well as participate in establishing the strategy for long-term Haxe development, which are the places I’ll bring the most value to the Haxe Foundation.

At the moment, I have several potential candidates but I have not made my choice, I want to take time to choose the best person for this important task. If you are or you know someone that might be interested in taking the job, make sure (s)he contacts me at nicolas _at_ haxe.org.

In order to help the CEO to make decisions, I’m also making a call for community participation in order to establish an advisory board. The role of the board will be to counsel the CEO and discuss the actions that needs to be done and their priorities. The CEO will get input from the advisory board, establish a plan of action and submit it to the board so it can be discussed and improved on. Members of the advisory board might be assigned specific tasks by the CEO if they can help in that particular area.

While the CEO will be paid by HF, the advisory board members will be volunteers. Please expect this will require a significant involvement time-wise (count 3-4 hours per week for at least a year).

This idea of an advisory board was already in place with the current Haxe Foundation form, but was more informal and less effective because there were less actions to consider. By having only the most motivated people and especially the ones that are ready to give their time to help Haxe reach the next step, we will be able to help the HF CEO best.

If you are seriously considering joining the advisory board, mail me at nicolas _at_ haxe.org.

I hope that we will be able to perform these changes in our organization in the upcoming months, it highly depends on finding the right candidates and in particular our new CEO.

Once in place, I am sure this new organization will bring Haxe a much greater success, one that it fully deserves as a technology all of us love to use!

--

Nicolas Cannasse
