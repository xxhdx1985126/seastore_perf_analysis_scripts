set term png size 1980,1020
set output 'gc_time_per_sampling.png'
set title 'time spent on different gc procedures during one sampling interval'
set ylabel 'time (nanoseconds)'
set xlabel 'sampling points (sampling interval: 10s)'
set yrang [0:]
plot 'accumulated_gc_duration_per_sampling.plot' title 'the time seastore doing some gc work in the last sampling interval' with line, \
'accumulated_gc_backref_trimming_duration_per_sampling.plot' title 'time spent on triming backrefs in the last sampling interval' with line, \
'journal_trim_duration_per_sampling.plot' title 'time spent on trimming journal in the last sampling interval' with line, \
'accumulated_reclaim_space_duration_per_sampling.plot' title 'time spent on reclaiming disk space in the last sampling interval' with line
