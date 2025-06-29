set history save
set history filename ~/.gdb_history
set verbose off
set print pretty on
set print array off
set print array-indexes on
set confirm off
set pagination off
set auto-load safe-path /
#set substitute-path / /media/nomachine/work/

set remotetimeout 100000
set breakpoint pending on
b main
b _Dmain
#b _d_throw
