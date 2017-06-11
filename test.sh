#! /bin/sh

echo "=== sh ==="
time split2.sh 8 sample.txt sample
echo 

echo "=== perl ==="
time split2.pl 8 sample.txt sample
echo 

echo "=== ruby ==="
time split2.rb 8 sample.txt sample
echo 

echo "=== python ==="
time split2.py 8 sample.txt sample
echo 

echo "=== lisp ==="
time split2.lisp 8 sample.txt sample
echo 

echo "=== java ==="
time java split2 8 sample.txt sample
echo 

echo "=== c ==="
time split2 8 sample.txt sample
echo 


