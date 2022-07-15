set term png size 1980,1020
set output 'space_reclamation_duration_per_cycle.png'
set title 'avg duration of one space reclamation cycle'
set ylabel 'time (nanoseconds)'
set xlabel 'time of tests (seconds)'
set yrang [0:]
plot 'reclaim_space_duration_per_cycle.with_time.plot' using 1:2 title 'duration of single space reclamation cycle' with line, \
'reclaim_space_work_time_per_cycle.with_time.plot' using 1:2 title 'time spent by space reclamation doing actual work' with line, \
'time_wasted_on_repeat_per_cycle.with_time.plot' using 1:2 title 'time wasted on waiting to repeat' with line, \
'get_live_extents_time_per_cycle.with_time.plot' using 1:2 title 'time spent on retrieving live extents' with line, \
'backref_batch_insert_time_per_cycle.with_time.plot' using 1:2 title 'time spent on merging backrefs' with line, \
'transaction_submit_time_per_cycle.with_time.plot' using 1:2 title 'time spent on committing space reclamation trans' with line

set output 'reclaim_space_cycles_per_sampling.png'
set title 'num of space reclaim trans per smapling interval'
set ylabel 'num of space reclaim trans'
set xlabel 'sampling point (1 per 10 secs)'
set yrange [0:]
plot 'reclaim_space_cycles_per_sampling.plot' title 'num of space reclaim trans per smapling interval' with line
