#!/usr/bin/perl
#
#  copy_rc_local.pl:
#	Copy rc.local to /etc if the version pulled by git is different
#  to /usr/local/bin on this pc
#	J. Hull -- 9/6/16

use File::Copy;
use File::Compare;
use POSIX qw(strftime);

$srcfile  = "/home/dem/gitproject/client-code/rc.local";
$destfile = "/etc/rc.local";

$dt =  strftime '%Y-%m-%d-%H-%M-%S', localtime();

if (-f $srcfile && compare($srcfile,$destfile)) { # src != dest
   print "$dt: copy_rc_local.pl: copying $srcfile\n";
   if (-e $destfile) {
      move("$destfile","$destfile.PREV") or die("mv $destfile.PREV fail $!");
   }
   copy("$srcfile","$destfile") or die("copy $srcfile $destfile failed $!");
   chmod 0755, $destfile or die("cant change perms on $destfile");
}
else {
  if (-f $srcfile) { print "$dt: copy_usr_local_bin.pl: skip $srcfile\n"; }
}
