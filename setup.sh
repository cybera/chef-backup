#!/bin/bash

# Get the canonical path to the directory containing the script (following any links to the source file)
if [[ -z $(readlink $0) ]]; then
        TARGET=$0
else
        TARGET="$(dirname $0)/$(readlink $0)"
fi
SOURCE_DIR=$(cd $(dirname $TARGET); pwd)

# Make a fresh bin directory in the same directory as this script
if [[ -d $SOURCE_DIR/bin ]]; then
	rm -r $SOURCE_DIR/bin
fi
mkdir $SOURCE_DIR/bin

# Check if we're using Chef 10.x (which uses CouchDB). Set the VERSION_DIR appropriately.
COUCHDB_VERSION=$(couchdb -V 2>/dev/null | grep -E "couchdb - Apache CouchDB" | sed "s/[^0-9\.]*//")
if [[ -n $COUCHDB_VERSION ]]; then
	CHECK_CHEF_10=$(curl $(cat /var/lib/couchdb/$COUCHDB_VERSION/couch.uri)"_all_dbs" 2>/dev/null | grep chef)
fi

if [[ -z $CHECK_CHEF_10 ]]; then
	VERSION_DIR=chef-11
else
	VERSION_DIR=chef-10
fi

# Make our symbolic links to the version specific scripts off of the base directory
for f in $SOURCE_DIR/$VERSION_DIR/bin/*
do
	(cd $SOURCE_DIR/bin; ln -s ../$VERSION_DIR/bin/$(basename $f) $(basename $f))
done

# Info on installing to /usr/local/bin via the stow package
echo "If you have stow installed (apt-get install stow), you can create links in /usr/local via:"
echo
if [[ "$(dirname $SOURCE_DIR)" != "/usr/local/stow" ]]; then
	echo "mv $SOURCE_DIR /usr/local/stow"
fi
echo "cd /usr/local/stow; stow $(basename $SOURCE_DIR)"