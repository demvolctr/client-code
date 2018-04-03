#
#  autofill_rulegen.py:
#     Given data that describe autofill rules, generate the corresponding
#  text for the prefs.js file.
#
#  When you get new autofill data, edit this file and apply it to 
#  the prefs.js files on the cluster.
#
#     to run: python autofill_rulegen.py
#
#     Jon Hull -- 3/26/18
#

from __future__ import print_function
import re

try:
   f = open('/etc/hostname', 'r')
   hostname = f.read()
   hostnum = re.findall('\d+', hostname )[0]
   #print(hostnum)
except:
   print("couldn\'t open /etc/hostname or it didn't contain a hostnum")

rules = list()

rules = [
{ 't':0, 'n':'^email$', 'v':'ksrivers@comcast.net', 
  's':'www.hubdialer.com', 'c':':' },

{ 't':3, 'n':'^first_time$', 'v':'0', 
  's':'www.hubdialer.com', 'c':':' },

{ 't':0, 'n':'^active_campaigns$', 'v':'11742', 
  's':'www.hubdialer.com', 'c':':' },

{ 't':1, 'n':'^pass_code$', 'v':'222222', 
  's':'www.hubdialer.com', 'c':':' },

{ 't':0, 'n':'^Email$', 'v':'skype%s@demvolctr.org' % (hostnum), 
  's':'phonebank.bluevote.com', 'c':':' },

{ 't':0, 'n':'^VirtualPhoneBankCode$', 'v':'C08352D-920984', 
  's':'www.openvpb.com', 'c':':' },

{ 't':0, 'n':'^Email$', 'v':'skype%s@demvolctr.org' % (hostnum), 
  's':'phonebank.bluevote.com', 'c':':' },

{ 't':1, 'n':'^Password$', 'v':'win2018', 
  's':'phonebank.bluevote.com', 'c':':' }
]

print("user_pref(\"extensions.autofill.rulecount\", %d);" % (len(rules)))

prefix = "user_pref(\"extensions.autofill.rules\", \"{" 
print(prefix, end="")

rnum = 1
for i,r in enumerate(rules):
   print("\\\"r%d\\\":{\\\"t\\\":%d" % (rnum, r['t']), end="")
   print(",\\\"n\\\":\\\"%s\\\"" % (r['n']), end="")
   print(",\\\"v\\\":\\\"%s\\\"" % (r['v']), end="")
   print(",\\\"s\\\":\\\"%s\\\"" % (r['s']), end="")
   print(",\\\"c\\\":\\\"\\\"}",end="")
   if i < len(rules)-1: print(",",end="") 
   else: print("",end="")
   rnum = rnum + 1
   #print(r)

print("}\");");
