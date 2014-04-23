//--------------------------------------------------------------------------//
// Title:       golden_top.v                                                //
// Rev:         Rev 5                                                       //
// Created:     November 30, 2012                                               //
//--------------------------------------------------------------------------//
// Description: Cyclone V SX SoC pinout and IO Standard example design      //              					                        //
//--------------------------------------------------------------------------//
// Revision History:                                                        //
// Rev 0:       1st cut                                                      //
//----------------------------------------------------------------------------
//------ 1 ------- 2 ------- 3 ------- 4 ------- 5 ------- 6 ------- 7 ------7
//------ 0 ------- 0 ------- 0 ------- 0 ------- 0 ------- 0 ------- 0 ------8
//----------------------------------------------------------------------------
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
//with any other product not provided by Altera.                              
//                                                                            



//`define		HPS
//`define	DDR3_FPGA
//`define	DDR3_HPS
//`define	I2C_FPGA
//`define	MAX_FPGA

//`define	HSMA_XCVR      
//`define	HSMA_LVDS
//`define	HSMA_PARALLEL 
//`define	PCIE_XCVR
//`define	SDI_XCVR

module holosynthiiCVSoc (
//--------------------------------------------------------------------------//
/*
//User-IO------------------------------//X pins  //--------------------------
	output [3:0]   user_led_fpga,       
	
//GPLL-CLK-----------------------------//X pins
   input          clk_100m_fpga,       //2.5V    //100 MHz (2nd copy to max)
   input          clk_50m_fpga,        //2.5V    //50MHz (2nd copy to max) 

	input          clk_top1,            //2.5V    //156.25 MHz adjustable
   input          clk_bot1,            //1.5V    //100 MHz ajustable

	  output         ddr3_fpga_csn,       //SSTL15  //Chip Select
	input          cpu_resetn          //2.5V    //NIOS CPU Reset Pushbutton
*/
//--------------------------------------------------------------------------//
//////////////////// Hard Processor System (HPS) pins ////////////////////////
//--------------------------------------------------------------------------//

`ifdef	HPS
//HPS-CLK-INPUT------------------------//2 pins   //--------------------------
   //input          clk_osc1,            //3.3V     //Not for instantiation
   //input          clk_osc2,            //3.3V     //Not for instantiation

//HPS-Reset----------------------------//2 pins  //--------------------------
   //inout          mictor_rstn,         //3.3V    //Cold Reset 
   //input          hps_resetn,          //3.3V    //Warm Reset 

//HPS-User-IO--------------------------//X pins  //--------------------------
   //input  [3:0]   user_dipsw_hps,      //1.5V
   //output [3:0]   user_led_hps,        //3.3V
   //input  [1:0]   user_pb_hps,         //1.5V

//HPS-UART----------------------------//2 pins   //--------------------------
   input          uart_rx,            //3.3V LV  //UART Receive
   output         uart_tx,            //3.3V     //UART Transmit


//HPS-I2C------------------------------//2 pins  //--------------------------
	inout          i2c_scl_hps,         //3.3V    //HPS I2C Clock output
	inout          i2c_sda_hps,         //3.3V    //HPS I2C Data Input/Output
	
//HPS-SPI-Bus--------------------------//4 pins  //--------------------------
	output         spi_csn,             //3.3V    //Slave Sel 0 - LTC Analog
	input          spi_miso,            //3.3V    //Master Input
	output         spi_mosi,            //3.3V    //Master Output 
	output         spi_sck,             //3.3V    //Clock Output 

//HPS-QSPI-Flash-----------------------//6 pins  //--------------------------
	output         qspi_clk,            //3.3V    //Clock
	inout [3:0]    qspi_io,             //3.3V    //Data
	output         qspi_ss0,            //3.3V    //Select
	
//HPS-SD-Card-Flash--------------------//7 pins  //--------------------------
   output         sd_clk,              //3.3V    //
	inout          sd_cmd,              //3.3V    //
	output         sd_pwren,            //3.3V    //
   //inout  [3:0]   sd_dat,              //3.3V    //???????????????  should only be (3:0) ????????
   inout  [7:0]   sd_dat,              //3.3V    //???????????????  should only be (3:0) ????????

//HPS-USB-OTG-------------------------//19 pins  //--------------------------
	input          usb_clk,            //3.3V     //Clock
	inout  [7:0]   usb_data,           //3.3V     //
	input          usb_nxt,            //3.3V     //
	input          usb_dir,            //3.3V     //
	output         usb_stp,            //3.3V     //
	input          usb_empty,  
	input          usb_full,    
	output         usb_oen,    
	output         usb_rdn,       
	output         usb_resetn,
	output         usb_scl,       
	inout          usb_sda,       
	output         usb_wrn,
	

//HPS-Ethernet----10/100/1000----------//14 pins //--------------------------
	output         enet_hps_gtx_clk,    //3.3V    //Gb Ethernet Clock
	//input			   enet_hps_intn,       //3.3V    //Placed on HPS GPIO
	output         enet_hps_mdc,        //3.3V    //MDIO Clock (TR=0)
	inout          enet_hps_mdio,       //3.3V    //MDIO Data (TR=0)
	input			   enet_hps_rx_clk,     //3.3V    //Receive Data
	input			   enet_hps_rx_dv,      //3.3V    //Receive Data Valid / Cont
	input	[3:0]	   enet_hps_rxd,        //3.3V    //Receive Data
	output         enet_hps_tx_en,      //3.3V    //Transmit Data Enable / Cont
	output [3:0]   enet_hps_txd,        //3.3V    //Transmit Data
	
//HPS-CAN-BUS--------------------------//2 pins  //
   input          can_0_rx,            //3.3V    //HPS only
   output         can_0_tx,            //3.3V    //HPS only 

//HPS-Trace----------------------------//10 pins //--------------------------
	//input          mictor_rstn,         //3.3V    //??????????????? not in Qsys - needed?
   output         trace_clk_mic,       //3.3V    //
   output [7:0]   trace_data,          //3.3V    //

`endif

//HPS-DDR3-400Mx40---------------------//78 pins //--------------------------
`ifdef	DDR3_HPS
   output [14:0]  ddr3_hps_a,          //SSTL15  //Address
   output [2:0]   ddr3_hps_ba,         //SSTL15  //Bank Address
   output         ddr3_hps_casn,       //SSTL15  //Column Address Strobe
   output         ddr3_hps_cke,        //SSTL15  //Clock Enable
   output         ddr3_hps_clk_n,      //SSTL15  //Diff Clock - Neg
   output         ddr3_hps_clk_p,      //SSTL15  //Diff Clock - Pos
   output         ddr3_hps_csn,        //SSTL15  //Chip Select
   output [4:0]   ddr3_hps_dm,         //SSTL15  //Data Write Mask
   inout  [39:0]  ddr3_hps_dq,         //SSTL15  //Data Bus
   inout	 [4:0]   ddr3_hps_dqs_n,      //SSTL15  //Diff Data Strobe - Neg
	inout  [4:0]   ddr3_hps_dqs_p,      //SSTL15  //Diff Data Strobe - Pos
	output         ddr3_hps_odt,        //SSTL15  //On-Die Termination Enable
	output         ddr3_hps_rasn,       //SSTL15  //Row Address Strobe
	output         ddr3_hps_resetn,     //SSTL15  //Reset
	output         ddr3_hps_wen,        //SSTL15  //Write Enable
	input          ddr3_hps_rzq,        //OCT_rzqin
	//input          ddr3_rup,          //OCT_rup
	//input          ddr3_rdn,          //OCT_rdn
`else
   //output         ddr3_hps_csn,        //SSTL15  //Chip Select
`endif


//--------------------------------------------------------------------------//
//////////////////////////////// FPGA Pins ///////////////////////////////////
//--------------------------------------------------------------------------//

	
//FPGA-GPLL-CLK------------------------//X pins
   input          clk_100m_fpga,       //2.5V    //100 MHz (2nd copy to max)
   input          clk_50m_fpga,        //2.5V    //50MHz (2nd copy to max) 
	input				clk_25m_fpga,
	input          clk_top1,            //2.5V    //156.25 MHz adjustable
   input          clk_bot1,            //1.5V    //100 MHz adjustable
//   input          clk_enet_fpga_p,     //LVDS    //125 MHz fixed

//FPGA-User-IO-------------------------//11 pins //--------------------------
	input          cpu_resetn,          //2.5V    //NIOS CPU Reset Pushbutton
	input	 [3:0]   user_dipsw_fpga,     //
	output [3:0]   user_led_fpga,       //
	input	 [1:0]   user_pb_fpga,        //

//FPGA-DDR3-400Mx32--------------------//71 pins //--------------------------
`ifdef	DDR3_FPGA
   output [14:0]  ddr3_fpga_a,         //SSTL15  //Address
   output [2:0]   ddr3_fpga_ba,        //SSTL15  //Bank Address
	output         ddr3_fpga_casn,      //SSTL15  //Column Address Strobe
	output         ddr3_fpga_cke,       //SSTL15  //Clock Enable
	output         ddr3_fpga_clk_n,     //SSTL15  //Diff Clock - Neg
	output         ddr3_fpga_clk_p,     //SSTL15  //Diff Clock - Pos
   output         ddr3_fpga_csn,       //SSTL15  //Chip Select
   output [3:0]   ddr3_fpga_dm,        //SSTL15  //Data Write Mask
   inout  [31:0]  ddr3_fpga_dq,        //SSTL15  //Data Bus
   inout  [3:0]   ddr3_fpga_dqs_n,     //SSTL15  //Diff Data Strobe - Neg
   inout  [3:0]   ddr3_fpga_dqs_p,     //SSTL15  //Diff Data Strobe - Pos
   output         ddr3_fpga_odt,       //SSTL15  //On-Die Termination Enable
   input          ddr3_fpga_rasn,      //SSTL15  //Row Address Strobe
   input          ddr3_fpga_resetn,    //SSTL15  //Reset
   input          ddr3_fpga_wen,       //SSTL15  //Write Enable
	input          ddr3_fpga_rzq,       //OCT_rzqin
`else
   output         ddr3_fpga_csn,       //SSTL15  //Chip Select
`endif
	

//FPGA-Ethernet1---10/100--------------//14 pins //--------------------------
	input			   enet1_rx_clk,        //2.5V    //Receive Data Clock
	input	[3:0]	   enet1_rx_d,          //2.5V    //Receive Data
	input			   enet1_rx_dv,         //2.5V    //Receive Data Valid
	input			   enet1_rx_error,      //2.5V    //Receive Data Error
	output         enet1_tx_clk_fb,     //2.5V    //Transmit Clock Feedback
	output [3:0]   enet1_tx_d,          //2.5V    //Transmit Data
	output         enet1_tx_en,         //2.5V    //Transmit Data Enable
	input          enet1_tx_error,      //2.5V    //Transmit Data Error
	output         enet_dual_resetn,    //2.5V    //EtherCat PHY Reset
	input			   enet2_rx_clk,        //2.5V    //Receive Data Clock
	input	[3:0]	   enet2_rx_d,          //2.5V    //Receive Data
	input			   enet2_rx_dv,         //2.5V    //Receive Data Valid
	input			   enet2_rx_error,      //2.5V    //Receive Data Error
	output         enet2_tx_clk_fb,     //2.5V    //Transmit Clock Feedback
	output [3:0]   enet2_tx_d,          //2.5V    //Transmit Data
	output         enet2_tx_en,         //2.5V    //Transmit Data Enable
	input          enet2_tx_error,      //2.5V    //Transmit Data Error
	input				enet_fpga_mdc,
	input				enet_fpga_mdio,

//SDI-XCVR-Video-----------------------//X pins  //--------------------------
`ifdef	use_SDI_XCVR_refclk_p
   	input          clk_148_p,           //LVDS    //148.5MHz Prog. SDI VCXO 
`endif
`ifdef	SDI_XCVR
	input          gxb_rx_l4_p,         //PCML    //SDI Receiver (or SMA)
	output         gxb_tx_l4_p,         //PCML    //SDI Transmitter (or SMA)
`endif

	//148.5M programmable VCXO in refclk section above
	output			sdi_clk148_dn,       //2.5V    //VCXO pump up
	output			sdi_clk148_up,       //2.5V    //VCXO pump down
	input 			sdi_fault,           //2.5V    //SDI Cable Driver Fault
	output			sdi_rsti,            //2.5V    //SDI Cable Driver Reset
	output			sdi_rx_bypass,       //2.5V    //SDI Equalizer Bypass
	output 			sdi_rx_en,           //2.5V    //SDI Equalizer Enable
	output 			sdi_tx_en,           //2.5V    //SDI Cable Driver Enable
	output 			sdi_tx_sd_hdn,       //2.5V    //SDI Cable Driver High-Def 
`ifdef	I2C_FPGA	
	inout				i2c_sda_fpga,
	inout				i2c_scl_fpga,
`endif


`ifdef	MAX_FPGA
	output	max_fpga_miso,
	input		max_fpga_mosi,
	inout		max_fpga_sck,
	inout		max_fpga_ssel,
`endif


//HSMC-Port-A--------------------------//107pins //--------------------------
`ifdef	use_HSMA_XCVR_refclk_p
	input          refclk_ql2_p,       //LVDS    //HSMA Transceiver Refclk -reqs OCT
`endif
`ifdef	HSMA_XCVR
   	input [3:0]    hsma_rx_p,           //PCML?   //HSMA Receive Data -reqs OCT
   	output [3:0]   hsma_tx_p,           //PCML?   //HSMA Transmit Data
`endif
 //Enable below for CMOS HSMC        
	//inout  [79:0]  hsma_d,            //2.5V    //HSMA CMOS Data Bus
 //Enable below for LVDS HSMC        
   input          hsma_clk_in0,        //2.5V    //Primary single-ended CLKIN
	input				hsma_clk_in_p1,		// LVCMOS signal
	input				hsma_clk_in_n1,		// LVCMOS signal
   input          hsma_clk_in_p2,      //LVDS    //Primary Source-Sync CLKIN
   output         hsma_clk_out0,       //2.5V    //Primary single-ended CLKOUT
	output			hsma_clk_out_p1,		// LVCMOS signal
	output			hsma_clk_out_n1,		// LVCMOS signal			
   output         hsma_clk_out_p2,     //LVDS    //Primary Source-Sync CLKOUT
   inout  [3:0]   hsma_d,              //2.5V    //Dedicated CMOS IO                            
	inout  [16:0]  hsma_rx_d_p,         //LVDS    //LVDS Sounce-Sync Input
	inout [16:0]  hsma_tx_d_p,         //LVDS    //LVDS Sounce-Sync Output
	inout  [16:0]  hsma_rx_d_n,         //LVDS    //LVDS Sounce-Sync Input
	inout [16:0]  hsma_tx_d_n,         //LVDS    //LVDS Sounce-Sync Output
	input          hsma_prsntn,         //2.5V    //HSMC Presence Detect Input
	output         hsma_scl,            //2.5V    //SMBus Clock
	inout          hsma_sda,            //2.5V    //SMBus Data

//PCI-Express--------------------------//X pins  //--------------------------
`ifdef	use_PCIE_XCVR_refclk_p
   input          pcie_refclk_p,       //LVDS    //PCIe Refclk -reqs OCT 
`endif
`ifdef	PCIE_XCVR               
   input  [3:0]   pcie_rx_p,           //PCML    //PCIe Receive Data-req'sOCT
   output [3:0]   pcie_tx_p,           //PCML    //PCIe Transmit Data
`endif 
//---Found multiple nets with the same name
   input			pcie_perstn_in,		// Pin W21 instance 0 
   output			pcie_perstn_out,	// Pin AG6 instance 1    
   	input				pcie_prsnt2_x1,
	input				pcie_prsnt2_x4,
	inout				pcie_smbclk,
	inout				pcie_smbdat,
	inout				pcie_waken

);



//=======================================================
//  PARAMETER declarations
//=======================================================
`define _CycloneV
`define _Synth
//`define _24BitAudio // if not defined defaults to 16-bit audio output
//`define _271MhzOscs // if not defined defaults to 180 Mhz oscilator clock


//parameter VOICES = 256;
//parameter VOICES = 128;
//parameter VOICES = 64;
parameter VOICES = 32;
//parameter VOICES = 16;
//parameter VOICES = 8;	// number of simultainious voices 
//parameter VOICES = 4;	// number of simultainious voices
//parameter VOICES = 2;	// number of simultainious voices
//parameter VOICES = 1;	// number of simultainious voices

//parameter V_OSC = 8;  //!NEEK
//parameter V_OSC = 6;
parameter V_OSC = 4;	// number of oscilators pr. voice.
//parameter V_OSC = 3;
//parameter V_OSC = 2;	// number of oscilators pr. voice.
//parameter V_OSC = 1;

parameter O_ENVS = 2;	// number of envelope generators pr. oscilator.

parameter V_ENVS = V_OSC * O_ENVS;	// number of envelope generators  pr. voice.


//=======================================================
//  REG/WIRE declarations
//=======================================================

reg [7:0]   delay_1;

wire iRST_n;

	wire [7:0] LEDG;
	wire [17:0] LEDR;
//	assign LED = ~LEDG[3:0];
	assign  user_led_fpga = ~LEDG[3:0];
	
//	assign iRST_n = cpu_resetn;// !double assignment

	
	
	wire AUD_XCK; // HSMA_RX_D_N14 		Violet
	assign hsma_tx_d_p[12] = AUD_XCK; // HSMA_RX_D_N14 		Violet
	
//	assign aud_bck = AUD_BCLK;
	wire AUD_BCLK; // HSMA_RX_D_P15 		Orange
	assign hsma_tx_d_n[11] = AUD_BCLK; // HSMA_RX_D_P15 		Orange

//	assign aud_lrck = AUD_DACLRCK;
	wire AUD_DACLRCK; // HSMA_RX_D_N15	Green
	assign hsma_tx_d_p[11] = AUD_DACLRCK; // HSMA_RX_D_N15	Green
	
//	assign aud_dat = AUD_DACDAT;
	wire AUD_DACDAT; // HSMA_RX_D_P16 	White
	assign hsma_tx_d_n[10] =AUD_DACDAT; // HSMA_RX_D_P16 	White

//	wire midi_rxd = HSMC_RX_p[10]; // HSMA_TX_D_P12		Blue !
	wire midi_rxd = user_dipsw_fpga[0] ? hsma_rx_d_p[10] : ~hsma_rx_d_p[10]; // HSMA_TX_D_P12		Blue !
	
	wire midi_txd;
	
//	assign HSMC_TX_p[10] = midi_txd; // Yellow
	assign hsma_rx_d_n[9] = user_dipsw_fpga[1] ? midi_txd : ~midi_txd; // Yellow !! inverted midi out
	
//	assign clkout_sma = AUD_XCK;
	
/*	wire noe_in_sig = SW[1];

//=======================================================
//  Structural coding
//=======================================================
    
SFL	SFL_inst (
	.noe_in ( noe_in_sig )
	);
*/	
	
synthesizer #(.VOICES(VOICES),.V_OSC(V_OSC),.V_ENVS(V_ENVS))  synthesizer_inst(
    .EXT_CLOCK_IN(clk_50m_fpga) ,   // input  CLOCK_50_sig
    .reg_DLY0(iRST_n),
//    .MIDI_Rx_DAT(~midi_rxd) ,    // input  MIDI_DAT_sig (inverted due to inverter in rs232 chip)
    .MIDI_Rx_DAT(midi_rxd) ,    // input  MIDI_DAT_sig (inverted due to inverter in rs232 chip)
	.midi_txd ( midi_txd ),		// output midi transmit signal (inverted due to inverter in rs232 chip)
    .button( {user_pb_fpga[1:0],user_pb_fpga[1:0]}),            //  Button[3:0]
//    .SW ( SW[17:0]),
    .GLED(LEDG),                            //  Green LED [4:1]
    .RLED(LEDR),                            //  Green LED [4:1]
`ifdef _Synth
//    .AUD_ADCLRCK(AUD_ADCLRCK),      //  Audio CODEC ADC LR Clock
    .AUD_ADCLRCK(),      //  Audio CODEC ADC LR Clock
    .AUD_DACLRCK(AUD_DACLRCK),      //  Audio CODEC DAC LR Clock
//    .AUD_ADCDAT (AUD_ADCDAT ),      //  Audio CODEC ADC Data
    .AUD_ADCDAT ( ),      //  Audio CODEC ADC Data
    .AUD_DACDAT (AUD_DACDAT ),      //  Audio CODEC DAC Data
    .AUD_BCLK   (AUD_BCLK   ),      //  Audio CODEC Bit-Stream Clock
    .AUD_XCK    (AUD_XCK    )      //  Audio CODEC Chip Clock
`endif
);


	
// Rev A board Ethernet reset can interrupt device configuration, to fix
// enet_dual_reset tristate as input or drive as output to 1
assign	enet_dual_resetn	=	1'b1;	
// FPGA user dipswitches drive user LEDs
//assign   user_led_fpga		=	~user_dipsw_fpga;
// Disable FPGA DDR3 
assign   ddr3_fpga_csn		=	1'b1;	





endmodule











