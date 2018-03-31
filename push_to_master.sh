#!/bin/sh
hugo
rsync -avHPx --delete docs/* root@jdieter.net:/var/www/html/jdieter/
ssh root@jdieter.net "chown root.root /var/www/html/jdieter/* -Rf; chmod go-w /var/www/html/jdieter/* -R"
