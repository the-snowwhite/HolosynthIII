//--------------------------------------------------------------------------//
// Title:       a2gx_pcie_top.v                                             //
// Rev:         Rev 5                                                       //
//--------------------------------------------------------------------------//
// Description: Golden Top file contains Arria II GX FPGA Dev Kit Board     //
//              pins and I/O Standards.                                     //
//--------------------------------------------------------------------------//
// Revision History:                                                        //
// 1: Initial															    //
// 2: Swap user_pb[1:0] with ddr2_dimm_a[4:0]								//
// 3: Correct pin locations.												//
// 4: Update CLKIN_155_P/N pin locations and DDR2 signal names.				//
// 5: Change ddr3_wen to ddr3_we_n in assignment editor to match pin name.  //
//    20100908
//------ 1 ------- 2 ------- 3 ------- 4 ------- 5 ------- 6 ------- 7 ------7
//------ 0 ------- 0 ------- 0 ------- 0 ------- 0 ------- 0 ------- 0 ------8
//Copyright � 2010 Altera Corporation. All rights reserved.  Altera products
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


module holosynthii_a2gx_dev_kit (
//CLK-Inputs---------------------------//15 pins
    //wired through XCVR blocks, all AC-coupled)
//    input           clkin_ref_q1_1_p,     //LVDS    //adj. defaut 100.000 MHz osc
//    input           clkin_ref_q1_2_p,     //LVDS    //adj. defaut 125.000 MHz osc
//    input           clkin_ref_q2_p,     //LVDS      //adj. default 125.000 MHz osc
//    input           clkin_ref_q3_p,     //LVDS      //adj. default 125.000 MHz osc
//    input   	    clkin_155_p,	   //LVPECL    //155.520 MHz osc 
    input           clkin_bot_p,       //LVDS      //ADJ default 100.000 MHz osc or sma in (Requires external termination.)
    input           clkin_top_p,       //LVDS      //ADJ default 125.000 MHz osc (Requires external termination.)
    output          clkout_sma,        //1.8V      //PLL CLK sma out

	
////DDR3-SDRAM-PORTS  -> 64Mx16 Interface ---------------------//49 pins
    output [14:0]  ddr3_a,          //SSTL15    //Address (1Gb max)
    output [2:0]   ddr3_ba,         //SSTL15    //Bank address
    inout  [15:0]  ddr3_dq,         //SSTL15    //Data
    inout  [1:0]   ddr3_dqs_p,      //SSTL15    //Strobe Pos
    inout  [1:0]   ddr3_dqs_n,      //SSTL15    //Strobe Neg
    output [1:0]   ddr3_dm,         //SSTL15    //Byte write mask
    output         ddr3_we_n,       //SSTL15    //Write enable
    output         ddr3_ras_n,      //SSTL15    //Row address select
    output         ddr3_cas_n,      //SSTL15    //Column address select
    output         ddr3_clk_p,      //SSTL15    //System Clock Pos
    output         ddr3_cke,        //SSTL15    //Clock Enable
    output         ddr3_cs_n,       //SSTL15    //Chip Select
    output         ddr3_rst_n,     	//SSTL15    //Reset
    output         ddr3_odt,        //SSTL15    //On-die termination enable
 
 //DDR2 SDRAM SoDIMM -------------------------------------//x64 -> 117 pins (Default)
	//x64 -> 125 pins
    output [15:0]  ddr2_a,	    	//SSTL18    //Address		
    output [2:0]   ddr2_ba,    		//SSTL18    //Bank address  
    inout  [63:0]  ddr2_dq,         //SSTL18    //Data x64 SODIMM		
    inout  [7:0]   ddr2_dqs,      	//SSTL18    //Strobe Pos			
    inout  [7:0]   ddr2_dqsn,      	//SSTL18    //Strobe Neg			
    output [7:0]   ddr2_dm,         //SSTL18    //Byte write mask  
    output [0:0]   ddr2_cke,    	//SSTL18   //System Clock Enable  
    output [1:0]   ddr2_clk_p,   	//SSTL18   //System Clock Pos     
 // output [1:0]   ddr2_clk_n,   	//SSTL18    //System Clock Neg		
    output         ddr2_we_n,   	//SSTL18    //Write enable		
    output         ddr2_ras_n,  	//SSTL18    //Row address select		
    output         ddr2_cas_n,  	//SSTL18    //Column address select  
    output	[1:0]  ddr2_cs_n,       //SSTL18    //Chip Select           
    output  [1:0]  ddr2_odt,        //SSTL18    //On-die termination enable	

////////////////////////////////////////////////////////////////// 
//ETHERNET-10/100/1000-RGMII-----------
    output  	   enet_gtx_clk,     	//2.5V  //RGMII Transmit Clock
    output [3:0]   enet_tx_d,        	//2.5V  //TX to PHY
    input  [3:0]   enet_rx_d,        	//2.5V  //RX from PHY
    output         enet_tx_en,       	//2.5V  //RGMII Transmit Control
    input	       enet_rx_clk,      	//2.5V  //Derived Received Clock
    input          enet_rx_dv,       	//2.5V  //RGMII Receive Control 
    output         enet_resetn,        	//2.5V  //Reset to PHY (TR=0)
    output         enet_mdc,           	//2.5V  //MDIO Control (TR=0)
    inout          enet_mdio,          	//2.5V  //MDIO Data (TR=0)
    input          enet_intn,           //2.5V  //MDIO Interrupt (TR=0)
///////////////////////////////////////////////////////////////////

//FLASH-SRAM-MAX-------------FSM-Bus---//90 pins
    output [25:0]  fsm_a,              //2.5V      //FSM Address Bus (1Gb Flash)
    inout  [31:0]  fsm_d,              //2.5V      //FSM Data Bus
    output         flash_clk,          //2.5V  
    output         flash_cen,          //2.5V  
    output         flash_oen,          //2.5V
    output         flash_wen,          //2.5V
    output         flash_advn,         //2.5V
    input          flash_rdybsyn,      //2.5V
    output         flash_resetn,       //2.5V     // (TR=0)
    output         sram_clk,           //2.5V
    output         sram_cen,           //2.5V
    inout  [3:0]   sram_dqp,           //2.5V     //Parity bits only go to SRAM
    output [3:0]   sram_bwn,           //2.5V
    output         sram_gwn,           //2.5V
    output         sram_bwen,          //2.5V
    output         sram_oen,           //2.5V
    output         sram_advn,          //2.5V
    output         sram_adspn,         //2.5V
    output         sram_adscn,         //2.5V
    output         sram_zz,            //2.5V     // (TR=0)
    output         max2_clk,           //1.8V
    output         max2_csn,           //1.8V
    output [3:0]   max2_ben,           //1.8V
    output         max2_oen,           //1.8V
    output         max2_wen,           //1.8V

////LCD----------------------------------//11 pins
    inout  [7:0]   lcd_data,           //2.5V
    output         lcd_d_cn,           //2.5V
    output         lcd_wen,            //2.5V
    output         lcd_csn,            //2.5V
//
////User-IO------------------------------//11 pins
    input  [3:0]   user_dipsw,         //2.5V     // (TR=0)
    output [3:0]   user_led,           //2.5V
    input  [1:0]   user_pb,            //1.8V     // (TR=0)
    input          cpu_resetn,         //2.5V (DEV_CLRn)    // (TR=0)
  
//// //PCI-EXPRESS-EDGE---------------------
//    input          pcie_refclk_p,      //HCSL
//    output [7:0]   pcie_tx_p,          //1.4V PCML
//    input  [7:0]   pcie_rx_p,          //1.4V PCML
    input          pcie_smbclk,        //2.5V     // (TR=0)
    inout          pcie_smbdat,        //2.5V     // (TR=0)
    input          pcie_perstn,        //2.5V     // (TR=0)
    output         pcie_waken,         //2.5V     // (TR=0)
    output         pcie_led_x1,        //2.5V
    output         pcie_led_x4,        //2.5V
    output         pcie_led_x8,        //2.5V
//HIGH-SPEED-MEZZANINE-CARD------------//198 pins (HSMB is only connected on EP2AGX260 devices)
    //Port A -->   single samtec conn  //107 pins  //------------------
 //   output [3:0]   hsma_tx_p,    	 //1.4V PCML
 //   input  [3:0]   hsma_rx_p,    	 //1.4V PCML
      //Enable below for CMOS HSMC     
//	inout  [79:0]  hsma_d,           //2.5V
	inout  [75:60]  hsma_d,           //3.3V
	output aud_xck,
	input lrck_in,
	output aud_dat,
	output aud_bck,
	output aud_lrck,
	//Enable below for LVDS HSMC
//    output [16:0]  hsma_tx_d_p,        //LVDS  //69 pins
//    input  [16:0]  hsma_rx_d_p,        //LVDS
//    inout  [3:0]   hsma_d,             //2.5V
    input          hsma_clk_in0,       //2.5V
    output         hsma_clk_out0,      //2.5V
//    input          hsma_clk_in_p1,     //LVDS //Requires external termination  
//    output         hsma_clk_out_p1,    //LVDS
//   input          hsma_clk_in_p2,     //LVDS //Requires external termination
//    output         hsma_clk_out_p2,    //LVDS
    inout          hsma_sda,           //2.5V     // (TR=0)
    output         hsma_scl,           //2.5V     // (TR=0)
    output         hsma_tx_led,        //2.5V
    output         hsma_rx_led,        //2.5V
    input          hsma_prsntn        //2.5V     // (TR=0)

//    //Port B -->   single samtec conn  //107 pins  //------------------
//This port is only available if the board is populated with a EP2AGX260 device.
//    output [3:0]   hsmb_tx_p,    	 //1.4V PCML   
//    input  [3:0]   hsmb_rx_p,    	 //1.4V PCML   
//    inout  [75:0]  hsmb_d,           //2.5V
//    input          hsmb_clk_in0       //2.5V   
//    output         hsmb_clk_out0,      //2.5V   
//    output         hsmb_clk_out_p1,    //LVDS   
//    inout          hsmb_sda,           //2.5V   
//    output         hsmb_scl,           //2.5V    
//    output         hsmb_tx_led,        //2.5V                 
//    output         hsmb_rx_led,        //2.5V                 
//    input          hsmb_prsntn         //2.5V   
);  

//parameter output_volume_scaling = 32 + V_WIDTH + O_WIDTH; // try *3/4 (0.75) pr 2 voices,osc's
//parameter output_volume_scaling = 32 + ((3*(3+2)) >> 3); // trying *3/4 (0.75) pr 2 voices,osc's


`define _Synth
`define _24BitAudio
`define _271MhzOscs // if not defined defaults to 180 Mhz oscilator clock

	reg [19:0] clk_div;

	reg [3:0] counter;
	
//	reg [15:0] hsma_out;
	
	reg pb[1:0] , resetn,r_key_pressed;
	
//	assign hsma_d[59:0] = 0;

//	assign hsma_d[79:76] = 0;
	
//	assign hsma_d[75:60] = 1'b1 << counter;
	
//	assign user_led = ~counter;

//	wire [15:0] audio_data_in;
//	wire [63:0] sound_data;
		
//	assign audio_data_in = hsma_d[75:60];
	
//	wire AUD_BCK;
	wire iRST_n;
//	wire [15:0] scaled_sound_data;
	
	wire AUD_ADCLRCK, AUD_DACLRCK, AUD_ADCDAT, AUD_DACDAT, AUD_BCLK, AUD_XCK;
	
	wire [7:0] LEDG;
	assign user_led = ~LEDG[3:0];
	
	wire UART_RXD = ~hsma_d[75];
	
	
//	assign AUD_BCK = AUD_BCLK;
//	assign iRST_N = cpu_resetn;
//	assign scaled_sound_data = sound_data >>> output_volume_scaling;// - + 1 
	
	assign aud_bck = AUD_BCLK;
	assign aud_lrck = AUD_DACLRCK;
	assign aud_dat = AUD_DACDAT;
//	assign aud_xck = AUD_XCK;
	assign hsma_d[67] = AUD_XCK;
	
	assign clkout_sma = AUD_XCK;
	
/*	
	always @(posedge clkin_bot_p)begin
		clk_div <= clk_div +1;
	end
	
	always@(posedge clk_div[8])begin
		pb[0] <= user_pb[0];
		pb[1] <= user_pb[1];
		resetn <= cpu_resetn;
		r_key_pressed <= key_pressed;
	end
	
	wire key_pressed = (!pb[0] | !pb[1]) ? 1'b1 : 1'b0;

	always @(negedge resetn or posedge r_key_pressed) begin
		if(!resetn) begin
			counter <= 0;
//			hsma_out <= 0;
		end
		else if(r_key_pressed) begin
			if (!pb[0])begin
				counter <= counter + 1;
			end
			else if (!pb[1])begin
				counter <= counter - 1;
			end
//			hsma_out <= 1'b1 << counter;
		end
	end


sounddata_in sounddata_in_inst
(
	.latch_d(latch_d) ,	// input  latch_d_sig
	.lrck_in(lrck_in) ,	// input  lrck_in_sig
	.audio_data_in(audio_data_in) ,	// input [15:0] audio_data_in_sig
//	.l_sounddata(l_sounddata) ,	// output [63:0] l_sounddata_sig
//	.r_sounddata(r_sounddata) 	// output [63:0] r_sounddata_sig
	.sound_out ( sound_data )
);


audio_i2s_driver U_audio_i2s_driver                         // ObjectKind=Sheet Symbol|PrimaryId=U_audio_i2s_driver
(
	.iRST_N( iRST_N ),                               // ObjectKind=Sheet Entry|PrimaryId=audio_i2s_driver.v-iRST_N
	.iAUD_BCK( AUD_BCK ),                          // ObjectKind=Sheet Entry|PrimaryId=audio_i2s_driver.v-oAUD_BCK
	.iAUD_LRCK( lrck_in ),                         // ObjectKind=Sheet Entry|PrimaryId=audio_i2s_driver.v-oAUD_LRCK
	.sound_data ( scaled_sound_data ),
	.oAUD_DATA( AUD_DATA ) // ObjectKind=Sheet Entry|PrimaryId=audio_i2s_driver.v-oAUD_DATA
);
*/


    
synthesizer  synthesizer_inst(
    .EXT_CLOCK_IN(clkin_bot_p) ,   // input  CLOCK_sig
    .DLY0(iRST_n),
    .MIDI_Rx_DAT(UART_RXD) ,    // input  MIDI_DAT_sig
    .button( {cpu_resetn,user_pb[1:0],cpu_resetn} ),            //  Button[3:0]
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
//	.sounddata_out ( AUDIO_OUT ),
//	.latch_sig 		( LATCH_D )
//	.sounddata_out (  ),
//	.latch_sig 		(  )
//`endif
//   .LTM_SCEN(LTM_SCEN),
//   .LTM_GREST(LTM_GREST)
);




endmodule