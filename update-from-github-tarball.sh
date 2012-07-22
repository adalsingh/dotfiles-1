#!/bin/sh
# Update dotfiles from GitHub tarball

# Exit on any command failures
set -e

DOTFILESDIRREL=$(dirname $0)
cd $DOTFILESDIRREL
if [ -e .git ]
then
	echo "This dotfiles directory was checked out from Git so I won't update it."
	echo "If you want it updated from a tarball anyway, please delete .git first."
	exit 1
fi

OUTFILE="dotfiles.tar.gz"
which wget >/dev/null && DOWNLOAD="wget --no-check-certificate --output-document=$OUTFILE"
[ -z "$DOWNLOAD" ] && which curl >/dev/null && DOWNLOAD="curl --location --output $OUTFILE"
[ -z "$DOWNLOAD" ] && echo "Could not find wget or curl" && exit 1

$DOWNLOAD https://github.com/mikemcquaid/dotfiles/tarball/master
tar --strip-components=1 -z -x -v -f dotfiles.tar.gz
rm dotfiles.tar.gz