haxe.org
========

[![Build Status](https://travis-ci.org/HaxeFoundation/haxe.org.svg?branch=staging)](https://travis-ci.org/HaxeFoundation/haxe.org)
[![Code Climate](https://codeclimate.com/github/HaxeFoundation/haxe.org/badges/gpa.svg)](https://codeclimate.com/github/HaxeFoundation/haxe.org)
[![Issue Count](https://codeclimate.com/github/HaxeFoundation/haxe.org/badges/issue_count.svg)](https://codeclimate.com/github/HaxeFoundation/haxe.org)

This is the code base for the <https://haxe.org> website.

## Contributing Content

On the website there is a "Contribute" link on the footer of each page.  Clicking this link will take you to the relevant file in this repository, or the relevant file in the [HaxeManual repository](https://github.com/HaxeFoundation/HaxeManual).

You can then edit using Github's online file editor and submit a pull request. You can also fork the repo and edit on your local machine with your preferred text editor, which may be easier for large integrations.

## Issues, bugs and suggestions

If you find a bug, have an issue, suggestion, or want to contribute in some other way, please use the Github Issue Tracker.

Any bugs we will attempt to address promptly. New content or subjective issues (colours, fonts, marketing material etc) will be considered on a case by case basis.

If you are a designer and want to help freshen up the look of the site, please open an issue or contact <contact@haxe.org>. We'd love your input!

## Contributing CSS

Currently the css for the site is in [www/css/style.css](https://github.com/HaxeFoundation/haxe.org/blob/staging/www/css/style.css).

We currently use the bootstrap 2.3.2 CSS library and the Font Awesome 4.1.0 icon library.

## Structure

* The pages content are in `pages/`, in either html or markdown.
* The blog posts are in `posts/` in markdown, and their images are in `www/img/blog/$name/`.
* The release messages for the haxe versions are in `releaseNotes/`, in markdown.
* The code is in `src/`. The generations calls `src/Main.hx` and the javascript `src/Client.hx`.
* The views are in `views/` and uses the [haxe template syntax](https://haxe.org/manual/std-template.html) with foreach disabled.
* The static assets are in `www/`.

## Running a local copy for development

The haxe.org website was designed to be easy to generate, to run a local copy follow these steps:

### Requirements

* Haxe
* Haxelib
* Neko
* cUrl

### Setting up

* Install the dependencies `haxelib install all` in the root directory.
* Update submodule dependencies `git submodule init && git submodule update`
* Generate the website by running `haxe generate.hxml`.

The website is now available in the `out/` folder, you can launch it with `nekotools server -d out` and access it at `http://localhost:2000/`.

## Deploying updates

* Any push or merge to the `staging` branch will trigger [TravisCI](https://travis-ci.org/HaxeFoundation/haxe.org) to build and deploy to "staging.haxe.org".
* Any push or merge to the `master` branch will trigger [TravisCI](https://travis-ci.org/HaxeFoundation/haxe.org) to build and deploy to "haxe.org".
