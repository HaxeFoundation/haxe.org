haxe.org
========

This is the code base for the <http://haxe.org> website.

## Contributing Content

On the website there is a "Contribute" link on the footer of each page.  Clicking this link will take you to the relevant file in this repository, or the relevant file in the [HaxeManual repository](https://github.com/HaxeFoundation/HaxeManual).

You can then edit using Github's online file editor, and submit a pull request.  You can also fork the repo and edit on your local machine with your preferred text editor, which may be easier for large integrations.

## Issues, bugs and suggestions

If you find a bug, have an issue, suggestion, or want to contribute in some other way, please use the Github Issue Tracker.

Any bugs we will attempt to address promptly.  New content or subjective issues (colours, fonts, marketing material etc) will be considered on a case by case basis.

If you are a designer and want to help freshen up the look of the site, please contact <contact@haxe.org> or <jason.oneil@gmail.com>.  We'd love your input!

## Contributing CSS

Currently the css for the site is in [www/css/style.css](https://github.com/HaxeFoundation/haxe.org/blob/master/www/css/style.css).

We plan to switch back to using HSS at some point in the future to make this easier to maintain.

We currently use the bootstrap 2.3.2 CSS library and the Font Awesome 4.1.0 icon library. 

## Structure

* The code is in `src/`. It uses the ufront library and is structured in an MVC pattern.
* The static assets are in `www/`, and the JS and neko compiles and runs from here also.
* The website-generated content is in `uf-content`.

## Running a local copy

1.  `git clone https://github.com/HaxeFoundation/haxe.org.git haxeorg`
2.  `cd haxeorg`
3.  `haxelib install all` - this will install all dependencies. Please note this may take a while.
4.  `haxelib git markdown https://github.com/dpeek/haxe-markdown.git master src` - we need the development version of the markdown library.
5.  `haxelib install ufront; haxelib run ufront --setup` - setup the "ufront" alias so you don't have to run `haxelib run ufront`
6.  `mkdir dox` - this folder needs to exist for our documentation to compile.
7.  `ufront build` - builds all hxml files, alternatively, run `haxe server.hxml; haxe client.hxml;`
8.  Create a "uf-content" directory, make sure it is writeable by the web server.
9.  `ufront server` - start a "nekotools" server in the `www` directory.
10.  Visit `http://localhost:2987/update/manual/` to prepare the manual content.
11.	Visit `http://localhost:2987/update/site/` to prepare some site content.

These instructions were written on Linux (Ubuntu 12.04), if problems are encountered on other platforms please file an issue so it can be resolved.

## Deploying updates

* Any push or merge to the `HaxeManual` repository will trigger an update of the manual on "haxe.org".  (We follow the `master` branch).
* Running `ufront deploy` (or just `ufront d`) will compile all files and push them to the haxe.org server. You will need your SSH keys added to the server for this to work.  If you added or modified any download content you will need to visit `/update/site/` to trigger some further upgrades.
* We plan to have changes to this repository also trigger automatic updates, but this is not ready just yet, so there may be a delay between pull requests being merged and them being visible on the live site.
