## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]


## LEDs mapped to keys
set_property PACKAGE_PIN U16 [get_ports {keys[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[0]}]
set_property PACKAGE_PIN E19 [get_ports {keys[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[1]}]
set_property PACKAGE_PIN U19 [get_ports {keys[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[2]}]
set_property PACKAGE_PIN V19 [get_ports {keys[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[3]}]
set_property PACKAGE_PIN W18 [get_ports {keys[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[4]}]
set_property PACKAGE_PIN U15 [get_ports {keys[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[5]}]
set_property PACKAGE_PIN U14 [get_ports {keys[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[6]}]
set_property PACKAGE_PIN V14 [get_ports {keys[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[7]}]
set_property PACKAGE_PIN V13 [get_ports {keys[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[8]}]
set_property PACKAGE_PIN V3 [get_ports {keys[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[9]}]
set_property PACKAGE_PIN W3 [get_ports {keys[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[10]}]
set_property PACKAGE_PIN U3 [get_ports {keys[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[11]}]
set_property PACKAGE_PIN P3 [get_ports {keys[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[12]}]
set_property PACKAGE_PIN N3 [get_ports {keys[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[13]}]
set_property PACKAGE_PIN P1 [get_ports {keys[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[14]}]
set_property PACKAGE_PIN L1 [get_ports {keys[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {keys[15]}]
	
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

## Switches
set_property PACKAGE_PIN V17 [get_ports {volume[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {volume[0]}]
set_property PACKAGE_PIN V16 [get_ports {volume[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {volume[1]}]
set_property PACKAGE_PIN W16 [get_ports {volume[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {volume[2]}]
set_property PACKAGE_PIN W17 [get_ports {volume[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {volume[3]}]
set_property PACKAGE_PIN W15 [get_ports {volume[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {volume[4]}]
set_property PACKAGE_PIN V15 [get_ports {volume[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {volume[5]}]
set_property PACKAGE_PIN W14 [get_ports {volume[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {volume[6]}]
set_property PACKAGE_PIN W13 [get_ports {volume[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {volume[7]}]
#set_property PACKAGE_PIN V2 [get_ports {sw[8]}]                    
    #set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
#set_property PACKAGE_PIN T3 [get_ports {sw[9]}]                    
    #set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
#set_property PACKAGE_PIN T2 [get_ports {sw[10]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
#set_property PACKAGE_PIN R3 [get_ports {sw[11]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
#set_property PACKAGE_PIN W2 [get_ports {sw[12]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
#set_property PACKAGE_PIN U1 [get_ports {sw[13]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
#set_property PACKAGE_PIN T1 [get_ports {sw[14]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
#set_property PACKAGE_PIN R2 [get_ports {sw[15]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
 
##7 segment display
#set_property PACKAGE_PIN W7 [get_ports {seg[0]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
#set_property PACKAGE_PIN W6 [get_ports {seg[1]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
#set_property PACKAGE_PIN U8 [get_ports {seg[2]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
#set_property PACKAGE_PIN V8 [get_ports {seg[3]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
#set_property PACKAGE_PIN U5 [get_ports {seg[4]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
#set_property PACKAGE_PIN V5 [get_ports {seg[5]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
#set_property PACKAGE_PIN U7 [get_ports {seg[6]}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

#set_property PACKAGE_PIN V7 [get_ports dp]                         
    #set_property IOSTANDARD LVCMOS33 [get_ports dp]

#set_property PACKAGE_PIN U2 [get_ports {an[0]}]                    
    #set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
#set_property PACKAGE_PIN U4 [get_ports {an[1]}]                    
    #set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
#set_property PACKAGE_PIN V4 [get_ports {an[2]}]                    
    #set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
#set_property PACKAGE_PIN W4 [get_ports {an[3]}]                    
    #set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]


##Buttons
#set_property PACKAGE_PIN U18 [get_ports btnC]                      
    #set_property IOSTANDARD LVCMOS33 [get_ports btnC]
set_property PACKAGE_PIN T18 [get_ports btnU]                      
    set_property IOSTANDARD LVCMOS33 [get_ports btnU]
#set_property PACKAGE_PIN W19 [get_ports btnL]                      
    #set_property IOSTANDARD LVCMOS33 [get_ports btnL]
#set_property PACKAGE_PIN T17 [get_ports btnR]                      
    #set_property IOSTANDARD LVCMOS33 [get_ports btnR]
#set_property PACKAGE_PIN U17 [get_ports btnD]                      
    #set_property IOSTANDARD LVCMOS33 [get_ports btnD]

##KEYPAD
##Pmod Header JA mapped to row and col
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {col[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {col[3]}]
##Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {col[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {col[2]}]
##Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {col[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {col[1]}]
##Sch name = JA4
set_property PACKAGE_PIN G2 [get_ports {col[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {col[0]}]
##Sch name = JA7
set_property PACKAGE_PIN H1 [get_ports {row[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {row[3]}]
##Sch name = JA8
set_property PACKAGE_PIN K2 [get_ports {row[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {row[2]}]
##Sch name = JA9
set_property PACKAGE_PIN H2 [get_ports {row[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {row[1]}]
##Sch name = JA10
set_property PACKAGE_PIN G3 [get_ports {row[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {row[0]}]

##OLED
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


##Pmod Header JB
##Sch name = JB1
#set_property PACKAGE_PIN A14 [get_ports {AIN}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {AIN}]
##Sch name = JB2
#set_property PACKAGE_PIN A16 [get_ports {GAIN}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {GAIN}]                
##Sch name = JB4
#set_property PACKAGE_PIN B16 [get_ports {SHUTDOWN_L}]                   
    #set_property IOSTANDARD LVCMOS33 [get_ports {SHUTDOWN_L}]

##Pmod Header JXADC
##Sch name = XA1_P
set_property PACKAGE_PIN J3 [get_ports {AIN}]             
    set_property IOSTANDARD LVCMOS33 [get_ports {AIN}]
##Sch name = XA2_P
set_property PACKAGE_PIN L3 [get_ports {GAIN}]             
    set_property IOSTANDARD LVCMOS33 [get_ports {GAIN}]
##Sch name = XA3_P
#set_property PACKAGE_PIN M2 [get_ports {JXADC[2]}]             
    #set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[2]}]
##Sch name = XA4_P
set_property PACKAGE_PIN N2 [get_ports {SHUTDOWN_L}]             
    set_property IOSTANDARD LVCMOS33 [get_ports {SHUTDOWN_L}]
##Sch name = XA1_N
#set_property PACKAGE_PIN K3 [get_ports {JXADC[4]}]             
    #set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[4]}]
##Sch name = XA2_N
#set_property PACKAGE_PIN M3 [get_ports {JXADC[5]}]             
    #set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[5]}]
##Sch name = XA3_N
#set_property PACKAGE_PIN M1 [get_ports {JXADC[6]}]             
    #set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[6]}]
##Sch name = XA4_N
#set_property PACKAGE_PIN N1 [get_ports {JXADC[7]}]             
    #set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[7]}]