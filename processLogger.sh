Help()
{
    echo "the help"
}
#TODO : test script
#  processLogger -p ananas -d 2

# Option parsing
while getopts "hY:m:d:H:M:S:p:" OPTION; do
    case $OPTION in
	h) # display the help
	    Help
	    exit;;
	p)
	    process_name=$OPTARG;;
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
log_file_name="testProcessLog.log"

# process_name="ananas"
latest_process_exec=$(grep $process_name, $log_file_name | \
			  cut --delimiter="," --field=2 | \
			  sort --numeric-sort --reverse | \
			  head --lines=1)

echo "latest process exec : " $latest_process_exec
echo "latest process exec in epoch : " $(date -d "$latest_process_exec" +"%s")
echo "most recent data accepted  : " $(date -d @$most_recent_date_accepted_epoch +"%Y_%m_%d %H:%M:%S")
echo "most recent data accepted in epoch : " $most_recent_date_accepted_epoch

latest_process_exec_epoch=$(date -d "$latest_process_exec" +"%s")

if $(test $most_recent_date_accepted_epoch -gt $latest_process_exec_epoch)
then echo "process has not been executed yet"
else echo "process already executed"
fi

# TODO change above condition to true or false return
# TODO add record if process has to be executed
# TODO option to delete the X nb of record, in up or down order

# TODO display if process have ever been recorded in this .log
# IMPLEMENTATION if $(grep -c process_name a_file) = 0
# if not executed, insert an execution log
# return true :
