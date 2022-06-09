set term png size 1980,1020
set output 'space_reclamation_duration_per_cycle.png'
set title 'avg duration of one space reclamation cycle'
set ylabel 'time (nanoseconds)'
set xlabel 'time of tests (seconds)'
set yrang [0:]
plot 'reclaim_space_duration_per_cycle.with_time.plot' using 1:2 title 'duration of single space reclamation cycle' with line, \
'reclaim_space_work_time_per_cycle.with_time.plot' using 1:2 title 'time spent by space reclamation doing actual work' with line, \
'time_wasted_on_repeat_per_cycle.with_time.plot' using 1:2 title 'time wasted on waiting to repeat' with line, \
'get_live_extents_time_per_cycle.with_time.plot' using 1:2 title 'time spent on retrieving live extents' with line
