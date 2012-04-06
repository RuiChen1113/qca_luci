#!/bin/sh

PATTERN=$1

[ -z "$PATTERN" ] && PATTERN='*.pot'

for lang in $(cd po; echo ?? ??_??); do
	for file in $(cd po/templates; echo $PATTERN); do
		if [ -f po/templates/$file -a ! -f "po/$lang/${file%.pot}.po" ]; then
			msginit --no-translator -l "$lang" -i "po/templates/$file" -o "po/$lang/${file%.pot}.po"
			svn add "po/$lang/${file%.pot}.po"
		fi
	done
done
