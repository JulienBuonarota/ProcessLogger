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
# TODO decide where (and how) to calculate the most_recent_date_accepted

#default value of 1 day elaspe time
year=${year:-0}
month=${month:-0}
day=${day:-1}
hour=${hour:-0}
minute=${minute:-0}
second=${second:-0}

# lets separate date and hour
most_recent_date_accepted=$(($year*10000 + $month*100 + $day*1))
most_recent_hour_accepted=$(($hour*10000 + $minute*100 + $second*1))

# echo $most_recent_date_accepted
# echo $most_recent_hour_accepted
# 
# echo $(expr ${year:-0} + ${carry_year:-0})
# echo $(expr ${month:-0} + ${carry_month:-0})
# echo $(expr ${day:-1} + ${carry_day:-0})
# echo $(expr ${hour:-0} + ${carry_hour:-0})
# echo $(expr ${minute:-0} + ${carry_minute:-0})
# echo $(expr ${second:-0} + ${carry_second:-0})

# IDEA use -u option to get time as universal time zone so that the
# excution of this script does not depend of local environment

current_date=$(date +%Y%m%d)
current_hour=$(date %H%M%S)
# parse the last process timelapse condition
#  by default : 1 day
# check if the process has been executed
log_file_name="testProcessLog.log"

# process_name="ananas"
# most_recent_date_accepted=20200101010101
latest_process_exec=$(grep $process_name, $log_file_name | \
			  cut --delimiter="," --field=2 | \
			  sort --numeric-sort --reverse | \
			  head --lines=1)

echo "latest process exec : " $latest_process_exec
echo "most recent data accepted : " $most_recent_date_accepted

if $(test $most_recent_date_accepted -gt $latest_process_exec)
then echo "process has not been executed yet"
else echo "process already executed"
fi


# TODO display if process have ever been recorded in this .log
# IMPLEMENTATION if $(grep -c process_name a_file) = 0
# if not executed, insert an execution log
# return true :
