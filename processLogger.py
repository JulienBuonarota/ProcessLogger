import subprocess
import os

"""
The folder containing processLogger script should be added 
to the PATH variable
"""

def ask(process_name, log_file_name, year=0, month=0, day=0, hour=0, minute=0, second=0):
    """
    Ask the question : 
        Has the {process_name} been executed in the last {minute/hour/day...} as
        recorded in {log_file_name}
    process_name: string
    log_file_name: string
    year, month, day, hour, minute, second: int
    return: bool
        True: the process has been executed more recently than the elapse time
        False: the process has not been executed more recently than the elapse time
        None: Unexpected output of ProcessLogger
    """
    output = subprocess.run("processLogger.sh -f {} -p {} -y {} -m {} -d {} -H {} -M {} -S {}"
                            .format(log_file_name, process_name,
                                    year, month, day, hour, minute, second),
                        shell=True, capture_output=True)
    ## Parsing of the different possible outputs
    output_string = output.stdout.decode().strip()
    if 'process' in output_string:
        # can consider that if the process has not been log yet if should be executed
        output_bool = False
    elif ('True' in output_string) or ('False' in output_string):
        output_bool = eval(output_string)
    else:
        output_bool = None

    return output_bool


def log(process_name, log_file_name):
    """ Log {process_name} to {log_file_name} with curent date and time"""
    output = subprocess.run("processLogger.sh -l -f {} -p {}".format(log_file_name, process_name), shell=True, capture_output=True)
    return output
