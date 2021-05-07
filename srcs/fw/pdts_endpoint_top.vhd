library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use work.pdts_defs.all;
--use work.pdts_ep_pkg.all;

entity pdts_endpoint_top is
	generic(
	--	SCLK_FREQ: real := 50.0; -- Frequency (MHz) of the supplied sclk
		EN_TX: boolean := false;
		SIM: boolean := false;
		NEED_ADJUST: boolean := true;
		NEED_TSTAMP: boolean := true
	);
	port(
		sclk: in std_logic; -- Free-running system clock
		srst: in std_logic; -- System reset (sclk domain)
		addr: in std_logic_vector(7 downto 0); -- Endpoint address (async, sampled in clk domain)
		tgrp: in std_logic_vector(1 downto 0); -- Timing group (async, sampled in clk domain)
		stat: out std_logic_vector(3 downto 0); -- Status output (sclk domain)
		rec_clk: in std_logic; -- CDR recovered clock from timing link
		rec_d: in std_logic; -- CDR recovered data from timing link (rec_clk domain)
		txd: out std_logic; -- Output data to timing link (rec_clk domain)
		sfp_los: in std_logic := '0'; -- SFP LOS line (async, sampled in sclk domain)
		cdr_los: in std_logic := '0'; -- CDR LOS line (async, sampled in sclk domain)
		cdr_lol: in std_logic := '0'; -- CDR LOL line (async, sampled in sclk domain)
		sfp_tx_dis: out std_logic; -- SFP tx disable line (clk domain)
		clk: out std_logic; -- 50MHz clock output
		rst: out std_logic; -- 50MHz domain reset
		rdy: out std_logic; -- Timestamp valid flag
		sync: out std_logic_vector(SCMD_W - 1 downto 0); -- Sync command output (clk domain)
		sync_stb: out std_logic; -- Sync command strobe (clk domain)
		sync_first: out std_logic; -- Sync command valid flag (clk domain)
		tstamp: out std_logic_vector(8 * TSTAMP_WDS - 1 downto 0); -- Timestamp out
                tsync_in: in std_logic_vector(9 downto 0); -- Tx sync command input
                tsync_out: out std_logic_vector(1 downto 0); -- Tx sync command handshake
		debug: out std_logic_vector(31 downto 0) := (others => '0') -- port for debug info, e.g. applied delay values
	);
end pdts_endpoint_top;

architecture rtl of pdts_endpoint_top is
  signal tsync_out_r : cmd_r;
  signal tsync_in_r : cmd_w;
begin
  tsync_out(0)   <=tsync_out_r.ren;
  tsync_out(1)   <= tsync_out_r.ack;
  tsync_in_r.d    <= tsync_in(7 downto 0);
  tsync_in_r.req <= tsync_in(8);
  tsync_in_r.last <= tsync_in(9);
  
  ep:  entity work.pdts_endpoint
    generic map(
      SCLK_FREQ => 50.0,
      EN_TX => EN_TX,
      SIM     => SIM,
      NEED_ADJUST => NEED_ADJUST,
      NEED_TSTAMP => NEED_TSTAMP
      )
    port map (
      sclk => sclk,
      srst => srst,
      addr => addr,
      tgrp => tgrp,
      stat => stat,
      rec_clk => rec_clk,
      rec_d   => rec_d,
      txd      => txd,
      sfp_los=> sfp_los,
      cdr_los=> cdr_los,
      cdr_lol => cdr_lol,
      sfp_tx_dis => sfp_tx_dis,
      clk             => clk,
      rst             => rst,
      rdy            => rdy,
      sync          => sync,
      sync_stb   => sync_stb,
      sync_first  => sync_first,
      tsync_in    => tsync_in_r,
      tsync_out  => tsync_out_r
      
      );
end rtl;
