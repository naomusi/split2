#! /usr/bin/perl

if (scalar(@ARGV) != 3) {
  printf(STDERR "Usage : split2.pl divisor input base\n");
  exit(1);
}

$divisor  = shift(@ARGV);
$input    = shift(@ARGV);
$base     = shift(@ARGV);

$c_start  = 0;
$c_end    = 0;
$quotient = 0;
$toomach  = 0; 
$total    = 0; 
$part     = 0; 

if (!open(FD,$input)) {
  printf(STDERR "Can't open file[%s]\n",$input);
  exit(1);
}
while(<FD>) {$total++}
close(FD);

$quotient = int($total / $divisor);
$toomuch  = int($total % $divisor);

foreach $no (0..($divisor-1)) {
  my($file) = sprintf("%s%02d",$base,$no);
  if (!open(${$file},">$file")) {
    printf(STDERR "Can't open file[%s]\n",$file);
    exit(1);
  }
}

if (!open(FD,$input)) {
  printf(STDERR "Can't open file[%s]\n",$input);
  exit(1);
}
my($cnt) = 0;
while(<FD>) {
  $cnt++;
  if ($cnt > $c_end) {
    if($part < $toomuch)  {
      $c_start = $c_end + 1;
      $c_end   = $c_start + $quotient;
    }
    else {
      $c_start = $c_end + 1;
      $c_end   = $c_start + $quotient - 1;
    }
    printf("Part[%d] Start[%08d] End[%08d] Cnt[%08d]\n",
           $part + 1,$c_start,$c_end,$c_end - $c_start + 1); 
    $part++;
  }
  my($file) = sprintf("%s%02d",$base,$part-1);
  printf({${$file}} "%s",$_);
}

close(FD);

foreach $no (0..($divisor-1)) {
  my($file) = sprintf("%s%02d",$base,$no);
  close(${$file});
}

