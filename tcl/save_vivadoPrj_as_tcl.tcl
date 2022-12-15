write_project_tcl my_create_project.tcl
set ip_list [get_ips *]
set iter  1
foreach a $ip_list {
    write_ip_tcl $a my_ip_$iter.tcl
    incr iter
    #Looks like -multiple_files can be used and you can just provide a list of arguments
}
# get_files bd_list *.bd
# set iter 1
# foreach a $bd_list  {
#     open_bd_design $a
#     write_bd_tcl  my_bd_$iter.tcl
#     close_bd_design [get_bd_designs *]
#     incr iter
# }
