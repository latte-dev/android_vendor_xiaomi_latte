
mkdir -p /data/intel
cd /data/intel

ROUNDNAME="current_dump_round"
ROUND=0

if [ -f $ROUNDNAME ]
then
    ROUND=`cat $ROUNDNAME`
fi
let ROUND=ROUND+1
if [ $ROUND -gt 3 ]
then
    ROUND=1
fi
echo $ROUND > $ROUNDNAME

mkdir -p /data/intel/ftracelog.$ROUND
rm -rf /data/intel/ftracelog.$ROUND/*
#rm -rf /data/intel/ftracelog.$ROUND/kmsg.txt

#echo 0 > /proc/sys/kernel/printk
echo 0x3e > /sys/module/drm/parameters/debug

#cat /proc/kmsg > /data/intel/ftracelog.$ROUND/kmsg.txt &

cd /sys/kernel/debug/tracing
echo echo 81920 > buffer_size_kb

# Function Trace
#echo function_graph > current_tracer
echo i915_* drm_* intel_* vlv_* valleyview_* mutex > set_ftrace_filter

#MMIO Trace
#echo nop > current_tracer
#echo 1 > /sys/kernel/debug/tracing/events/i915/i915_reg_rw/enable
echo 1 > /d/tracing/events/i915/i915_gem_request_add/enable
echo 1 > /d/tracing/events/i915/i915_gem_request_complete/enable
echo 1 > /d/tracing/events/i915/i915_gem_request_notify/enable
echo 1 > /d/tracing/events/i915/i915_gem_request_retire/enable
echo 1 > /d/tracing/events/i915/i915_gem_request_wait_begin/enable
echo 1 > /d/tracing/events/i915/i915_gem_request_wait_end/enable
echo 1 > /d/tracing/events/i915/i915_scheduler_destroy/enable
echo 1 > /d/tracing/events/i915/i915_scheduler_fly/enable
echo 1 > /d/tracing/events/i915/i915_scheduler_irq/enable
echo 1 > /d/tracing/events/i915/i915_scheduler_landing/enable
echo 1 > /d/tracing/events/i915/i915_scheduler_node_state_change/enable
echo 1 > /d/tracing/events/i915/i915_scheduler_pop_from_queue/enable
echo 1 > /d/tracing/events/i915/i915_scheduler_queue/enable
echo 1 > /d/tracing/events/i915/i915_scheduler_remove/enable
echo 1 > /d/tracing/events/i915/i915_scheduler_unfly/enable
echo 1 > /d/tracing/events/i915/i915_gem_ring_dispatch/enable
echo 1 > /d/tracing/events/i915/i915_flip_complete/enable
echo 1 > /d/tracing/events/i915/i915_flip_request/enable

echo 0 > tracing_on
echo 0 > trace
echo 1 > tracing_on

NUM0=0
NUM1=0
NUM2=0
while true
do
        dmesg | grep "i915_wait_request\|mutex_lock"
        if [ $? -eq 0 ]
        then
	       if [ $NUM0 -lt 10 ]
	       then
		    cat /sys/kernel/debug/tracing/trace > /data/intel/ftracelog.$ROUND/ftrace_wait_request.txt.$NUM0
		    cat /d/dri/0/i915_scheduler_info > /data/intel/ftracelog.$ROUND/i915_scheduler_info_w.log.$NUM0
		    cat /d/dri/0/i915_gem_request > /data/intel/ftracelog.$ROUND/i915_gem_request_w.log.$NUM0
		    #cat /d/dri/0/i915_error_state > /data/intel/ftracelog.$ROUND/i915_error_state_w_1.log.$NUM0
		    #echo > /d/dri/0/i915_error_state
		    #echo -1 > /d/dri/0/i915_wedged
		    #cat /d/dri/0/i915_error_state  > /data/intel/ftracelog.$ROUND/i915_error_state_w_2.log.$NUM0
               fi
	       let NUM0+=1
	       echo "Dump ftrace times: $NUM0 - `date`" > /data/intel/ftracelog.$ROUND/wait_request_dump_num
        fi

        dmesg | grep "pci_pm_suspend"
	if [ $? -eq 0 ]
        then
	       if [ $NUM1 -lt 10 ]
	       then
		    cat /sys/kernel/debug/tracing/trace > /data/intel/ftracelog.$ROUND/ftrace_i915_pm_suspend.txt.$NUM1
               fi
               let NUM1+=1
               echo "Dum ftrace times: $NUM1 - `date`" > /data/intel/ftracelog.$ROUND/pm_suspend_dump_num
        fi

        dmesg | grep "fence\ timeout\|GPU\ HANG"
        if [ $? -eq 0 ]
        then
               if [ $NUM2 -lt 10 ]
               then
                    cat /sys/kernel/debug/tracing/trace > /data/intel/ftracelog.$ROUND/ftrace_fence_timeout_or_GPU_hang.txt.$NUM2
                    cat /d/dri/0/i915_scheduler_info > /data/intel/ftracelog.$ROUND/i915_scheduler_info_f.log.$NUM2
                    cat /d/dri/0/i915_gem_request > /data/intel/ftracelog.$ROUND/i915_gem_request_f.log.$NUM2
                    cat /d/dri/0/i915_error_state > /data/intel/ftracelog.$ROUND/i915_error_state_f_1.log.$NUM2
                    echo > /d/dri/0/i915_error_state
                    echo -1 > /d/dri/0/i915_wedged
                    cat /d/dri/0/i915_error_state  > /data/intel/ftracelog.$ROUND/i915_error_state_f_2.log.$NUM2
               fi
               let NUM2+=1
               echo "Dum ftrace times: $NUM2 - `date`" > /data/intel/ftracelog.$ROUND/fence_timeout_or_gpu_hang_dump_num
        fi

        sleep 30
done

echo "Done..."
