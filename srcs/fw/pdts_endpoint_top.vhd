library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use work.pdts_defs.all;
use work.pdts_ep_defs.all;

entity pdts_endpoint_top is
	port(
		sclk: in std_logic; -- Free-running system clock
		srst: in std_logic; -- System reset (sclk domain)
		addr: in std_logic_vector(15 downto 0); -- Endpoint address (async, sampled in clk domain)	
		stat: out std_logic_vector(3 downto 0); -- Status output (sclk domain)
                rxd: in std_logic; -- Timing input (clk domain)
		txd: out std_logic; -- Output data to timing link (rec_clk domain)
                txenb: out std_logic; -- Timing output enable (active low for SFP) (clk domain)
		sfp_los: in std_logic := '0'; -- SFP LOS line (async, sampled in sclk domain)
		clk: out std_logic; -- 50MHz clock output
		rst: out std_logic; -- 50MHz domain reset
		rdy: out std_logic; -- Timestamp valid flag
		sync: out std_logic_vector(7 downto 0); -- Sync command output (clk domain)
		sync_stb: out std_logic; -- Sync command strobe (clk domain)
		tstamp: out std_logic_vector(64 - 1 downto 0); -- Timestamp out
                dcmd  : out std_logic_vector (7 downto 0);
                pdts_debug : out std_logic_vector(31 downto 0)
          
	);
end pdts_endpoint_top;



architecture rtl of pdts_endpoint_top is
  signal ctrl_out : pdts_cmo;
  signal ctrl_in  : pdts_cmi;
  signal pdts_clk :std_logic;
  signal pdts_rst :std_logic;
  signal pdts_sync: std_logic_vector(7 downto 0);
  signal pdts_sync_stb : std_logic;
  ATTRIBUTE X_INTERFACE_PARAMETER : string;
  ATTRIBUTE X_INTERFACE_PARAMETER of clk: SIGNAL is "FREQ_HZ 62500000"; 
begin
  clk <= pdts_clk;
  rst <= pdts_rst;
  sync<= pdts_sync;
  sync_stb <= pdts_sync_stb;
  
  ep:  entity work.pdts_endpoint
    generic map(
      SCLK_FREQ => 100.0  --PRIYA 50.0,
     --  BUFG_IN_DATAPATH => true
      --EXT_PLL_DIV => 1
      )
    port map (
      sys_clk => sclk,
      sys_rst => srst,
      sys_addr => addr,
     -- sys_ctrl_in  => sys_ctrl_in,     
     -- sys_ctrl_out => sys_ctrl_out,
      sys_stat => stat,
      ctrl_out=>ctrl_out,
      ctrl_in => ctrl_in ,
--      pll_clko => unused
--      pll_clki => unused
    
      los => sfp_los,
      rxd => rxd,
      txd      => txd,
      txenb    => txenb,
      clk             => pdts_clk,
      rst             => pdts_rst,
--      clk2x         => unused
--      clk4x         => unused
      ready           => rdy,
      tstamp          => tstamp,
      sync            => pdts_sync,
      sync_stb        => pdts_sync_stb,
      debug            => pdts_debug
      );

  decode: entity work.pdts_cmd_decoder
    port map(
      clk => pdts_clk,
      rst => pdts_rst,
      ctrl_in => ctrl_out,
      ctrl_out => ctrl_in,
      sync => pdts_sync,
      sync_stb => pdts_sync_stb,
      cmd => dcmd
      );

end rtl;
