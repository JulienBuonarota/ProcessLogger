import subprocess
import os

##
def ask(process_name, log_file_name, year=0, month=0, day=0, hour=0, minute=0, second=0):
    output = subprocess.run("./processLogger.sh -f {} -p {} -y {} -m {} -d {} -H {} -M {} -S {}"
                            .format(log_file_path, process_name,
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
    print("./processLogger.sh -l -f {} -p {}".format(log_file_name, process_name))
    output = subprocess.run("./processLogger.sh -l -f {} -p {}".format(log_file_name, process_name), shell=True, capture_output=True)


if __name__ == "__main__":
    print("logging ananas")
    log("ananas", "florent.log")

