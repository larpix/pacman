set_clock_groups -asynchronous -group clk_fpga_0 -group clk_fpga_1

set_property IOSTANDARD LVDS_25 [get_ports {sfp_clk_p[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {sfp_clk_n[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports pdts_sfp_tx_dis]
set_property PACKAGE_PIN W16 [get_ports {cdr_data_clk_p[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports sfp_los]
set_property IOSTANDARD LVCMOS25 [get_ports cdr_los]
set_property IOSTANDARD LVCMOS25 [get_ports cdr_lol]

set_property PACKAGE_PIN W17 [get_ports {cdr_clk_clk_p[0]}]
set_property PACKAGE_PIN W20 [get_ports {sfp_tx_p[0]}]

set_property PACKAGE_PIN AA22 [get_ports {sfp_clk_p[0]}]
