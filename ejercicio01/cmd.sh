#!/bin/sh
docker run --rm --name my-nginx-container -v $PWD/my-content:/usr/share/nginx/html -d -p 8080:80 nginx
