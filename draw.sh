#!/usr/bin/sh

run_dir=$(dirname $(readlink -f $0))

gnuplot -e "out_file='cleaner_trim_conflicts_on_extents';log_file='CLEANER_TRIM.log';log_file2='CLEANER_TRIM_PER_SEC.log'" ${run_dir}/conflicts.p
gnuplot -e "out_file='cleaner_reclaim_conflicts_on_extents';log_file='CLEANER_RECLAIM.log';log_file2='CLEANER_RECLAIM_PER_SEC.log'" ${run_dir}/conflicts.p

for script in `ls ${run_dir}/*.p|grep -v conflicts.p`
do
	gnuplot ${script}
done
