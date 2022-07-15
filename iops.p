set term png size 1980,1020
set output 'iops_avg_1min.png'
set title 'seastore throughput(avg 1 min)'
set ylabel 'IOPS'
set xlabel 'time of tests (min)'
set yrang [0:]
plot 'iops.log' title 'seastore throughput' with line

set output 'iops_avg_1sec.png'
set title 'seastore throughput(avg 1 sec)'
set ylabel 'IOPS'
set xlabel 'time of tests (secs)'
set yrang [0:]
plot 'iops_last_1sec.log' title 'seastore throughput' with line
