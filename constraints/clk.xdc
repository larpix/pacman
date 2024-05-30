set_false_path -from [get_pins {{zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[0]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[10]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[11]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[12]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[13]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[14]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[15]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[16]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[17]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[18]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[19]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[1]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[20]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[21]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[22]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[23]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[24]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[25]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[26]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[27]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[28]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[29]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[2]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[30]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[31]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[3]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[4]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[5]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[6]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[7]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[8]/C} {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[9]/C}}] -to [get_pins {{zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig1_mask_meta_reg[0]/D} {zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig1_mask_meta_reg[1]/D} {zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig1_mask_meta_reg[2]/D} {zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig1_mask_meta_reg[3]/D} {zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig1_mask_meta_reg[4]/D} {zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig1_mask_meta_reg[5]/D} {zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig1_mask_meta_reg[6]/D} {zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig1_mask_meta_reg[7]/D}}]

#set_property IOSTANDARD LVDS_25 [get_ports {sfp_clk_p}]
#set_property IOSTANDARD LVDS_25 [get_ports {sfp_clk_n}]

set_property IOSTANDARD LVCMOS25 [get_ports pdts_sfp_tx_dis]
set_property IOSTANDARD LVCMOS25 [get_ports sfp_los]
set_property IOSTANDARD LVCMOS25 [get_ports cdr_los]
set_property IOSTANDARD LVCMOS25 [get_ports cdr_lol]


#set_property PACKAGE_PIN AA22 [get_ports {sfp_clk_p}]
#set_property PACKAGE_PIN AB23 [get_ports {sfp_clk_n}]

set_false_path -from [get_pins {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[*]/C}] -to [get_pins {zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig1_mask_meta_reg[*]/D}]

set_false_path -from [get_pins {zsys_i/larpix_trig/axi_lite_reg_space/axi_lite_reg_space_0/U0/slv_reg1_reg[*]/C}] -to [get_pins {zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig1_mask_meta_reg[*]/D}]
set_false_path -to [get_cells -hierarchical -regexp .*zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig2_mask_meta_reg.*]
set_false_path -to [get_cells -hierarchical -regexp .*zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig3_mask_meta_reg.*]
set_false_path -to [get_cells -hierarchical -regexp .*zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig1_mask_meta_reg.*]
set_false_path -to [get_cells -hierarchical -regexp .*zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig0_mask_meta_reg.*]

set_false_path -to [get_pins -hierarchical -regexp {.*zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig_len_meta_reg\[[0-9]\]/D.*}]

set_false_path -to [get_pins -hierarchical -regexp {.*zsys_i/larpix_trig/larpix_trig_gen_0/U0/TRIG[0-3]_IN_d_reg\[0\]/D.*}]

set_false_path -to [get_pins -hierarchical -regexp {.*zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig0_mask_meta_reg\[[0-9]\]/D.*}]
set_false_path -to [get_pins -hierarchical -regexp {.*zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig_len_meta_reg\[[0-9]\]*/D.*}]
set_false_path -to [get_pins -hierarchical -regexp {.*zsys_i/larpix_trig/larpix_trig_gen_0/U0/trig_len_meta_reg\[[0-9]\]*/D.*}]


#J2 header: pin 7
#J2 header: pin 8






