#!/bin/bash
#
#  rewrite_autofill.bash -- add a new set of autofill passwords
#     to prefs.js.  The script uses ls -t to find the newest prefs.js
#     because there can be multiple firefox/*default directories
#     for some reason.  We only want to modify the most recent.
#
#     N.B.:   before running this script, copy a new version of
#             autofill_rulegen.py to /home/demcaller
#             This script executes that file.
#
#     usage:  ./rewrite_autofill.bash 
#
#     run this as demcaller
#
#     Jon Hull -- 4/2/18

PREFS_JS=`ls -t /home/demcaller/.mozilla/firefox/*default*/prefs.js|head -1`
echo $PREFS_JS

echo "shutdown firefox"
/usr/local/bin/close_firefox.bash

echo "remove extensions.autofill rules from $PREFS_JS"
sed -i.bak /extensions.autofill.rulecount/d $PREFS_JS
sed -i /extensions.autofill.rules/d $PREFS_JS

echo "add new rules with /usr/local/bin/autofill_rulegen.py"
python /home/demcaller/autofill_rulegen.py >> $PREFS_JS

echo "restart firefox"
/usr/local/bin/start_firefox.bash
