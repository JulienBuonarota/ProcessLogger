import subprocess
import os

# TODO resolve problem of log file being save outside the exec path
def ananas_process():
    print("process to be executed")

## Verify if the process called ananas has been executed in the last 2 seconds
log_file_path = os.path.join(os.getcwd(), "example_log.log")
output = subprocess.run("./processLogger.sh -f {} -p ananas -d 2".format(log_file_path),
                        shell=True, capture_output=True)

## Parsing of the different possible outputs
output_string = output.stdout.decode().strip()
if 'process' in output_string:
    # example of possible output_string:
    # No process of name -  ananas  - have been found in log file -  example_log.log  -
    print(output_string)
    # can consider that if the process has not been log yet if should be executed
    output_bool = False
elif ('True' in output_string) or ('False' in output_string):
    output_bool = eval(output_string)
else:
    print("unknown output")

# exec
if output_bool is False:
    # the process has not been executed yet
    ananas_process()
    # record the execution of the process
    output = subprocess.run("./processLogger.sh -l -f example_log.log -p ananas", shell=True, capture_output=True)
else:
    print("No execution of process ananas needed")

