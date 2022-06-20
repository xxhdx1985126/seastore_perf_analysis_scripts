#!/bin/sh

for ((i=1;i<=$1;i++)); do echo $(($i*10)); done &> secs.log
unset journal_trim_cycles

cat metrics.log |grep -A 2 segment_cleaner_journal_trim_cycles|grep value|awk '{print $NF}' &> segment_cleaner_journal_trim_cycles.log
journal_trim_cycles=( `cat segment_cleaner_journal_trim_cycles.log`)

rm -f journal_trim_cycles_per_sampling.plot
unset journal_trim_cycles_per_sampling
declare -a journal_trim_cycles_per_sampling
for ((i=1;i<$1;i++))
do
	journal_trim_cycles_per_sampling[$i]=$((${journal_trim_cycles[$i]}-${journal_trim_cycles[$(($i-1))]}))
	echo ${journal_trim_cycles_per_sampling[$i]} >> journal_trim_cycles_per_sampling.plot
done

unset journal_trim_io_blocked_cycles

cat metrics.log |grep -A 2 segment_cleaner_journal_trim_io_blocked_cycles|grep value|awk '{print $NF}' &> segment_cleaner_journal_trim_io_blocked_cycles.log
journal_trim_io_blocked_cycles=( `cat segment_cleaner_journal_trim_io_blocked_cycles.log`)

rm -f journal_trim_io_blocked_cycles_per_sampling.plot
unset journal_trim_io_blocked_cycles_per_sampling
declare -a journal_trim_io_blocked_cycles_per_sampling
for ((i=1;i<$1;i++))
do
	journal_trim_io_blocked_cycles_per_sampling[$i]=$((${journal_trim_io_blocked_cycles[$i]}-${journal_trim_io_blocked_cycles[$(($i-1))]}))
	echo ${journal_trim_io_blocked_cycles_per_sampling[$i]} >> journal_trim_io_blocked_cycles_per_sampling.plot
done


unset journal_trim_repeats
cat metrics.log |grep -A 2 segment_cleaner_journal_trim_repeats|grep value|awk '{print $NF}' &> segment_cleaner_journal_trim_repeats.log
journal_trim_repeats=( `cat segment_cleaner_journal_trim_repeats.log` )

rm -f journal_trim_repeats_per_sampling.plot
unset journal_trim_repeats_per_sampling
declare -a journal_trim_repeats_per_sampling
for ((i=1;i<$1;i++))
do
	journal_trim_repeats_per_sampling[$i]=$((${journal_trim_repeats[$i]}-${journal_trim_repeats[$(($i-1))]}))
	echo ${journal_trim_repeats_per_sampling[$i]} >> journal_trim_repeats_per_sampling.plot
done

rm -f journal_trim_repeats_per_cycle.plot
unset journal_trim_repeats_per_cycle
declare -a journal_trim_repeats_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${journal_trim_cycles_per_sampling[$i]} -gt 0 ]; then
		journal_trim_repeats_per_cycle[$i]=`echo "scale=4; ${journal_trim_repeats_per_sampling[$i]} / ${journal_trim_cycles_per_sampling[$i]}"|bc`
	else
		journal_trim_repeats_per_cycle[$i]=0
	fi
	echo ${journal_trim_repeats_per_cycle[$i]} >> journal_trim_repeats_per_cycle.plot
done

unset journal_trim_duration
cat metrics.log |grep -A 2 segment_cleaner_journal_trim_duration|grep value|awk '{print $NF}' &> segment_cleaner_journal_trim_duration.log
journal_trim_duration=( `cat segment_cleaner_journal_trim_duration.log` )

rm -f journal_trim_duration_per_sampling.plot
unset journal_trim_duration_per_sampling
declare -a journal_trim_duration_per_sampling
for ((i=1;i<$1;i++))
do
	journal_trim_duration_per_sampling[$i]=$((${journal_trim_duration[$i]}-${journal_trim_duration[$(($i-1))]}))
	echo ${journal_trim_duration_per_sampling[$i]} >> journal_trim_duration_per_sampling.plot
done

rm -f journal_trim_duration_per_cycle.plot
unset journal_trim_duration_per_cycle
declare -a journal_trim_duration_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${journal_trim_cycles_per_sampling[$i]} -gt 0 ]; then
		journal_trim_duration_per_cycle[$i]=`echo "scale=4; ${journal_trim_duration_per_sampling[$i]} / ${journal_trim_cycles_per_sampling[$i]}"|bc`
	else
		journal_trim_duration_per_cycle[$i]=0
	fi
	echo ${journal_trim_duration_per_cycle[$i]} >> journal_trim_duration_per_cycle.plot
done
paste secs.log journal_trim_duration_per_cycle.plot &> journal_trim_duration_per_cycle.with_time.plot


unset accumulated_rewrite_dirty_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_rewrite_dirty_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_rewrite_dirty_time.log
accumulated_rewrite_dirty_time=( `cat segment_cleaner_accumulated_rewrite_dirty_time.log` )

rm -f accumulated_rewrite_dirty_time_per_sampling.plot
unset accumulated_rewrite_dirty_time_per_sampling
declare -a accumulated_rewrite_dirty_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_rewrite_dirty_time_per_sampling[$i]=$((${accumulated_rewrite_dirty_time[$i]}-${accumulated_rewrite_dirty_time[$(($i-1))]}))
	echo ${accumulated_rewrite_dirty_time_per_sampling[$i]} >> accumulated_rewrite_dirty_time_per_sampling.plot
done

rm -f rewrite_dirty_time_per_cycle.plot
unset rewrite_dirty_time_per_cycle
declare -a rewrite_dirty_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${journal_trim_cycles_per_sampling[$i]} -gt 0 ]; then
		rewrite_dirty_time_per_cycle[$i]=`echo "scale=4; ${accumulated_rewrite_dirty_time_per_sampling[$i]} / ${journal_trim_cycles_per_sampling[$i]}"|bc`
	else
		rewrite_dirty_time_per_cycle[$i]=0
	fi
	echo ${rewrite_dirty_time_per_cycle[$i]} >> rewrite_dirty_time_per_cycle.plot
done
paste secs.log rewrite_dirty_time_per_cycle.plot &> rewrite_dirty_time_per_cycle.with_time.plot

unset accumulated_trim_backrefs_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_trim_backrefs_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_trim_backrefs_time.log
accumulated_trim_backrefs_time=( `cat segment_cleaner_accumulated_trim_backrefs_time.log` )

rm -f accumulated_trim_backrefs_time_per_sampling.plot
unset accumulated_trim_backrefs_time_per_sampling
declare -a accumulated_trim_backrefs_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_trim_backrefs_time_per_sampling[$i]=$((${accumulated_trim_backrefs_time[$i]}-${accumulated_trim_backrefs_time[$(($i-1))]}))
	echo ${accumulated_trim_backrefs_time_per_sampling[$i]} >> accumulated_trim_backrefs_time_per_sampling.plot
done

rm -f trim_backrefs_time_per_cycle.plot
unset trim_backrefs_time_per_cycle
declare -a trim_backrefs_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${journal_trim_cycles_per_sampling[$i]} -gt 0 ]; then
		trim_backrefs_time_per_cycle[$i]=`echo "scale=4; ${accumulated_trim_backrefs_time_per_sampling[$i]} / ${journal_trim_cycles_per_sampling[$i]}"|bc`
	else
		trim_backrefs_time_per_cycle[$i]=0
	fi
	echo ${trim_backrefs_time_per_cycle[$i]} >> trim_backrefs_time_per_cycle.plot
done
paste secs.log trim_backrefs_time_per_cycle.plot &> trim_backrefs_time_per_cycle.with_time.plot

cat metrics.log |grep -A 5 cache_committed_extents|grep -A 4 FRESH_OOL|grep -A 3 ONODE|grep -A 2 CLEANER_TRIM|grep value|awk '{print $NF}' &> onode_block_staged_cleaner_trim.log
cat metrics.log |grep -A 3 cache_trans_committed|grep -A 2 CLEANER_TRIM|grep value|awk '{print $NF}' &> cache_trans_committed_cleaner_trim.log
cat onode_block_staged_cleaner_trim.log |awk 'BEGIN{last=0}{if (NR==1) {last=$1} else {print ($1-last); last=$1}}END{}' &> onode_block_staged_cleaner_trim_per_sample.log
cat cache_trans_committed_cleaner_trim.log |awk 'BEGIN{last=0}{if (NR==1) {last=$1} else {print ($1-last); last=$1}}END{}' &> cache_trans_committed_cleaner_trim_per_sample.log
unset onode_block_staged_cleaner_trim_per_sample
onode_block_staged_cleaner_trim_per_sample=( `cat onode_block_staged_cleaner_trim_per_sample.log` )
unset cache_trans_committed_cleaner_trim_per_sample
cache_trans_committed_cleaner_trim_per_sample=( `cat cache_trans_committed_cleaner_trim_per_sample.log` )
for ((i=0;i<$1;i++)); do if [ ${cache_trans_committed_cleaner_trim_per_sample[$i]} != 0 ]; then echo "scale=4; ${onode_block_staged_cleaner_trim_per_sample[$i]} / ${cache_trans_committed_cleaner_trim_per_sample[$i]}"|bc; else echo 0; fi; done &> onode_block_staged_per_cleaner_trim.log
paste secs.log onode_block_staged_per_cleaner_trim.log &> onode_block_staged_per_cleaner_trim.with_time.log

rm -f CLEANER_TRIM_*
for name in `cat metrics.log |grep -A 5 cache_trans_invalidated|grep '\<ext\>'|awk -F'"' '{print $(NF-1)}'|sort |uniq`; do cat metrics.log |grep -A 5 cache_trans_invalidated|grep -A 4 "\<${name}\>"|grep -A 2 CLEANER_TRIM|grep value|awk '{print $NF}' &> CLEANER_TRIM_${name}.log; done
paste CLEANER_TRIM_* &> CLEANER_TRIM.log
for name in `cat metrics.log |grep -A 5 cache_trans_invalidated|grep '\<ext\>'|awk -F'"' '{print $(NF-1)}'|sort |uniq`; do cat CLEANER_TRIM_${name}.log|awk 'BEGIN{last=0}{if (NR==1) {last=$1} else {print ($1-last)/10; last=$1}}END{}' &> CLEANER_TRIM_${name}_PER_SEC.log; done
paste secs.log CLEANER_TRIM_*_PER_SEC.log &> CLEANER_TRIM_PER_SEC.log

rm -f CLEANER_TRIM_COMMITTED_EXTENTS_*
for name in `cat metrics.log |grep -A 5 cache_committed_extents|grep '\<ext\>'|awk -F'"' '{print $(NF-1)}'|sort |uniq`; do cat metrics.log |grep -A 5 cache_committed_extents|grep -A 1 -B 3 CLEANER_TRIM|grep -A 3 -B 1 "\<${name}\>"|grep -A 4 'FRESH_OOL\|FRESH_INLINE'|grep value|awk '{print $NF}' &> CLEANER_TRIM_COMMITTED_EXTENTS_${name}.log; done
paste CLEANER_TRIM_COMMITTED_EXTENTS_* &> CLEANER_TRIM_COMMITTED_EXTENTS.log
cache_trans_committed_cleaner_trim=( `cat metrics.log |grep -A 3 '\<cache_trans_committed\>'|grep -A 1 'CLEANER_TRIM'|grep value|awk '{print $NF}'` )
rm -f cache_trans_committed_cleaner_trim_per_sampling.plot
declare -a cache_trans_committed_cleaner_trim_per_sampling
for ((i=1;i<$1;i++))
do
	cache_trans_committed_cleaner_trim_per_sampling[$i]=$((${cache_trans_committed_cleaner_trim[$i]}-${cache_trans_committed_cleaner_trim[$(($i-1))]}))
	echo ${cache_trans_committed_cleaner_trim_per_sampling[$i]} >> cache_trans_committed_cleaner_trim_per_sampling.plot
done
unset orig_val
for name in `cat metrics.log |grep -A 5 cache_committed_extents|grep '\<ext\>'|awk -F'"' '{print $(NF-1)}'|sort |uniq`
do
	orig_val=( `cat CLEANER_TRIM_COMMITTED_EXTENTS_${name}.log` )
	unset total_val
	unset per_sampling_val
	unset per_cycle_val
	declare -a total_val
	declare -a per_sampling_val
	declare -a per_cycle_val

	rm -f CLEANER_TRIM_COMMITTED_EXTENTS_${name}_PER_SAMPLING.plot
	rm -f CLEANER_TRIM_COMMITTED_EXTENTS_${name}_PER_CYCLE.plot
	rm -f CLEANER_TRIM_COMMITTED_EXTENTS_${name}_TOTAL.plot
	echo "${name}" >> CLEANER_TRIM_COMMITTED_EXTENTS_${name}_TOTAL.plot
	echo "${name}" >> CLEANER_TRIM_COMMITTED_EXTENTS_${name}_PER_SAMPLING.plot
	echo "${name}" >> CLEANER_TRIM_COMMITTED_EXTENTS_${name}_PER_CYCLE.plot
	for ((i=0;i<$1;i++))
	do
		total_val[$i]=$((orig_val[$((i*2))]+orig_val[$((i*2+1))]))
		echo "${total_val[$i]}" >> CLEANER_TRIM_COMMITTED_EXTENTS_${name}_TOTAL.plot
	done
	for ((i=1;i<$1;i++))
	do
		per_sampling_val[$i]=`echo "scale=4; ${total_val[$i]}-${total_val[$(($i-1))]}"|bc`
		echo "${per_sampling_val[$i]}" >> CLEANER_TRIM_COMMITTED_EXTENTS_${name}_PER_SAMPLING.plot
		if [ ${cache_trans_committed_cleaner_trim_per_sampling[$i]} -gt 0 ]; then
			per_cycle_val[$i]=`echo "scale=4; ${per_sampling_val[$i]} / ${cache_trans_committed_cleaner_trim_per_sampling[$i]}"|bc`
		else
			per_cycle_val[$i]=0
		fi
		echo "${per_cycle_val[$i]}" >> CLEANER_TRIM_COMMITTED_EXTENTS_${name}_PER_CYCLE.plot
	done
	paste secs.log CLEANER_TRIM_COMMITTED_EXTENTS_${name}_PER_CYCLE.plot &> CLEANER_TRIM_COMMITTED_EXTENTS_${name}_PER_CYCLE.with_time.plot
	paste secs.log CLEANER_TRIM_COMMITTED_EXTENTS_${name}_PER_SAMPLING.plot &> CLEANER_TRIM_COMMITTED_EXTENTS_${name}_PER_SAMPLING.with_time.plot
done
paste secs.log CLEANER_TRIM_COMMITTED_EXTENTS_*_PER_CYCLE.plot &> CLEANER_TRIM_COMMITTED_EXTENTS_PER_CYCLE.with_time.plot
paste secs.log CLEANER_TRIM_COMMITTED_EXTENTS_*_PER_SAMPLING.plot &> CLEANER_TRIM_COMMITTED_EXTENTS_PER_SAMPLING.with_time.plot


unset io_blocked_count_trim
cat metrics.log |grep -A 2 segment_cleaner_io_blocked_count_trim|grep value|awk '{print $NF}' &> segment_cleaner_io_blocked_count_trim.log
io_blocked_count_trim=( `cat segment_cleaner_io_blocked_count_trim.log` )

rm -f io_blocked_count_trim_per_sampling.plot
unset io_blocked_count_trim_per_sampling
declare -a io_blocked_count_trim_per_sampling
for ((i=1;i<$1;i++))
do
	io_blocked_count_trim_per_sampling[$i]=$((${io_blocked_count_trim[$i]}-${io_blocked_count_trim[$(($i-1))]}))
	echo ${io_blocked_count_trim_per_sampling[$i]} >> io_blocked_count_trim_per_sampling.plot
done


unset accumulated_rewrite_dirty_trans_commit_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_rewrite_dirty_trans_commit_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_rewrite_dirty_trans_commit_time.log
accumulated_rewrite_dirty_trans_commit_time=( `cat segment_cleaner_accumulated_rewrite_dirty_trans_commit_time.log` )

rm -f accumulated_rewrite_dirty_trans_commit_time_per_sampling.plot
unset accumulated_rewrite_dirty_trans_commit_time_per_sampling
declare -a accumulated_rewrite_dirty_trans_commit_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_rewrite_dirty_trans_commit_time_per_sampling[$i]=$((${accumulated_rewrite_dirty_trans_commit_time[$i]}-${accumulated_rewrite_dirty_trans_commit_time[$(($i-1))]}))
	echo ${accumulated_rewrite_dirty_trans_commit_time_per_sampling[$i]} >> accumulated_rewrite_dirty_trans_commit_time_per_sampling.plot
done

rm -f rewrite_dirty_trans_commit_time_per_cycle.plot
unset rewrite_dirty_trans_commit_time_per_cycle
declare -a rewrite_dirty_trans_commit_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${journal_trim_cycles_per_sampling[$i]} -gt 0 ]; then
		rewrite_dirty_trans_commit_time_per_cycle[$i]=`echo "scale=4; ${accumulated_rewrite_dirty_trans_commit_time_per_sampling[$i]} / ${journal_trim_cycles_per_sampling[$i]}"|bc`
	else
		rewrite_dirty_trans_commit_time_per_cycle[$i]=0
	fi
	echo ${rewrite_dirty_trans_commit_time_per_cycle[$i]} >> rewrite_dirty_trans_commit_time_per_cycle.plot
done
paste secs.log rewrite_dirty_trans_commit_time_per_cycle.plot &> rewrite_dirty_trans_commit_time_per_cycle.with_time.plot


unset accumulated_prepare_rewrite_dirty_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_prepare_rewrite_dirty_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_prepare_rewrite_dirty_time.log
accumulated_prepare_rewrite_dirty_time=( `cat segment_cleaner_accumulated_prepare_rewrite_dirty_time.log` )

rm -f accumulated_prepare_rewrite_dirty_time_per_sampling.plot
unset accumulated_prepare_rewrite_dirty_time_per_sampling
declare -a accumulated_prepare_rewrite_dirty_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_prepare_rewrite_dirty_time_per_sampling[$i]=$((${accumulated_prepare_rewrite_dirty_time[$i]}-${accumulated_prepare_rewrite_dirty_time[$(($i-1))]}))
	echo ${accumulated_prepare_rewrite_dirty_time_per_sampling[$i]} >> accumulated_prepare_rewrite_dirty_time_per_sampling.plot
done

rm -f prepare_rewrite_dirty_time_per_cycle.plot
unset prepare_rewrite_dirty_time_per_cycle
declare -a prepare_rewrite_dirty_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${journal_trim_cycles_per_sampling[$i]} -gt 0 ]; then
		prepare_rewrite_dirty_time_per_cycle[$i]=`echo "scale=4; ${accumulated_prepare_rewrite_dirty_time_per_sampling[$i]} / ${journal_trim_cycles_per_sampling[$i]}"|bc`
	else
		prepare_rewrite_dirty_time_per_cycle[$i]=0
	fi
	echo ${prepare_rewrite_dirty_time_per_cycle[$i]} >> prepare_rewrite_dirty_time_per_cycle.plot
done
paste secs.log prepare_rewrite_dirty_time_per_cycle.plot &> prepare_rewrite_dirty_time_per_cycle.with_time.plot


unset accumulated_io_blocked_rewrite_dirty_trans_commit_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_io_blocked_rewrite_dirty_trans_commit_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_io_blocked_rewrite_dirty_trans_commit_time.log
accumulated_io_blocked_rewrite_dirty_trans_commit_time=( `cat segment_cleaner_accumulated_io_blocked_rewrite_dirty_trans_commit_time.log` )

rm -f accumulated_io_blocked_rewrite_dirty_trans_commit_time_per_sampling.plot
unset accumulated_io_blocked_rewrite_dirty_trans_commit_time_per_sampling
declare -a accumulated_io_blocked_rewrite_dirty_trans_commit_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_io_blocked_rewrite_dirty_trans_commit_time_per_sampling[$i]=$((${accumulated_io_blocked_rewrite_dirty_trans_commit_time[$i]}-${accumulated_io_blocked_rewrite_dirty_trans_commit_time[$(($i-1))]}))
	echo ${accumulated_io_blocked_rewrite_dirty_trans_commit_time_per_sampling[$i]} >> accumulated_io_blocked_rewrite_dirty_trans_commit_time_per_sampling.plot
done

rm -f io_blocked_rewrite_dirty_trans_commit_time_per_cycle.plot
unset io_blocked_rewrite_dirty_trans_commit_time_per_cycle
declare -a io_blocked_rewrite_dirty_trans_commit_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${journal_trim_io_blocked_cycles_per_sampling[$i]} -gt 0 ]; then
		io_blocked_rewrite_dirty_trans_commit_time_per_cycle[$i]=`echo "scale=4; ${accumulated_io_blocked_rewrite_dirty_trans_commit_time_per_sampling[$i]} / ${journal_trim_io_blocked_cycles_per_sampling[$i]}"|bc`
	else
		io_blocked_rewrite_dirty_trans_commit_time_per_cycle[$i]=0
	fi
	echo ${io_blocked_rewrite_dirty_trans_commit_time_per_cycle[$i]} >> io_blocked_rewrite_dirty_trans_commit_time_per_cycle.plot
done
paste secs.log io_blocked_rewrite_dirty_trans_commit_time_per_cycle.plot &> io_blocked_rewrite_dirty_trans_commit_time_per_cycle.with_time.plot

unset accumulated_io_blocked_prepare_rewrite_dirty_time
cat metrics.log |grep -A 2 segment_cleaner_accumulated_io_blocked_prepare_rewrite_dirty_time|grep value|awk '{print $NF}' &> segment_cleaner_accumulated_io_blocked_prepare_rewrite_dirty_time.log
accumulated_io_blocked_prepare_rewrite_dirty_time=( `cat segment_cleaner_accumulated_io_blocked_prepare_rewrite_dirty_time.log` )

rm -f accumulated_io_blocked_prepare_rewrite_dirty_time_per_sampling.plot
unset accumulated_io_blocked_prepare_rewrite_dirty_time_per_sampling
declare -a accumulated_io_blocked_prepare_rewrite_dirty_time_per_sampling
for ((i=1;i<$1;i++))
do
	accumulated_io_blocked_prepare_rewrite_dirty_time_per_sampling[$i]=$((${accumulated_io_blocked_prepare_rewrite_dirty_time[$i]}-${accumulated_io_blocked_prepare_rewrite_dirty_time[$(($i-1))]}))
	echo ${accumulated_io_blocked_prepare_rewrite_dirty_time_per_sampling[$i]} >> accumulated_io_blocked_prepare_rewrite_dirty_time_per_sampling.plot
done

rm -f io_blocked_prepare_rewrite_dirty_time_per_cycle.plot
unset io_blocked_prepare_rewrite_dirty_time_per_cycle
declare -a io_blocked_prepare_rewrite_dirty_time_per_cycle
for ((i=1;i<$1;i++))
do
	if [ ${journal_trim_io_blocked_cycles_per_sampling[$i]} -gt 0 ]; then
		io_blocked_prepare_rewrite_dirty_time_per_cycle[$i]=`echo "scale=4; ${accumulated_io_blocked_prepare_rewrite_dirty_time_per_sampling[$i]} / ${journal_trim_io_blocked_cycles_per_sampling[$i]}"|bc`
	else
		io_blocked_prepare_rewrite_dirty_time_per_cycle[$i]=0
	fi
	echo ${io_blocked_prepare_rewrite_dirty_time_per_cycle[$i]} >> io_blocked_prepare_rewrite_dirty_time_per_cycle.plot
done
paste secs.log io_blocked_prepare_rewrite_dirty_time_per_cycle.plot &> io_blocked_prepare_rewrite_dirty_time_per_cycle.with_time.plot
