#!/usr/bin/perl
#
#  kill_firefox.pl: kill all firefox processes owned by demcaller.
#     Run as demcaller, typically by ssh from a remote host.
#
#     usage: ./kill_firefox.pl
#     Jon Hull -- 11/3/16
#

$cmd = "ps -U demcaller -u demcaller | grep firefox";
@pss = `$cmd`;

foreach my $line (@pss) {
   if ($line =~ /^\s*(\d+)\s+\S+\s+\S+\s+(\S+)/) {
      ($pid,$pscmd) = ($1,$2);
      #print "pid=$pid pscmd=$pscmd c=$line";
      if ($pscmd eq "firefox") {
         $killcmd = "kill -9 $pid";
         print "Killing: $killcmd for ps line: $line";
         $res = `$killcmd`;
      }
   }
}
