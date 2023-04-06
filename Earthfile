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
    SAVE ARTIFACT --keep-ts package-lock.json AS LOCAL .

haxelib-install:
    FROM haxe:$HAXE_VERSION
    WORKDIR /workspace
    COPY client.hxml generator.hxml generate.hxml .
    RUN haxelib newrepo
    RUN haxelib install all --always
    SAVE ARTIFACT .haxelib

client.min.js:
    FROM haxe:$HAXE_VERSION
    WORKDIR /workspace
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
    WORKDIR /workspace
    COPY src src
    COPY views views
    COPY generator.hxml .
    COPY +haxelib-install/.haxelib .haxelib
    RUN mkdir -p bin
    RUN haxe generator.hxml
    SAVE ARTIFACT --keep-ts bin/generator.js AS LOCAL bin/generator.js

generate:
    RUN apt-get update \
        && apt-get install -qqy --no-install-recommends \
            curl \
            ca-certificates \
            inkscape \
            fonts-noto-core \
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
    RUN --no-cache node bin/generator.js
    SAVE ARTIFACT --keep-ts out AS LOCAL ./out

deploy:
    FROM haxe:$HAXE_VERSION
    WORKDIR /workspace
    RUN apt-get update \
        && apt-get install -qqy --no-install-recommends \
            awscli \
        # Clean up
        && apt-get autoremove -y \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/*
    COPY --keep-ts +generate/out out
    COPY src src
    COPY downloads downloads
    COPY deploy.hxml .
    RUN --no-cache ls -lah
    RUN --no-cache \
        --mount=type=secret,id=+secrets/.envrc,target=.envrc \
        . ./.envrc \
        && haxe deploy.hxml
