## Generated SDC file "holosynthii_avgx_starter.out.sdc"

## Copyright (C) 1991-2012 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 12.1 Build 177 11/07/2012 SJ Full Version"

## DATE    "Sun Dec 09 18:00:24 2012"

##
## DEVICE  "5AGXFB3H4F35C5ES"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_av_osc_clk} -period 22.500 -waveform { 0.000 11.250 } [get_pins {*|arriav_oscillator|clkout}]
create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {clkinbot_100_p} -period 10.000 -waveform { 0.000 5.000 } [get_ports {clkinbot_100_p}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[0]} -source [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 206 -divide_by 19 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[0]}] 
create_generated_clock -name {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[1]} -source [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 206 -divide_by 19 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[1]}] 
create_generated_clock -name {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[2]} -source [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 206 -divide_by 19 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[2]}] 
create_generated_clock -name {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[3]} -source [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 206 -divide_by 19 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[3]}] 
create_generated_clock -name {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[4]} -source [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 206 -divide_by 19 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[4]}] 
create_generated_clock -name {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[5]} -source [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 206 -divide_by 19 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[5]}] 
create_generated_clock -name {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[6]} -source [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 206 -divide_by 19 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[6]}] 
create_generated_clock -name {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[7]} -source [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 206 -divide_by 19 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[7]}] 
create_generated_clock -name {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk} -source [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 4 -master_clock {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[0]} [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] 
create_generated_clock -name {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll2~PLL_OUTPUT_COUNTER|divclk} -source [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll2~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 64 -master_clock {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[0]} [get_pins {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll2~PLL_OUTPUT_COUNTER|divclk}] 
create_generated_clock -name {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[0]} -source [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 3 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[0]}] 
create_generated_clock -name {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[1]} -source [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 3 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[1]}] 
create_generated_clock -name {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[2]} -source [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 3 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[2]}] 
create_generated_clock -name {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[3]} -source [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 3 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[3]}] 
create_generated_clock -name {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[4]} -source [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 3 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[4]}] 
create_generated_clock -name {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[5]} -source [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 3 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[5]}] 
create_generated_clock -name {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[6]} -source [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 3 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[6]}] 
create_generated_clock -name {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[7]} -source [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|refclkin}] -duty_cycle 50.000 -multiply_by 3 -master_clock {clkinbot_100_p} [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[7]}] 
create_generated_clock -name {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk} -source [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|vco1ph[0]}] -duty_cycle 50.000 -multiply_by 1 -divide_by 12 -master_clock {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~FRACTIONAL_PLL|vcoph[0]} [get_pins {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  
set_clock_uncertainty -rise_from [get_clocks {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  
set_clock_uncertainty -fall_from [get_clocks {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  
set_clock_uncertainty -fall_from [get_clocks {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {synthesizer_inst|sys_disp_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.050  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.050  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.050  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.050  
set_clock_uncertainty -rise_from [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll2~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll2~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  
set_clock_uncertainty -rise_from [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll2~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll2~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  
set_clock_uncertainty -fall_from [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll2~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll2~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  
set_clock_uncertainty -fall_from [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll2~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll2~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  
set_clock_uncertainty -rise_from [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  
set_clock_uncertainty -rise_from [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  
set_clock_uncertainty -fall_from [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  
set_clock_uncertainty -fall_from [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {synthesizer_inst|audio_pll_inst|altpll_component|auto_generated|generic_pll1~PLL_OUTPUT_COUNTER|divclk}] -setup 0.050  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************

set_max_delay -from  [get_clocks {altera_reserved_av_osc_clk}]  -to  [get_clocks {altera_reserved_av_osc_clk}] 10.000


#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

