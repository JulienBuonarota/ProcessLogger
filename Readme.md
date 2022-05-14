ProcessLogger allow to keep a log of process, keeping track of their execution.
 It allow to ask the question:
   <q>As this process been executed in the last minute/hour/day...\</q>


## Options
### Elapse time management
By default all values are set to 0
 <ul>
  <li> <b>y</b> elapse time in year since last execution </li>
  <li> <b>m</b> elapse time in month since last execution </li>
  <li> <b>d</b> elapse time in day since last execution </li>
  <li> <b>H</b> elapse time in hour since last execution </li>
  <li> <b>M</b> elapse time in minute since last execution </li>
  <li> <b>S</b> elapse time in second since last execution </li>
</ul> 

### Other options
<ul> 
  <li> <b>l</b> if given, the process will be haded to log with name and
  current date and time. By default the process is not loged to let
  the program using ProcessLogger the oportunity to verify if the
  process completed his execution. </li>
  
  <li> <b>p</b> name of the process  </li>

  <li> <b>f</b> name of the log file either a path or a file name. In the
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
