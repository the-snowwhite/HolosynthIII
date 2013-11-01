// ============================================================================
// Copyright (c) 2013 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//  
//  
//                     web: http://www.terasic.com/  
//                     email: support@terasic.com
//
// ============================================================================
//Date:  Mon Jul  1 14:21:10 2013
// ============================================================================

//`define ENABLE_DDR3
//`define ENABLE_HPS
`define ENABLE_HSMC

module holosynthii_SoCKit(

      ///////// AUD /////////
      input              AUD_ADCDAT,
      inout              AUD_ADCLRCK,
      inout              AUD_BCLK,
      output             AUD_DACDAT,
      inout              AUD_DACLRCK,
      output             AUD_I2C_SCLK,
      inout              AUD_I2C_SDAT,
      output             AUD_MUTE,
      output             AUD_XCK,

`ifdef ENABLE_DDR3
      ///////// DDR3 /////////
      output      [14:0] DDR3_A,
      output      [2:0]  DDR3_BA,
      output             DDR3_CAS_n,
      output             DDR3_CKE,
      output             DDR3_CK_n,
      output             DDR3_CK_p,
      output             DDR3_CS_n,
      output      [3:0]  DDR3_DM,
      inout       [31:0] DDR3_DQ,
      inout       [3:0]  DDR3_DQS_n,
      inout       [3:0]  DDR3_DQS_p,
      output             DDR3_ODT,
      output             DDR3_RAS_n,
      output             DDR3_RESET_n,
      input              DDR3_RZQ,
      output             DDR3_WE_n,
`endif /*ENABLE_DDR3*/

      ///////// FAN /////////
      output             FAN_CTRL,

`ifdef ENABLE_HPS
      ///////// HPS /////////
      input              HPS_CONV_USB_n,
      output      [14:0] HPS_DDR3_A,
      output      [2:0]  HPS_DDR3_BA,
      output             HPS_DDR3_CAS_n,
      output             HPS_DDR3_CKE,
      output             HPS_DDR3_CK_n,
      output             HPS_DDR3_CK_p,
      output             HPS_DDR3_CS_n,
      output      [3:0]  HPS_DDR3_DM,
      inout       [31:0] HPS_DDR3_DQ,
      inout       [3:0]  HPS_DDR3_DQS_n,
      inout       [3:0]  HPS_DDR3_DQS_p,
      output             HPS_DDR3_ODT,
      output             HPS_DDR3_RAS_n,
      output             HPS_DDR3_RESET_n,
      input              HPS_DDR3_RZQ,
      output             HPS_DDR3_WE_n,
      output             HPS_ENET_GTX_CLK,
      inout              HPS_ENET_INT_n,
      output             HPS_ENET_MDC,
      inout              HPS_ENET_MDIO,
      input              HPS_ENET_RX_CLK,
      input       [3:0]  HPS_ENET_RX_DATA,
      input              HPS_ENET_RX_DV,
      output      [3:0]  HPS_ENET_TX_DATA,
      output             HPS_ENET_TX_EN,
      inout       [3:0]  HPS_FLASH_DATA,
      output             HPS_FLASH_DCLK,
      output             HPS_FLASH_NCSO,
      inout              HPS_GSENSOR_INT,
      inout              HPS_I2C_CLK,
      inout              HPS_I2C_SDA,
      inout       [3:0]  HPS_KEY,
      inout              HPS_LCM_BK,
      output             HPS_LCM_D_C,
      output             HPS_LCM_RST_N,
      input              HPS_LCM_SPIM_CLK,
      output             HPS_LCM_SPIM_MOSI,
      output             HPS_LCM_SPIM_SS,
      output      [3:0]  HPS_LED,
      inout              HPS_LTC_GPIO,
      output             HPS_SD_CLK,
      inout              HPS_SD_CMD,
      inout       [3:0]  HPS_SD_DATA,
      output             HPS_SPIM_CLK,
      input              HPS_SPIM_MISO,
      output             HPS_SPIM_MOSI,
      output             HPS_SPIM_SS,
      input       [3:0]  HPS_SW,
      input              HPS_UART_RX,
      output             HPS_UART_TX,
      input              HPS_USB_CLKOUT,
      inout       [7:0]  HPS_USB_DATA,
      input              HPS_USB_DIR,
      input              HPS_USB_NXT,
      output             HPS_USB_STP,
`endif /*ENABLE_HPS*/

`ifdef ENABLE_HSMC
      ///////// HSMC /////////
      input       [2:1]  HSMC_CLKIN_n,
      input       [2:1]  HSMC_CLKIN_p,
      output      [2:1]  HSMC_CLKOUT_n,
      output      [2:1]  HSMC_CLKOUT_p,
      output             HSMC_CLK_IN0,
      output             HSMC_CLK_OUT0,
      inout       [3:0]  HSMC_D,
//      input       [7:0]  HSMC_GXB_RX_p,
//      output      [7:0]  HSMC_GXB_TX_p,
//      input              HSMC_REF_CLK_p,
      inout       [16:0] HSMC_RX_n,
      inout       [16:0] HSMC_RX_p,
      output             HSMC_SCL,
      inout              HSMC_SDA,
      inout       [16:0] HSMC_TX_n,
      inout       [16:0] HSMC_TX_p,
`endif /*ENABLE_HSMC*/

      ///////// IRDA /////////
      input              IRDA_RXD,

      ///////// KEY /////////
      input       [3:0]  KEY,

      ///////// LED /////////
      output      [3:0]  LED,

      ///////// OSC /////////
      input              OSC_50_B3B,
      input              OSC_50_B4A,
      input              OSC_50_B5B,
      input              OSC_50_B8A,

      ///////// PCIE /////////
      input              PCIE_PERST_n,
      output             PCIE_WAKE_n,

      ///////// RESET /////////
      input              RESET_n,

      ///////// SI5338 /////////
      inout              SI5338_SCL,
      inout              SI5338_SDA,

      ///////// SW /////////
      input       [3:0]  SW,

      ///////// TEMP /////////
      output             TEMP_CS_n,
      output             TEMP_DIN,
      input              TEMP_DOUT,
      output             TEMP_SCLK,

      ///////// USB /////////
      input              USB_B2_CLK,
      inout       [7:0]  USB_B2_DATA,
      output             USB_EMPTY,
      output             USB_FULL,
      input              USB_OE_n,
      input              USB_RD_n,
      input              USB_RESET_n,
      inout              USB_SCL,
      inout              USB_SDA,
      input              USB_WR_n,

      ///////// VGA /////////
      output      [7:0]  VGA_B,
      output             VGA_BLANK_n,
      output             VGA_CLK,
      output      [7:0]  VGA_G,
      output             VGA_HS,
      output      [7:0]  VGA_R,
      output             VGA_SYNC_n,
      output             VGA_VS
);

//=======================================================
//  PARAMETER declarations
//=======================================================
`define _CycloneV
`define _Synth
//`define _24BitAudio // if not defined defaults to 16-bit audio output
//`define _271MhzOscs // if not defined defaults to 180 Mhz oscilator clock

//`define _Graphics

//`define _VEEK_Graphics
//`define _LTM_Graphics

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
assign AUD_MUTE = SW[2];

reg [7:0]   delay_1;

wire iRST_n;

	wire [7:0] LEDG;
//	assign LED = ~LEDG[3:0];
	assign LED = LEDG[3:0];
	
	assign iRST_n = RESET_n;

	
	
	assign HSMC_TX_p[12] = AUD_XCK; // HSMA_RX_D_N14 		Violet
	
//	assign aud_bck = AUD_BCLK;
	assign HSMC_TX_n[11] = AUD_BCLK; // HSMA_RX_D_P15 		Orange

//	assign aud_lrck = AUD_DACLRCK;
	assign HSMC_TX_p[11] = AUD_DACLRCK; // HSMA_RX_D_N15	Green
	
//	assign aud_dat = AUD_DACDAT;
	assign HSMC_TX_n[10] = AUD_DACDAT; // HSMA_RX_D_P16 	White

//	wire UART_RXD = HSMC_RX_p[10]; // HSMA_TX_D_P12		Blue !
	wire UART_RXD = SW[0] ? HSMC_RX_p[10] : ~HSMC_RX_p[10]; // HSMA_TX_D_P12		Blue !
	
	wire midi_txd;
	
//	assign HSMC_TX_p[10] = midi_txd; // Yellow
	assign HSMC_RX_n[9] = SW[1] ? midi_txd : ~midi_txd; // Yellow !! inverted midi out
	
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
    .EXT_CLOCK_IN(OSC_50_B4A) ,   // input  CLOCK_50_sig
    .DLY0(iRST_n),
//    .MIDI_Rx_DAT(~UART_RXD) ,    // input  MIDI_DAT_sig (inverted due to inverter in rs232 chip)
    .MIDI_Rx_DAT(UART_RXD) ,    // input  MIDI_DAT_sig (inverted due to inverter in rs232 chip)
	.midi_txd ( midi_txd ),		// output midi transmit signal (inverted due to inverter in rs232 chip)
    .button( KEY[3:0] ),            //  Button[3:0]
//    .SW ( SW[17:0]),
    .GLED(LEDG),                            //  Green LED [4:1]
    .RLED(LEDR),                            //  Green LED [4:1]
//  .hex_disp(hex_disp),
`ifdef _Synth
    .AUD_ADCLRCK(AUD_ADCLRCK),      //  Audio CODEC ADC LR Clock
    .AUD_DACLRCK(AUD_DACLRCK),      //  Audio CODEC DAC LR Clock
    .AUD_ADCDAT (AUD_ADCDAT ),      //  Audio CODEC ADC Data
    .AUD_DACDAT (AUD_DACDAT ),      //  Audio CODEC DAC Data
    .AUD_BCLK   (AUD_BCLK   ),      //  Audio CODEC Bit-Stream Clock
    .AUD_XCK    (AUD_XCK    )      //  Audio CODEC Chip Clock
`endif
);



always @(negedge KEY[3] or posedge OSC_50_B4A) 
    begin
        if ( !KEY[3])
            delay_1 <=0 ;
        else if ( !delay_1 [7] )
            delay_1 <= delay_1 + 1'b1;
    end

I2C_AV_Config       u3  (   //  Host Side
                            .iCLK  ( OSC_50_B4A    ),
                            .iRST_N( delay_1[7] ),
                            //  I2C Side
                            .I2C_SCLK(AUD_I2C_SCLK),
                            .I2C_SDAT(AUD_I2C_SDAT) 
                            
                            );


endmodule
