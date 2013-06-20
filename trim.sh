#!/bin/sh

#
# Copyright 2012 Todd Brandt <tebrandt@frontier.com>
#
# This program is free software; you may redistribute it and/or modify it
# under the same terms as Perl itself.
#    utility to set up development windows quickly
#    Copyright (C) 2012 Todd Brandt <tebrandt@frontier.com>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

printHelp() {
    echo ""
    echo "USAGE: trim.sh <args> filefilter"
    echo "  Arguments:"
    echo "    -e : list all file exts under current path"
    echo "    -v : inverse search for filefilter"
    echo "    -r : remove files matching the search"
    echo ""
    exit
}

onError() {
    echo ""
    echo "ERROR: $1"
    printHelp
}

findAllExts() {
    DIR=$1
    find $DIR ! -type d -name \*.\* | sed "s/.*\.//" | sort | uniq | tr '\n' ' '
    echo ""
}

if [ $# -le 0 ]; then
    printHelp
    exit
fi

for last; do true; done
FILTER=$last
INVERSE=0
REMOVE=0

if [ "$FILTER" = "-e" ]; then
    findAllExts $PWD
    exit
fi

while [ "$1" ] ; do
    if [ "$1" = "$FILTER" ]; then
        break
    fi
    case "$1" in
    -v)
        INVERSE=1
    ;;
    -r)
        REMOVE=1
    ;;
    -e)
        findAllExts $PWD
        exit
    ;;
    *)
        onError "Unrecognized argument $1"
    ;;
    esac
    shift
done

if [ $REMOVE -eq 1 ]; then
    echo ""
    echo "You've selected the REMOVE option, this will delete any matching files."
    echo "Backups of all deleted files will be placed in /tmp/trim/"
    echo ""
    echo -n "Are you sure you want to do this? (yes/no): "
    read ANSWER
    if [ "$ANSWER" != "yes" ]; then
        echo "Aborting..."
        exit
    fi
fi

echo ""
echo " Invert Search : $INVERSE"
echo "Remove Matches : $REMOVE"
echo "   File Filter : $FILTER"
echo ""

TMP=/tmp/trim
if [ $INVERSE -eq 0 ]; then
    LIST=`find $PWD ! -type d -name "$1" | sed "s/ /|/g"`
else
    LIST=`find $PWD ! -type d ! -name "$1" | sed "s/ /|/g"`
fi

for fileline in $LIST
do
    file=`echo "$fileline" | sed "s/|/ /g"`
    echo $file
    if [ $REMOVE -eq 1 ]; then
        DIR=`echo $file | sed "s/\(.*\)\/.*/\1/"`
        mkdir -p "$TMP$DIR"
        cp "$file" "$TMP$DIR"
        rm "$file"
    fi
done
