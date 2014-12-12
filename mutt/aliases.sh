#!/bin/sh

MESSAGE=$(cat)

# There might be an error down there.
# AWK='{$1=""; if (NF == 3) {print "alias" $0;} else if (NF == 2) '
# AWK+='{print "alias" $0 $0;} else if (NF > 3) {print "alias", '
# AWK+='tolower($(NF-1))"-"tolower($2) $0;}}'
# NEWALIAS=$(echo "${MESSAGE}" | grep ^"From: " | sed s/[\,\"\']//g | awk $AWK)

NEWALIAS=$(echo "${MESSAGE}" | grep ^"From: " | sed s/[\,\"\']//g | awk '{$1=""; if (NF == 3) {print "alias" $0;} else if (NF == 2) {print "alias" $0 $0;} else if (NF > 3) {print "alias", tolower($(NF-1))"-"tolower($2) $0;}}')

if grep -Fxq "$NEWALIAS" $HOME/.mutt/aliases.txt; then
    :
else
    echo "$NEWALIAS" >> $HOME/.mutt/aliases.txt
fi

echo "${MESSAGE}"
