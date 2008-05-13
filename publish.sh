#!/bin/sh

if [ "x$2" == "x" ]; then
    echo "Usage: $0 plugin_name version"
    exit 1
fi

PLUGIN=$1
VERSION=$2
BASEURL=$( cat ~/.wpplugins )

if [ "x$BASEURL" == "x" ]; then
    echo "You need to write where to upload the plugin in the ~/.wpplugins file"
    echo "Example:"
    echo "  echo myserver.example.com:public_html/plugins/ > ~/.wpplugins"
    exit 3
fi

if [ ! -d "wp-content" ]; then
    echo "You need to run this script from the wordpress base directory"
    exit 2
fi

pushd wp-content/plugins/$PLUGIN
perl -pe "s/Version: .*/Version: $VERSION/" -i $PLUGIN.php
perl -pe "s/^define\(${PLUGIN}_version,.*/define(${PLUGIN}_version, '$VERSION');/" -i $PLUGIN.php

git add $PLUGIN.php
echo "Diff to commit"
git diff --cached
echo "Press return to accept or Ctrl-C to cancel"
read foo
git commit -m "Version bump to $VERSION"
git tag -s v$VERSION -m "Version $VERSION"
git push --mirror
git archive --format=tar --prefix=$PLUGIN/ v$VERSION | gzip -c9 > $PLUGIN-$VERSION.tar.gz
tar tzvf $PLUGIN-$VERSION.tar.gz
scp $PLUGIN-$VERSION.tar.gz $BASEURL/$PLUGIN/
popd
