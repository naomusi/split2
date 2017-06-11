#! /bin/sh

if [ "$#" != 3 ]
then
    echo "Usage : split2.sh divisor input base"
    exit 1
fi

divisor=$1
input=$2
base=$3

c_start=0
c_end=0
quotient=0
toomach=0
total=0
part=0

total=`wc -l < $input`
quotient=`expr $total / $divisor`
toomuch=`expr $total % $divisor`

divisor=`expr $divisor - 1`
#printf "%d %d %d\n" $total $qutient $toomuch

for no in `seq 0 $divisor`
do
    if [ $no -lt $toomuch ]
    then
        c_start=`expr $c_end + 1`
        c_end=`expr $c_start + $quotient`
    else
        c_start=`expr $c_end + 1`
        c_end=`expr $c_start + $quotient - 1`
    fi
    file=`printf "%s%02d" $base $no`
    cmd=`echo "$cmd -e '$c_start,$c_end w $file'"`

    cnt=`expr $c_end - $c_start + 1`
    printf "Part[%d] Start[%08d] End[%08d] Cnt[%08d]\n" `expr $no + 1` $c_start $c_end $cnt
done

sh -c "sed -n $cmd $input"
