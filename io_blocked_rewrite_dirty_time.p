set term png size 1980,1020
set output 'io_blocked_rewrite_dirty_time.png'
set title 'analysis of dirty extents rewrite time'
set ylabel 'time (nanoseconds)'
set xlabel 'time of tests(seconds)'
set yrange [0:]
plot 'io_blocked_rewrite_dirty_trans_commit_time_per_cycle.with_time.plot' using 1:2 title 'dirty extents rewriting transactions commit time(when io is blocked)' with line, \
'io_blocked_prepare_rewrite_dirty_time_per_cycle.with_time.plot' using 1:2 title 'dirty extents rewriting transaction construction time(when io is blocked)' with line

set output 'journal_trim_io_blocked_cycles_per_sampling.png'
set title 'journal trim cycles(when io is blocked) per sampling interval'
set ylabel 'number of cycles'
set xlabel 'sampling point (1 per 10 secs)'
set yrange [0:]
plot 'journal_trim_cycles_per_sampling.plot' title 'journal trim cycles(when io is blocked) per sampling interval' with line
