###########################################################################
# Created for ArriaV GX Starter Kit Rev C
# Rev 1.1, 6/28/12 
# DO NOT DELETE THIS FILE!!
###########################################################################

# REFCLK & CLKOUT
# Use these constraints when transceiver designs are instantiated in your top level #####################
# set_location_assignment PIN_R26 -to clk_148_p
# set_location_assignment PIN_W26 -to refclk1_ql0_p
# set_location_assignment PIN_U26 -to refclk2_ql1_p
# set_location_assignment PIN_W9 -to refclk1_qr0_p
# set_location_assignment PIN_U9 -to refclk2_qr1_p
# set_location_assignment PIN_R9 -to refclk3_qr1_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to clk_148_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to refclk1_ql0_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to refclk2_ql1_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to refclk1_qr0_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to refclk2_qr1_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to refclk3_qr1_p
# set_instance_assignment -name INPUT_TERMINATION "OCT 100 OHMS" -to clk_148_p
# set_instance_assignment -name INPUT_TERMINATION "OCT 100 OHMS" -to refclk1_ql0_p
# set_instance_assignment -name INPUT_TERMINATION "OCT 100 OHMS" -to refclk2_ql1_p
# set_instance_assignment -name INPUT_TERMINATION "OCT 100 OHMS" -to refclk1_qr0_p
# set_instance_assignment -name INPUT_TERMINATION "OCT 100 OHMS" -to refclk2_qr1_p
# set_instance_assignment -name INPUT_TERMINATION "OCT 100 OHMS" -to refclk3_qr1_p
#########################################################################################################
set_location_assignment PIN_AH17 -to clk_125_p
set_location_assignment PIN_A3 -to clkintop_125_p
set_location_assignment PIN_AP32 -to clkinbot_125_p
set_location_assignment PIN_A19 -to clkintop_100_p
set_location_assignment PIN_AH18 -to clkinbot_100_p
set_location_assignment PIN_A16 -to clkin_50_top
set_location_assignment PIN_AP29 -to clkin_50_bot
set_location_assignment PIN_C3 -to clkout_sma
set_instance_assignment -name IO_STANDARD LVDS -to clk_125_p
set_instance_assignment -name IO_STANDARD LVDS -to clkintop_125_p
set_instance_assignment -name IO_STANDARD LVDS -to clkinbot_125_p
set_instance_assignment -name IO_STANDARD LVDS -to clkintop_100_p
set_instance_assignment -name IO_STANDARD LVDS -to clkinbot_100_p
set_instance_assignment -name IO_STANDARD "2.5 V" -to clkin_50_top
set_instance_assignment -name IO_STANDARD "2.5 V" -to clkin_50_bot
set_instance_assignment -name IO_STANDARD "2.5 V" -to clkout_sma


# SMA XCVR
# Use these constraints when transceiver designs are instantiated in your top level #####################
# set_location_assignment PIN_H34 -to sma_xcvr_rx_p
# set_location_assignment PIN_G32 -to sma_xcvr_tx_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to sma_xcvr_tx_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to sma_xcvr_rx_p
#########################################################################################################

# PCIE
# Use these constraints when transceiver designs are instantiated in your top level #####################
# set_location_assignment PIN_AJ32 -to pcie_tx_p[0]
# set_location_assignment PIN_AG32 -to pcie_tx_p[1]
# set_location_assignment PIN_AE32 -to pcie_tx_p[2]
# set_location_assignment PIN_AC32 -to pcie_tx_p[3]
# set_location_assignment PIN_W32 -to pcie_tx_p[4]
# set_location_assignment PIN_U32 -to pcie_tx_p[5]
# set_location_assignment PIN_R32 -to pcie_tx_p[6]
# set_location_assignment PIN_N32 -to pcie_tx_p[7]
# set_location_assignment PIN_AK34 -to pcie_rx_p[0]
# set_location_assignment PIN_AH34 -to pcie_rx_p[1]
# set_location_assignment PIN_AF34 -to pcie_rx_p[2]
# set_location_assignment PIN_AD34 -to pcie_rx_p[3]
# set_location_assignment PIN_Y34 -to pcie_rx_p[4]
# set_location_assignment PIN_V34 -to pcie_rx_p[5]
# set_location_assignment PIN_T34 -to pcie_rx_p[6]
# set_location_assignment PIN_P34 -to pcie_rx_p[7]
# set_location_assignment PIN_AA27 -to pcie_refclk_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to pcie_tx_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to pcie_rx_p
# set_instance_assignment -name IO_STANDARD HCSL -to pcie_refclk_p
# set_instance_assignment -name INPUT_TERMINATION "OCT 100 OHMS" -to pcie_refclk_p
#########################################################################################################
set_location_assignment PIN_B2 -to pcie_perstn
set_location_assignment PIN_F17 -to pcie_led_g2
set_location_assignment PIN_G17 -to pcie_led_x1
set_location_assignment PIN_G16 -to pcie_led_x4
set_location_assignment PIN_G15 -to pcie_led_x8
set_location_assignment PIN_F14 -to pcie_smbdat
set_location_assignment PIN_F16 -to pcie_smbclk
set_location_assignment PIN_E14 -to pcie_waken
set_instance_assignment -name IO_STANDARD "2.5 V" -to pcie_perstn
set_instance_assignment -name IO_STANDARD "2.5 V" -to pcie_led_g2
set_instance_assignment -name IO_STANDARD "2.5 V" -to pcie_led_x1
set_instance_assignment -name IO_STANDARD "2.5 V" -to pcie_led_x4
set_instance_assignment -name IO_STANDARD "2.5 V" -to pcie_led_x8
set_instance_assignment -name IO_STANDARD "2.5 V" -to pcie_smbdat
set_instance_assignment -name IO_STANDARD "2.5 V" -to pcie_smbclk
set_instance_assignment -name IO_STANDARD "2.5 V" -to pcie_waken

# sdi
# Use these constraints when transceiver designs are instantiated in your top level #####################
# set_location_assignment PIN_L32 -to sdi_tx_p
# set_location_assignment PIN_M34 -to sdi_rx_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to sdi_tx_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to sdi_rx_p
#########################################################################################################
set_location_assignment PIN_AC23 -to sdi_clk148_up
set_location_assignment PIN_AB23 -to sdi_clk148_dn
set_location_assignment PIN_AD24 -to sdi_rx_bypass
set_location_assignment PIN_AC24 -to sdi_tx_en
set_location_assignment PIN_AD23 -to sdi_rx_en
set_location_assignment PIN_AC25 -to sdi_tx_sd_hdn
set_location_assignment PIN_AH28 -to sdi_scl
set_location_assignment PIN_AJ28 -to sdi_sda
set_location_assignment PIN_AJ29 -to sdi_fault
set_instance_assignment -name IO_STANDARD "2.5 V" -to sdi_clk148_up
set_instance_assignment -name IO_STANDARD "2.5 V" -to sdi_clk148_dn
set_instance_assignment -name IO_STANDARD "2.5 V" -to sdi_rx_bypass
set_instance_assignment -name IO_STANDARD "2.5 V" -to sdi_tx_en
set_instance_assignment -name IO_STANDARD "2.5 V" -to sdi_rx_en
set_instance_assignment -name IO_STANDARD "2.5 V" -to sdi_tx_sd_hdn
set_instance_assignment -name IO_STANDARD "2.5 V" -to sdi_scl
set_instance_assignment -name IO_STANDARD "2.5 V" -to sdi_sda
set_instance_assignment -name IO_STANDARD "2.5 V" -to sdi_fault
set_instance_assignment -name AUTO_OPEN_DRAIN_PINS ON -to sdi_scl
set_instance_assignment -name AUTO_OPEN_DRAIN_PINS ON -to sdi_sda
set_instance_assignment -name AUTO_OPEN_DRAIN_PINS ON -to sdi_fault

# hdmi
# Use these constraints when transceiver designs are instantiated in your top level #####################
# set_location_assignment PIN_AJ3 -to hdmi_tx_p[0]
# set_location_assignment PIN_AG3 -to hdmi_tx_p[1]
# set_location_assignment PIN_AE3 -to hdmi_tx_p[2]
# set_location_assignment PIN_AC3 -to hdmi_tx_clkout_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to hdmi_tx_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to hdmi_tx_clkout_p
#########################################################################################################
set_location_assignment PIN_AC9 -to hdmi_tx_oen
set_location_assignment PIN_AF8 -to hdmi_tx_hpd
set_location_assignment PIN_AD11 -to hdmi_tx_i2c_sda
set_location_assignment PIN_AE11 -to hdmi_tx_i2c_scl
set_instance_assignment -name IO_STANDARD "2.5 V" -to hdmi_tx_oen
set_instance_assignment -name IO_STANDARD "2.5 V" -to hdmi_tx_hpd
set_instance_assignment -name IO_STANDARD "2.5 V" -to hdmi_tx_i2c_sda
set_instance_assignment -name IO_STANDARD "2.5 V" -to hdmi_tx_i2c_scl
set_instance_assignment -name AUTO_OPEN_DRAIN_PINS ON -to hdmi_tx_i2c_scl
set_instance_assignment -name AUTO_OPEN_DRAIN_PINS ON -to hdmi_tx_i2c_sda
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to hdmi_tx_i2c_scl
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to hdmi_tx_i2c_sda


# HSMC
# Use these constraints when transceiver designs are instantiated in your top level #####################
# set_location_assignment PIN_G3 -to hsma_tx_p[0]
# set_location_assignment PIN_J3 -to hsma_tx_p[1]
# set_location_assignment PIN_L3 -to hsma_tx_p[2]
# set_location_assignment PIN_N3 -to hsma_tx_p[3]
# set_location_assignment PIN_R3 -to hsma_tx_p[4]
# set_location_assignment PIN_U3 -to hsma_tx_p[5]
# set_location_assignment PIN_W3 -to hsma_tx_p[6]
# set_location_assignment PIN_AA3 -to hsma_tx_p[7]
# set_location_assignment PIN_H1 -to hsma_rx_p[0]
# set_location_assignment PIN_K1 -to hsma_rx_p[1]
# set_location_assignment PIN_M1 -to hsma_rx_p[2]
# set_location_assignment PIN_P1 -to hsma_rx_p[3]
# set_location_assignment PIN_T1 -to hsma_rx_p[4]
# set_location_assignment PIN_V1 -to hsma_rx_p[5]
# set_location_assignment PIN_Y1 -to hsma_rx_p[6]
# set_location_assignment PIN_AB1 -to hsma_rx_p[7]
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to hsma_rx_p
# set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to hsma_tx_p
#########################################################################################################
set_location_assignment PIN_AJ10 -to hsma_d[0]
set_location_assignment PIN_AH10 -to hsma_d[1]
set_location_assignment PIN_AH9 -to hsma_d[2]
set_location_assignment PIN_AH8 -to hsma_d[3]
set_location_assignment PIN_AM10 -to hsma_tx_d_p[0]
set_location_assignment PIN_AL9 -to hsma_tx_d_p[1]
set_location_assignment PIN_AF10 -to hsma_tx_d_p[2]
set_location_assignment PIN_AE9 -to hsma_tx_d_p[3]
set_location_assignment PIN_AJ6 -to hsma_tx_d_p[4]
set_location_assignment PIN_AC6 -to hsma_tx_d_p[5]
set_location_assignment PIN_AM4 -to hsma_tx_d_p[6]
set_location_assignment PIN_AE6 -to hsma_tx_d_p[7]
set_location_assignment PIN_G9 -to hsma_tx_d_p[8]
set_location_assignment PIN_J6 -to hsma_tx_d_p[9]
set_location_assignment PIN_G8 -to hsma_tx_d_p[10]
set_location_assignment PIN_G6 -to hsma_tx_d_p[11]
set_location_assignment PIN_E1 -to hsma_tx_d_p[12]
set_location_assignment PIN_E5 -to hsma_tx_d_p[13]
set_location_assignment PIN_E8 -to hsma_tx_d_p[14]
set_location_assignment PIN_E9 -to hsma_tx_d_p[15]
set_location_assignment PIN_A8 -to hsma_tx_d_p[16]
set_location_assignment PIN_AP11 -to hsma_rx_d_p[0]
set_location_assignment PIN_AN8 -to hsma_rx_d_p[1]
set_location_assignment PIN_AM8 -to hsma_rx_d_p[2]
set_location_assignment PIN_AN11 -to hsma_rx_d_p[3]
set_location_assignment PIN_AL12 -to hsma_rx_d_p[4]
set_location_assignment PIN_AM13 -to hsma_rx_d_p[5]
set_location_assignment PIN_AH12 -to hsma_rx_d_p[6]
set_location_assignment PIN_AJ13 -to hsma_rx_d_p[7]
set_location_assignment PIN_A13 -to hsma_rx_d_p[8]
set_location_assignment PIN_A11 -to hsma_rx_d_p[9]
set_location_assignment PIN_E11 -to hsma_rx_d_p[10]
set_location_assignment PIN_F10 -to hsma_rx_d_p[11]
set_location_assignment PIN_C11 -to hsma_rx_d_p[12]
set_location_assignment PIN_A10 -to hsma_rx_d_p[13]
set_location_assignment PIN_C8 -to hsma_rx_d_p[14]
set_location_assignment PIN_A7 -to hsma_rx_d_p[15]
set_location_assignment PIN_B6 -to hsma_rx_d_p[16]
set_location_assignment PIN_AJ8 -to hsma_scl
set_location_assignment PIN_AK8 -to hsma_sda
set_location_assignment PIN_J8 -to hsma_prsntn
set_location_assignment PIN_AL5 -to hsma_clk_in0
set_location_assignment PIN_AL6 -to hsma_clk_out0
set_location_assignment PIN_AN3 -to hsma_clk_in_p[1]
set_location_assignment PIN_C1 -to hsma_clk_in_p[2]
set_location_assignment PIN_AD8 -to hsma_clk_out_p[1]
set_location_assignment PIN_L9 -to hsma_clk_out_p[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to hsma_d
set_instance_assignment -name IO_STANDARD LVDS -to hsma_tx_d_p
set_instance_assignment -name IO_STANDARD LVDS -to hsma_rx_d_p
set_instance_assignment -name INPUT_TERMINATION DIFFERENTIAL -to hsma_rx_d_p
set_instance_assignment -name IO_STANDARD "2.5 V" -to hsma_scl
set_instance_assignment -name IO_STANDARD "2.5 V" -to hsma_sda
set_instance_assignment -name IO_STANDARD "2.5 V" -to hsma_prsntn
set_instance_assignment -name IO_STANDARD "2.5 V" -to hsma_clk_in0
set_instance_assignment -name IO_STANDARD "2.5 V" -to hsma_clk_out0
set_instance_assignment -name IO_STANDARD LVDS -to hsma_clk_in_p
set_instance_assignment -name IO_STANDARD LVDS -to hsma_clk_out_p

# ddr3top
set_location_assignment PIN_E26 -to ddr3top_ck_p
set_location_assignment PIN_F26 -to ddr3top_ck_n
set_location_assignment PIN_D26 -to ddr3top_a[0]
set_location_assignment PIN_E27 -to ddr3top_a[1]
set_location_assignment PIN_A27 -to ddr3top_a[2]
set_location_assignment PIN_B27 -to ddr3top_a[3]
set_location_assignment PIN_G26 -to ddr3top_a[4]
set_location_assignment PIN_H26 -to ddr3top_a[5]
set_location_assignment PIN_K27 -to ddr3top_a[6]
set_location_assignment PIN_L27 -to ddr3top_a[7]
set_location_assignment PIN_D27 -to ddr3top_a[8]
set_location_assignment PIN_C28 -to ddr3top_a[9]
set_location_assignment PIN_C29 -to ddr3top_a[10]
set_location_assignment PIN_D28 -to ddr3top_a[11]
set_location_assignment PIN_G27 -to ddr3top_a[12]
#set_location_assignment PIN_G28 -to ddr3top_a[13]	#uncomment this statement if you are upgrading the SDRAM to higher capacity
set_location_assignment PIN_A29 -to ddr3top_ba[0]
set_location_assignment PIN_A28 -to ddr3top_ba[1]
set_location_assignment PIN_B29 -to ddr3top_ba[2]
set_location_assignment PIN_F28 -to ddr3top_casn
set_location_assignment PIN_K29 -to ddr3top_cke
set_location_assignment PIN_D30 -to ddr3top_csn
set_location_assignment PIN_H27 -to ddr3top_odt
set_location_assignment PIN_B30 -to ddr3top_rasn
set_location_assignment PIN_F29 -to ddr3top_wen
set_location_assignment PIN_K25 -to ddr3top_rstn

set_location_assignment PIN_G24 -to ddr3top_dq[0]
set_location_assignment PIN_H24 -to ddr3top_dq[1]
set_location_assignment PIN_M24 -to ddr3top_dq[2]
set_location_assignment PIN_A26 -to ddr3top_dq[3]
set_location_assignment PIN_A25 -to ddr3top_dq[4]
set_location_assignment PIN_C25 -to ddr3top_dq[5]
set_location_assignment PIN_B26 -to ddr3top_dq[6]
set_location_assignment PIN_C26 -to ddr3top_dq[7]
set_location_assignment PIN_M25 -to ddr3top_dm[0]
set_location_assignment PIN_F25 -to ddr3top_dqs_p[0]
set_location_assignment PIN_G25 -to ddr3top_dqs_n[0]

set_location_assignment PIN_H23 -to ddr3top_dq[8]
set_location_assignment PIN_J23 -to ddr3top_dq[9]
set_location_assignment PIN_K24 -to ddr3top_dq[10]
set_location_assignment PIN_B24 -to ddr3top_dq[11]
set_location_assignment PIN_C23 -to ddr3top_dq[12]
set_location_assignment PIN_D23 -to ddr3top_dq[13]
set_location_assignment PIN_D24 -to ddr3top_dq[14]
set_location_assignment PIN_E24 -to ddr3top_dq[15]
set_location_assignment PIN_M23 -to ddr3top_dm[1]
set_location_assignment PIN_F23 -to ddr3top_dqs_p[1]
set_location_assignment PIN_G23 -to ddr3top_dqs_n[1]

set_location_assignment PIN_D21 -to ddr3top_dq[16]
set_location_assignment PIN_E21 -to ddr3top_dq[17]
set_location_assignment PIN_M21 -to ddr3top_dq[18]
set_location_assignment PIN_C22 -to ddr3top_dq[19]
set_location_assignment PIN_D22 -to ddr3top_dq[20]
set_location_assignment PIN_G21 -to ddr3top_dq[21]
set_location_assignment PIN_A23 -to ddr3top_dq[22]
set_location_assignment PIN_B23 -to ddr3top_dq[23]
set_location_assignment PIN_M22 -to ddr3top_dm[2]
set_location_assignment PIN_F22 -to ddr3top_dqs_p[2]
set_location_assignment PIN_G22 -to ddr3top_dqs_n[2]

set_location_assignment PIN_K20 -to ddr3top_dq[24]
set_location_assignment PIN_L20 -to ddr3top_dq[25]
set_location_assignment PIN_M20 -to ddr3top_dq[26]
set_location_assignment PIN_A22 -to ddr3top_dq[27]
set_location_assignment PIN_B21 -to ddr3top_dq[28]
set_location_assignment PIN_B20 -to ddr3top_dq[29]
set_location_assignment PIN_F20 -to ddr3top_dq[30]
set_location_assignment PIN_G20 -to ddr3top_dq[31]
set_location_assignment PIN_K21 -to ddr3top_dm[3]
set_location_assignment PIN_D20 -to ddr3top_dqs_p[3]
set_location_assignment PIN_E20 -to ddr3top_dqs_n[3]

set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_a
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr3top_a
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_ba
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr3top_ba
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_casn
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr3top_casn
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_cke
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr3top_cke
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_csn
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr3top_csn
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_odt
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr3top_odt
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_rasn
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr3top_rasn
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_wen
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr3top_wen
set_instance_assignment -name IO_STANDARD 1.5V -to ddr3top_rstn
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr3top_rstn
set_instance_assignment -name IO_STANDARD "1.5 V" -to ddr3top_oct_rzq
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_dq

# Comement out these constraints constraints when a DDR3 design is instantiated in your top level ######
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_ck_p
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to ddr3top_ck_p
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_ck_n
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to ddr3top_ck_n
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_dqs_p
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_dqs_n
#########################################################################################################

# Use these constraints when a DDR3 design is instantiated in your top level ###########################
#set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to ddr3top_ck_p
#set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to ddr3top_ck_n
#set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to ddr3top_dq
#set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to ddr3top_dq
#set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to ddr3top_dqs_p
#set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to ddr3top_dqs_p
#set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to ddr3top_dqs_p
#set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to ddr3top_dqs_n
#set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to ddr3top_dqs_n
#set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to ddr3top_dqs_n
#set_location_assignment PIN_E32 -to ddr3top_oct_rzq
#########################################################################################################

set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to ddr3top_dm
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to ddr3top_dm
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[0] -to ddr3top_dq[0]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[0] -to ddr3top_dq[1]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[0] -to ddr3top_dq[2]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[0] -to ddr3top_dq[3]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[0] -to ddr3top_dq[4]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[0] -to ddr3top_dq[5]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[0] -to ddr3top_dq[6]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[0] -to ddr3top_dq[7]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[1] -to ddr3top_dq[8]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[1] -to ddr3top_dq[9]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[1] -to ddr3top_dq[10]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[1] -to ddr3top_dq[11]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[1] -to ddr3top_dq[12]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[1] -to ddr3top_dq[13]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[1] -to ddr3top_dq[14]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[1] -to ddr3top_dq[15]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[2] -to ddr3top_dq[16]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[2] -to ddr3top_dq[17]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[2] -to ddr3top_dq[18]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[2] -to ddr3top_dq[19]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[2] -to ddr3top_dq[20]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[2] -to ddr3top_dq[21]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[2] -to ddr3top_dq[22]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[2] -to ddr3top_dq[23]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[3] -to ddr3top_dq[24]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[3] -to ddr3top_dq[25]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[3] -to ddr3top_dq[26]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[3] -to ddr3top_dq[27]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[3] -to ddr3top_dq[28]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[3] -to ddr3top_dq[29]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[3] -to ddr3top_dq[30]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[3] -to ddr3top_dq[31]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[3] -to ddr3top_dq[0]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[1] -to ddr3top_dm[1]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[2] -to ddr3top_dm[2]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[3] -to ddr3top_dm[3]
set_instance_assignment -name DQ_GROUP 9 -from ddr3top_dqs_p[0] -to ddr3top_dm[0]

# Ethernet
set_location_assignment PIN_AL11 -to enet_resetn
set_location_assignment PIN_AG11 -to enet_intn
set_location_assignment PIN_AJ11 -to enet_mdc
set_location_assignment PIN_AH11 -to enet_mdio
set_instance_assignment -name IO_STANDARD "2.5 V" -to enet_resetn
set_instance_assignment -name IO_STANDARD "2.5 V" -to enet_intn
set_instance_assignment -name IO_STANDARD "2.5 V" -to enet_mdc
set_instance_assignment -name IO_STANDARD "2.5 V" -to enet_mdio
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to enet_resetn
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to enet_resetn
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to enet_mdc
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to enet_mdc
# SGMII
set_location_assignment PIN_AP13 -to enet_tx_p
set_location_assignment PIN_AP14 -to enet_rx_p
set_instance_assignment -name IO_STANDARD LVDS -to enet_tx_p
set_instance_assignment -name IO_STANDARD LVDS -to enet_rx_p
# RGMII
set_location_assignment PIN_AC11 -to enet_tx_d[0]
set_location_assignment PIN_AC12 -to enet_tx_d[1]
set_location_assignment PIN_AC13 -to enet_tx_d[2]
set_location_assignment PIN_AB11 -to enet_tx_d[3]
set_location_assignment PIN_AF11 -to enet_rx_d[0]
set_location_assignment PIN_AF13 -to enet_rx_d[1]
set_location_assignment PIN_AE12 -to enet_rx_d[2]
set_location_assignment PIN_AE13 -to enet_rx_d[3]
set_location_assignment PIN_AD12 -to enet_gtx_clk
set_location_assignment PIN_AB12 -to enet_tx_en
set_location_assignment PIN_AL4 -to enet_rx_clk
set_location_assignment PIN_AB13 -to enet_rx_dv
set_instance_assignment -name IO_STANDARD "2.5 V" -to enet_tx_d
set_instance_assignment -name IO_STANDARD "2.5 V" -to enet_rx_d
set_instance_assignment -name IO_STANDARD "2.5 V" -to enet_gtx_clk
set_instance_assignment -name IO_STANDARD "2.5 V" -to enet_tx_en
set_instance_assignment -name IO_STANDARD "2.5 V" -to enet_rx_clk
set_instance_assignment -name IO_STANDARD "2.5 V" -to enet_rx_dv
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to enet_tx_d
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to enet_tx_d
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to enet_gtx_clk
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to enet_gtx_clk
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to enet_tx_en
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to enet_tx_en


# Flash & SSRAM
set_location_assignment PIN_AP22 -to fsm_a[0]
set_location_assignment PIN_AP23 -to fsm_a[1]
set_location_assignment PIN_AN23 -to fsm_a[2]
set_location_assignment PIN_AN24 -to fsm_a[3]
set_location_assignment PIN_AM23 -to fsm_a[4]
set_location_assignment PIN_AL23 -to fsm_a[5]
set_location_assignment PIN_AL24 -to fsm_a[6]
set_location_assignment PIN_AK24 -to fsm_a[7]
set_location_assignment PIN_AK23 -to fsm_a[8]
set_location_assignment PIN_AJ23 -to fsm_a[9]
set_location_assignment PIN_AJ25 -to fsm_a[10]
set_location_assignment PIN_AH23 -to fsm_a[11]
set_location_assignment PIN_AH24 -to fsm_a[12]
set_location_assignment PIN_AH25 -to fsm_a[13]
set_location_assignment PIN_AG23 -to fsm_a[14]
set_location_assignment PIN_AG24 -to fsm_a[15]
set_location_assignment PIN_AF23 -to fsm_a[16]
set_location_assignment PIN_AF25 -to fsm_a[17]
set_location_assignment PIN_AE25 -to fsm_a[18]
set_location_assignment PIN_AE24 -to fsm_a[19]
set_location_assignment PIN_AE23 -to fsm_a[20]
set_location_assignment PIN_AP20 -to fsm_a[21]
set_location_assignment PIN_AN21 -to fsm_a[22]
set_location_assignment PIN_AN20 -to fsm_a[23]
set_location_assignment PIN_AM20 -to fsm_a[24]
set_location_assignment PIN_AM22 -to fsm_a[25]
set_location_assignment PIN_AL20 -to fsm_a[26]

set_location_assignment PIN_AD27 -to fsm_d[0]
set_location_assignment PIN_AD26 -to fsm_d[1]
set_location_assignment PIN_AE26 -to fsm_d[2]
set_location_assignment PIN_AE28 -to fsm_d[3]
set_location_assignment PIN_AF29 -to fsm_d[4]
set_location_assignment PIN_AF28 -to fsm_d[5]
set_location_assignment PIN_AF26 -to fsm_d[6]
set_location_assignment PIN_AG29 -to fsm_d[7]
set_location_assignment PIN_AG26 -to fsm_d[8]
set_location_assignment PIN_AH29 -to fsm_d[9]
set_location_assignment PIN_AG27 -to fsm_d[10]
set_location_assignment PIN_AH27 -to fsm_d[11]
set_location_assignment PIN_AH26 -to fsm_d[12]
set_location_assignment PIN_AJ26 -to fsm_d[13]
set_location_assignment PIN_AK27 -to fsm_d[14]
set_location_assignment PIN_AK26 -to fsm_d[15]
set_location_assignment PIN_AL27 -to fsm_d[16]
set_location_assignment PIN_AL28 -to fsm_d[17]
set_location_assignment PIN_AL29 -to fsm_d[18]
set_location_assignment PIN_AE29 -to fsm_d[19]
set_location_assignment PIN_AM31 -to fsm_d[20]
set_location_assignment PIN_AM29 -to fsm_d[21]
set_location_assignment PIN_AM28 -to fsm_d[22]
set_location_assignment PIN_AL26 -to fsm_d[23]
set_location_assignment PIN_AL25 -to fsm_d[24]
set_location_assignment PIN_AM26 -to fsm_d[25]
set_location_assignment PIN_AM25 -to fsm_d[26]
set_location_assignment PIN_AN26 -to fsm_d[27]
set_location_assignment PIN_AP28 -to fsm_d[28]
set_location_assignment PIN_AP27 -to fsm_d[29]
set_location_assignment PIN_AP26 -to fsm_d[30]
set_location_assignment PIN_AP25 -to fsm_d[31]

set_location_assignment PIN_AL22 -to flash_oen
set_location_assignment PIN_AH21 -to flash_wen
set_location_assignment PIN_AK21 -to flash_cen[0]
set_location_assignment PIN_AK20 -to flash_cen[1]
set_location_assignment PIN_AJ22 -to flash_clk
set_location_assignment PIN_AH22 -to flash_resetn
set_location_assignment PIN_AJ20 -to flash_advn
set_location_assignment PIN_AH20 -to flash_rdybsyn[0]
set_location_assignment PIN_AG20 -to flash_rdybsyn[1]

set_location_assignment PIN_AL18 -to sram_clk
set_location_assignment PIN_AL17 -to sram_oen
set_location_assignment PIN_AL19 -to sram_cen
set_location_assignment PIN_AP17 -to sram_bwen
set_location_assignment PIN_AM17 -to sram_bwn[0]
set_location_assignment PIN_AM19 -to sram_bwn[1]
set_location_assignment PIN_AN17 -to sram_bwn[2]
set_location_assignment PIN_AN18 -to sram_bwn[3]
set_location_assignment PIN_AP19 -to sram_adscn
set_location_assignment PIN_AF22 -to sram_gwn
set_location_assignment PIN_AD21 -to sram_zz
set_location_assignment PIN_AE19 -to sram_advn
set_location_assignment PIN_AF19 -to sram_adspn
set_location_assignment PIN_AG21 -to sram_mode
set_location_assignment PIN_AF20 -to sram_dqp[0]
set_location_assignment PIN_AE20 -to sram_dqp[1]
set_location_assignment PIN_AE22 -to sram_dqp[2]
set_location_assignment PIN_AE21 -to sram_dqp[3]

set_instance_assignment -name IO_STANDARD "2.5 V" -to fsm_a
set_instance_assignment -name IO_STANDARD "2.5 V" -to fsm_d
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fsm_a
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fsm_d
set_instance_assignment -name IO_STANDARD "2.5 V" -to flash_oen
set_instance_assignment -name IO_STANDARD "2.5 V" -to flash_wen
set_instance_assignment -name IO_STANDARD "2.5 V" -to flash_cen
set_instance_assignment -name IO_STANDARD "2.5 V" -to flash_clk
set_instance_assignment -name IO_STANDARD "2.5 V" -to flash_resetn
set_instance_assignment -name IO_STANDARD "2.5 V" -to flash_advn
set_instance_assignment -name IO_STANDARD "2.5 V" -to flash_rdybsyn
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_clk
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_oen
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_cen
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_bwen
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_bwn
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_adscn
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_gwn
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_zz
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_advn
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_adspn
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_mode
set_instance_assignment -name IO_STANDARD "2.5 V" -to sram_dqp

# MaxV
set_location_assignment PIN_G12 -to max5_clk
set_location_assignment PIN_G11 -to max5_csn
set_location_assignment PIN_G13 -to max5_ben[0]
set_location_assignment PIN_F13 -to max5_ben[1]
set_location_assignment PIN_E12 -to max5_ben[2]
set_location_assignment PIN_D12 -to max5_ben[3]
set_location_assignment PIN_C10 -to max5_oen
set_location_assignment PIN_D10 -to max5_wen
set_location_assignment PIN_H11 -to int_tsd_sda
set_location_assignment PIN_H12 -to int_tsd_scl
set_instance_assignment -name IO_STANDARD "2.5 V" -to max5_clk
set_instance_assignment -name IO_STANDARD "2.5 V" -to max5_csn
set_instance_assignment -name IO_STANDARD "2.5 V" -to max5_ben
set_instance_assignment -name IO_STANDARD "2.5 V" -to max5_oen
set_instance_assignment -name IO_STANDARD "2.5 V" -to max5_wen
set_instance_assignment -name IO_STANDARD "2.5 V" -to int_tsd_sda
set_instance_assignment -name IO_STANDARD "2.5 V" -to int_tsd_scl

# usb Blaster II
set_location_assignment PIN_AG15 -to usb_clk
set_location_assignment PIN_AP16 -to usb_data[0]
set_location_assignment PIN_AN15 -to usb_data[1]
set_location_assignment PIN_AM16 -to usb_data[2]
set_location_assignment PIN_AM14 -to usb_data[3]
set_location_assignment PIN_AL16 -to usb_data[4]
set_location_assignment PIN_AL15 -to usb_data[5]
set_location_assignment PIN_AL14 -to usb_data[6]
set_location_assignment PIN_AK14 -to usb_data[7]
set_location_assignment PIN_AH15 -to usb_addr[0]
set_location_assignment PIN_AH14 -to usb_addr[1]
set_location_assignment PIN_AJ19 -to usb_scl
set_location_assignment PIN_AK17 -to usb_sda
set_location_assignment PIN_AJ17 -to usb_resetn
set_location_assignment PIN_AK15 -to usb_oen
set_location_assignment PIN_AH19 -to usb_rdn
set_location_assignment PIN_AK18 -to usb_wrn
set_location_assignment PIN_AJ16 -to usb_full
set_location_assignment PIN_AH16 -to usb_empty
set_location_assignment PIN_AG8 -to fx2_resetn
set_instance_assignment -name IO_STANDARD "2.5 V" -to usb_clk
set_instance_assignment -name IO_STANDARD "2.5 V" -to usb_data
set_instance_assignment -name IO_STANDARD "2.5 V" -to usb_addr
set_instance_assignment -name IO_STANDARD "2.5 V" -to usb_scl
set_instance_assignment -name IO_STANDARD "2.5 V" -to usb_sda
set_instance_assignment -name IO_STANDARD "2.5 V" -to usb_resetn
set_instance_assignment -name IO_STANDARD "2.5 V" -to usb_oen
set_instance_assignment -name IO_STANDARD "2.5 V" -to usb_rdn
set_instance_assignment -name IO_STANDARD "2.5 V" -to usb_wrn
set_instance_assignment -name IO_STANDARD "2.5 V" -to usb_full
set_instance_assignment -name IO_STANDARD "2.5 V" -to usb_empty
set_instance_assignment -name IO_STANDARD "2.5 V" -to fx2_resetn

# user I/O
set_location_assignment PIN_C19 -to lcd_data[0]
set_location_assignment PIN_D19 -to lcd_data[1]
set_location_assignment PIN_D18 -to lcd_data[2]
set_location_assignment PIN_D17 -to lcd_data[3]
set_location_assignment PIN_E17 -to lcd_data[4]
set_location_assignment PIN_G19 -to lcd_data[5]
set_location_assignment PIN_E18 -to lcd_data[6]
set_location_assignment PIN_F19 -to lcd_data[7]
set_location_assignment PIN_B17 -to lcd_csn
set_location_assignment PIN_B18 -to lcd_d_cn
set_location_assignment PIN_C17 -to lcd_wen
set_location_assignment PIN_C16 -to user_led[0]
set_location_assignment PIN_C14 -to user_led[1]
set_location_assignment PIN_C13 -to user_led[2]
set_location_assignment PIN_D16 -to user_led[3]
set_location_assignment PIN_D9 -to hsma_tx_led
set_location_assignment PIN_D8 -to hsma_rx_led
set_location_assignment PIN_A14 -to user_pb[0]
set_location_assignment PIN_B15 -to user_pb[1]
set_location_assignment PIN_B14 -to user_pb[2]
set_location_assignment PIN_D15 -to user_dipsw[0]
set_location_assignment PIN_D14 -to user_dipsw[1]
set_location_assignment PIN_D13 -to user_dipsw[2]
set_location_assignment PIN_E15 -to user_dipsw[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_data
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_csn
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_d_cn
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_wen
set_instance_assignment -name IO_STANDARD "2.5 V" -to user_led
set_instance_assignment -name IO_STANDARD "2.5 V" -to hsma_tx_led
set_instance_assignment -name IO_STANDARD "2.5 V" -to hsma_rx_led
set_instance_assignment -name IO_STANDARD "2.5 V" -to user_pb
set_instance_assignment -name IO_STANDARD "2.5 V" -to user_dipsw


# Miscellaneous
set_location_assignment PIN_H8 -to overtemp_fpga
set_instance_assignment -name IO_STANDARD "2.5 V" -to overtemp_fpga
set_location_assignment PIN_D5 -to cpu_resetn
set_instance_assignment -name IO_STANDARD "2.5 V" -to cpu_resetn