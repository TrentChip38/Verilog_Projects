## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
## Switches
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property PACKAGE_PIN W17 [get_ports {sw[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property PACKAGE_PIN W15 [get_ports {sw[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
set_property PACKAGE_PIN V15 [get_ports {sw[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
set_property PACKAGE_PIN W14 [get_ports {sw[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
set_property PACKAGE_PIN W13 [get_ports {sw[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
set_property PACKAGE_PIN V2 [get_ports {sw[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
set_property PACKAGE_PIN T3 [get_ports {sw[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
set_property PACKAGE_PIN T2 [get_ports {sw[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
set_property PACKAGE_PIN R3 [get_ports {sw[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
set_property PACKAGE_PIN W2 [get_ports {sw[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
set_property PACKAGE_PIN U1 [get_ports {sw[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
set_property PACKAGE_PIN T1 [get_ports {sw[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
set_property PACKAGE_PIN R2 [get_ports {sw[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
 

## LEDs
set_property PACKAGE_PIN U16 [get_ports {ready}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ready}]


##Buttons
# btnC 
set_property PACKAGE_PIN U18 [get_ports rst]						
	set_property IOSTANDARD LVCMOS33 [get_ports rst]
# btnU 
set_property PACKAGE_PIN T18 [get_ports showchar]						
	set_property IOSTANDARD LVCMOS33 [get_ports showchar]
# btnL 
set_property PACKAGE_PIN W19 [get_ports showbmp]						
	set_property IOSTANDARD LVCMOS33 [get_ports showbmp]
# btnR 
set_property PACKAGE_PIN T17 [get_ports clear]						
	set_property IOSTANDARD LVCMOS33 [get_ports clear]

# btnD
#set_property PACKAGE_PIN U17 [get_ports btnd]						
#	set_property IOSTANDARD LVCMOS33 [get_ports btnd]
 



##Pmod Header JB
##Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {cs_n}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {cs_n}]
##Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports {sdo}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sdo}]
##Sch name = JB3 (NC)
#set_property PACKAGE_PIN B15 [get_ports {JB[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JB[2]}]
##Sch name = JB4
set_property PACKAGE_PIN B16 [get_ports {sclk}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sclk}]
##Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports {dc}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dc}]
##Sch name = JB8
set_property PACKAGE_PIN A17 [get_ports {res}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {res}]
##Sch name = JB9
set_property PACKAGE_PIN C15 [get_ports {vbat}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {vbat}]
##Sch name = JB10 
set_property PACKAGE_PIN C16 [get_ports {vdd}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {vdd}]
 


