#!/usr/bin/perl
#
#  copy_dotmozilla.pl:
#	Copy and customize dotmozilla to ~demcaller/.mozilla
#	J. Hull -- 10/5/16

use File::Copy::Recursive qw(dircopy);
use File::Compare;
use POSIX qw(strftime);

$srcdir  = "/home/dem/gitproject/client-code/dotmozilla";
$destdir = "/home/demcaller/dotmozilla";

$dt =  strftime '%Y-%m-%d-%H-%M-%S', localtime();

#if (-f $srcfile && compare($srcfile,$destfile)) { # src != dest
   print "$dt: copy_dotmozilla.pl: copying $srcdir\n";
   #if (-e $destfile) {
      #move("$destfile","$destfile.PREV") or die("mv $destfile.PREV fail $!");
   #}
   dircopy("$srcdir","$destdir") or die("dircopy $srcdir $destdir failed $!");
   # chmod 0755, $destfile or die("cant change perms on $destfile");
#}
#else {
  #if (-f $srcfile) { print "$dt: copy_usr_local_bin.pl: skip $srcfile\n"; }
#}


