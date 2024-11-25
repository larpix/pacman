library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.uart_types_pkg.all;

entity uart_channel is
  generic (
    C_CHANNEL : STD_LOGIC_VECTOR ( 7 downto 0 ) := x"FF";
    C_LARPIX_DATA_WIDTH : integer := 64;
    C_TILE_ID           : integer := 0;
    C_TOTAL_CHANNELS            : integer := 4
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
end uart_channel;

architecture arch_imp of uart_channel is
  component larpix_uart_tx_noAXIS is   
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    MCLK : in STD_LOGIC;
    MRST : in STD_LOGIC;
    UART_TX_OUT : out STD_LOGIC;
    CLKOUT_RATIO : in STD_LOGIC_VECTOR ( 7 downto 0 );
    CLKOUT_PHASE : in STD_LOGIC_VECTOR ( 3 downto 0 );    
    FIFO_COUNT : out STD_LOGIC_VECTOR ( 8 downto 0 );
    UART_TX_BUSY : out STD_LOGIC;
    larpix_update : in std_logic;
    larpix_data : in std_logic_vector ( C_LARPIX_DATA_WIDTH-1 downto 0 )
  );
  end component larpix_uart_tx_noAXIS;

  component  axi_stream_to_larpix_all_channels is
  generic (
    C_S_AXIS_TDATA_WIDTH        : integer := 128;
    C_LARPIX_DATA_WIDTH         : integer := 64;
    C_TOTAL_CHANNELS            : integer := 4;
    C_CHANNEL                   : std_logic_vector(7 downto 0) := x"FF";
    C_DATA_TYPE                 : std_logic_vector(7 downto 0) := x"44";
    C_TILE_ID                   : integer := 15
    );
  port (
    --C_CHANNEL           : in std_logic_vector(7 downto 0) := x"FF";
    data_LArPix         : out t_uart_array_64(0 to C_TOTAL_CHANNELS - 1);
    data_update_LArPix  : out std_logic_vector(C_TOTAL_CHANNELS-1 downto 0);
    busy_LArPix         : in std_logic_vector(C_TOTAL_CHANNELS-1 downto 0);    
    S_AXIS_ACLK	        : in std_logic;
    S_AXIS_ARESETN	: in std_logic;

    S_AXIS_TREADY	: out std_logic;
    S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
    S_AXIS_TSTRB    : in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
    S_AXIS_TKEEP    : in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
    S_AXIS_TLAST    : in std_logic;
    S_AXIS_TVALID	: in std_logic
    );
  end component axi_stream_to_larpix_all_channels;

    
  component larpix_uart_rx is
    generic (
      C_CHANNEL : STD_LOGIC_VECTOR ( 7 downto 0 ) := C_CHANNEL
      );
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    MCLK : in STD_LOGIC;
    CLKIN_RATIO : in STD_LOGIC_VECTOR ( 7 downto 0 );
    CLKIN_PHASE : in STD_LOGIC_VECTOR ( 7 downto 0 );
    PACMAN_TS : in std_logic_vector ( 63 downto 0 );
    UART_RX_IN : in STD_LOGIC;
    UART_RX_BUSY : out STD_LOGIC;
    M_AXIS_TVALID : out STD_LOGIC;
    M_AXIS_TDATA : out STD_LOGIC_VECTOR ( 127 downto 0 );
    M_AXIS_TKEEP : out STD_LOGIC_VECTOR ( 15 downto 0 );
    M_AXIS_TSTRB : out STD_LOGIC_VECTOR ( 15 downto 0 );
    M_AXIS_TLAST : out STD_LOGIC;
    M_AXIS_TREADY : in STD_LOGIC
    );
  end component larpix_uart_rx;

  component axi_lite_reg_space is
    generic (
    C_S_AXI_LITE_DATA_WIDTH : integer := 32;
    C_S_AXI_LITE_ADDR_WIDTH : integer := 32;
    C_RW_REG0_DEFAULT : std_logic_vector(31 downto 0) := x"00000002";
    C_RW_REG1_DEFAULT : std_logic_vector(31 downto 0) := x"00000001";
    C_RW_REG2_DEFAULT : std_logic_vector(31 downto 0) := x"00000000";
    C_RW_REG3_DEFAULT : std_logic_vector(31 downto 0) := x"00000000";
    C_RO_REG0_OFFSET : std_logic_vector(11 downto 0) := x"000";
    C_RO_REG1_OFFSET : std_logic_vector(11 downto 0) := x"004";
    C_RO_REG2_OFFSET : std_logic_vector(11 downto 0) := x"008";
    C_RO_REG3_OFFSET : std_logic_vector(11 downto 0) := X"00C";
    C_RW_REG0_OFFSET : std_logic_vector(11 downto 0) := x"010";
    C_RW_REG1_OFFSET : std_logic_vector(11 downto 0) := x"014";
    C_RW_REG2_OFFSET : std_logic_vector(11 downto 0) := x"018";
    C_RW_REG3_OFFSET : std_logic_vector(11 downto 0) := X"01C"
    );
    port (
    RW_REG0            : out std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RW_REG1            : out std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RW_REG2            : out std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RW_REG3            : out std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG0            : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG1            : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG2            : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG3            : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG4            : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG5            : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG6            : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG7            : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG8            : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG9            : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG10           : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    RO_REG11           : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    
    update : out std_logic;
    S_AXI_LITE_ACLK  : in std_logic;
    S_AXI_LITE_ARESETN  : in std_logic;
    S_AXI_LITE_AWADDR  : in std_logic_vector(C_S_AXI_LITE_ADDR_WIDTH-1 downto 0);
    S_AXI_LITE_AWPROT  : in std_logic_vector(2 downto 0) := "000";
    S_AXI_LITE_AWVALID  : in std_logic;
    S_AXI_LITE_AWREADY  : out std_logic;
    S_AXI_LITE_WDATA  : in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    S_AXI_LITE_WSTRB  : in std_logic_vector((C_S_AXI_LITE_DATA_WIDTH/8)-1 downto 0);
    S_AXI_LITE_WVALID  : in std_logic;
    S_AXI_LITE_WREADY  : out std_logic;
    S_AXI_LITE_BRESP  : out std_logic_vector(1 downto 0);
    S_AXI_LITE_BVALID  : out std_logic;
    S_AXI_LITE_BREADY  : in std_logic;
    S_AXI_LITE_ARADDR  : in std_logic_vector(C_S_AXI_LITE_ADDR_WIDTH-1 downto 0);
    S_AXI_LITE_ARPROT  : in std_logic_vector(2 downto 0) := "000";
    S_AXI_LITE_ARVALID  : in std_logic;
    S_AXI_LITE_ARREADY  : out std_logic;
    S_AXI_LITE_RDATA  : out std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
    S_AXI_LITE_RRESP  : out std_logic_vector(1 downto 0);
    S_AXI_LITE_RVALID  : out std_logic;
    S_AXI_LITE_RREADY  : in std_logic
    );
  end component;

  component obuft_out is
    port (
       i  : in    std_logic;
       en : in    std_logic;
       o  : out  std_logic
      );
  end component;

  
  signal ACLK_1 : STD_LOGIC;
  signal ARESETN_1 : STD_LOGIC;
  signal C_CHANNEL_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal MCLK_1 : STD_LOGIC;
  signal PACMAN_TS_1 : std_logic_vector ( 63 downto 0 );
  signal S_AXIS_1_TDATA : STD_LOGIC_VECTOR ( 127 downto 0 );
  signal S_AXIS_1_TKEEP : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal S_AXIS_1_TLAST : STD_LOGIC;
  signal S_AXIS_1_TREADY : STD_LOGIC;
  signal S_AXIS_1_TSTRB  : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal S_AXIS_1_TVALID : STD_LOGIC;
  signal S_AXI_LITE_1_ARADDR  :  t_uart_array_32(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_ARPROT  : t_uart_array_3(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_ARREADY : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_ARVALID : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_AWADDR  : t_uart_array_32(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_AWPROT  : t_uart_array_3(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_AWREADY : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_AWVALID : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_BREADY : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_BRESP  : t_uart_array_2(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_BVALID : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_RDATA  : t_uart_array_32(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_RREADY : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_RRESP  : t_uart_array_2(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_RVALID : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_WDATA  : t_uart_array_32(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_WREADY : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_WSTRB  : t_uart_array_4(0 to C_TOTAL_CHANNELS-1);
  signal S_AXI_LITE_1_WVALID : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal UART_RX_1 : STD_LOGIC_VECTOR(C_TOTAL_CHANNELS-1 downto 0);
  signal larpix_uart_rx_0_M_AXIS_TDATA : t_uart_array_128 (0 to C_TOTAL_CHANNELS-1);
  signal larpix_uart_rx_0_M_AXIS_TKEEP : t_uart_array_16(0 to C_TOTAL_CHANNELS-1);
  signal larpix_uart_rx_0_M_AXIS_TLAST : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal larpix_uart_rx_0_M_AXIS_TREADY : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal larpix_uart_rx_0_M_AXIS_TSTRB : t_uart_array_16(0 to C_TOTAL_CHANNELS-1);
  signal larpix_uart_rx_0_M_AXIS_TVALID : std_logic_vector(0 to C_TOTAL_CHANNELS-1);
  signal larpix_uart_tx_0_FIFO_COUNT : t_uart_array_9(0 to C_TOTAL_CHANNELS-1);
  signal larpix_uart_tx_0_UART_TX_OUT : STD_LOGIC_VECTOR(C_TOTAL_CHANNELS-1 downto 0);
  signal CLKIN_RATIO_1 : t_uart_array_8(0 to C_TOTAL_CHANNELS-1);
  signal CLKOUT_PHASE : t_uart_array_4(0 to C_TOTAL_CHANNELS-1);
  signal CLKIN_PHASE : t_uart_array_8(0 to C_TOTAL_CHANNELS-1);
  signal POSI_POLARITY : std_logic_vector(C_TOTAL_CHANNELS-1 downto 0);
  signal PISO_POLARITY : std_logic_vector(C_TOTAL_CHANNELS-1 downto 0);
  signal RW_REG0 : t_uart_array_32(0 to C_TOTAL_CHANNELS-1);
  signal RW_REG1 : t_uart_array_32(0 to C_TOTAL_CHANNELS-1);
  signal RW_REG2 : t_uart_array_32(0 to C_TOTAL_CHANNELS-1);
  signal RW_REG3 : t_uart_array_32(0 to C_TOTAL_CHANNELS-1);


  signal data_LArPix : t_uart_array_64(0 to C_TOTAL_CHANNELS - 1);
  signal data_update_LarPix :  std_logic_vector(C_TOTAL_CHANNELS-1 downto 0);
  signal data_UART_TX_BUSY :  STD_LOGIC_VECTOR(C_TOTAL_CHANNELS-1 downto 0);

begin
  ACLK_1 <= ACLK;
  ARESETN_1 <= ARESETN;
  C_CHANNEL_1(7 downto 0) <= C_CHANNEL(7 downto 0);

  S_AXIS_1_TDATA(127 downto 0) <= S_AXIS_tdata(127 downto 0);
  S_AXIS_1_TKEEP(15 downto 0) <= S_AXIS_tkeep(15 downto 0);
  S_AXIS_1_TLAST <= S_AXIS_tlast;
  S_AXIS_1_TSTRB(15 downto 0) <= S_AXIS_tstrb(15 downto 0);
  S_AXIS_1_TVALID <= S_AXIS_tvalid;
  S_AXIS_tready <= S_AXIS_1_TREADY;

  UART_TX_BUSY  <= data_UART_TX_BUSY;

  larpix_axiLite_uartRx_gen: for I in 0 to C_TOTAL_CHANNELS-1 generate
--  MCLK_1 <= MCLK;
  M_AXIS_tdata(I)(127 downto 0) <= larpix_uart_rx_0_M_AXIS_TDATA(I)(127 downto 0);
  M_AXIS_tkeep(I)(15 downto 0) <= larpix_uart_rx_0_M_AXIS_TKEEP(I)(15 downto 0);
  M_AXIS_tlast(I) <= larpix_uart_rx_0_M_AXIS_TLAST(I);
  M_AXIS_tstrb(I)(15 downto 0) <= larpix_uart_rx_0_M_AXIS_TSTRB(I)(15 downto 0);
  M_AXIS_tvalid(I) <= larpix_uart_rx_0_M_AXIS_TVALID(I);
  PACMAN_TS_1(63 downto 0) <= PACMAN_TS(63 downto 0); 
  S_AXI_LITE_1_ARADDR(I)(31 downto 0) <= S_AXI_LITE_araddr(I)(31 downto 0);
  S_AXI_LITE_1_ARPROT(I)(2 downto 0) <= S_AXI_LITE_arprot(I)(2 downto 0);
  S_AXI_LITE_1_ARVALID(I) <= S_AXI_LITE_arvalid(I);
  S_AXI_LITE_1_AWADDR(I)(31 downto 0) <= S_AXI_LITE_awaddr(I)(31 downto 0);
  S_AXI_LITE_1_AWPROT(I)(2 downto 0) <= S_AXI_LITE_awprot(I)(2 downto 0);
  S_AXI_LITE_1_AWVALID(I) <= S_AXI_LITE_awvalid(I);
  S_AXI_LITE_1_BREADY(I) <= S_AXI_LITE_bready(I);
  S_AXI_LITE_1_RREADY(I) <= S_AXI_LITE_rready(I);
  S_AXI_LITE_1_WDATA(I)(31 downto 0) <= S_AXI_LITE_wdata(I)(31 downto 0);
  S_AXI_LITE_1_WSTRB(I)(3 downto 0) <= S_AXI_LITE_wstrb(I)(3 downto 0);
  S_AXI_LITE_1_WVALID(I) <= S_AXI_LITE_wvalid(I);
  S_AXI_LITE_arready(I) <= S_AXI_LITE_1_ARREADY(I);
  S_AXI_LITE_awready(I) <= S_AXI_LITE_1_AWREADY(I);
  S_AXI_LITE_bresp(I)(1 downto 0) <= S_AXI_LITE_1_BRESP(I)(1 downto 0);
  S_AXI_LITE_bvalid(I) <= S_AXI_LITE_1_BVALID(I);
  S_AXI_LITE_rdata(I)(31 downto 0) <= S_AXI_LITE_1_RDATA(I)(31 downto 0);
  S_AXI_LITE_rresp(I)(1 downto 0) <= S_AXI_LITE_1_RRESP(I)(1 downto 0);
  S_AXI_LITE_rvalid(I) <= S_AXI_LITE_1_RVALID(I);
  S_AXI_LITE_wready(I) <= S_AXI_LITE_1_WREADY(I);

  UART_RX_1(I) <= UART_RX(I) xor PISO_POLARITY(I);
--  UART_TX(I) <= larpix_uart_tx_0_UART_TX_OUT(I) xor POSI_POLARITY(I);
  larpix_uart_rx_0_M_AXIS_TREADY(I) <= M_AXIS_tready(I);
  
  CLKIN_RATIO_1(I)(7 downto 0) <= RW_REG0(I)(7 downto 0);
  CLKOUT_PHASE(I)(3 downto 0) <= RW_REG1(I)(3 downto 0);
  CLKIN_PHASE(I)(7 downto 0) <= RW_REG2(I)(7 downto 0);
  POSI_POLARITY(I) <= RW_REG3(I)(0);
  PISO_POLARITY(I) <= RW_REG3(I)(1);



  axi_lite_reg_space_0 : axi_lite_reg_space
     port map (
      s_AXI_LITE_ACLK => ACLK_1,
      S_AXI_LITE_ARESETN => ARESETN_1,
      RW_REG0(31 downto 0) => RW_REG0(I)(31 downto 0),
      RW_REG1 => RW_REG1(I)(31 downto 0),
      RW_REG2 => RW_REG2(I)(31 downto 0),
      RW_REG3 => RW_REG3(I)(31 downto 0),      
      RO_REG0(8 downto 0) => larpix_uart_tx_0_FIFO_COUNT(I)(8 downto 0),
      RO_REG0(31 downto 9) => (others => '0'),
      RO_REG1 => (others => '0'),
      RO_REG2 => (others => '0'),
      RO_REG3 => (others => '0'),
      RO_REG4 => (others => '0'),
      RO_REG5 => (others => '0'),
      RO_REG6 => (others => '0'),
      RO_REG7 => (others => '0'),
      RO_REG8 => (others => '0'),
      RO_REG9 => (others => '0'),
      RO_REG10 => (others => '0'),
      RO_REG11 => (others => '0'),      
      update => open,
      S_AXI_LITE_araddr(31 downto 0) => S_AXI_LITE_1_ARADDR(I)(31 downto 0),
      S_AXI_LITE_arprot(2 downto 0) => S_AXI_LITE_1_ARPROT(I)(2 downto 0),
      S_AXI_LITE_arready => S_AXI_LITE_1_ARREADY(I),
      S_AXI_LITE_arvalid => S_AXI_LITE_1_ARVALID(I),
      S_AXI_LITE_awaddr(31 downto 0) => S_AXI_LITE_1_AWADDR(I)(31 downto 0),
      S_AXI_LITE_awprot(2 downto 0) => S_AXI_LITE_1_AWPROT(I)(2 downto 0),
      S_AXI_LITE_awready => S_AXI_LITE_1_AWREADY(I),
      S_AXI_LITE_awvalid => S_AXI_LITE_1_AWVALID(I),
      S_AXI_LITE_bready => S_AXI_LITE_1_BREADY(I),
      S_AXI_LITE_bresp(1 downto 0) => S_AXI_LITE_1_BRESP(I)(1 downto 0),
      S_AXI_LITE_bvalid => S_AXI_LITE_1_BVALID(I),
      S_AXI_LITE_rdata(31 downto 0) => S_AXI_LITE_1_RDATA(I)(31 downto 0),
      S_AXI_LITE_rready => S_AXI_LITE_1_RREADY(I),
      S_AXI_LITE_rresp(1 downto 0) => S_AXI_LITE_1_RRESP(I)(1 downto 0),
      S_AXI_LITE_rvalid => S_AXI_LITE_1_RVALID(I),
      S_AXI_LITE_wdata(31 downto 0) => S_AXI_LITE_1_WDATA(I)(31 downto 0),
      S_AXI_LITE_wready => S_AXI_LITE_1_WREADY(I),
      S_AXI_LITE_wstrb(3 downto 0) => S_AXI_LITE_1_WSTRB(I)(3 downto 0),
      S_AXI_LITE_wvalid => S_AXI_LITE_1_WVALID(I)
      );
  
  larpix_uart_rx_0: component larpix_uart_rx
     port map (
      ACLK => ACLK_1,
      ARESETN => ARESETN_1,
      CLKIN_RATIO(7 downto 0) => CLKIN_RATIO_1(I)(7 downto 0),
      CLKIN_PHASE(7 downto 0) => CLKIN_PHASE(I)(7 downto 0),
      MCLK => MCLK, --MCLK_1,
      M_AXIS_TDATA(127 downto 0) => larpix_uart_rx_0_M_AXIS_TDATA(I)(127 downto 0),
      M_AXIS_TKEEP(15 downto 0) => larpix_uart_rx_0_M_AXIS_TKEEP(I)(15 downto 0),
      M_AXIS_TLAST => larpix_uart_rx_0_M_AXIS_TLAST(I),
      M_AXIS_TREADY => larpix_uart_rx_0_M_AXIS_TREADY(I),
      M_AXIS_TSTRB(15 downto 0) => larpix_uart_rx_0_M_AXIS_TSTRB(I)(15 downto 0),
      M_AXIS_TVALID => larpix_uart_rx_0_M_AXIS_TVALID(I),
      PACMAN_TS(63 downto 0) => PACMAN_TS_1(63 downto 0),
      UART_RX_IN => UART_RX_1(I),
      UART_RX_BUSY => UART_RX_BUSY(I)
      );

  end generate;
  
  axi_stream_to_larpix_all_channels_0 : component axi_stream_to_larpix_all_channels
    generic map(
      C_TILE_ID => C_TILE_ID
      )
    port map (
      S_AXIS_ACLK => ACLK_1,
      S_AXIS_ARESETN => ARESETN_1,
      S_AXIS_TDATA(127 downto 0) => S_AXIS_1_TDATA(127 downto 0),
      S_AXIS_TKEEP(15 downto 0) => S_AXIS_1_TKEEP(15 downto 0),
      S_AXIS_TLAST => S_AXIS_1_TLAST,
      S_AXIS_TREADY => S_AXIS_1_TREADY,
      S_AXIS_TSTRB(15 downto 0) => S_AXIS_1_TSTRB(15 downto 0),
      S_AXIS_TVALID => S_AXIS_1_TVALID,
      data_LArPix   => data_LArPix,
      data_update_LArPix => data_update_LarPix,
      busy_LArPix  => data_UART_TX_BUSY
      );
  
  larpix_tx_gen:  for I in 0 to C_TOTAL_CHANNELS-1 generate
    MOSI_loopback(I) <= larpix_uart_tx_0_UART_TX_OUT(I);
    
    larpix_uart_tx_0: component larpix_uart_tx_noAXIS
      port map (
        ACLK => ACLK_1,
        ARESETN => ARESETN_1,
        MRST => MRST,
        CLKOUT_RATIO(7 downto 0) => CLKIN_RATIO_1(I)(7 downto 0),
        CLKOUT_PHASE(3 downto 0) => CLKOUT_PHASE(I)(3 downto 0),      
        FIFO_COUNT(8 downto 0) => larpix_uart_tx_0_FIFO_COUNT(I)(8 downto 0),
        MCLK => MCLK, --MCLK_1,
        UART_TX_OUT => larpix_uart_tx_0_UART_TX_OUT(I),
        UART_TX_BUSY => data_UART_TX_BUSY(I) ,
        larpix_update =>  data_update_LarPix(I),
        larpix_data   =>  data_LArPix(I)
        );

    obuft_out_inst : component obuft_out
      port map(
        i  =>larpix_uart_tx_0_UART_TX_OUT(I), 
        en =>TILE_EN,
        o  =>MOSI(I)
        );
  
    
       
  end generate;
end arch_imp;
