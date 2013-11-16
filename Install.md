# Install haxe

Install Haxe 3.1 & Neko 2.0

	# this gets latest haxe git for Ubuntu.  Do what you need to for other OS's
	bash <(curl -s https://raw.github.com/jasononeil/OneLineHaxe/master/scripts/linux-ubuntu-1204-haxe-git.sh)

Update haxelib

	sudo haxelib selfupdate

Clone the haxe.org repo, install all dependencies

	git clone https://github.com/jasononeil/haxe.org.git
	cd haxe.org
	haxelib install all

For now we need a fork of minject, until @dpeek releases a new version with my pull request included.  We also need the latest tink_core:

	haxelib git minject https://github.com/jasononeil/minject.git master src/
	haxelib git tink_core https://github.com/haxetink/tink_core.git

Not only that, but tink_macro depends on an exact version dependency of `tink_core`, so it breaks when we try to use the dev version.  GAH.  Need fuzzy version matching in Haxelib.

Change:

	"tink_core": "1.0.0-beta.4"

To: 

	"tink_core": ""

Run ufront setup

	sudo haxelib run ufront --setup

Add your mysql JSON

	cp src/conf/mysql.json.sample src/conf/mysql.json
	nano src/conf/mysql.json  // Edit your details

Compile the site files (in debug mode)

	mkdir out
	mkdir out/js
	mkdir dox
	ufront b --debug

Set up a uf-content directory on the server

	mkdir out/uf-content/
	mkdir out/uf-content/log/
	mkdir out/uf-content/sessions/

Copy the assets

	./runrsync

	# Or copy paste contents of "/assets" into "/out"

Run the server

	ufront s

If we were doing DB stuff, you would go to your address and install tables (but we're not)

	http://jason-samsung-laptop:2987/ufadmin/

Set up a default user:

	ufront task initialSetup jason password

Copy the manual from Simn's github:

	http://jason-samsung-laptop:2987/updatemanual/