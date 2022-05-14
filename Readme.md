ProcessLogger allow to keep a log of process, keeping track of their execution.
 It allows to ask the question:
 <blockquote>
  As this process been executed in the last minute/hour/day...
</blockquote>

## Options
### Elapse time management
By default all values are set to 0
 <ul>
  <li> <b>y</b> : elapse time in year since last execution </li>
  <li> <b>m</b> : elapse time in month since last execution </li>
  <li> <b>d</b> : elapse time in day since last execution </li>
  <li> <b>H</b> : elapse time in hour since last execution </li>
  <li> <b>M</b> : elapse time in minute since last execution </li>
  <li> <b>S</b> : elapse time in second since last execution </li>
</ul> 

### Other options
<ul> 
  <li> <b>l</b> : if given, the process will be haded to log with name and
  current date and time. By default the process is not loged to let
  the program using ProcessLogger the oportunity to verify if the
  process completed his execution. </li>
  
  <li> <b>p</b> : name of the process  </li>

  <li> <b>f</b> : name of the log file either a path or a file name. In the
  late case the file will be saved in the current folder. Its default
  value is ProcessLogger.log </li>
</ul>

## Example of use 
$ line of code, // commentary

```shell
// Has process Ananas been executed in the last 2 days 
$ processLogger -p Ananas -d 2
$ False
// the process can then be executed
// If it had been executed succesfully it should be logged
$ processLogger -l -p Ananas
```

## Use from python
```python
import subprocess
import os

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
    # can consider that if the process has not been log yet it should be executed
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
    output = subprocess.run("./processLogger.sh -l -f example_log.log -p ananas", 
	                        shell=True, capture_output=True)
else:
    print("No execution of process ananas needed")
```

## Python API
For ease of use I wrapped the two main use of processLogger in two
python functions. The first allow to ask if a process has been
executed and the second to log the process. This function are in the
file processLogger.py and are presented below.

```python
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
    subprocess.run("./processLogger.sh -l -f {} -p {}".format(log_file_name, process_name),
                   shell=True, capture_output=True)
```
