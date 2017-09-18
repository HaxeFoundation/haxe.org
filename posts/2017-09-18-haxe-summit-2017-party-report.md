title: Haxe Summit 2017 Party Report
author: simn
description: We met up, had some beers and made decisions about Haxe
published: true
tags: events
disqusID: 29
---
# Haxe Summit 2017 Party Report

I am back from Amsterdam, where the Haxe Summit 2017 took place between September 13 and September 16. After four days of interesting talks, people, workshops, ideas and conversations, I would like to write down some of the many experiences I had there. The focus here is not going to be on any of the talks or workshops that are on video - you can just watch the videos for that - but instead on the after-conference meetups. In that sense, it is a party report. So let's party!

## Tuesday, September 12th

I traveled to Amsterdam one day before the start of the conference. We are in the fortunate situation of living only about 3 hours from Amsterdam, which allowed us to go by car. This lead to the unfortunate situation of us having to find a parking spot there. I was accompanied by Josefiene, our "communication, enquiries and community" manager. Or more informally, the girl you talk to. Now, they say that behind every successful man there is a woman, but I have to disagree. Granted, she parked the car for me and without her I probably wouldn't have had an accomodation. I also wouldn't have found that accomodation, the conference venue or the door to the conference venue. But... well, let's move on!

We arrived some time in the evening and met up with Nicolas and Mr. Uni<strike>verse</strike>code Heinz at [Stoop & Stoop](https://www.google.de/maps/place/Stoop+%26+Stoop+eetcaf%C3%A9/@52.3639312,4.883747,19.25z/data=!4m5!3m4!1s0x47c609e8ffb4db0d:0x214dbace51c7e10a!8m2!3d52.3642605!4d4.8839606). There we had some interesting conversations about the differences and similarities of natural and programming languages. This lead to questions like "Does poetry exist in a programming language?" While I find some of Nicolas' code quite poetic in the sense that there's probably some meaning to it which eludes everyone but the author, the question ultimately remained unanswered.

We moved on to a nice place named [Bourbon Street](https://www.google.de/maps/place/Bourbon+Street/@52.363699,4.8851278,20.75z/data=!4m12!1m6!3m5!1s0x47c609e9119a1f75:0xe9ea4034d45f11db!2sCafe+Het+Hok!8m2!3d52.3636186!4d4.8852025!3m4!1s0x0:0x9cbd1f0cb9d5904!8m2!3d52.3638739!4d4.8853232) that promised "live music all night". I learned there that shouting at each other about the usefulness of type classes was something that was missing in my life up to that point. Eventually, we called it a night and looked forward to the first day of the Haxe Summit 2017!

## Wednesday, September 13th

After the official part of the conference, a subset of the attendees grouped up and moved towards the general bar area of Amsterdam. We ended up invading a nice place called [Cafe Het Hok](https://www.google.de/maps/place/Cafe+Het+Hok/@52.3634818,4.884776,20.25z/data=!4m12!1m6!3m5!1s0x47c609e9119a1f75:0xe9ea4034d45f11db!2sCafe+Het+Hok!8m2!3d52.3636186!4d4.8852025!3m4!1s0x47c609e9119a1f75:0xe9ea4034d45f11db!8m2!3d52.3636186!4d4.8852025) where we sat down together at a table. After Nicolas tweeted out the address, more and more people starting showing up and we almost took over the entire thing!

I had a very interesting discussion with Hugh about performance, GCs and the C++ target. We agreed that we should really look into finding a way to automatically run benchmarks in order to detect performance regressions. This is one of these topics where everybody agrees that it's a good idea, but the realization is a bit tricky given that benchmark servers have some requirements regarding consistency.

Afterwards, I argued with Juraj about writing Haxe in Haxe. This comes up on a regular basis and the assumption is usually that we would get more contributions if the compiler code was written in Haxe instead of OCaml. My contention on that matter is that it's more of an architecture than a language problem, because the compiler code is not easy to get into and just changing the implementation language would not help with that.

We cut the evening a bit shorter because I realized that my presentation would be the next day and I hadn't really looked at my slides since creating them.

## Thursday, September 14th

Similar to the previous day, we were walking in a group towards the Amsterdam bar area. This time, however, an interesting group dynamic developed where everyone expected everyone else to make a decision about where to go. In the end, Nicolas came through with his leadership role and we entered [Café Eijlders](https://www.google.de/maps/place/Caf%C3%A9+Eijlders/@52.3646127,4.8826523,20.5z/data=!4m12!1m6!3m5!1s0x47c609e8ffb4db0d:0x214dbace51c7e10a!2sStoop+%26+Stoop+eetcaf%C3%A9!8m2!3d52.3642605!4d4.8839606!3m4!1s0x0:0x317bd3cbf3fa94b7!8m2!3d52.3647514!4d4.8825853).

This is going to be a bit of an inside joke, but I have to talk about the waitress there! If she was a programmer, she would definitely prefer a language with a strict typing discipline. A very strict typing discipline. Philippe almost got his ass kicked for lighting a cigarette on a candle, and the waitress kindly offered to beat up "the guy with the dreads" for reasons I'm not gonna disclose. I would just have to bring him back on Saturday. Looking back, this feels like a missed opportunity...

For some reason, everyone wanted to talk about inline XML that evening. It felt like every conversation would lead back to that subject somehow. I didn't really like the idea of having a language inside the source file of another language. Heinz tried to convince me that it was necessary for some JavaScript use-case. I heard 4 different design proposals from 3 different people, which is usually something that makes me dismiss a proposal entirely. That is, of course, not very nice of me: Even if people can't always agree on _how_ something should be done, we have to acknowledge that they agree _that_ something should be done. I realized that in situations like this, it is our job to find a solution which is either general enough to cover all needs, or is configurable enough to be adaptable to all needs.

At some point, Mrs. nadako started telling us about the museums she had visited in Amsterdam. I enjoyed that conversation a lot, because it wasn't about inline XML. A bit later, some of us ended up back at Bourbon Street where some nice blues was going on. Being the compiler developers that we are, it ended with Heinz, Dan and me standing outside to discuss compiler things. It got fairly late again that day, but that was fine because none of us had to give a talk the next day.

## Friday, September 15th

It was time for the main event, or at least the official dinner event. The organizers had reserved the backroom of [De Bekeerde Suster](https://www.google.de/maps/place/De+Bekeerde+Suster/@52.3719231,4.8989568,20z/data=!4m5!3m4!1s0x47c609b92c420703:0x1c223af553d2d715!8m2!3d52.3720689!4d4.8992416) for us, where a large percentage of the conference attendees arrived. We encouraged some mix & matching by sitting together in the compiler team, which means we didn't encourage it at all. Fortunately, this sort of thing usually naturally happens during the course of the evening. It still took me 3 hours to realize that there was another floor with lots of people I hadn't spoken to, but oh well...

I talked to a group of guys who use Haxe in their company, but aren't allowed to talk about it much. It's a secret success story, so to speak. This made me wonder how many other such stories might exist. It is quite difficult to estimate our reach and impact in general. For instance, for a while leading up to the start of the conference, it felt like it was getting a bit quieter around Haxe. And then the conference came along and suddenly we had almost overbooked our venue. There might be a dark figure of Haxe users that is bigger than we imagine.

I was also privileged to witness what shall from now on be known as "the handshake". I am not going to spoil anything, of course, but I can say that it involved Nicolas, Robert, heaps and Kha. No spoilers though!

## Saturday, September 16th

For the final chapter, we met up at the [Bar "Saloon"](https://www.google.com/maps/place/Bar+%22Saloon%22/@52.3622759,4.8838331,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0xbea4e8c6b462305d!8m2!3d52.3622759!4d4.8860218?hl=en) with about 10 people. Naturally, we were still discussing compiler stuff and among other things decided to add `final` to the language. The lesson learned here is that Nicolas is much more open to suggestions after a few beers!

Here's the thing: I'm usually a very rational person. There's even a rumor floating around that I'm just a robot Nicolas built during his trips to Japan. However, the last day of a conference always make me sad. More and more people start leaving over the course of the evening to catch their trains and planes, and ultimately the group remaining has to realize that it's time to call it a conference and head home. At the same time, there's a sense of certainty that we all will meet up again in a year or so, which helps a lot.

As they say: something ends, something begins. In the end, there's nothing left for me to do but to thank all the organizers and attendees of this wonderful conference. The community spirit that surfaced during these days is invaluable, and I'm looking forward to the Haxe Summit 2018!
