#! /usr/bin/ruby

if (ARGV.length != 3)
  printf("Usage : split2.rb divisor input base\n")
  exit(1)
end

divisor  = ARGV[0].to_i
input    = ARGV[1]
base     = ARGV[2]

c_start  = 0
c_end    = 0
quotient = 0
toomuch  = 0
total    = 0
part     = 0
fplist   = []

f = File.open(input,"r");
f.each_line do |line|
  total += 1
end
f.close()

divisor.times do |no|
  fplist[no] = open("%s%02d"%[base,no],"w")  
end

quotient = (total / divisor).to_i
toomuch  = (total % divisor).to_i

cnt = 0
f = File.open(input,"r");
f.each_line do |line|
  cnt += 1
  if (cnt > c_end)
    if (part < toomuch) 
      c_start = c_end + 1
      c_end   = c_start + quotient
    else
      c_start = c_end + 1
      c_end   = c_start + quotient - 1
    end
    printf("Part[%d] Start[%08d] End[%08d] Cnt[%08d]\n",
           part + 1,c_start,c_end,c_end - c_start + 1)
    part += 1
  end
  fplist[part-1].printf("%s",line)
end
f.close()

divisor.times do |no|
  fplist[no].close
end
