# Install haxe

Install Haxe 3.0 & Neko 2.0

	# this works for Ubuntu.  Do what you need to for other OS's
	bash <(curl -s https://raw.github.com/jasononeil/OneLineHaxe/master/scripts/linux-ubuntu-1204-haxe3.sh)

Update haxelib

	sudo haxelib selfupdate

Clone the ufblog repo, install all dependencies

	git clone https://github.com/jasononeil/ufblog.git
	haxelib install all

Run ufront setup

	sudo haxelib run ufront --setup

Add your mysql JSON

	cp src/conf/mysql.json.sample src/conf/mysql.json
	nano src/conf/mysql.json  // Edit your details

Compile the site files (in debug mode)

	mkdir out
	mkdir out/js
	ufront b -d

Set up a uf-content directory on the server

	mkdir out/uf-content/
	mkdir out/uf-content/log/
	mkdir out/uf-content/sessions/

Run the server

	ufront s

Go to your address and install tables

	http://jason-samsung-laptop:2987/ufadmin/

Set up a default user:

	ufront task initialSetup jason password