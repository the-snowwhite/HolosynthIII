//--------------------------------------------------------------------------//
// Title:       a5gx_starter_golden_top.v                                   //
// Rev:         Rev 1.1                                                     //
//--------------------------------------------------------------------------//
// Description: Golden Top file contains Arria V GX FPGA Starter Kit		    //
//              Rev C board pins and I/O standards.                         //
//--------------------------------------------------------------------------//

//Copyright 2012 Altera Corporation. All rights reserved.  Altera products
//are protected under numerous U.S. and foreign patents, maskwork rights,
//copyrights and other intellectual property laws.
//                 
//This reference design file, and your use thereof, is subject to and
//governed by the terms and conditions of the applicable Altera Reference
//Design License Agreement.  By using this reference design file, you
//indicate your acceptance of such terms and conditions between you and
//Altera Corporation.  In the event that you do not agree with such terms and
//conditions, you may not use the reference design file. Please promptly                         
//destroy any copies you have made.
//
//This reference design file being provided on an "as-is" basis and as an
//accommodation and therefore all warranties, representations or guarantees
//of any kind (whether express, implied or statutory) including, without
//limitation, warranties of merchantability, non-infringement, or fitness for
//a particular purpose, are specifically disclaimed.  By making this
//reference design file available, Altera expressly does not recommend,
//suggest or require that this reference design file be used in combination 
//with any other product not provided by Altera
//----------------------------------------------------------------------------

module holosynthii_avgx_starter (

//Refclk & Clkout
	//clkin: 22
	//clkout: 1
	input clk_148_p,				//1.5-V PCML, default 148.5MHz
	input refclk1_ql0_p,			//1.5-V PCML, default 409.6MHz
	input refclk2_ql1_p,			//1.5-V PCML, default 125MHz
	input refclk1_qr0_p,			//1.5-V PCML, default 156.25Mhz
	input refclk2_qr1_p,			//1.5-V PCML, default 125MHz
	input refclk3_qr1_p,			//1.5-V PCML, HSMC CLKIN2 (differential)
	input clk_125_p,				//LVDS, default 125MHz
	input clkintop_125_p,		//LVDS, default 125MHz
	input clkinbot_125_p,		//LVDS, default 125MHz
	input clkintop_100_p,		//LVDS, default 100MHz
	input clkinbot_100_p,		//LVDS, default 100MHz
	input clkin_50_top,			//2.5V, default 50MHz
	input clkin_50_bot,			//2.5V, default 50MHz
	output clkout_sma,				//2.5V
		
//SMA connector interface
	//xcvr: 1
	output sma_xcvr_tx_p,	//1.5V PCML	
	input  sma_xcvr_rx_p,	//1.5V PCML	

//PCIe edge connector interface
	//xcvr: 8
	//IO: 8
	output [7:0]	pcie_tx_p,		 	 //1.5-V PCML
	input  [7:0]	pcie_rx_p,		 	 //1.5-V PCML
	input 			pcie_refclk_p,	 	 //HCSL	
	input				pcie_perstn,		 //2.5V
	output			pcie_led_g2,		 //2.5V
	output 			pcie_waken,			 //2.5V
	output			pcie_led_x1,		 //2.5V
	output			pcie_led_x4,		 //2.5V
	output			pcie_led_x8,		 //2.5V
	inout				pcie_smbdat,		 //2.5V
	output			pcie_smbclk,		 //2.5V

//SDI cable driver/equalizer interface 
	//xcvr: 1
	//IO: 9
	output 	sdi_tx_p,					//1.5V PCML
	input 	sdi_rx_p,					//1.5V PCML
	input		sdi_rx_bypass,				//2.5V
	output	sdi_tx_sd_hdn,				//2.5V
	output	sdi_tx_en,					//2.5V
	output	sdi_rx_en,					//2.5V
	output	sdi_scl,						//2.5V
	inout		sdi_sda,						//2.5V
	input		sdi_fault,					//2.5V
	output  	sdi_clk148_up,				//2.5V
	output  	sdi_clk148_dn,				//2.5V

//HDMI interface
	//IO: 4
	//XCVR: 4 (TX only)
	output 				hdmi_tx_i2c_scl,	//2.5V
	inout 				hdmi_tx_i2c_sda,	//2.5V
	output				hdmi_tx_oen,		//2.5V
	input 				hdmi_tx_hpd,		//2.5V
	output	[2:0]		hdmi_tx_p,			//1.5-V PCML
	output				hdmi_tx_clkout_p,	//1.5-V PCML, 270MHz max
	
//HIGH-SPEED-MEZZANINE-CARD interface ------------//198 pins
   //xcvr: 8
   //IO: 85

   //Bank 1 (transceivers)   	
	output [7:0]	hsma_tx_p,		//1.5V PCML
	input  [7:0]	hsma_rx_p,		//1.5V PCML
	
	//Bank 1, 2 & 3 (non-transceiver)
	inout          hsma_sda,         //2.5V    
	output       	hsma_scl,         //2.5V 
	input				hsma_prsntn,		//2.5V   
	output			hsma_clk_out0,	   //2.5V
	input				hsma_clk_in0,	   //2.5V
	output [2:1]	hsma_clk_out_p,	//LVDS
	input  [2:1]	hsma_clk_in_p,		//LVDS
	inout [3:0]		hsma_d,				//2.5V
	inout [16:0]	hsma_tx_d_p,		//LVDS
	inout [16:0]	hsma_rx_d_p,		//LVDS
	inout [16:0]	hsma_tx_d_n,		//LVDS
	inout [16:0]	hsma_rx_d_n,		//LVDS
	
	
//DDR3 x32 Devices Interface
	//IO: 70
	output						ddr3top_ck_p,		//DIFFERENTIAL 1.5-V SSTL CLASS I
	output						ddr3top_ck_n,		//DIFFERENTIAL 1.5-V SSTL CLASS I
	inout				[31:0]	ddr3top_dq,			//SSTL-15 CLASS I
	inout				[3:0]		ddr3top_dqs_p,		//DIFFERENTIAL 1.5-V SSTL CLASS I
	inout				[3:0]		ddr3top_dqs_n,		//DIFFERENTIAL 1.5-V SSTL CLASS I
	output			[3:0]		ddr3top_dm,			//SSTL-15 CLASS I
	output			[12:0]	ddr3top_a,			//SSTL-15 CLASS I
	output			[2:0]		ddr3top_ba,			//SSTL-15 CLASS I
	output						ddr3top_casn,		//SSTL-15 CLASS I
	output						ddr3top_rasn,		//SSTL-15 CLASS I
	output						ddr3top_cke,		//SSTL-15 CLASS I
	output						ddr3top_csn,		//SSTL-15 CLASS I
	output						ddr3top_odt,		//SSTL-15 CLASS I
	output						ddr3top_wen,		//SSTL-15 CLASS I	
	output						ddr3top_rstn,		//1.5V
	input							ddr3top_oct_rzq,	//1.5V	
	
//Ethernet PHY interface	
	//IO: 20
	input		enet_intn,				//2.5V
	output	enet_resetn,			//2.5V
	output	enet_mdio,				//2.5V
	output	enet_mdc,				//2.5V
	//SGMII
	output	enet_tx_p,				//LVDS
	input		enet_rx_p,				//LVDS
	//RGMII
	output	[3:0]	enet_tx_d,		//2.5V
	input		[3:0]	enet_rx_d,		//2.5V
	output	enet_gtx_clk,			//2.5V
	output 	enet_tx_en,				//2.5V
	input		enet_rx_clk,			//2.5V
	input		enet_rx_dv,				//2.5V	
	
	
//Flash & SSRAM Interface
	//IO: 86
	output 	[26:0]	fsm_a,				//2.5V
	inout		[31:0]	fsm_d,				//2.5V
	output				flash_oen,			//2.5V
	output				flash_wen,			//2.5V
	output	[1:0]		flash_cen,			//2.5V
	output				flash_clk,			//2.5V 
	output				flash_resetn,		//2.5V 
	output				flash_advn,			//2.5V 
	input		[1:0]		flash_rdybsyn,		//2.5V 
	
	output				sram_clk,			//2.5V
	output				sram_oen,			//2.5V
	output				sram_cen,			//2.5V
	output				sram_bwen,			//2.5V
	output	[3:0]		sram_bwn,			//2.5V			
	output				sram_adscn,			//2.5V
	output				sram_gwn,			//2.5V 
	output				sram_zz,				//2.5V
	output				sram_advn,			//2.5V
	output				sram_adspn,			//2.5V
	output				sram_mode,			//2.5V
	output	[3:0]		sram_dqp,			//2.5V
		
//MAX V Interface
	//IO: 10
	output				max5_clk,			//2.5V
	output				max5_csn,			//2.5V
	output	[3:0]		max5_ben,			//2.5V
	output				max5_wen,			//2.5V
	output				max5_oen,			//2.5V
	inout					int_tsd_sda,		//2.5V
	input					int_tsd_scl,		//2.5V

//USB Blaster II
	//IO: 20
	input					usb_clk,			//2.5V
	output	[7:0]		usb_data,		//2.5V
	output	[1:0]		usb_addr,		//2.5V
	inout					usb_scl,			//2.5V
	output				usb_sda,			//2.5V
	output				usb_resetn,		//2.5V
	output				usb_oen,			//2.5V
	output				usb_rdn,			//2.5V
	output				usb_wrn,			//2.5V
	output				usb_full,		//2.5V
	output				usb_empty,		//2.5V
	input					fx2_resetn,		//2.5V
	
//LCD character
	//IO: 11
	inout		[7:0]		lcd_data,			//2.5V
	output				lcd_csn,				//2.5V
	output				lcd_d_cn,			//2.5V
	output				lcd_wen,				//2.5V

//user LED
	//IO: 6
	output 	[3:0]	user_led,			//2.5V
	output 			hsma_tx_led,		//2.5V
	output 			hsma_rx_led,		//2.5V
		
//user DIP
	//IO: 4
	input		[3:0] user_dipsw,	//2.5V
	
//user PB
	//IO: 3
	input		[2:0] user_pb,		//2.5V

//Miscellaneous
	//IO: 2
	input 	cpu_resetn,				//2.5V; comment out if dev_clrn function is set 
	output 	overtemp_fpga			//2.5V	
);


`define _Synth
`define _24BitAudio
`define _271MhzOscs // if not defined defaults to 180 Mhz oscilator clock

//	reg [19:0] clk_div;

//	reg [3:0] counter;
	
	
	reg pb[1:0] , resetn,r_key_pressed;
	
	
	wire iRST_n;
	
	wire AUD_ADCLRCK, AUD_DACLRCK, AUD_ADCDAT, AUD_DACDAT, AUD_BCLK, AUD_XCK;
	
	wire [7:0] LEDG;
	assign user_led = ~LEDG[3:0];
	
	assign iRST_n = cpu_resetn;

	
	
	assign hsma_rx_d_n[14] = AUD_XCK; // HSMA_RX_D_N14 		Violet
	
//	assign aud_bck = AUD_BCLK;
	assign hsma_rx_d_p[15] = AUD_BCLK; // HSMA_RX_D_P15 		Orange

//	assign aud_lrck = AUD_DACLRCK;
	assign hsma_rx_d_n[15] = AUD_DACLRCK; // HSMA_RX_D_N15	Green
	
//	assign aud_dat = AUD_DACDAT;
	assign hsma_rx_d_p[16] = AUD_DACDAT; // HSMA_RX_D_P16 	White

//	wire UART_RXD = ~hsma_d[74]; // HSMA_TX_D_N16		Yellow
	wire UART_RXD = ~hsma_tx_d_n[16]; // HSMA_TX_D_N16		not Yellow !
	
	assign clkout_sma = AUD_XCK;
	



    
synthesizer  synthesizer_inst(
    .EXT_CLOCK_IN(clkinbot_100_p) ,   // input  CLOCK_sig
    .DLY0(iRST_n),
    .MIDI_Rx_DAT(UART_RXD) ,    // input  MIDI_DAT_sig
    .button( {cpu_resetn,user_pb[2:0]} ),            //  Button[3:0]
  //  .SW ( SW[17:0]),
    .GLED(LEDG),                            //  Green LED [4:1]
//    .RLED(LEDR),                            //  Green LED [4:1]
	.RLED( ),                            //  Green LED [4:1]

//`ifdef _Synth
    .AUD_ADCLRCK(AUD_ADCLRCK),      //  Audio CODEC ADC LR Clock
    .AUD_DACLRCK(AUD_DACLRCK),      //  Audio CODEC DAC LR Clock
    .AUD_ADCDAT (AUD_ADCDAT ),      //  Audio CODEC ADC Data
    .AUD_DACDAT (AUD_DACDAT ),      //  Audio CODEC DAC Data
    .AUD_BCLK   (AUD_BCLK   ),      //  Audio CODEC Bit-Stream Clock
    .AUD_XCK    (AUD_XCK    )      //  Audio CODEC Chip Clock
);




endmodule