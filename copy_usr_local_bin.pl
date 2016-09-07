#!/usr/bin/perl
#
#  copy_usr_local_bin.pl:
#	Copy the contents of the git version of /usr/local/bin 
#  to /usr/local/bin on this pc
#	J. Hull -- 9/6/16

use File::Copy;
use File::Compare;
use POSIX qw(strftime);

$Src  = "/home/dem/gitproject/client-code/usr_local_bin";
$Dest = "/usr/local/bin";

$dt =  strftime '%Y-%m-%d-%H-%M-%S', localtime();

opendir(my $dh, $Src) || die "Can't open $Src: $!";
while (readdir $dh) {
   $file = $_;
   if ($file  =~ /.PREV$/) { next; } # skip these files
   $srcfile  = "$Src/$file";
   $destfile = "$Dest/$file";
   if (-f $srcfile && compare($srcfile,$destfile)) { # src != dest
      print "$dt: copy_usr_local_bin.pl: copying $srcfile\n";
      move("$destfile","$destfile.PREV") or die("mv $destfile.PREV failed $!");
      copy("$srcfile","$destfile") or die("copy $srcfile $destfile failed $!");
      chmod 0755, $destfile;
   }
   else {
     print "$dt: copy_usr_local_bin.pl: skippping $srcfile\n";
   }
}
closedir $dh;
