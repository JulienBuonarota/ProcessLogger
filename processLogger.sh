Help()
{
    echo "the help"
}
#  processLogger -p ananas -d 2

# Option parsing
while getopts "hly:m:d:H:M:S:p:f:" OPTION; do
    case $OPTION in
	h) # display the help
	    Help
	    exit;;
	l)
	    log_process=1
	;;
	p)
	    process_name=$OPTARG
	;;
	f)
	    log_file_name=$OPTARG
	;;
	y)
	    year=$OPTARG
    	;;
        m)
    	    month=$OPTARG
    	;;
        d)
    	    day=$OPTARG
    	;;
        H)
    	    hour=$OPTARG
    	;;
        M)
    	    minute=$OPTARG
    	;;
        S)
    	    second==$OPTARG
    	;;
	*)
	    echo "unknown options :" $1
	    exit 1;;
    esac
done

# DONE check that a process name has been given
if [ -z $process_name ]
then
    echo "no process name given"
    exit 1
fi


log_process=${log_process:-0}
log_file_name=${log_file_name:-"testProcessLog.log"}

# Add the process to the log file with date of now and exist
if [ "$log_process" == 1 ]
then
    echo "Adding process -" $process_name "- "
    echo $process_name', '$(date +"%Y-%m-%d %H:%M:%S") >> $log_file_name
    exit 0
fi

#default value of 1 day elapse time
year=${year:-0}
month=${month:-0}
day=${day:-1}
hour=${hour:-0}
minute=${minute:-0}
second=${second:-0}

most_recent_date_accepted_epoch=$(date -d "-$year year -$month month -$day day -$hour hour -$minute minute -$second second" +%s)

# parse the last process timelapse condition
#  by default : 1 day
# log_file_name=${log_file_name:"testProcessLog.log"}


# echo "process name : " $process_name
# echo "log file name : " ${log_file_name}
####### DONE check if process is present in the log #######
#  currently it somehow find that the process has already been executed if not present in the og file
latest_process_exec=$(grep $process_name, $log_file_name | \
			  cut --delimiter="," --field=2 | \
			  sort --numeric-sort --reverse | \
			  head --lines=1)

# test if any process have been found in the log file
latest_process_exec=${latest_process_exec:-"no_process_found"}

if [ "$latest_process_exec" = "no_process_found" ]
then
    echo "No process of name - " ${process_name} " - have been found in log file - " $log_file_name " - "
else
#     echo "most recent process exec : " $latest_process_exec
#     echo "most recent process exec in epoch : " $(date -d "$latest_process_exec" +"%s")
#     echo "most recent date accepted  : " $(date -d @$most_recent_date_accepted_epoch +"%Y_%m_%d %H:%M:%S")
#     echo "most recent date accepted in epoch : " $most_recent_date_accepted_epoch

    latest_process_exec_epoch=$(date -d "$latest_process_exec" +%s)

    if $(test $most_recent_date_accepted_epoch -gt $latest_process_exec_epoch)
    then
	# not executed yet
	echo "False"
	# TODO add process to log file with the date of now
    else echo "True"
    fi
fi


# DONE change above condition to true or false return
# DONE add record if process has to be executed (might be better has an other function
#  or option

# TODO option to delete the X nb of record, in up or down
#  order

# TODO display if process have ever been recorded in this .log
# IMPLEMENTATION if $(grep -c process_name a_file) = 0
# if not executed, insert an execution log
# return true :
