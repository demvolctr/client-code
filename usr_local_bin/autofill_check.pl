#!/usr/bin/perl
# 
#  autofill_check.pl:  extract and print the autofill parameters from prefs.js
#
#    usage: 
#    ./autofill_check.pl /home/demcaller/.mozilla/firefox/qw2334433/prefs.js
#
#    J. Hull -- 10/9/16
#

use JSON;
use Data::Dumper;  

$input_json = $ARGV[0];
open $fh, '<', $input_json or die "Can't open file $!";

$json = JSON->new;

while (<$fh>) {
   $linein = $_;
   if (/extensions.autofill.rules\",\s*(.*)\)\;$/) { 
       $json_rules = $1;
       $json_rules =~ s/^"(.*)"$/$1/; # remove leading and trailing quotes
       $json_rules =~ s/\\"/"/g;      # remove backslashes before quotes
       $json_rules =~ s/\\n//g;       # remove backslash n's

       $parsed_json = $json->utf8(1)->decode($json_rules);
       # print Dumper $parsed_json;
       @k = keys %$parsed_json;
       @l = sort {suff($a) <=> suff($b)} @k;
       # print join(" ",@l), "\n";
       foreach $r (@l) {
          $rule = %$parsed_json{$r};
          %subrule = %$rule;
          print "   ", $subrule{s}," ",($subrule{n} =~ /(\w+)\$$/)," ",$subrule{v},"\n";
       }
   }
}

sub suff {
  $_[0] =~ /(\d+)/;
  return($1);
}
