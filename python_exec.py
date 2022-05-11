import subprocess

## Verify if the process called ananas has been executed in the last 2 seconds
output = subprocess.run("./processLogger.sh -p ananas -S 2", shell=True, capture_output=True)
# cast to bool does not work
# TODO check how to handle b""
process_executed = eval(output.stdout.decode().strip())
print(output)
print(process_executed)
