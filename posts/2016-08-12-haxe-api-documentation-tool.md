title: Dox 1.1 released, our documentation tool
author: markknol
description: Our official documentation tool dox has been updated and released on haxelib. The release contains theme related updates and easier customization. 
published: true
tags: announcements
disqusID: 19
---

> Our official documentation tool [dox](https://github.com/HaxeFoundation/dox) has been updated and released on [haxelib](http://lib.haxe.org/p/dox).

<style>.article-view img {border:1px solid #eee;box-shadow:0 0 10px #eee; border-radius:5px}</style>

_You can install or update dox using haxelib:_
```
haxelib install dox
```

## Personalize documentation for your brand

We've seen many projects using dox to generate API documentation. This is great because documentation is part of a project success. That's why we continued improving the documentation tool.

Now some projects used the old themes, which we admit wasn't very pretty, other already start using the newer one since this is much greater. We've seen some developers copy/pasted the theme files and changed it to their needs. That works, but does not allow to update the theme with the latest features. With this release it is possible to only update the parts you actually need. 

## Default theme is more configurable

First of all, maybe you don't even need a custom theme anymore. 
The default theme has settings (theme colors, logo, website url, title, description) to customize it to your need. Go for a [custom theme](https://github.com/HaxeFoundation/dox/wiki/Custom-themes), if you need more expressive customization.

The following examples demonstrate what you can tweak using the default theme settings:

#### Example - no settings
```
haxelib run dox -i bin/xml -o bin/api-minimal
```
![image](17349508/bf57910c-591e-11e6-8c9a-0299772a59ac.png)


#### Example - themeColor and title
```
haxelib run dox -i bin/xml -o bin/api-basic --title "API documentation" -D themeColor 0x1294f6
```
![image](da6adefe-591e-11e6-9ea0-06b7d82bed3b.png)


#### Example - themeColor, textColor, title, website and logo
```
haxelib run dox -i bin/xml -o bin/api-advanced --title "Great API documentation" -D version "1.0.0 beta" -D website "http://haxe.org" -D logo "https://placehold.it/300x75/3c4db7" -D themeColor 0x1294F6 -D textColor 0x9BF1FB -D description "Just a perfect day to learn all about this framework!" -D source-path https://github.com/HaxeFoundation/haxe/blob/development/std/ -ex my.secret.pack
```
![image](8d230e8c-591e-11e6-8a01-5fa3d0eb5062.png)

A demonstration of a real project with the default theme with custom settings is [hxnodejs](http://haxefoundation.github.io/hxnodejs/js/Node.html). It is automatically published online using [Travis CI instructions](https://github.com/HaxeFoundation/hxnodejs/blob/master/.travis.yml#L18-L21) on Github Pages.

## But we want a custom theme

Yes, we wanted that too! The official [haxe API documentation](http://api.haxe.org) uses a custom theme too. But it "inherits" from the default theme. This allows to overwrite specific templates of a parent theme. Check out how the [Haxe API documentation theme files](https://github.com/HaxeFoundation/dox/tree/master/themes/haxe_api) are structured. In the _config.json_ we tell its `parentTheme` is the default theme. From this point, we only changed the top bar, footer and package description for our specific needs.

## Dox is documented

We've documented how you can work with dox in the [dox wiki](https://github.com/HaxeFoundation/dox/wiki). This also contains a overview of [all arguments/settings](https://github.com/HaxeFoundation/dox/wiki/Commandline-arguments-overview) you can use with dox.

> We encourage everyone to update to the latest documentation theme, it is easier to maintain and contains great improvements over the previous release. 

As always, feel free to [open a ticket](https://github.com/HaxeFoundation/dox/issues) on the GitHub for suggestions or bugs. 

---

When you used the latest theme in your project, leave a link in the comments, we are looking forward to see it.
