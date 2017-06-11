#! /usr/bin/python

import sys

if len(sys.argv) != 4:
  print "Usage : split2.py divisor input base"
  sys.exit(1)

divisor  = int(sys.argv[1])
input    = sys.argv[2]
base     = sys.argv[3]

c_start  = 0
c_end    = 0
quotient = 0
toomuch  = 0
total    = 0
part     = 0
fplist   = []

f = open(input,"r")
for line in f:
  total += 1
f.close()

quotient = total / divisor
toomuch  = total % divisor

for no in range(0, divisor):
  f = open("%s%02d"%(base,no),"w")
  fplist.append(f)

cnt = 0
f = open(input,"r")
for line in f:
  cnt += 1
  if cnt > c_end:
    if part < toomuch:
      c_start = c_end + 1
      c_end   = c_start + quotient
    else:
      c_start = c_end + 1
      c_end   = c_start + quotient - 1
    print "Part[%d] Start[%08d] End[%08d] Cnt[%08d]" \
          %(part+1,c_start,c_end,c_end - c_start + 1)
    part += 1
  fplist[part-1].write("%s"%line)
f.close()

for out in fplist:
  out.close()
