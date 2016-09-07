#!/bin/bash
#
# spin on network interface first, then github
#

test_host() {
   for i in `seq 1 10`;
   do
      ping -q -c 1 $1 > /dev/null
      let exit_status=$?
      if [ $exit_status -eq 0 ]; then echo "found $1 i=$i"; return 0; fi;
      sleep 10
   done
   return 1
}

if (test_host "127.0.0.1" -eq 0); then
   if (test_host "github.com" -eq 0) ; then exit 0; fi
fi
exit 1

