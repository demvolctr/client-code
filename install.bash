#!/bin/bash
#
#  install.bash:
#    Called once at startup in /etc/rc.local.
#    1.  spin on network interface first, then github
#    2.  if both are alive, then pull and update
#
#	J.Hull -- 9/6/16
#

test_host() {
   for i in `seq 1 20`;
   do
      ping -q -c 1 $1 > /dev/null
      let exit_status=$?
      if [ $exit_status -eq 0 ]; then echo "found $1 i=$i"; return 0; fi;
      sleep 10
   done
   return 1
}

echo `/bin/date` "Starting to install software updates and do health checkup"

test_host "127.0.0.1"
let host_there=$?
if [ $host_there -ne 0 ]; then echo "no net interface"; exit 1; fi

test_host "github.com"
let host_there=$?
if [ $host_there -ne 0 ]; then echo "no github.com"; exit 1; fi

echo `/bin/date` "Starting pull and install"

cd /home/dem/gitproject/client-code
sudo --user=dem git pull https://github.com/demvolctr/client-code master

# let pull_result=$?
# if [ $pull_result -eq 0 ]; then
#    echo "Nothing changed since last reboot"
 #   exit 0
# fi

/home/dem/gitproject/client-code/copy_usr_local_bin.pl
/home/dem/gitproject/client-code/copy_rc_local.pl

/usr/local/bin/install_pkgs

echo "Starting health checkup"
/usr/local/bin/health_checkup >& /home/dem/gitproject/health_report
echo "Finished health checkup"

# let machine_num=`/usr/local/bin/echo_host`
# echo "machine_num=" $machine_num
# if [ $machine_num -eq 25 ] || [ $machine_num -eq 26 ]; then
  # echo `/bin/date` ":updating dotmozilla for machine " $machine_num
  # sudo --user=demcaller /home/dem/gitproject/client-code/copy_dotmozilla.pl
  # cd /home/demcaller/dotmozilla/firefox/????????.default
  # sudo --user=demcaller /usr/local/bin/customize.pl $machine_num < prefs.js > newprefs.js
  # sudo --user=demcaller mv prefs.js oldprefs.js
  # sudo --user=demcaller mv newprefs.js prefs.js
  # echo `/bin/date` ":finished customizing dotmozilla"
# fi

echo `/bin/date` "Finished installing updates and performing health checkup"

