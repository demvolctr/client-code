#!/usr/bin/perl
#
#  customize.pl:  rewrite the prefs.js file on any machine based on its 
#     individual settings.
#
#        Jon Hull -- 10/5/16
#

if ($#ARGV != 0) { print STDERR "Need a machine number on command line!\n"; 
                   exit(1); }

$My_machine = $ARGV[0];


$rules{25} = { 'AREA_CODE'      => '650',
               'PHONE_PREFIX'   => '209',
               'PHONE_SUFFIX'   => '4815',
               'VAN_UID'        => 'CA2016DVC25',
               'VAN_PASSWORD'   => '2016victory',
               'SKYPE_UID'      => 'skype25@demvolctr.org',
               'SKYPE_PASSWORD' => 'Victory2016',
               'SC_USER'        => 'SantaClaraVol25',
               'SC_PASSWORD'    => 'Victory!',
               'MACHINE_NUMBER' => '25'
         };

$rules{26} = { 'AREA_CODE'      => '650',
               'PHONE_PREFIX'   => '209',
               'PHONE_SUFFIX'   => '4832',
               'VAN_UID'        => 'CA2016DVC25',
               'VAN_PASSWORD'   => '2016victory',
               'SKYPE_UID'      => 'skype26@demvolctr.org',
               'SKYPE_PASSWORD' => 'Victory2016',
               'SC_USER'        => 'SantaClaraVol26',
               'SC_PASSWORD'    => 'Victory!',
               'MACHINE_NUMBER' => '26'
         };

$Matches_found    = 0;
$Matches_expected = 0;

$Expected_keys    = 9;  # number of keys in each rule minus one

@key_arr = (keys $rules{$My_machine});
$Found_keys = $#key_arr;

if ($Found_keys != $Expected_keys) {
   print STDERR "Found $Found_keys but expected to find $Expected_keys\n";
   print STDERR "  Looks likes we have no info about machine num=$My_machine\n";
   exit(2);
}

print STDERR "Customizing prefs.js for machine number $My_machine\n";

print STDERR "Making the following substitutions:\n";
for $mykey (sort @key_arr) {
   print STDERR "    $mykey => $rules{$My_machine}{$mykey}\n";
}

while (<STDIN>) {
  if (/autofill.rules/ || /\"browser.startup.homepage\"/) { 
      for $mykey (@key_arr) {
         rewrite($mykey, $rules{$My_machine}{$mykey});
      }
  }
  print;
}

print STDERR "Found $Matches_found matches, expected to find $Matches_expected\n";
print STDERR "  Note: number found should be half number expected because of how rewrite() is being called\n";

sub rewrite {
  my($from,$to) = @_;
  # print STDERR "rewriting from=$from to=$to\n";
  if (s/$from/$to/) { ++$Matches_found; }
  ++$Matches_expected;
}
