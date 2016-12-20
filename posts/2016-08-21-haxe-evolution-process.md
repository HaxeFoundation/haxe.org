title: Haxe Evolution Process
author: nadako
description: The new proposal process for changes to the Haxe programming language, compiler, standard library and sister projects
published: true
tags: announcements
---

Hello, community!

We would like to introduce a new formalized process of proposing substantial changes
to the Haxe programming language, compiler, standard library and sister projects, like Haxelib.

## What are "substantial" changes? 

Basically, the kind of changes that change the way you code in Haxe.  

For example:

+ changing, removing or introducing new syntax or type system features
+ adding new general-purpose types into standard library
+ reworking IDE support protocol 

In other words - things that require some thoughtful design process and consensus among the
Haxe core developers and the community. Things that define or change the direction Haxe is evolving in.

This does not include bugfixes, optimizations, documentation changes or minor standard library
additions. For that, the standard Github issue and pull request workflow is working great!

## How does it work?

The process itself is meant to be as lightweight as possible and at the same time providing
an easy and consistent way to propose, discuss and implement evolutionary changes in Haxe.

There's a new [haxe-evolution](https://github.com/HaxeFoundation/haxe-evolution)
repository under the HaxeFoundation organization. It contains the README file describing the process,
the template for proposals and accepted proposals. Adding a new proposal is as simple as filling
in the template and making a pull request to the repository. The pull request is where the public discussion
takes place and merging the PR means that the proposal has been accepted.

The template and the process itself is not yet "set in stone" and we will revise and improve it if any
issues arise with real proposals.

## Conclusion

With this addition, we want to reach several important goals:

 * Make sure that proposed language features are thoroughly designed
 * Have a constructive discussions about future changes and not be stuck in doubts
 * Make decisions in a truly open-source way where experts from the community can easily get involved
 * Have good reference documents for new features and breaking changes

Let's use this and make Haxe future clear and bright, together! :)
