# killbygrep
killbygrep kill processes that matches with the associate grep

The syntax is 

killbygrep.sh grepstring [forcekill]

killbygrep perform a research as follow:

ps aux |grep grepstring

creates a list of process, shoe the process and their PID to the user and askes if they have to be killed.

The script can kill the processes without ask the user by adding a second paramenter, forcekill.
