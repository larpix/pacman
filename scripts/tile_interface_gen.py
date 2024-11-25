#!/usr/bin/python3

print("SAIRAM");
import sys

orig_stdout = sys.stdout
f = open('uart_channel_top.vhd', 'w')
sys.stdout = f

tiles    = 10; #10; #8;
channels = 4; #40; #32;

#TILES - OUTPUT TO PROCESSOR
m_axis_interface_to_processor = {
    "M_AXIS_tdata  : out std_logic_vector (127 downto 0);",
    "M_AXIS_tkeep  : out std_logic_vector(15 downto 0);",
    "M_AXIS_tlast  : out std_logic;",
    "M_AXIS_tready : in std_logic;",
    "M_AXIS_tstrb  : out std_logic_vector(15 downto 0);",
    "M_AXIS_tvalid : out std_logic;"
    }

#CHANNELS - INPUT FROM TILES
s_axis_interface_from_tile = {
    "S_AXIS_tdata : in std_logic_vector(127 downto 0);",
    "S_AXIS_tkeep : in std_logic_vector(15 downto 0);",
    "S_AXIS_tlast : in std_logic;",
    "S_AXIS_tready : out std_logic;",
    "S_AXIS_tstrb : in std_logic_vector(15 downto 0);",
    "S_AXIS_tvalid : in std_logic;"
    }

#AXI-LITE INTERFACE FROM PROCESSOR TO CHANNELS
s_axi_lite = {   
    "S_AXI_LITE_araddr : in std_logic_vector(31 downto 0);",
    "S_AXI_LITE_arprot : in std_logic_vector(2 downto 0);",
    "S_AXI_LITE_arready : out std_logic;",
    "S_AXI_LITE_arvalid : in std_logic;",
    "S_AXI_LITE_awaddr : in std_logic_vector(31 downto 0);",
    "S_AXI_LITE_awprot : in std_logic_vector(2 downto 0);",
    "S_AXI_LITE_awready : out std_logic;",
    "S_AXI_LITE_awvalid : in  std_logic;",
    "S_AXI_LITE_bready : in std_logic;",
    "S_AXI_LITE_bresp : out std_logic_vector(1 downto 0);",
    "S_AXI_LITE_bvalid : out std_logic;",
    "S_AXI_LITE_rdata : out std_logic_vector(31 downto 0);",
    "S_AXI_LITE_rready : in std_logic;",
    "S_AXI_LITE_rresp : out std_logic_vector(1 downto 0);", 
    "S_AXI_LITE_rvalid : out std_logic;",
    "S_AXI_LITE_wdata : in std_logic_vector (31 downto 0);",
    "S_AXI_LITE_wready : out std_logic;",
    "S_AXI_LITE_wstrb : in std_logic_vector(3 downto 0);",
    "S_AXI_LITE_wvalid : in std_logic;"
};


print ("""
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.uart_types_pkg.all;

entity uart_channel_top is
  generic(
    TOTAL_CHANNELS : integer := """,channels,"""; 
    TOTAL_TILES    : integer := """, tiles, """ 
    );
   port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    MCLK : in STD_LOGIC;
    MRST : in STD_LOGIC;
""");
print("--MAXIS interface")
for i in range(tiles):
    for x in m_axis_interface_to_processor:        
        txt = x.replace("M_AXIS","M_AXIS"+str(i))
        print("\t",txt)
    print("\n")
          
print("--SAXIS interface")
for i in range(tiles):
    for x in s_axis_interface_from_tile:
        txt = x.replace("S_AXIS","S_AXIS"+str(i))
        print("\t",txt)
    print("\n")

print("--A_AXI_LITE interface")
for i in range(channels*tiles):
    for x in s_axi_lite:
        txt = x.replace("S_AXI_LITE","S_AXI_LITE"+str(i))
        print("\t",txt)
    print("\n")
        
print ("""   
    PACMAN_TS : in std_logic_vector ( 63 downto 0 );
    MISO : in std_logic_vector(TOTAL_TILES * TOTAL_CHANNELS-1 downto 0);   
    UART_RX_BUSY : out std_logic;
    UART_TX_BUSY : out std_logic;
    TILE_EN      : in  std_logic_vector(0 to TOTAL_TILES-1);
    MOSI         : out std_logic_vector (TOTAL_TILES * TOTAL_CHANNELS-1 downto 0) ;
    MOSI_loopback : out std_logic_vector (TOTAL_TILES * TOTAL_CHANNELS-1 downto 0) 
  
  );
end uart_channel_top;
""");


print ("""
architecture arch_imp of uart_channel_top is
   component uart_channel_array is
       generic(
    TOTAL_CHANNELS : integer := """, channels,""";
    TOTAL_TILES    : integer := """, tiles,"""
    );
   port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    MCLK : in STD_LOGIC;
    MRST : in STD_LOGIC;
    M_AXIS_tdata : out t_uart_array_128 (0 to TOTAL_TILES-1);
    M_AXIS_tkeep : out t_uart_array_16(0 to TOTAL_TILES-1);
    M_AXIS_tlast : out std_logic_vector(0 to TOTAL_TILES-1);
    M_AXIS_tready : in std_logic_vector(0 to TOTAL_TILES-1);
    M_AXIS_tstrb : out t_uart_array_16(0 to TOTAL_TILES-1);
    M_AXIS_tvalid : out std_logic_vector(0 to TOTAL_TILES-1);
    PACMAN_TS : in std_logic_vector ( 63 downto 0 );
    S_AXIS_tdata : in t_uart_array_128 (0 to TOTAL_TILES-1);
    S_AXIS_tkeep : in t_uart_array_16(0 to TOTAL_TILES-1);
    S_AXIS_tlast : in std_logic_vector(0 to TOTAL_TILES-1);
    S_AXIS_tready : out std_logic_vector(0 to TOTAL_TILES-1);
    S_AXIS_tstrb : in t_uart_array_16(0 to TOTAL_TILES-1);
    S_AXIS_tvalid : in std_logic_vector(0 to TOTAL_TILES-1);
    S_AXI_LITE_araddr : in t_uart_array_32(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_arprot : in t_uart_array_3(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_arready : out std_logic_vector(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_arvalid : in std_logic_vector(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_awaddr : in t_uart_array_32(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_awprot : in t_uart_array_3(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_awready : out std_logic_vector(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_awvalid : in  std_logic_vector(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_bready : in std_logic_vector(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_bresp : out t_uart_array_2(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_bvalid : out std_logic_vector(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_rdata : out t_uart_array_32(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_rready : in std_logic_vector(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_rresp : out t_uart_array_2(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_rvalid : out std_logic_vector(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_wdata : in t_uart_array_32(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_wready : out std_logic_vector(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_wstrb : in t_uart_array_4(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    S_AXI_LITE_wvalid : in std_logic_vector(0 to  TOTAL_TILES*TOTAL_CHANNELS-1);
    MISO : in std_logic_vector( TOTAL_TILES*TOTAL_CHANNELS-1 downto 0);   
    UART_RX_BUSY : out std_logic;
    UART_TX_BUSY : out std_logic;
    TILE_EN      : in  std_logic_vector(0 to TOTAL_TILES-1);
    MOSI         : out std_logic_vector (  TOTAL_TILES*TOTAL_CHANNELS-1 downto 0) ;
    MOSI_loopback  : out std_logic_vector (  TOTAL_TILES*TOTAL_CHANNELS-1 downto 0) 
  );
  end component;

  signal M_AXIS_tdata : t_uart_array_128 (0 to TOTAL_TILES-1);
  signal M_AXIS_tkeep : t_uart_array_16(0 to TOTAL_TILES-1);
  signal M_AXIS_tlast : std_logic_vector(0 to TOTAL_TILES-1);
  signal M_AXIS_tready : std_logic_vector(0 to TOTAL_TILES-1);
  signal M_AXIS_tstrb : t_uart_array_16(0 to TOTAL_TILES-1);
  signal M_AXIS_tvalid: std_logic_vector(0 to TOTAL_TILES-1);

  signal S_AXIS_tdata : t_uart_array_128 (0 to TOTAL_TILES-1);
  signal S_AXIS_tkeep : t_uart_array_16(0 to TOTAL_TILES-1);
  signal S_AXIS_tlast : std_logic_vector(0 to TOTAL_TILES-1);
  signal S_AXIS_tready :std_logic_vector(0 to TOTAL_TILES-1);
  signal S_AXIS_tstrb  :t_uart_array_16(0 to TOTAL_TILES-1);
  signal S_AXIS_tvalid :std_logic_vector(0 to TOTAL_TILES-1);
 
  signal S_AXI_LITE_araddr :t_uart_array_32(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_arprot :t_uart_array_3(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_arready :std_logic_vector(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_arvalid :std_logic_vector(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_awaddr :t_uart_array_32(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_awprot :t_uart_array_3(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_awready :std_logic_vector(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_awvalid : std_logic_vector(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_bready :std_logic_vector(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_bresp :t_uart_array_2(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_bvalid :std_logic_vector(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_rdata :t_uart_array_32(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_rready :std_logic_vector(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_rresp :t_uart_array_2(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_rvalid :std_logic_vector(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_wdata :t_uart_array_32(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_wready :std_logic_vector(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_wstrb :t_uart_array_4(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal S_AXI_LITE_wvalid :std_logic_vector(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
begin
""");
for i in range(tiles):
    for x in m_axis_interface_to_processor:
        variable,pattern,type = x.partition(':')        
        txt = variable.replace("M_AXIS", "M_AXIS"+str(i))
        if " in " in type:
            z   = variable + "("+str(i)+") <= " + txt + ";";
        else:
            z   = txt + " <= " + variable + "("+str(i)+")" + ";"
        print("\t",z)
        


for i in range(tiles):
    for x in s_axis_interface_from_tile:
        variable,pattern, type = x.partition(':')
        txt = variable.replace("S_AXIS","S_AXIS"+str(i))
        if " in " in type:
            z   = variable + "("+str(i)+") <= " + txt + ";";
        else:
            z   = txt + " <= " + variable + "("+str(i)+")" + ";"
        print("\t",z)

for i in range(tiles*channels):
    for x in s_axi_lite:
        variable,pattern, type = x.partition(':')
        txt = variable.replace("S_AXI_LITE","S_AXI_LITE"+str(i))
        if " in " in type:
            z   = variable + "("+str(i)+") <= " + txt + ";";
        else:
            z   = txt + " <= " + variable + "("+str(i)+")" + ";"
        print("\t",z)        
print("""
uart_channel_array_inst : component uart_channel_array
  generic map(
    TOTAL_TILES =>""", tiles,""",
    TOTAL_CHANNELS => """, channels,"""
  )
  port map(
   ACLK => ACLK,
   ARESETN => ARESETN,
   MCLK    => MCLK,
   MRST    => MRST,
   M_AXIS_tdata => M_AXIS_tdata,
    M_AXIS_tkeep => M_AXIS_tkeep ,
    M_AXIS_tlast => M_AXIS_tlast,
    M_AXIS_tready => M_AXIS_tready,
    M_AXIS_tstrb  => M_AXIS_tstrb,
    M_AXIS_tvalid => M_AXIS_tvalid,
    PACMAN_TS     => PACMAN_TS,
    S_AXIS_tdata  => S_AXIS_tdata,
    S_AXIS_tkeep  => S_AXIS_tkeep,
    S_AXIS_tlast  => S_AXIS_tlast,
    S_AXIS_tready => S_AXIS_tready,
    S_AXIS_tstrb  => S_AXIS_tstrb,
    S_AXIS_tvalid => S_AXIS_tvalid,
    S_AXI_LITE_araddr => S_AXI_LITE_araddr,
    S_AXI_LITE_arprot => S_AXI_LITE_arprot,
    S_AXI_LITE_arready => S_AXI_LITE_arready,
    S_AXI_LITE_arvalid => S_AXI_LITE_arvalid,
    S_AXI_LITE_awaddr  => S_AXI_LITE_awaddr,
    S_AXI_LITE_awprot  => S_AXI_LITE_awprot,
    S_AXI_LITE_awready => S_AXI_LITE_awready,
    S_AXI_LITE_awvalid => S_AXI_LITE_awvalid,
    S_AXI_LITE_bready  => S_AXI_LITE_bready,
    S_AXI_LITE_bresp   => S_AXI_LITE_bresp,
    S_AXI_LITE_bvalid  => S_AXI_LITE_bvalid,
    S_AXI_LITE_rdata   => S_AXI_LITE_rdata,
    S_AXI_LITE_rready  => S_AXI_LITE_rready,
    S_AXI_LITE_rresp   => S_AXI_LITE_rresp,
    S_AXI_LITE_rvalid  => S_AXI_LITE_rvalid,
    S_AXI_LITE_wdata   =>  S_AXI_LITE_wdata,
    S_AXI_LITE_wready  => S_AXI_LITE_wready,
    S_AXI_LITE_wstrb   => S_AXI_LITE_wstrb,
    S_AXI_LITE_wvalid  => S_AXI_LITE_wvalid,
    MISO               => MISO,
    UART_RX_BUSY       => UART_RX_BUSY,
    UART_TX_BUSY       => UART_TX_BUSY,
    TILE_EN            => TILE_EN,
    MOSI               => MOSI,
    MOSI_loopback      => MOSI_loopback
  );
end arch_imp;
""");
