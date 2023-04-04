VERSION 0.6
FROM ubuntu:focal
WORKDIR /workspace
RUN apt-get update \
    && apt-get install -qqy --no-install-recommends \
        nodejs \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
ARG HAXE_VERSION=4.2.5

npm-install:
    RUN apt-get update \
        && apt-get install -qqy --no-install-recommends \
            npm \
            make \
            gcc \
            g++ \
        # Clean up
        && apt-get autoremove -y \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/*
    COPY package.json package-lock.json .
    RUN npm i
    SAVE ARTIFACT node_modules
    SAVE ARTIFACT package-lock.json AS LOCAL .

haxelib-install:
    FROM haxe:$HAXE_VERSION
    COPY client.hxml generator.hxml generate.hxml .
    RUN haxelib newrepo
    RUN haxelib install all --always
    SAVE ARTIFACT .haxelib

client.min.js:
    FROM haxe:$HAXE_VERSION
    RUN apt-get update \
        && apt-get install -qqy --no-install-recommends \
            openjdk-11-jre \
        # Clean up
        && apt-get autoremove -y \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/*
    COPY src src
    COPY client.hxml .
    COPY +haxelib-install/.haxelib .haxelib
    RUN haxe client.hxml
    SAVE ARTIFACT client.min.js

generator.js:
    FROM haxe:$HAXE_VERSION
    COPY src src
    COPY views views
    COPY generator.hxml .
    COPY +haxelib-install/.haxelib .haxelib
    RUN mkdir -p bin
    RUN haxe generator.hxml
    SAVE ARTIFACT bin/generator.js AS LOCAL bin/generator.js

generate:
    RUN apt-get update \
        && apt-get install -qqy --no-install-recommends \
            curl \
            ca-certificates \
        # Clean up
        && apt-get autoremove -y \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/*
    COPY manual manual
    COPY www www
    COPY posts posts
    COPY pages pages
    COPY grammars grammars
    COPY downloads downloads
    COPY videos videos

    COPY package.json .
    COPY +npm-install/node_modules node_modules

    COPY sitemap.json people.json .

    COPY +client.min.js/client.min.js out/js/client.min.js
    COPY +generator.js/generator.js bin/generator.js
    RUN node bin/generator.js
    SAVE ARTIFACT out AS LOCAL ./out
