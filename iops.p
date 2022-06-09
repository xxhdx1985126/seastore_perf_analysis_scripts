set term png size 1980,1020
set output 'iops.png'
set title 'seastore throughput'
set ylabel 'IOPS'
set xlabel 'time of tests (min)'
set yrang [0:]
plot 'iops.log' title 'seastore throughput' with line
