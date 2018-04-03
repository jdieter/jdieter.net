#!/bin/sh
mv docs docs.old
hugo
if [ "$?" -ne "0" ]; then
    exit 1;
fi
cd docs
chmod go-w ./ -R
find ./ -exec ../set_date.sh "../docs.old/{}" "{}" ';'
cd ..
rm -rf docs.old
rsync -rlptDvHPx --delete docs/ root@jdieter.net:/var/www/html/jdieter/
ssh root@jdieter.net "chown root.root /var/www/html/jdieter/* -Rf; chmod go-w /var/www/html/jdieter/* -R"
