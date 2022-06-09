set term png size 3836,2021
set output out_file.'.png'
set title 'conflict on extents'
set ylabel 'number of conflicts'
set xlabel 'No. of sample point (1 point per 10 seconds)'
set yrang [0:]
plot log_file using 1 title 'ALLOC\_INFO' with line, \
log_file using 2 title 'COLL\_BLOCK' with line, \
log_file using 3 title 'LADDR\_INTERNAL' with line, \
log_file using 4 title 'LADDR\_LEAF' with line, \
log_file using 5 title 'OBJECT\_DATA\_BLOCK' with line, \
log_file using 6 title 'OMAP\_INNER' with line, \
log_file using 7 title 'OMAP\_LEAF' with line, \
log_file using 8 title 'ONODE\_BLOCK\_STAGED' with line, \
log_file using 9 title 'RETIRED\_PLACEHOLDER' with line, \
log_file using 10 title 'ROOT' with line, \
log_file using 11 title 'TEST\_BLOCK' with line, \
log_file using 12 title 'TEST\_BLOCK\_PHYSICAL' with line

set output out_file.'.per_sec.png'
set title 'conflict per second on extents'
set ylabel 'number of conflicts per second'
set xlabel 'No. of sample point (1 point per 10 seconds)'
set yrang [0:]
plot log_file2 using 1 title 'ALLOC\_INFO' with line, \
log_file2 using 2 title 'COLL\_BLOCK' with line, \
log_file2 using 3 title 'LADDR\_INTERNAL' with line, \
log_file2 using 4 title 'LADDR\_LEAF' with line, \
log_file2 using 5 title 'OBJECT\_DATA\_BLOCK' with line, \
log_file2 using 6 title 'OMAP\_INNER' with line, \
log_file2 using 7 title 'OMAP\_LEAF' with line, \
log_file2 using 8 title 'ONODE\_BLOCK\_STAGED' with line, \
log_file2 using 9 title 'RETIRED\_PLACEHOLDER' with line, \
log_file2 using 10 title 'ROOT' with line, \
log_file2 using 11 title 'TEST\_BLOCK' with line, \
log_file2 using 12 title 'TEST\_BLOCK\_PHYSICAL' with line
