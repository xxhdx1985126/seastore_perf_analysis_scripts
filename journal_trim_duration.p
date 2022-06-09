set term png size 1980,1020
set output 'journal_trim_duration_per_cycle.png'
set title 'avg duration of one journal trimming cycle'
set ylabel 'time (nanoseconds)'
set xlabel 'time of tests (seconds)'
set yrang [0:]
plot 'journal_trim_duration_per_cycle.with_time.plot' using 1:2 title 'duration of single journal trimming cycle' with line, \
'trim_backrefs_time_per_cycle.with_time.plot' using 1:2 title 'time spent on merging backrefs' with line, \
'rewrite_dirty_time_per_cycle.with_time.plot' using 1:2 title 'time spent on rewriting dirty extents' with line

set output 'rewrite_dirty_time.png'
set title 'analysis of dirty extents rewrite time'
set ylabel 'time (nanoseconds)'
set xlabel 'time of tests(seconds)'
set yrange [0:]
plot 'rewrite_dirty_time_per_cycle.with_time.plot' using 1:2 title 'time spent on rewriting dirty extents' with line, \
'rewrite_dirty_trans_commit_time_per_cycle.with_time.plot' using 1:2 title 'dirty extents rewriting transactions commit time' with line, \
'prepare_rewrite_dirty_time_per_cycle.with_time.plot' using 1:2 title 'dirty extents rewriting transaction construction time' with line

set output 'journal_trim_cycles_per_sampling.png'
set title 'journal trim cycles per sampling interval'
set ylabel 'number of cycles'
set xlabel 'sampling point (1 per 10 secs)'
set yrange [0:]
plot 'journal_trim_cycles_per_sampling.plot' title 'journal trim cycles per sampling interval' with line
