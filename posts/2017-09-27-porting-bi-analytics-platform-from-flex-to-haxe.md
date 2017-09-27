title: Porting our BI Analytics Platform from Flex to Haxe/HTML5
author: marcmauri
description: Marc Mauri, CTO of Kaizen for Pharma, reflects on their decision to use Haxe and how they transitioned from a Flash plugin to Html5/WebGL in 4 months
published: true
tags: case-studies
disqusID: 30
background: kaizen.png
---
# Porting our BI Analytics Platform from Flex to Haxe/HTML5

## Background

[Kaizen for Pharma](https://www.kaizenforpharma.com/) is a Business Intelligence & analytics platform for the pharmaceutical industry.

The application itself runs on desktop browsers and iPad (via AIR). It incorporates charts, maps and reports and is utilized daily by thousands of field force reps from companies such as Pfizer, BMS, Merck & Kyowa Kirin.

It was developed using the Apache Flex Framework and has no 3rd party dependencies, using its own maps engine as well as its own charts engine, which was developed due to poor performance of standard Flex chart components in Adobe AIR for mobile.

### Frontend Web (Flash based)

* Flex based
* 300+ classes
* 200+ MXML templates
* 100K+ lines of code

### Frontend iOS

* Air based

### Backend

*  .NET / FlourineFX (AMF)

### Battle-test code

* 3000 daily users relying on Kaizen for their business decisions

### Flex Web App (before)

<p><a class="btn" href="https://demo.kaizenforpharma.com/KaizenInsight.aspx"><i class="fa fa-external-link"></i> Open old demo </a></p>

[![Flex Web App (before)](image1.png)](!/image1.png)

### Haxe/OpenFL/HaxeUI Web App (after)

<p><a class="btn" href="https://demo.kaizenforpharma.com/KaizenInsightv2.aspx"><i class="fa fa-external-link"></i> Open new demo</a></p>

[![Haxe/OpenFL/HaxeUI Web App (after)](image2.png)](!/image2.png)



## Why

Chrome, Firefox and Microsoft all announced that in a matter of months Flash content would be blocked in their respective browsers by default meaning users would be manually required to enable Flash.

Compounding the issue, in the following months, Adobe announced the [end of life of the Flash Browser plugin in 2020](https://blogs.adobe.com/conversations/2017/07/adobe-flash-update.html?scid=social73423017&adbid=889878192994918401&adbpl=tw&adbpr=63786611). This was the final nail in the coffin for Flash, it was already dead and something had to be done to move away from it as soon as possible.

In order for Kaizen to avoid the same fate as Flash various potential solutions were evaluated:

### React

<div>
	<div style="width:50%; float:left">
		<h4>Pros</h4>
		<ul>
			<li>Huge community</li>
			<li>It’s “trendy”, makes hiring devs easier</li>
			<li>“React Native” for multiplatform</li>
		</ul>
	</div>
	<div style="width:50%; float:left">
		<h4>Cons</h4>
		<ul>
			<li>Total rewrite</li>
			<li>Javascript fatigue - hard to know if React will become legacy code and unmaintained in 3 years</li>
			<li>React Native iOS was at the time unreleased, meaning final performance was uncertain</li>
			<li>Untyped JavaScript!!!</li>
			<li>Runtime errors not detected at compile time</li>
		</ul>
	</div>
	<div style="clear:both"></div>
</div>

### Apache FlexJS

<div>
	<div style="width:50%; float:left">
		<h4>Pros</h4>
		<ul>
			<li>Easier approach to port current Flex code</li>
			<li>Open Source</li>
			<li>Multiplatform due to Adobe AIR</li>
		</ul>
	</div>
	<div style="width:50%; float:left">
		<h4>Cons</h4>
		<ul>
			<li>Lots of breaking changes</li>
			<li>Being in development for years and still at 0.8 beta version</li>
			<li>Adobe not committed</li>
			<li>Not mature enough</li>
			<li>Former vibrant Flex community has gone</li>
		</ul>
	</div>
	<div style="clear:both"></div>
</div>

### Haxe/OpenFL/HaxeUI

<div>
	<div style="width:50%; float:left">
		<h4>Pros</h4>
		<ul>
			<li>OpenFL allows the team to use the existing Flash API code “as is”</li>
			<li>HaxeUI allows porting of existing Flex layouts and components with relative ease</li>
			<li>Haxe has the lowest learning curve - indeed along with FlexJS</li>
			<li>80% of code can be ported automatically with “as3hx”</li>
			<li>Mature</li>
			<li>Open source stack</li>
			<li>OpenFL has full multi platform support (Html5 Canvas/WebGL, Native C++ iOS/Android, Emscripten / Web Assembly)</li>
		</ul>
	</div>
	<div style="width:50%; float:left">
		<h4>Cons</h4>
		<ul>
			<li>OpenFL is game oriented, and so is the community meaning that issues with idle CPU usage, text fields, text inputs &  fonts are not their priority</li>
			<li>We would pave the way using this stack for non-game orientated applications</li>
			<li>HaxeUI v2 in beta for long time</li>
			<li>OpenFL and HaxeUI are not backed by big corporations like React/Angular</li>
			<li>OpenFL “Graphics” class is not GPU accelerated.</li>
		</ul>
	</div>
	<div style="clear:both"></div>
</div>

## The Decision

The Haxe/OpenFl/HaxeUI method seemed the be the best option, however, deep testing was needed before the port could even begin.

A double pronged test approach was decided upon: migrate an existing open source AS3 project and perform various tests of HaxeUI’s layout capabilities.

### AS3 ModestMaps map tiles engine

[Modest Maps](https://github.com/migurski/modestmaps-as3) is the background tile engine for the Flex version of Kaizen and seemed like a good test bed to learn and identify any potential porting glitches.

[As3hx](https://github.com/haxefoundation/as3hx) was used to port AS3 code to Haxe allowing compiler issues from the translated source to be identified and manually fixed - all whilst greatly helping the team to understand the types of errors generated on a smaller, more manageable project.

The final port of ModestMaps to OpenFl can be found on github [here](https://github.com/mmauri/modestmaps-openfl). The performance of the WebGL version can also be seen [here](https://mmauri.github.io/).

### Flex MXML to HaxeUI xml

The team was tasked with porting the MXML template of the main view to the HaxeUI format in order to better understand the differences between them. Certain obstacles were encountered regarding some custom navigation panels though with a little effort they could be overcome.

The porting of MXML templates to HaxeUI was identified as one of the toughest parts of the migration but nonetheless something that was certainly possible.


## Ready, Set, Go

Before starting the porting process there were a number of maintenance tasks the team wanted to perform on the existing legacy codebase:

* Dead code elimination
* Moving AS3 untyped arrays to typed AS3 vectors (when possible)
* General code cleanup

All of these steps ultimately allowed the port process to go smoother either because of less code to port to and easier syntax / paradigm equivalences in the AS3 when converting to Haxe.

The backend also needed to be updated from .NET Fluorine/AMF to JSON making communication with Haxe far simpler and adding a new .Net facade class for REST based JSON message interchange.

On the Haxe side, it was merely a new helper method to handle and manage every REST call to the new backend facade.

The legacy AS3 codebase was now in a state where the as3hx converter could be used efficiently. The converter was not without issues, but the team knew what needed to be fixed manually with the previous experience porting ModestMaps.

Some of the issues that were overcome (manually) that as3hx introduced include:

* Fix generated Dynamic data types to correct types (where possible)
* Remove Reflection usage as much as possible
* Removing unneeded (and dangerous) try/catch blocks

A performance issue relating to mapping polygons was also encountered because of the OpenFl Graphics software renderer and the maps subsystem was eventually moved to [LeafletJS](http://leafletjs.com/).

This solution created a few issues regarding integrating WebGL contexts into the DOM that had to be overcome.

Changing the maps engine also had the side effect on the backend processes that generate the map data, in that they needed to be updated to use the more standard and verbose GeoJSON format.

When it came to the porting MXML to HaxeUI templates, Ian Harrigan (author of HaxeUI) was hired to give the team a quick start and some training, eventually enabling the team to convert any remaining templates.

Most of the work was simply to check and translate code as the templating syntax between Flex and HaxeUI was very close. Certain mismatches were identified, however, after clarifications were made porting templates became relatively a straightforward task.

Some of the main issues identified whilst translating MXML were:

* Labels: tweaks and workarounds to make them look correct (this was an OpenFL issue that was eventually resolved)
* Performance while resizing listviews with lots of elements.

## Final outcome

Using Haxe/OpenFl/HaxeUI worked really well in our scenario. There was a huge saving on time and developers learning curve.

Had the application been converted to JS an estimate of a year for porting plus another 6 months to stabilize code would not have been unrealistic.

Going via the Haxe/OpenFL/HaxeUI route meant from start to production was a mere 4 months.

The team managed to leverage their existing Flex background without the need to write lots of new code, which in turn would have required more extensive testing before going to production.

As added bonuses the application size reduced (1MB vs 1.9MB) and feels faster than the former Flex based app.
