

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.uart_types_pkg.all;

entity uart_channel_array is
  generic(
    TOTAL_CHANNELS : natural := 4;
    TOTAL_TILES    : natural := 10
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
    S_AXI_LITE_araddr : in t_uart_array_32(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_arprot : in t_uart_array_3(0 to TOTAL_CHANNELS *TOTAL_TILES-1);
    S_AXI_LITE_arready : out std_logic_vector(0 to TOTAL_CHANNELS *TOTAL_TILES-1);
    S_AXI_LITE_arvalid : in std_logic_vector(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_awaddr : in t_uart_array_32(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_awprot : in t_uart_array_3(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_awready : out std_logic_vector(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_awvalid : in  std_logic_vector(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_bready : in std_logic_vector(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_bresp : out t_uart_array_2(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_bvalid : out std_logic_vector(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_rdata : out t_uart_array_32(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_rready : in std_logic_vector(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_rresp : out t_uart_array_2(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_rvalid : out std_logic_vector(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_wdata : in t_uart_array_32(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_wready : out std_logic_vector(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_wstrb : in t_uart_array_4(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    S_AXI_LITE_wvalid : in std_logic_vector(0 to TOTAL_CHANNELS * TOTAL_TILES-1);
    MISO : in std_logic_vector(TOTAL_TILES*TOTAL_CHANNELS-1 downto 0);   
    UART_RX_BUSY : out std_logic;
    UART_TX_BUSY : out std_logic;
    TILE_EN      : in  std_logic_vector(0 to TOTAL_TILES-1);
    MOSI         : out std_logic_vector ( TOTAL_TILES*TOTAL_CHANNELS-1 downto 0) ;
    MOSI_loopback  : out std_logic_vector ( TOTAL_TILES*TOTAL_CHANNELS-1 downto 0) 
  );
end uart_channel_array;

architecture arch_imp of uart_channel_array is
  component uart_channel is
  generic (
    C_CHANNEL : STD_LOGIC_VECTOR ( 7 downto 0 ) := x"FF";
    C_LARPIX_DATA_WIDTH : integer := 64;
    C_TOTAL_CHANNELS            : integer := 4;
    C_TILE_ID                   : integer := 0
    );
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    MCLK : in STD_LOGIC;
    MRST : in STD_LOGIC;
    M_AXIS_tdata : out t_uart_array_128 (0 to C_TOTAL_CHANNELS-1);
    M_AXIS_tkeep : out t_uart_array_16(0 to C_TOTAL_CHANNELS-1);
    M_AXIS_tlast : out std_logic_vector(0 to C_TOTAL_CHANNELS-1);
    M_AXIS_tready : in std_logic_vector(0 to C_TOTAL_CHANNELS-1);
    M_AXIS_tstrb : out t_uart_array_16(0 to C_TOTAL_CHANNELS-1);
    M_AXIS_tvalid : out std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  
    PACMAN_TS : in std_logic_vector ( 63 downto 0 );
    S_AXIS_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    S_AXIS_tkeep : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXIS_tlast : in STD_LOGIC;
    S_AXIS_tready : out STD_LOGIC;
    S_AXIS_tstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXIS_tvalid : in STD_LOGIC;
    S_AXI_LITE_araddr : in t_uart_array_32(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_arprot : in t_uart_array_3(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_arready : out std_logic_vector(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_arvalid : in std_logic_vector(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_awaddr : in t_uart_array_32(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_awprot : in t_uart_array_3(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_awready : out std_logic_vector(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_awvalid : in  std_logic_vector(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_bready : in std_logic_vector(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_bresp : out t_uart_array_2(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_bvalid : out std_logic_vector(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_rdata : out t_uart_array_32(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_rready : in std_logic_vector(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_rresp : out t_uart_array_2(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_rvalid : out std_logic_vector(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_wdata : in t_uart_array_32(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_wready : out std_logic_vector(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_wstrb : in t_uart_array_4(0 to C_TOTAL_CHANNELS-1);
    S_AXI_LITE_wvalid : in std_logic_vector(0 to C_TOTAL_CHANNELS-1);
   
    UART_RX : in STD_LOGIC_VECTOR(C_TOTAL_CHANNELS-1 downto 0);
   -- UART_TX : out STD_LOGIC_VECTOR(C_TOTAL_CHANNELS-1 downto 0);
    UART_RX_BUSY : out STD_LOGIC_VECTOR(C_TOTAL_CHANNELS-1 downto 0);
    UART_TX_BUSY : out STD_LOGIC_VECTOR(C_TOTAL_CHANNELS-1 downto 0);

    TILE_EN      : in  std_logic;
    MOSI         : out std_logic_vector(C_TOTAL_CHANNELS-1 downto 0);
    MOSI_loopback: out std_logic_vector(C_TOTAL_CHANNELS-1 downto 0)
  );
end component uart_channel;

  
  COMPONENT axis_interconnect_merge
  PORT (
    ACLK : IN STD_LOGIC;
    ARESETN : IN STD_LOGIC;
    S00_AXIS_ACLK : IN STD_LOGIC;
    S01_AXIS_ACLK : IN STD_LOGIC;
    S02_AXIS_ACLK : IN STD_LOGIC;
    S03_AXIS_ACLK : IN STD_LOGIC;
    S00_AXIS_ARESETN : IN STD_LOGIC;
    S01_AXIS_ARESETN : IN STD_LOGIC;
    S02_AXIS_ARESETN : IN STD_LOGIC;
    S03_AXIS_ARESETN : IN STD_LOGIC;
    S00_AXIS_TVALID : IN STD_LOGIC;
    S01_AXIS_TVALID : IN STD_LOGIC;
    S02_AXIS_TVALID : IN STD_LOGIC;
    S03_AXIS_TVALID : IN STD_LOGIC;
    S00_AXIS_TREADY : OUT STD_LOGIC;
    S01_AXIS_TREADY : OUT STD_LOGIC;
    S02_AXIS_TREADY : OUT STD_LOGIC;
    S03_AXIS_TREADY : OUT STD_LOGIC;
    S00_AXIS_TDATA : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    S01_AXIS_TDATA : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    S02_AXIS_TDATA : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    S03_AXIS_TDATA : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    S00_AXIS_TSTRB : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    S01_AXIS_TSTRB : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    S02_AXIS_TSTRB : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    S03_AXIS_TSTRB : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    S00_AXIS_TKEEP : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    S01_AXIS_TKEEP : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    S02_AXIS_TKEEP : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    S03_AXIS_TKEEP : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    S00_AXIS_TLAST : IN STD_LOGIC;
    S01_AXIS_TLAST : IN STD_LOGIC;
    S02_AXIS_TLAST : IN STD_LOGIC;
    S03_AXIS_TLAST : IN STD_LOGIC;
    M00_AXIS_ACLK : IN STD_LOGIC;
    M00_AXIS_ARESETN : IN STD_LOGIC;
    M00_AXIS_TVALID : OUT STD_LOGIC;
    M00_AXIS_TREADY : IN STD_LOGIC;
    M00_AXIS_TDATA : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    M00_AXIS_TSTRB : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    M00_AXIS_TKEEP : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    M00_AXIS_TLAST : OUT STD_LOGIC;
    S00_ARB_REQ_SUPPRESS : IN STD_LOGIC;
    S01_ARB_REQ_SUPPRESS : IN STD_LOGIC;
    S02_ARB_REQ_SUPPRESS : IN STD_LOGIC;
    S03_ARB_REQ_SUPPRESS : IN STD_LOGIC;
    M00_FIFO_DATA_COUNT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
  END COMPONENT;
  --signal   UART_TX        : std_logic_vector(0 to TOTAL_TILES*TOTAL_CHANNELS-1);
  signal   UART_RX_BUSY_i : std_logic_vector(TOTAL_TILES*TOTAL_CHANNELS-1 downto 0);
  signal   UART_TX_BUSY_i : std_logic_vector(TOTAL_TILES*TOTAL_CHANNELS-1 downto 0);

  signal   M_AXIS_tdata_ch: t_uart_array_128 (0 to TOTAL_CHANNELS*TOTAL_TILES-1);
  signal   M_AXIS_tkeep_ch: t_uart_array_16(0 to  TOTAL_CHANNELS*TOTAL_TILES-1);
  signal   M_AXIS_tlast_ch: std_logic_vector(0 to TOTAL_CHANNELS*TOTAL_TILES-1);
  signal   M_AXIS_tready_ch : std_logic_vector(0 to TOTAL_CHANNELS*TOTAL_TILES-1);
  signal   M_AXIS_tstrb_ch  : t_uart_array_16(0 to TOTAL_CHANNELS*TOTAL_TILES-1);
  signal   M_AXIS_tvalid_ch : std_logic_vector(0 to TOTAL_CHANNELS*TOTAL_TILES-1);
begin
  UART_RX_BUSY <= or UART_RX_BUSY_i;
  UART_TX_BUSY <= or UART_TX_BUSY_i;  
  larpix_uart_gen: for I in 0 to TOTAL_TILES-1 generate
    -- UNUSED_CHANNELS: if( I < 32)  and (I mod 4 = 0) generate
    --   UART_TX (I)       <= '1';
    --   UART_RX_BUSY_i(I) <= '0';
    --   UART_TX_BUSY_i(I) <= '0';    
    -- else generate
      larpix_uart_channel : component uart_channel
        generic map(
          C_TOTAL_CHANNELS => 4,
          C_TILE_ID        => I
          )
      port map (
        ACLK                   => ACLK,
        ARESETN                => ARESETN,
        MCLK                   => MCLK,
        MRST                   => MRST,
        M_AXIS_tdata           => M_AXIS_tdata_ch(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1),
        M_AXIS_tkeep           => M_AXIS_tkeep_ch (TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1),
        M_AXIS_tlast           => M_AXIS_tlast_ch(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        M_AXIS_tready          => M_AXIS_tready_ch(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1),
        M_AXIS_tstrb           => M_AXIS_tstrb_ch(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1),
        M_AXIS_tvalid          => M_AXIS_tvalid_ch(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1),
        PACMAN_TS              => PACMAN_TS,
        S_AXIS_tdata           => S_AXIS_tdata(I),
        S_AXIS_tkeep           => S_AXIS_tkeep(I),
        S_AXIS_tlast           => S_AXIS_tlast(I),
        S_AXIS_tready          => S_AXIS_tready(I),
        S_AXIS_tstrb           => S_AXIS_tstrb(I),
        S_AXIS_tvalid          => S_AXIS_tvalid(I),
        S_AXI_LITE_araddr      => S_AXI_LITE_araddr(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1),
        S_AXI_LITE_arprot      => S_AXI_LITE_arprot(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_arready     => S_AXI_LITE_arready(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1),
        S_AXI_LITE_arvalid     => S_AXI_LITE_arvalid(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1),
        S_AXI_LITE_awaddr      => S_AXI_LITE_awaddr(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_awprot      => S_AXI_LITE_awprot(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_awready     => S_AXI_LITE_awready(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_awvalid     => S_AXI_LITE_awvalid(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1),
        S_AXI_LITE_bready      => S_AXI_LITE_bready(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_bresp       => S_AXI_LITE_bresp(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_bvalid      => S_AXI_LITE_bvalid(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_rdata       => S_AXI_LITE_rdata(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_rready      => S_AXI_LITE_rready(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1),
        S_AXI_LITE_rresp       => S_AXI_LITE_rresp(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1),
        S_AXI_LITE_rvalid      => S_AXI_LITE_rvalid(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_wdata       => S_AXI_LITE_wdata(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_wready      => S_AXI_LITE_wready(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_wstrb       => S_AXI_LITE_wstrb(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        S_AXI_LITE_wvalid      => S_AXI_LITE_wvalid(TOTAL_CHANNELS*I to TOTAL_CHANNELS*I + TOTAL_CHANNELS-1), 
        UART_RX                => MISO( TOTAL_CHANNELS*I + TOTAL_CHANNELS-1 downto TOTAL_CHANNELS*I ), 
      --  UART_TX                => UART_TX(I),
        UART_RX_BUSY           => UART_RX_BUSY_i(TOTAL_CHANNELS*I + TOTAL_CHANNELS-1 downto TOTAL_CHANNELS*I ),
        UART_TX_BUSY           => UART_TX_BUSY_i(TOTAL_CHANNELS*I + TOTAL_CHANNELS-1 downto TOTAL_CHANNELS*I ),
        TILE_EN                => TILE_EN(I),
        MOSI                   => MOSI(TOTAL_CHANNELS*I + TOTAL_CHANNELS-1 downto TOTAL_CHANNELS*I ),
        MOSI_loopback          => MOSI_loopback(TOTAL_CHANNELS*I + TOTAL_CHANNELS-1 downto TOTAL_CHANNELS*I )
        );
  end generate;

  larpix_aximerge_gen: for I in 0 to TOTAL_TILES-1 generate
  axis_interconnect_merge_inst : axis_interconnect_merge
  PORT MAP (
    ACLK => ACLK,
    ARESETN => ARESETN,
    S00_AXIS_ACLK => ACLK,
    S01_AXIS_ACLK => ACLK,
    S02_AXIS_ACLK => ACLK,
    S03_AXIS_ACLK => ACLK,
    S00_AXIS_ARESETN => ARESETN,
    S01_AXIS_ARESETN => ARESETN,
    S02_AXIS_ARESETN => ARESETN,
    S03_AXIS_ARESETN => ARESETN,
    S00_AXIS_TVALID => M_AXIS_tvalid_ch(I*TOTAL_CHANNELS),
    S01_AXIS_TVALID => M_AXIS_tvalid_ch(I*TOTAL_CHANNELS+1),
    S02_AXIS_TVALID => M_AXIS_tvalid_ch(I*TOTAL_CHANNELS+2),
    S03_AXIS_TVALID => M_AXIS_tvalid_ch(I*TOTAL_CHANNELS+3),
    S00_AXIS_TREADY => M_AXIS_tready_ch(I*TOTAL_CHANNELS),
    S01_AXIS_TREADY => M_AXIS_tready_ch(I*TOTAL_CHANNELS+1),
    S02_AXIS_TREADY => M_AXIS_tready_ch(I*TOTAL_CHANNELS+2),
    S03_AXIS_TREADY => M_AXIS_tready_ch(I*TOTAL_CHANNELS+3),
    S00_AXIS_TDATA => M_AXIS_tdata_ch(I*TOTAL_CHANNELS), 
    S01_AXIS_TDATA => M_AXIS_tdata_ch(I*TOTAL_CHANNELS+1), 
    S02_AXIS_TDATA => M_AXIS_tdata_ch(I*TOTAL_CHANNELS+2), 
    S03_AXIS_TDATA => M_AXIS_tdata_ch(I*TOTAL_CHANNELS+3), 
    S00_AXIS_TSTRB => M_AXIS_tstrb_ch(I*TOTAL_CHANNELS),
    S01_AXIS_TSTRB => M_AXIS_tstrb_ch(I*TOTAL_CHANNELS+1),
    S02_AXIS_TSTRB => M_AXIS_tstrb_ch(I*TOTAL_CHANNELS+2),
    S03_AXIS_TSTRB => M_AXIS_tstrb_ch(I*TOTAL_CHANNELS+3),
    S00_AXIS_TKEEP => M_AXIS_tkeep_ch (I*TOTAL_CHANNELS),
    S01_AXIS_TKEEP => M_AXIS_tkeep_ch (I*TOTAL_CHANNELS+1),
    S02_AXIS_TKEEP => M_AXIS_tkeep_ch (I*TOTAL_CHANNELS+2),
    S03_AXIS_TKEEP => M_AXIS_tkeep_ch (I*TOTAL_CHANNELS+3),
    S00_AXIS_TLAST => M_AXIS_tlast_ch(I*TOTAL_CHANNELS),
    S01_AXIS_TLAST => M_AXIS_tlast_ch(I*TOTAL_CHANNELS+1),
    S02_AXIS_TLAST => M_AXIS_tlast_ch(I*TOTAL_CHANNELS+2),
    S03_AXIS_TLAST => M_AXIS_tlast_ch(I*TOTAL_CHANNELS+3),
    M00_AXIS_ACLK => ACLK,
    M00_AXIS_ARESETN => ARESETN,
    M00_AXIS_TVALID => M_AXIS_TVALID(I),
    M00_AXIS_TREADY => M_AXIS_TREADY(I),
    M00_AXIS_TDATA => M_AXIS_TDATA(I),
    M00_AXIS_TSTRB => M_AXIS_TSTRB(I),
    M00_AXIS_TKEEP => M_AXIS_TKEEP(I),
    M00_AXIS_TLAST => M_AXIS_TLAST(I),
    S00_ARB_REQ_SUPPRESS => '0',
    S01_ARB_REQ_SUPPRESS => '0',
    S02_ARB_REQ_SUPPRESS => '0',
    S03_ARB_REQ_SUPPRESS => '0'
    --M00_FIFO_DATA_COUNT => M00_FIFO_DATA_COUNT
  );
 end generate;  
end arch_imp;

