ProcessLogger allow to keep a log of process, keeping track of their execution.
 It allow to ask the question:
   \" As this process been executed in the last minute/hour/day...\"


## Options:
### Elapse time management:
By default all values are 0.
-y elapse time in year since last execution
-m elapse time in month since last execution
-d elapse time in day since last execution
-H elapse time in hour since last execution
-M elapse time in minute since last execution
-S elapse time in second since last execution
 
### Other options:
-l if given, the process will be haded to log with name and current date and time. By default the process is not loged to let the program using ProcessLogger the oportunity to verify if the process completed his execution.
-p name of the process 
-f name of the log file either a path or a file name. In the late case the file will be saved in the current folder. Its default value is ProcessLogger.log


Example of use ($ line of code, // commentary):

```shell
// Has process Ananas been executed in the last 2 days 
$ processLogger -p Ananas -d 2
$ False
// the process can then be executed
// If it had been executed succesfully it should be logged
$ processLogger -l -p Ananas
```
