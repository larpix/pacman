#
# vivado -mode batch -source tcl/build_xpr.tcl 
#
# Builds the PACMAN firware project and exports the hardware to
#
#     products-oldtimerev4/zsys_wrapper.hdf
#

set jobs 2
set synth_run synth_1
set impl_run impl_1

# open the project:
open_project ./pacman-oldtimerev4-fw/pacman-oldtimerev4-fw.xpr

# delete the top-level wrapper if it already exists:
set file "[get_files -quiet "zsys_wrapper.vhd"]"
if { $file != "" } { 
    puts "deleting top-level wrapper"
    remove_files  $file
    file delete -force $file
}

# recrete the top-level wrapper
puts "recreating top-level wrapper"
make_wrapper -files [get_files zsys.bd] -top
add_files -norecurse pacman-oldtimerev4-fw/pacman-oldtimerev4-fw.srcs/sources_1/bd/zsys/hdl/zsys_wrapper.vhd
set_property source_mgmt_mode None [current_project]
set_property top zsys_wrapper [current_fileset]
set_property source_mgmt_mode All [current_project]
update_compile_order -fileset sources_1

update_compile_order -fileset sources_1
#FIFO IP needs upgrade for Vivado 2020.2
upgrade_ip [get_ips]
reset_run $synth_run
reset_run $impl_run
launch_runs $synth_run -jobs $jobs
wait_on_run $synth_run
launch_runs $impl_run -jobs $jobs
wait_on_run $impl_run
launch_runs $impl_run -to_step write_bitstream -jobs $jobs
wait_on_run $impl_run
update_compile_order -fileset sources_1

write_hw_platform -fixed -include_bit -force -file ./pacman-oldtimerev4-fw/hw_platform/zsys_wrapper.xsa
file copy -force ./pacman-oldtimerev4-fw/pacman-oldtimerev4-fw.runs/impl_1/zsys_wrapper.bit ./products-oldtimerev4/zsys_wrapper.bit
file copy -force ./pacman-oldtimerev4-fw/hw_platform/zsys_wrapper.xsa ./products-oldtimerev4/.


