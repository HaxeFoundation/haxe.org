haxe.org
========

[![Build Status](https://travis-ci.org/HaxeFoundation/haxe.org.svg?branch=master)](https://travis-ci.org/HaxeFoundation/haxe.org)

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

0.  `git clone --recursive https://github.com/HaxeFoundation/haxe.org.git haxeorg`
0.  `cd haxeorg`
0.  `haxelib install all` - this will install all dependencies. Please note this may take a while.
0.  `haxelib install ufront; haxelib run ufront --setup` - setup the "ufront" alias so you don't have to run `haxelib run ufront`
0.	`haxelib dev minject submodules/minject/src/` - use dev version of minject, until 2.0.0 is released.
0.	`haxelib dev ufront-mvc submodules/ufront-mvc/` - use dev version of ufront-mvc, until minject:2.0.0 is released.
0.	`haxelib dev ufront-uftasks submodules/ufront-uftasks/` - use dev version of ufront-uftasks, until minject:2.0.0 is released.
0.  `mkdir dox` - this folder needs to exist for our documentation to compile.
0.  `ufront build` - builds all hxml files, alternatively, run `haxe server.hxml; haxe client.hxml;`
0.  Create a "uf-content" directory, make sure it is writeable by the web server.
0.  `ufront server` - start a "nekotools" server in the `www` directory.
0.  Visit `http://localhost:2987/update/manual/` to prepare the manual content.
0. Visit `http://localhost:2987/update/site/` to prepare some site content.

Please note, Haxe 3.1.3 will render some markdown pages incorrectly.  Using a development version of Haxe 3.2 is a workaround for this issue.

These instructions were written on Linux (Ubuntu 14.04), if problems are encountered on other platforms please file an issue so it can be resolved.

## Setting up database for blog

Create a database in MySQL:

	CREATE USER 'haxeorg'@'localhost' IDENTIFIED BY 'mypassword';
	GRANT USAGE ON *.* TO 'haxeorg'@'localhost' IDENTIFIED BY 'mypassword' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
	CREATE DATABASE IF NOT EXISTS `haxeorg`;
	GRANT ALL PRIVILEGES ON `haxeorg`.* TO 'haxeorg'@'localhost';

Create `src/conf/mysql.json`:

	{
		"host": "localhost",
		"port": null,
		"database": "haxeorg",
		"user": "haxeorg",
		"pass": "mypassword",
		"socket": null
	}

Visit `/blog/ufadmin/` and click on "DB Admin" to create and sync each of the required tables.

## Deploying updates

* Any push or merge to this `haxe.org` repository will trigger [TravisCI](https://travis-ci.org/HaxeFoundation/haxe.org) to build and deploy to "haxe.org".
* Any push or merge to the `HaxeManual` repository will trigger an update of the manual on "haxe.org".  (We follow the `master` branch).
* Running `ufront deploy` (or just `ufront d`) will compile all files and push them to the haxe.org server. You will need your SSH keys added to the server for this to work.  If you added or modified any download content you will need to visit `/update/site/` to trigger some further upgrades.
