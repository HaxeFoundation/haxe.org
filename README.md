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

## Running a local copy for development

The server has to be compiled with Haxe 3.2.1. It can be run in Apache using mod_neko / mod_tora.

Currently using [Docker](https://www.docker.com/) is the simpliest way to build and run the server. It doesn't require setting up Apache or MySQL since everything is included in the container. We would recommand to use the [Docker Platform](https://www.docker.com/products/docker) instead of the Docker Toolbox.

To start, run:

```
docker-compose up -d
```

The command above will copy the server source code and website resources into a container, compile it, and then start Apache to serve it.  To view the website, visit `http://localhost/` (or `http://$(docker-machine ip)/` if the Docker Toolbox is used).

Since the containers will expose port 80 (web) and 3306 (MySQL), make sure there is no other local application listening to those ports. In case there is another MySQL instance listening to 3306, we will get an error similar to `Uncaught exception - mysql.c(509) : Failed to connect to mysql server`.

When the server runs for the first time, we need to initialize a few things by visiting the pages as follows:
 * [http://localhost/update/manual/](http://localhost/update/manual/) for preparing the manual content.
 * [http://localhost/update/site/](http://localhost/update/site/) for preparing some site content.
 * [http://localhost/blog/ufadmin/](http://localhost/blog/ufadmin/) and click on "DB Admin" to create and sync each of the required tables.

To stop the server, run:
```
docker-compose down
```

If we modify any of the server source code or website resources, we need to rebuild the image and replace the running container by issuing the commands as follows:
```
docker-compose build
docker-compose up -d
```

## Deploying updates

* Any push or merge to this `haxe.org` repository will trigger [TravisCI](https://travis-ci.org/HaxeFoundation/haxe.org) to build and deploy to "haxe.org".
* Any push or merge to the `HaxeManual` repository will trigger an update of the manual on "haxe.org".  (We follow the `master` branch).
