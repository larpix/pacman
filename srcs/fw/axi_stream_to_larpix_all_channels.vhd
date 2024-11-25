library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.uart_types_pkg.all;

entity axi_stream_to_larpix_all_channels is
  generic (
    C_S_AXIS_TDATA_WIDTH        : integer := 128;
    C_LARPIX_DATA_WIDTH         : integer := 64;
    C_TOTAL_CHANNELS            : integer := 4;
    C_CHANNEL                   : std_logic_vector(7 downto 0) := x"FF";
    C_DATA_TYPE                 : std_logic_vector(7 downto 0) := x"44";
    C_TILE_ID                   : integer := 15 ;
    C_BROADCAST                 : std_logic_vector(3 downto 0) := x"F"
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
end axi_stream_to_larpix_all_channels;

architecture arch_imp of axi_stream_to_larpix_all_channels is
  type state is ( IDLE,
                  RX,
                  SHIFT,
                  RX_DONE,
                  TX_WAIT,
                  TX,
                  TX_DONE );
  signal mst_exec_state : state;

  signal axis_tready : std_logic;

  signal data_out : t_uart_array_64(0 to C_TOTAL_CHANNELS - 1);
  signal update :  std_logic_vector(C_TOTAL_CHANNELS-1 downto 0);

  signal buf_srg : std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
--  signal buf_index  :  integer range C_S_AXIS_TDATA_WIDTH/8-1 downto 0;
  signal buf_index  :  integer range C_S_AXIS_TDATA_WIDTH/8 downto 0; 
  signal srg : std_logic_vector(C_S_AXIS_TDATA_WIDTH*2-1 downto 0);
  signal srg_bytes : integer range C_S_AXIS_TDATA_WIDTH/8 downto 0;
  signal keep_srg : std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
  signal this_channel : natural; --std_logic_vector(7 downto 0);
  
begin
  -- I/O Connections assigments
  S_AXIS_TREADY	<= axis_tready;
  data_update_LArPix <= update;
  
  larpix_axis_gen: for I in 0 to C_TOTAL_CHANNELS-1 generate
      data_LArPix(I) <= data_out(I);

  end generate;
    
  -- Control state machine implementation
  larpix_tx_fsm : process (S_AXIS_ACLK) is
  variable word_start : integer;
  variable word_end   : integer;
 
  begin
    if (rising_edge(S_AXIS_ACLK)) then
      if (S_AXIS_ARESETN = '0') then
        -- synchronous reset
        mst_exec_state <= IDLE;
        srg_bytes <= 0;
        axis_tready <= '0';
        srg         <= (others => '0');
        buf_srg     <= (others => '0');
        this_channel <= C_TOTAL_CHANNELS; --x"FF";
        update       <= (others=>'0');
        keep_srg     <= (others=>'0');
        for I in 0 to C_TOTAL_CHANNELS-1 loop
          data_out(I) <= (others => '0');
        end loop;
          
        
      else
        case mst_exec_state is
          when IDLE =>
            -- wait for new data
            axis_tready <= '0';
            srg_bytes <= 0;
            this_channel <= C_TOTAL_CHANNELS; --x"FF";
            update <= (others => '0');
            
            if (S_AXIS_TVALID = '1') then
              mst_exec_state <= RX;
            end if;

          when RX =>
            -- latch data
            axis_tready <= '1';
            buf_srg(C_S_AXIS_TDATA_WIDTH-1 downto 0) <= S_AXIS_TDATA(C_S_AXIS_TDATA_WIDTH-1 downto 0);
            buf_index <= 0;
            keep_srg((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0) <= S_AXIS_TSTRB((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0) and S_AXIS_TKEEP((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
            mst_exec_state <= SHIFT;

          when SHIFT =>
            -- update shift registers
            axis_tready <= '0';
            keep_srg <= '0' & keep_srg((C_S_AXIS_TDATA_WIDTH/8)-1 downto 1);
            buf_srg <= x"00" & buf_srg(C_S_AXIS_TDATA_WIDTH-1 downto 8);
            buf_index <= buf_index + 1;
            
            -- pack bytes
            if (keep_srg(0) = '1') then
              srg <= buf_srg(7 downto 0) & srg(C_S_AXIS_TDATA_WIDTH*2-1 downto 8);
              srg_bytes <= srg_bytes + 1;
            end if;            

            if (buf_index = C_S_AXIS_TDATA_WIDTH/8-1) then
              mst_exec_state <= RX_DONE;
            end if;

          when RX_DONE =>
            -- complete word packed
            word_start := srg'length - srg_bytes*8;
            word_end   := word_start + C_S_AXIS_TDATA_WIDTH - 1;
            if (srg_bytes >= C_S_AXIS_TDATA_WIDTH/8) then
              srg_bytes <= srg_bytes - C_S_AXIS_TDATA_WIDTH/8;
              if (srg(word_start + 7 downto word_start) = C_DATA_TYPE(7 downto 0)) then              
                if(  (to_integer(unsigned(srg(word_start + 15 downto word_start + 12))) = C_TILE_ID) and (to_integer(unsigned(srg(word_start + 11 downto word_start + 8)))) < C_TOTAL_CHANNELS ) then
                  data_out(natural(to_integer(unsigned(srg(word_start + 11 downto word_start + 8)))))(C_LARPIX_DATA_WIDTH-1 downto 0) <= srg(word_end downto word_end - C_LARPIX_DATA_WIDTH + 1);
                  this_channel <= natural(to_integer(unsigned(srg(word_start + 11 downto word_start + 8))));
                  mst_exec_state <= TX_WAIT;    
                else
                  if (srg(word_start + 15 downto word_start + 8) = x"FF") then --broadcast
                    for I in 0 to C_TOTAL_CHANNELS-1 loop
                      data_out(I)(C_LARPIX_DATA_WIDTH-1 downto 0) <= srg(word_end downto word_end - C_LARPIX_DATA_WIDTH + 1);
                    end loop;
                    this_channel <= 255;
                    mst_exec_state <= TX_WAIT;
                  else
                    this_channel <= C_TOTAL_CHANNELS;
                    mst_exec_state <= IDLE;
                  end if;
                end if; 
              else
                mst_exec_state <= IDLE;
              end if;              
            -- for partial words don't reset srg_bytes
            else
              mst_exec_state <= IDLE;
            end if;

          when TX_WAIT =>
            axis_tready <= '0';
            -- wait for larpix ready
            if (busy_LArPix = x"0") then
              mst_exec_state <= TX;
            end if;
            
          when TX =>
            -- update larpix data
            if this_channel = 255 then --broadcast
              for I in 0 to C_TOTAL_CHANNELS-1 loop
                update(I) <= '1';
              end loop;
            else if this_channel < C_TOTAL_CHANNELS then
                   update(this_channel) <= '1';
                 else
                    for I in 0 to C_TOTAL_CHANNELS-1 loop
                      update(I) <= '0';
                    end loop;
                   --error
                 end if;
            end if;
            mst_exec_state <= TX_DONE;

          when TX_DONE =>
            -- wait for acknowledgement
            this_channel <= C_TOTAL_CHANNELS; --x"FF";
            update       <= (others => '0');
            
            if (busy_LArPix /= x"0") then
              mst_exec_state <= IDLE;
            end if;

          when others =>
            mst_exec_state <= IDLE;
        end case;
      end if;
    end if;
  end process larpix_tx_fsm;

end arch_imp;
