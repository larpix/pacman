-- diff_clock - Differential Clock Interface (slave directions)
-- 
-- Allowed parameters:
--  FREQ_HZ                   - Frequency                 (float default: 100000000) 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VComponents.all;

entity d_clk is
  Port (

  s_clk_p : in std_logic; -- ClockP (optional)
  s_clk_n : in std_logic; -- ClockN (optional)
           o : out STD_LOGIC;
           ob : out STD_LOGIC);
end d_clk;
architecture rtl of d_clk is

  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO of s_clk_p: SIGNAL is "xilinx.com:interface:diff_clock:1.0 d_clk CLK_P";
  ATTRIBUTE X_INTERFACE_INFO of s_clk_n: SIGNAL is "xilinx.com:interface:diff_clock:1.0 d_clk CLK_N";
  -- Uncomment the following to set interface specific parameter on the bus interface.
  --  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  --  ATTRIBUTE X_INTERFACE_PARAMETER of <port_name>: SIGNAL is "FREQ_HZ <value>";

begin

IBUFDS_DIFF_OUT_inst : IBUFDS_DIFF_OUT
generic map (
   DIFF_TERM => TRUE, -- Differential Termination
   IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
   IOSTANDARD => "DEFAULT") -- Specify the input I/O standard
port map (
   O => o,     -- Buffer diff_p output
   OB => ob,   -- Buffer diff_n output
   I => s_clk_p,  -- Diff_p buffer input (connect directly to top-level port)
   IB => s_clk_n -- Diff_n buffer input (connect directly to top-level port)
);
end rtl;
