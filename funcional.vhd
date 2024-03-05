library ieee;
use ieee.std_logic_1164.all;

entity funcional is
	port(dias : in std_logic_vector(6 downto 0);
        outBCD : out std_logic_vector(3 downto 0);
        laborable_festivo : out std_logic;
        segmentos_out: out std_logic_vector(6 downto 0) );
end funcional;


architecture arq1 of funcional is
	signal s : std_logic_vector(2 downto 0);
	signal diaBCD : std_logic_vector(3 downto 0);
	signal cmd : std_logic_vector(1 downto 0);
	signal Smx : std_logic ;
begin
	
--codificador 8 a 3
	process (dias)
		begin
			case dias is
				when "0000001" => s <= "001";
            when "0000010" => s <= "010";
            when "0000100" => s <= "011";
            when "0001000" => s <= "100";
            when "0010000" => s <= "101";
            when "0100000" => s <= "110";
            when "1000000" => s <= "111";
            when others    => s <= "000";
			end case;
	end process; 
	
-- Codificador de 3 a 4 
    process(s)
		begin
			case s is
					when "000" => diaBCD <= "0000";
					when "001" => diaBCD <= "0001";
					when "010" => diaBCD <= "0010";
					when "011" => diaBCD <= "0011";
					when "100" => diaBCD <= "0100";
					when "101" => diaBCD <= "0101";
					when "110" => diaBCD <= "0110";
					when "111" => diaBCD <= "0111";
					when others  => diaBCD <= "1111";
        end case;
	 end process;
	 
	
-- Decodificador de BCD a 7 segmentos
    process(diaBCD)
		begin
        case diaBCD is
            when "0000" => segmentos_out <= "0000001";  
            when "0001" => segmentos_out <= "1001111";  
            when "0010" => segmentos_out <= "0010010";  
            when "0011" => segmentos_out <= "0000110";  
            when "0100" => segmentos_out <= "1001100";  
            when "0101" => segmentos_out <= "0100100";  
            when "0110" => segmentos_out <= "0100000";  
            when "0111" => segmentos_out <= "0001111"; 	
            when others => segmentos_out <= "1111111"; 
        end case;
    end process;
	 
--Multiplexor 4 to 1

	 process (s, cmd)
    begin
		cmd <= s(2) & s(1);
			case cmd is
				when "11" => Smx <= '1';
			   when others => Smx <= '0';
         end case;
    end process;
	 
	 laborable_festivo <= Smx;
	 outBCD <= diaBCD;
	
end arq1;