#!/usr/bin/perl
#
#  rewrite_prefs.pl:  Given and old password and a new password 
#    as command line arguments, replace the old password with the
#    new password in firefox's prefs.js.  This is only applied 
#    on the "extensions.autofill.rules" line.
#
#    This script is placed in /usr/local/bin on the host whose 
#    password is to be changed and it is run as "demcaller" so
#    the permissions are correct.  It is typically called by an
#    ssh script from another laptop on the 103 subnet.
#
#    usage:  /usr/local/bin/rewrite_prefs.pl old_pw new_pw
#
#    Jon Hull -- 11/2/16
#

if ($#ARGV != 1) { 
   print STDERR "need from and to\n";
   exit(1);
}

$from = $ARGV[0];
$to   = $ARGV[1];
print "$from $to\n";

use URI::Escape;
$from_password = quotemeta( uri_unescape($ARGV[0]) );
$to_password   = uri_unescape($ARGV[1]);
print "$from_password $to_password\n";

@dirs = glob('/home/demcaller/.mozilla/firefox/*.default');
if ($#dirs != 0) {
   printf STDERR "Found %d profile directories, giving up!!\n", $#dirs;
   exit(1);
}
chdir("$dirs[0]") || die "cant cd";

open(FS, "prefs.js") || die "cant open prefs.js";
$cnt = 0;
while (<FS>) {
  if (/extensions.autofill.rules/ && /\"$from_password\\/) { $cnt = $cnt + 1; }
}
close(FS) || die "cant close prefs.js";
print "number of passwords found=$cnt\n";

if ($cnt != 1) { print STDERR "Found $cnt passwords.  Quitting.\n"; exit(2); }

open(FS, "prefs.js")        || die "cant open prefs.js";
open(OUTFS, ">newprefs.js") || die "cant open newprefs.js";

while (<FS>) {
  if (/extensions.autofill.rules/ && /\"$from_password\\/) { 
     s/\"$from_password\\/\"$to_password\\/; 
  }
  print OUTFS;
}

close(FS)    || die "cant close prefs.js";
close(OUTFS) || die "cant close newprefs.js";

rename("prefs.js", "oldprefs.js") || die "cant rename to oldprefs.js";
rename("newprefs.js", "prefs.js") || die "cant rename to prefs.js";
