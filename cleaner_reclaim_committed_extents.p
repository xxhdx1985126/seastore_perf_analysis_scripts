set term png size 1980,1020
set output 'cleaner_reclaim_committed_extents.png'
set title 'number of committed extents per space reclamation trans'
set ylabel 'number of committed extents'
set xlabel 'time of tests (sec)'
set yrang [0:]
plot 'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:2 title 'ALLOC INFO' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:3 title 'ALLOC TAIL' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:4 title 'BACKREF INTERNAL' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:5 title 'BACKREF LEAF' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:6 title 'COLL BLOCK' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:7 title 'LADDR INTERNAL' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:8 title 'LADDR LEAF' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:9 title 'OBJECT DATA BLOCK' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:10 title 'OMAP INNER' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:11 title 'OMAP LEAF' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:12 title 'ONODE BLOCK STAGED' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:13 title 'RETIRED PLACEHOLDER' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:14 title 'ROOT' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:15 title 'TEST BLOCK' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:16 title 'TEST BLOCK PHYSICAL' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot' every ::2 using 1:($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16) title 'TOTAL' with line

set output 'cleaner_reclaim_committed_extents_per_sampling.png'
set title 'number of committed extents by space reclamation trans per sampling'
set ylabel 'number of committed extents'
set xlabel 'time of tests (sec)'
set yrang [0:]
plot 'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:2 title 'ALLOC INFO' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:3 title 'ALLOC TAIL' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:4 title 'BACKREF INTERNAL' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:5 title 'BACKREF LEAF' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:6 title 'COLL BLOCK' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:7 title 'LADDR INTERNAL' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:8 title 'LADDR LEAF' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:9 title 'OBJECT DATA BLOCK' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:10 title 'OMAP INNER' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:11 title 'OMAP LEAF' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:12 title 'ONODE BLOCK STAGED' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:13 title 'RETIRED PLACEHOLDER' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:14 title 'ROOT' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:15 title 'TEST BLOCK' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:16 title 'TEST BLOCK PHYSICAL' with line, \
'CLEANER_RECLAIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot' every ::2 using 1:($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16) title 'TOTAL' with line
