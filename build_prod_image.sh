#!/usr/bin/env sh

docker build --build-arg appuser=devcampportfolio --build-arg apphome=/home/devcampportfolio/app --build-arg railsenv=production --tag devcampportfolio_website .

