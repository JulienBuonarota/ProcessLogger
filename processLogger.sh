Help()
{
    echo "the help"
}
#TODO : test script
#  processLogger -p ananas -d 2

# Option parsing
while getopts "hy:m:d:H:M:S:p:l:" OPTION; do
    case $OPTION in
	h) # display the help
	    Help
	    exit;;
	p)
	    process_name=$OPTARG;;
	l)
	    log_file_name=$OPTARG;;
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

#default value of 1 day elaspe time
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
log_file_name="testProcessLog.log"

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

    latest_process_exec_epoch=$(date -d "$latest_process_exec" +"%s")

    if $(test $most_recent_date_accepted_epoch -gt $latest_process_exec_epoch)
    then
	echo "process has not been executed yet"
	# TODO add process to log file with the date of now
    else echo "process already executed"
    fi
fi


# TODO change above condition to true or false return TODO add record
#  if process has to be executed (might be better has an other function
#  or option
# TODO option to delete the X nb of record, in up or down
#  order

# TODO display if process have ever been recorded in this .log
# IMPLEMENTATION if $(grep -c process_name a_file) = 0
# if not executed, insert an execution log
# return true :
