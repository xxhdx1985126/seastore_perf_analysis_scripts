#!/bin/sh

for ((i=1;i<$1;i++)); do echo $(($i*10)); done &> secs.log
unset reclaim_space_cycles

cat metrics.log |grep -A 2 reclaim_space_cycle|grep value|awk '{print $NF}' &> segment_cleaner_reclaim_space_cycle.log

reclaim_space_cycles=( `cat segment_cleaner_reclaim_space_cycle.log`)

unset reclaim_space_cycles_per_sampling
declare -a reclaim_space_cycles_per_sampling
for ((i=1;i<$1;i++))
do
	reclaim_space_cycles_per_sampling[$i]=$((${reclaim_space_cycles[$i]}-${reclaim_space_cycles[$(($i-1))]}))
done

unset accumulated_get_live_extents_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_get_live_extents_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_get_live_extents_time.log
accumulated_get_live_extents_time=( `cat segment_cleaner_accumulated_get_live_extents_time.log` )

rm -f accumulated_get_live_extents_time_per_sampling.plot
unset accumulated_get_live_extents_time_per_sampling
declare -a accumulated_get_live_extents_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_get_live_extents_time_per_sampling[$i]=$((${accumulated_get_live_extents_time[$i]}-${accumulated_get_live_extents_time[$(($i-1))]}))
	echo ${accumulated_get_live_extents_time_per_sampling[$i]} >> accumulated_get_live_extents_time_per_sampling.plot
done

rm -f get_live_extents_time_per_cycle.plot
unset get_live_extents_time_per_cycle
declare -a get_live_extents_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${reclaim_space_cycles_per_sampling[$i]} -gt 0 ]; then
		get_live_extents_time_per_cycle[$i]=`echo "scale=4; ${accumulated_get_live_extents_time_per_sampling[$i]} / ${reclaim_space_cycles_per_sampling[$i]}"|bc`
	else
		get_live_extents_time_per_cycle[$i]=0
	fi
	echo ${get_live_extents_time_per_cycle[$i]} >> get_live_extents_time_per_cycle.plot
	paste secs.log get_live_extents_time_per_cycle.plot &> get_live_extents_time_per_cycle.with_time.plot
done

unset accumulated_rewrite_extents_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_rewrite_extents_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_rewrite_extents_time.log
accumulated_rewrite_extents_time=( `cat segment_cleaner_accumulated_rewrite_extents_time.log` )

rm -f accumulated_rewrite_extents_time_per_sampling.plot
unset accumulated_rewrite_extents_time_per_sampling
declare -a accumulated_rewrite_extents_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_rewrite_extents_time_per_sampling[$i]=$((${accumulated_rewrite_extents_time[$i]}-${accumulated_rewrite_extents_time[$(($i-1))]}))
	echo ${accumulated_rewrite_extents_time_per_sampling[$i]} >> accumulated_rewrite_extents_time_per_sampling.plot
done

rm -f rewrite_extents_time_per_cycle.plot
unset rewrite_extents_time_per_cycle
declare -a rewrite_extents_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${reclaim_space_cycles_per_sampling[$i]} -gt 0 ]; then
		rewrite_extents_time_per_cycle[$i]=`echo "scale=4; ${accumulated_rewrite_extents_time_per_sampling[$i]} / ${reclaim_space_cycles_per_sampling[$i]}"|bc`
	else
		rewrite_extents_time_per_cycle[$i]=0
	fi
	echo ${rewrite_extents_time_per_cycle[$i]} >> rewrite_extents_time_per_cycle.plot
	paste secs.log rewrite_extents_time_per_cycle.plot &> rewrite_extents_time_per_cycle.with_time.plot
done

unset accumulated_backref_batch_insert_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_backref_batch_insert_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_backref_batch_insert_time.log
accumulated_backref_batch_insert_time=( `cat segment_cleaner_accumulated_backref_batch_insert_time.log` )

rm -f accumulated_backref_batch_insert_time_per_sampling.plot
unset accumulated_backref_batch_insert_time_per_sampling
declare -a accumulated_backref_batch_insert_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_backref_batch_insert_time_per_sampling[$i]=$((${accumulated_backref_batch_insert_time[$i]}-${accumulated_backref_batch_insert_time[$(($i-1))]}))
	echo ${accumulated_backref_batch_insert_time_per_sampling[$i]} >> accumulated_backref_batch_insert_time_per_sampling.plot
done

rm -f backref_batch_insert_time_per_cycle.plot
unset backref_batch_insert_time_per_cycle
declare -a backref_batch_insert_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${reclaim_space_cycles_per_sampling[$i]} -gt 0 ]; then
		backref_batch_insert_time_per_cycle[$i]=`echo "scale=4; ${accumulated_backref_batch_insert_time_per_sampling[$i]} / ${reclaim_space_cycles_per_sampling[$i]}"|bc`
	else
		backref_batch_insert_time_per_cycle[$i]=0
	fi
	echo ${backref_batch_insert_time_per_cycle[$i]} >> backref_batch_insert_time_per_cycle.plot
	paste secs.log backref_batch_insert_time_per_cycle.plot &> backref_batch_insert_time_per_cycle.with_time.plot
done

unset accumulated_get_backref_extents_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_get_backref_extents_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_get_backref_extents_time.log
accumulated_get_backref_extents_time=( `cat segment_cleaner_accumulated_get_backref_extents_time.log` )

rm -f accumulated_get_backref_extents_time_per_sampling.plot
unset accumulated_get_backref_extents_time_per_sampling
declare -a accumulated_get_backref_extents_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_get_backref_extents_time_per_sampling[$i]=$((${accumulated_get_backref_extents_time[$i]}-${accumulated_get_backref_extents_time[$(($i-1))]}))
	echo ${accumulated_get_backref_extents_time_per_sampling[$i]} >> accumulated_get_backref_extents_time_per_sampling.plot
done

rm -f get_backref_extents_time_per_cycle.plot
unset get_backref_extents_time_per_cycle
declare -a get_backref_extents_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${reclaim_space_cycles_per_sampling[$i]} -gt 0 ]; then
		get_backref_extents_time_per_cycle[$i]=`echo "scale=4; ${accumulated_get_backref_extents_time_per_sampling[$i]} / ${reclaim_space_cycles_per_sampling[$i]}"|bc`
	else
		get_backref_extents_time_per_cycle[$i]=0
	fi
	echo ${get_backref_extents_time_per_cycle[$i]} >> get_backref_extents_time_per_cycle.plot
	paste secs.log get_backref_extents_time_per_cycle.plot &> get_backref_extents_time_per_cycle.with_time.plot
done

unset accumulated_backrefs_calc_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_backrefs_calc_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_backrefs_calc_time.log
accumulated_backrefs_calc_time=( `cat segment_cleaner_accumulated_backrefs_calc_time.log` )

rm -f accumulated_backrefs_calc_time_per_sampling.plot
unset accumulated_backrefs_calc_time_per_sampling
declare -a accumulated_backrefs_calc_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_backrefs_calc_time_per_sampling[$i]=$((${accumulated_backrefs_calc_time[$i]}-${accumulated_backrefs_calc_time[$(($i-1))]}))
	echo ${accumulated_backrefs_calc_time_per_sampling[$i]} >> accumulated_backrefs_calc_time_per_sampling.plot
done

rm -f backrefs_calc_time_per_cycle.plot
unset backrefs_calc_time_per_cycle
declare -a backrefs_calc_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${reclaim_space_cycles_per_sampling[$i]} -gt 0 ]; then
		backrefs_calc_time_per_cycle[$i]=`echo "scale=4; ${accumulated_backrefs_calc_time_per_sampling[$i]} / ${reclaim_space_cycles_per_sampling[$i]}"|bc`
	else
		backrefs_calc_time_per_cycle[$i]=0
	fi
	echo ${backrefs_calc_time_per_cycle[$i]} >> backrefs_calc_time_per_cycle.plot
	paste secs.log backrefs_calc_time_per_cycle.plot &> backrefs_calc_time_per_cycle.with_time.plot
done

unset accumulated_transaction_submit_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_transaction_submit_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_transaction_submit_time.log
accumulated_transaction_submit_time=( `cat segment_cleaner_accumulated_transaction_submit_time.log` )

rm -f accumulated_transaction_submit_time_per_sampling.plot
unset accumulated_transaction_submit_time_per_sampling
declare -a accumulated_transaction_submit_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_transaction_submit_time_per_sampling[$i]=$((${accumulated_transaction_submit_time[$i]}-${accumulated_transaction_submit_time[$(($i-1))]}))
	echo ${accumulated_transaction_submit_time_per_sampling[$i]} >> accumulated_transaction_submit_time_per_sampling.plot
done

rm -f transaction_submit_time_per_cycle.plot
unset transaction_submit_time_per_cycle
declare -a transaction_submit_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${reclaim_space_cycles_per_sampling[$i]} -gt 0 ]; then
		transaction_submit_time_per_cycle[$i]=`echo "scale=4; ${accumulated_transaction_submit_time_per_sampling[$i]} / ${reclaim_space_cycles_per_sampling[$i]}"|bc`
	else
		transaction_submit_time_per_cycle[$i]=0
	fi
	echo ${transaction_submit_time_per_cycle[$i]} >> transaction_submit_time_per_cycle.plot
	paste secs.log transaction_submit_time_per_cycle.plot &> transaction_submit_time_per_cycle.with_time.plot
done

unset accumulated_get_backref_mappings_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_get_backref_mappings_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_get_backref_mappings_time.log
accumulated_get_backref_mappings_time=( `cat segment_cleaner_accumulated_get_backref_mappings_time.log` )

rm -f accumulated_get_backref_mappings_time_per_sampling.plot
unset accumulated_get_backref_mappings_time_per_sampling
declare -a accumulated_get_backref_mappings_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_get_backref_mappings_time_per_sampling[$i]=$((${accumulated_get_backref_mappings_time[$i]}-${accumulated_get_backref_mappings_time[$(($i-1))]}))
	echo ${accumulated_get_backref_mappings_time_per_sampling[$i]} >> accumulated_get_backref_mappings_time_per_sampling.plot
done

rm -f get_backref_mappings_time_per_cycle.plot
unset get_backref_mappings_time_per_cycle
declare -a get_backref_mappings_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${reclaim_space_cycles_per_sampling[$i]} -gt 0 ]; then
		get_backref_mappings_time_per_cycle[$i]=`echo "scale=4; ${accumulated_get_backref_mappings_time_per_sampling[$i]} / ${reclaim_space_cycles_per_sampling[$i]}"|bc`
	else
		get_backref_mappings_time_per_cycle[$i]=0
	fi
	echo ${get_backref_mappings_time_per_cycle[$i]} >> get_backref_mappings_time_per_cycle.plot
	paste secs.log get_backref_mappings_time_per_cycle.plot &> get_backref_mappings_time_per_cycle.with_time.plot
done

unset accumulated_reclaim_space_duration
cat metrics.log |grep -A 2 segment_cleaner_accumulated_reclaim_space_duration|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_reclaim_space_duration.log
accumulated_reclaim_space_duration=( `cat segment_cleaner_accumulated_reclaim_space_duration.log` )

rm -f accumulated_reclaim_space_duration_per_sampling.plot
unset accumulated_reclaim_space_duration_per_sampling
declare -a accumulated_reclaim_space_duration_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_reclaim_space_duration_per_sampling[$i]=$((${accumulated_reclaim_space_duration[$i]}-${accumulated_reclaim_space_duration[$(($i-1))]}))
	echo ${accumulated_reclaim_space_duration_per_sampling[$i]} >> accumulated_reclaim_space_duration_per_sampling.plot
done

rm -f reclaim_space_duration_per_cycle.plot
unset reclaim_space_duration_per_cycle
declare -a reclaim_space_duration_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${reclaim_space_cycles_per_sampling[$i]} -gt 0 ]; then
		reclaim_space_duration_per_cycle[$i]=`echo "scale=4; ${accumulated_reclaim_space_duration_per_sampling[$i]} / ${reclaim_space_cycles_per_sampling[$i]}"|bc`
	else
		reclaim_space_duration_per_cycle[$i]=0
	fi
	echo ${reclaim_space_duration_per_cycle[$i]} >> reclaim_space_duration_per_cycle.plot
	paste secs.log reclaim_space_duration_per_cycle.plot &> reclaim_space_duration_per_cycle.with_time.plot
done

unset accumulated_reclaim_space_repeats
cat metrics.log |grep -A 2 segment_cleaner_accumulated_reclaim_space_repeats|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_reclaim_space_repeats.log
accumulated_reclaim_space_repeats=( `cat segment_cleaner_accumulated_reclaim_space_repeats.log` )

rm -f accumulated_reclaim_space_repeats_per_sampling.plot
unset accumulated_reclaim_space_repeats_per_sampling
declare -a accumulated_reclaim_space_repeats_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_reclaim_space_repeats_per_sampling[$i]=$((${accumulated_reclaim_space_repeats[$i]}-${accumulated_reclaim_space_repeats[$(($i-1))]}))
	echo ${accumulated_reclaim_space_repeats_per_sampling[$i]} >> accumulated_reclaim_space_repeats_per_sampling.plot
done

rm -f reclaim_space_repeats_per_cycle.plot
unset reclaim_space_repeats_per_cycle
declare -a reclaim_space_repeats_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${reclaim_space_cycles_per_sampling[$i]} -gt 0 ]; then
		reclaim_space_repeats_per_cycle[$i]=`echo "scale=4; ${accumulated_reclaim_space_repeats_per_sampling[$i]} / ${reclaim_space_cycles_per_sampling[$i]}"|bc`
	else
		reclaim_space_repeats_per_cycle[$i]=0
	fi
	echo ${reclaim_space_repeats_per_cycle[$i]} >> reclaim_space_repeats_per_cycle.plot
	paste secs.log reclaim_space_repeats_per_cycle.plot &> reclaim_space_repeats_per_cycle.with_time.plot
done


unset reclaim_rewrite_bytes
cat metrics.log |grep -A 2 segment_cleaner_reclaim_rewrite_bytes|grep value|awk '{print $NF}' &> segment_cleaner_reclaim_rewrite_bytes.log
reclaim_rewrite_bytes=( `cat segment_cleaner_reclaim_rewrite_bytes.log` )

rm -f reclaim_rewrite_bytes_per_sampling.plot
unset reclaim_rewrite_bytes_per_sampling
declare -a reclaim_rewrite_bytes_per_sampling
for ((i=1;i<$1;i++))
do
	reclaim_rewrite_bytes_per_sampling[$i]=$((${reclaim_rewrite_bytes[$i]}-${reclaim_rewrite_bytes[$(($i-1))]}))
	echo ${reclaim_rewrite_bytes_per_sampling[$i]} >> reclaim_rewrite_bytes_per_sampling.plot
done

rm -f reclaim_rewrite_bytes_per_cycle.plot
unset reclaim_rewrite_bytes_per_cycle
declare -a reclaim_rewrite_bytes_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${reclaim_space_cycles_per_sampling[$i]} -gt 0 ]; then
		reclaim_rewrite_bytes_per_cycle[$i]=`echo "scale=4; ${reclaim_rewrite_bytes_per_sampling[$i]} / ${reclaim_space_cycles_per_sampling[$i]}"|bc`
	else
		reclaim_rewrite_bytes_per_cycle[$i]=0
	fi
	echo ${reclaim_rewrite_bytes_per_cycle[$i]} >> reclaim_rewrite_bytes_per_cycle.plot
done

unset accumulated_time_wasted_on_repeat
cat metrics.log |grep -A 2 segment_cleaner_accumulated_time_wasted_on_repeat|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_time_wasted_on_repeat.log
accumulated_time_wasted_on_repeat=( `cat segment_cleaner_accumulated_time_wasted_on_repeat.log` )

rm -f accumulated_time_wasted_on_repeat_per_sampling.plot
unset accumulated_time_wasted_on_repeat_per_sampling
declare -a accumulated_time_wasted_on_repeat_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_time_wasted_on_repeat_per_sampling[$i]=$((${accumulated_time_wasted_on_repeat[$i]}-${accumulated_time_wasted_on_repeat[$(($i-1))]}))
	echo ${accumulated_time_wasted_on_repeat_per_sampling[$i]} >> accumulated_time_wasted_on_repeat_per_sampling.plot
done

rm -f time_wasted_on_repeat_per_cycle.plot
unset time_wasted_on_repeat_per_cycle
declare -a time_wasted_on_repeat_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${reclaim_space_cycles_per_sampling[$i]} -gt 0 ]; then
		time_wasted_on_repeat_per_cycle[$i]=`echo "scale=4; ${accumulated_time_wasted_on_repeat_per_sampling[$i]} / ${reclaim_space_cycles_per_sampling[$i]}"|bc`
	else
		time_wasted_on_repeat_per_cycle[$i]=0
	fi
	echo ${time_wasted_on_repeat_per_cycle[$i]} >> time_wasted_on_repeat_per_cycle.plot
	paste secs.log time_wasted_on_repeat_per_cycle.plot &> time_wasted_on_repeat_per_cycle.with_time.plot
done

cat metrics.log |grep -A 5 cache_committed_extents|grep -A 4 FRESH_OOL|grep -A 3 ONODE|grep -A 2 CLEANER_RECLAIM|grep value|awk '{print $NF}' &> onode_block_staged_cleaner_reclaim.log
cat metrics.log |grep -A 3 cache_trans_committed|grep -A 2 CLEANER_RECLAIM|grep value|awk '{print $NF}' &> cache_trans_committed_cleaner_reclaim.log
cat onode_block_staged_cleaner_reclaim.log |awk 'BEGIN{last=0}{if (NR==1) {last=$1} else {print ($1-last); last=$1}}END{}' &> onode_block_staged_cleaner_reclaim_per_sample.log
cat cache_trans_committed_cleaner_reclaim.log |awk 'BEGIN{last=0}{if (NR==1) {last=$1} else {print ($1-last); last=$1}}END{}' &> cache_trans_committed_cleaner_reclaim_per_sample.log
unset onode_block_staged_cleaner_reclaim_per_sample
onode_block_staged_cleaner_reclaim_per_sample=( `cat onode_block_staged_cleaner_reclaim_per_sample.log` )
unset cache_trans_committed_cleaner_reclaim_per_sample
cache_trans_committed_cleaner_reclaim_per_sample=( `cat cache_trans_committed_cleaner_reclaim_per_sample.log` )
for ((i=0;i<$1;i++)); do if [ ${cache_trans_committed_cleaner_reclaim_per_sample[$i]} != 0 ]; then echo "scale=4; ${onode_block_staged_cleaner_reclaim_per_sample[$i]} / ${cache_trans_committed_cleaner_reclaim_per_sample[$i]}"|bc; else echo 0; fi; done &> onode_block_staged_per_cleaner_reclaim.log
paste secs.log onode_block_staged_per_cleaner_reclaim.log &> onode_block_staged_per_cleaner_reclaim.with_time.log

rm -f reclaim_space_work_time_per_cycle.plot
for ((i=1;i<$1;i++))
do
	echo "${get_backref_mappings_time_per_cycle[$i]} + ${get_backref_extents_time_per_cycle[$i]} + ${rewrite_extents_time_per_cycle[$i]} + ${backref_batch_insert_time_per_cycle[$i]} + ${get_live_extents_time_per_cycle[$i]} + ${backrefs_calc_time_per_cycle[$i]} +${transaction_submit_time_per_cycle[$i]}"|bc >> reclaim_space_work_time_per_cycle.plot
	paste secs.log reclaim_space_work_time_per_cycle.plot &> reclaim_space_work_time_per_cycle.with_time.plot
done
cat metrics.log |grep -A 3 ops_inflight|grep -A 2 TRANSACTION|grep value|awk '{print $NF}' &> ops_inflight.plot
paste secs.log ops_inflight.plot &> ops_inflight.with_time.plot

rm -f CLEANER_RECLAIM_*
for name in `cat metrics.log |grep -A 5 cache_trans_invalidated|grep '\<ext\>'|awk -F'"' '{print $(NF-1)}'|sort |uniq`; do cat metrics.log |grep -A 5 cache_trans_invalidated|grep -A 4 "\<${name}\>"|grep -A 2 CLEANER_RECLAIM|grep value|awk '{print $NF}' &> CLEANER_RECLAIM_${name}.log; done
paste CLEANER_RECLAIM_* &> CLEANER_RECLAIM.log
for name in `cat metrics.log |grep -A 5 cache_trans_invalidated|grep '\<ext\>'|awk -F'"' '{print $(NF-1)}'|sort |uniq`; do cat CLEANER_RECLAIM_${name}.log|awk 'BEGIN{last=0}{if (NR==1) {last=$1} else {print ($1-last)/10; last=$1}}END{}' &> CLEANER_RECLAIM_${name}_PER_SEC.log; done
paste secs.log CLEANER_RECLAIM_*_PER_SEC.log &> CLEANER_RECLAIM_PER_SEC.log


unset accumulated_io_block_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_io_block_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_io_block_time.log
accumulated_io_block_time=( `cat segment_cleaner_accumulated_io_block_time.log` )

rm -f accumulated_io_block_time_per_sampling.plot
unset accumulated_io_block_time_per_sampling
declare -a accumulated_io_block_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_io_block_time_per_sampling[$i]=$((${accumulated_io_block_time[$i]}-${accumulated_io_block_time[$(($i-1))]}))
	echo ${accumulated_io_block_time_per_sampling[$i]} >> accumulated_io_block_time_per_sampling.plot
done

unset io_blocked_count_reclaim
cat metrics.log |grep -A 2 segment_cleaner_io_blocked_count_reclaim|grep value|awk '{print $NF}' &> segment_cleaner_io_blocked_count_reclaim.log
io_blocked_count_reclaim=( `cat segment_cleaner_io_blocked_count_reclaim.log` )

rm -f io_blocked_count_reclaim_per_sampling.plot
unset io_blocked_count_reclaim_per_sampling
declare -a io_blocked_count_reclaim_per_sampling
for ((i=1;i<$1;i++))
do
	io_blocked_count_reclaim_per_sampling[$i]=$((${io_blocked_count_reclaim[$i]}-${io_blocked_count_reclaim[$(($i-1))]}))
	echo ${io_blocked_count_reclaim_per_sampling[$i]} >> io_blocked_count_reclaim_per_sampling.plot
done

unset io_blocked_count
cat metrics.log |grep -A 2 '\<segment_cleaner_io_blocked_count\>'|grep value|awk '{print $NF}' &> segment_cleaner_io_blocked_count.log
io_blocked_count=( `cat segment_cleaner_io_blocked_count.log` )

rm -f io_blocked_count_per_sampling.plot
unset io_blocked_count_per_sampling
declare -a io_blocked_count_per_sampling
for ((i=1;i<$1;i++))
do
	io_blocked_count_per_sampling[$i]=$((${io_blocked_count[$i]}-${io_blocked_count[$(($i-1))]}))
	echo ${io_blocked_count_per_sampling[$i]} >> io_blocked_count_per_sampling.plot
done


unset accumulated_gc_duration
cat metrics.log |grep -A 2 segment_cleaner_accumulated_gc_duration|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_gc_duration.log
accumulated_gc_duration=( `cat segment_cleaner_accumulated_gc_duration.log` )

rm -f accumulated_gc_duration_per_sampling.plot
unset accumulated_gc_duration_per_sampling
declare -a accumulated_gc_duration_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_gc_duration_per_sampling[$i]=$((${accumulated_gc_duration[$i]}-${accumulated_gc_duration[$(($i-1))]}))
	echo ${accumulated_gc_duration_per_sampling[$i]} >> accumulated_gc_duration_per_sampling.plot
done


unset accumulated_gc_backref_trimming_duration
cat metrics.log |grep -A 2 segment_cleaner_accumulated_gc_backref_trimming_duration|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_gc_backref_trimming_duration.log
accumulated_gc_backref_trimming_duration=( `cat segment_cleaner_accumulated_gc_backref_trimming_duration.log` )

rm -f accumulated_gc_backref_trimming_duration_per_sampling.plot
unset accumulated_gc_backref_trimming_duration_per_sampling
declare -a accumulated_gc_backref_trimming_duration_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_gc_backref_trimming_duration_per_sampling[$i]=$((${accumulated_gc_backref_trimming_duration[$i]}-${accumulated_gc_backref_trimming_duration[$(($i-1))]}))
	echo ${accumulated_gc_backref_trimming_duration_per_sampling[$i]} >> accumulated_gc_backref_trimming_duration_per_sampling.plot
done
