# Usage
# 
# 1. Build it: docker build -t haxe.org .
#
# 2. Create .env file with content as follows:
# HAXEORG_DB_HOST=localhost
# HAXEORG_DB_PORT=3306
# HAXEORG_DB_USER=user
# HAXEORG_DB_PASS=password
#
# 3. Run it: docker run -p 2000:80 --env-file .env haxe.org
#
# 4. Visit: http://$(docker-machine ip):2000/update/site/
#
# 5. Visit: http://$(docker-machine ip):2000/update/manual/
#

# https://hub.docker.com/r/andyli/tora/
FROM andyli/tora

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
		git \
		default-jdk \
		libmagickcore-dev \
		libmagickwand-dev \
	&& rm -r /var/lib/apt/lists/*

COPY *.hxml /src/

WORKDIR /src

RUN haxelib setup /haxelib
RUN yes | haxelib install all
RUN yes | haxelib install ufront
RUN yes | haxelib git closure https://github.com/jasononeil/closure.git patch-1

# install dev version of ufront-mvc to get unreleased feature
RUN git clone https://github.com/ufront/ufront-mvc.git
WORKDIR /src/ufront-mvc
RUN git checkout d7b9066f4405358aaa0e797ec7b7656c4daf46c4
RUN haxelib dev ufront-mvc .

RUN ln -s `haxelib path ImageMagick | sed "2q;d"`ndll/Linux64/nMagick.ndll /usr/lib/neko/nMagick.ndll

COPY www /src/www/
COPY src /src/src/
RUN git clone --depth 1 https://github.com/ufront/ufblog.git /src/submodules/ufblog

RUN rm -rf /var/www/html
RUN ln -s /src/www /var/www/html

WORKDIR /src

RUN mkdir /var/www/uf-content
RUN mkdir doc
RUN haxelib run ufront build

EXPOSE 80