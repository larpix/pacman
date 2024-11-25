library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity larpix_uart_tx_noAXIS is
  generic (
    C_CLK_HZ : integer := 100000000;
    C_CLKOUT_HZ : integer := 10000000;
    C_S_AXIS_TDATA_WIDTH : integer := 128;
    C_LARPIX_DATA_WIDTH : integer := 64;
--    C_CHANNEL : std_logic_vector(7 downto 0) := x"FF";
--    C_DATA_TYPE : std_logic_vector(7 downto 0) := x"44";
    C_FIFO_COUNT_WIDTH : integer := 9
    );
  port (
    --C_CHANNEL : in std_logic_vector(7 downto 0) := x"FF";
    
    ACLK : in std_logic;
    ARESETN : in std_logic;

    -- uart
    MCLK : in std_logic;
    MRST : in std_logic;    
    UART_TX_OUT : out std_logic;
    CLKOUT_RATIO : in std_logic_vector (7 downto 0);
    CLKOUT_PHASE : in std_logic_vector (3 downto 0);    
    FIFO_COUNT : out std_logic_vector (C_FIFO_COUNT_WIDTH-1 downto 0);
    UART_TX_BUSY : out std_logic;
    larpix_update : in std_logic;
    larpix_data : in std_logic_vector ( C_LARPIX_DATA_WIDTH-1 downto 0 )


    );
end larpix_uart_tx_noAXIS;

architecture arch_imp of larpix_uart_tx_noAXIS is
  
 
  component uart_tx is
    generic (
      CLK_HZ : integer := C_CLK_HZ;
      CLKOUT_HZ : integer := C_CLKOUT_HZ;
      DATA_WIDTH : INTEGER := C_LARPIX_DATA_WIDTH
      );
    port (
      CLK         : IN  STD_LOGIC;
      RST          : IN  STD_LOGIC;
      CLKOUT_RATIO : IN  STD_LOGIC_VECTOR (7 downto 0);
      CLKOUT_PHASE : IN  STD_LOGIC_VECTOR (3 downto 0);
      MCLK         : IN STD_LOGIC;
      MRST         : IN STD_LOGIC;      
      TX           : OUT STD_LOGIC;
      data         : IN  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0);
      data_update  : IN  STD_LOGIC;
      busy         : OUT STD_LOGIC;
      TC          : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
      );
  end component uart_tx;
  
  component fifo_64x512 is
    port (
      rst : in STD_LOGIC;
      wr_clk : in STD_LOGIC;
      rd_clk : in STD_LOGIC;
      din : in STD_LOGIC_VECTOR ( C_LARPIX_DATA_WIDTH-1 downto 0 );
      wr_en : in STD_LOGIC;
      rd_en : in STD_LOGIC;
      dout : out STD_LOGIC_VECTOR ( C_LARPIX_DATA_WIDTH-1 downto 0 );
      full : out STD_LOGIC;
      almost_full : out STD_LOGIC;
      wr_ack : out STD_LOGIC;
      empty : out STD_LOGIC;
      valid : out STD_LOGIC;
      wr_data_count : out STD_LOGIC_VECTOR ( C_FIFO_COUNT_WIDTH-1 downto 0 )
      );
  end component fifo_64x512;

  signal rst : std_logic;


  signal fifo_busy : std_logic;
  signal fifo_full : std_logic;
  signal fifo_almost_full : std_logic;
  signal fifo_wr_ack : std_logic;
  signal fifo_rd_en : std_logic;
  signal fifo_empty : std_logic;
  signal fifo_valid : std_logic;

  signal uart_update : std_logic;
  signal uart_busy : std_logic;
  signal uart_data : std_logic_vector ( C_LARPIX_DATA_WIDTH-1 downto 0 );

begin
  
  UART_TX_BUSY <= uart_busy;
  rst <= not ARESETN;

  
  -- clock domain crossing FIFO
  fifo_rd_en <= (not uart_busy) and (not fifo_empty) and (not fifo_valid);
  fifo_busy <= fifo_full or fifo_almost_full or fifo_wr_ack;
  fifo_64x512_inst : fifo_64x512 port map(
    rst => rst,
    wr_clk => ACLK,
    rd_clk => ACLK,
    din => larpix_data,
    wr_en => larpix_update,
    rd_en => fifo_rd_en,
    dout => uart_data,
    full => fifo_full,
    almost_full => fifo_almost_full,
    wr_ack => fifo_wr_ack,
    empty => fifo_empty,
    valid => fifo_valid,
    wr_data_count => FIFO_COUNT
    );

  -- drive uart pin
  uart_tx_inst : uart_tx port map(
    MCLK => MCLK,
    MRST => MRST,
    CLK => ACLK,
    RST => rst,
    CLKOUT_RATIO => CLKOUT_RATIO,
    CLKOUT_PHASE => CLKOUT_PHASE,    
    TX => UART_TX_OUT,
    data => uart_data,
    data_update => fifo_valid,
    busy => uart_busy,
    TC => open
    );

end arch_imp;

  
    
