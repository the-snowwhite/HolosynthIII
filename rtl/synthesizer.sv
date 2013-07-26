/////////////////////////////////////////////
////     2Channel-Music-Synthesizer     /////
/////////////////////////////////////////////
/*****************************************************/
/*             KEY & SW List               			 */
/* BUTTON[1]: I2C reset                       		 */
/* BUTTON[2]: Demo Sound and Keyboard mode selection */
/* BUTTON[3]: Keyboard code Reset             		 */
/* BUTTON[4]: Keyboard system Reset                  */
/*****************************************************/

module synthesizer (
// Clock
	input		EXT_CLOCK_IN,				
// reset
	output		DLY0,
// MIDI uart
	input		MIDI_Rx_DAT,				//	MIDI Data
	output 		midi_txd,

	input	[4:1]	button,					//	Button[4:1]
//	input   [17:0]	SW,
//	output	[3:0]	hex_disp[7:0],

	output	[8:1]	GLED,					//	LED[4:1] 
	output	[18:1]	RLED,					//	LED[4:1] 

/*	output		VGA_CLK,   				//	VGA Clock
	output		HS,					//	VGA H_SYNC
	output		VS,					//	VGA V_SYNC
//	output		LCD_BLANK,				//	LCD BLANK
	output		HD,				//	LCD BLANK
	output		VD,				//	LCD BLANK
	output		DEN,				//	LCD BLANK
	output		inDisplayArea,				//	VGA BLANK
	output		SYNC,				//	VGA SYNC
	output	[9:0]	VGA_R,   				//	VGA Red[9:0]
	output	[9:0]	VGA_G,	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B,   				//	VGA Blue[9:0]
	output          HC_VGA_CLOCK,			//  VGA encodr clock     
	output          HC_LCD_CLOCK,			//  VGA encodr clock     
*/
	inout		AUD_ADCLRCK,			//	Audio CODEC ADC LR Clock
	inout		AUD_DACLRCK,			//	Audio CODEC DAC LR Clock
	input		AUD_ADCDAT,			    //	Audio CODEC ADC Data
	output		AUD_DACDAT,				//	Audio CODEC DAC Data
	inout		AUD_BCLK,				//	Audio CODEC Bit-Stream Clock
	output		AUD_XCK,					//	Audio CODEC Chip Clock
/*
	input [1:0]		N_adr_data_rdy,				// midi data num ready from Nios
	input	[9:0]	N_adr,				// controller nr.
	output	[7:0]	N_synth_out_data,				// data byte
	input	[7:0]	N_synth_in_data,				// data byte
	output		N_save_sig,
	output		N_load_sig,
	output	[7:0] 	N_sound_nr, 

	input		LTM_ADC_BUSY,
	output   	LTM_ADC_DCLK,
	output		LTM_ADC_DIN,
	input		LTM_ADC_DOUT,
	input		LTM_ADC_PENIRQ_n,
	output		LTM_SCEN,
	inout		LTM_SDA
*/
//	output [15:0] 	sounddata_out,
//	output 			latch_sig
//	output		LTM_SCEN,
//	output		LTM_GREST
    inout [7:0]			data
);

`ifdef _NEEK
parameter VOICES = 32;
`else
//parameter VOICES = 128;
//parameter VOICES = 64;
//parameter VOICES = 32;
//parameter VOICES = 16;
//parameter VOICES = 8;	// number of simultainious voices 
//parameter VOICES = 4;	// number of simultainious voices
parameter VOICES = 2;	// number of simultainious voices
//parameter VOICES = 1;	// number of simultainious voices
`endif
//parameter V_OSC = 8;  //!NEEK
//parameter V_OSC = 6;
parameter V_OSC = 4;	// number of oscilators pr. voice.
//parameter V_OSC = 3;
//parameter V_OSC = 2;	// number of oscilators pr. voice.
//parameter V_OSC = 1;

parameter O_ENVS = 2;	// number of envelope generators pr. oscilator.

parameter V_ENVS = V_OSC * O_ENVS;	// number of envelope generators  pr. voice.

parameter V_WIDTH = utils::clogb2(VOICES);
parameter O_WIDTH = utils::clogb2(V_OSC);
parameter OE_WIDTH = utils::clogb2(O_ENVS);
parameter E_WIDTH = O_WIDTH + OE_WIDTH;

parameter V_1 = 1;
parameter V_2 = 2;
parameter V_3 = 3;
parameter V_4 = 4;
parameter V_5 = 5;
parameter V_6 = 6;
parameter V_7 = 7;
parameter V_8 = 8;
parameter V_9 = 9;
	
parameter VW_1 = utils::clogb2(V_1); 	
parameter VW_2 = utils::clogb2(V_2); 	
parameter VW_3 = utils::clogb2(V_3); 	
parameter VW_4 = utils::clogb2(V_4); 	
parameter VW_5 = utils::clogb2(V_5); 	
parameter VW_6 = utils::clogb2(V_6); 	
parameter VW_7 = utils::clogb2(V_7); 	
parameter VW_8 = utils::clogb2(V_8); 	
parameter VW_9 = utils::clogb2(V_9); 	

//-----		Registers		-----//

	reg	[10:0] MCNT;
	reg	[31:0]VGA_CLK_o;

//-----		Wires		-----//
	wire   sysclk = VGA_CLK_o[10];
//	wire 	 touch_clk = VGA_CLK_o[10];
//---	Reset gen		---//	

//	wire initial_reset=(MCNT<12)?1'b1:1'b0;

	wire reset1 = button[1];
//	wire reset1 = (button[1] & DLY2) ? 1'b1 : 1'b0;
	wire reset2 = button[2];
	wire reset3 = button[3];
	
	wire iRST_N = ((MCNT==200) || (!reset2))?1'b0:1'b1;

//---	Midi	---//
// inputs
//	wire midi_rxd = !MIDI_Rx_DAT; // 
	
	wire midi_rxd = MIDI_Rx_DAT; // Direct to optocopler RS-232 port (fix it in in topfile)			
//outputs
	wire midi_out_ready,midi_send_byte;
	wire [7:0] midi_out_data;
	wire byteready;
	wire [7:0] cur_status,midi_bytes,databyte;

//---	Midi	Decoder ---//
    wire [VOICES-1:0]  	keys_on;
// note events
    wire               	note_on;
    wire [V_WIDTH-1:0] 	cur_key_adr;
    wire [7:0]         	cur_key_val;
    wire [7:0]         	cur_vel_on;
    wire [7:0]         	cur_vel_off;
    wire				write;
	wire				read;
	wire				sysex_data_patch_send;
    wire [6:0]         	adr;
    wire               	env_sel;
    wire               	osc_sel;
    wire               	m1_sel;
    wire               	m2_sel;
    wire               	com_sel;
// from midi_controller_unit
	wire [13:0] 		pitch_val;
// from env gen
	wire [VOICES-1:0] 	voice_free;

// inputs
// outputs
	wire octrl_cmd,prg_ch_cmd,pitch_cmd;
	wire[7:0] octrl,octrl_data,prg_ch_data;
	wire [V_WIDTH:0]	active_keys;
	wire 	off_note_error;
	wire sys_real;
	wire [7:0] sys_real_dat;

	wire [3:0] midi_ch_sig;

	wire ictrl_cmd;
	wire [7:0]ictrl, ictrl_data;
	
	wire DLY1,DLY2;	

	wire HC_LCD_CLK, HC_VGA_CLOCK;

	wire	CLOCK_25;

	wire AUD_CTRL_CLK;
	wire TONE_CTRL_CLK;
	
	wire [63:0] lvoice_out;
	wire [63:0] rvoice_out;
		
//---	Midi	Controllers unit ---//

/*	
assign status_data[0] = active_keys;
//	assign status_data[1] =	off_note_error;
//	assign status_data[1] =	 {off_note_error,o_index[6:0]};
assign status_data[1] =	 osc_inx;
wire[7:0] osc_inx;
assign osc_inx[7] = off_note_error;
assign osc_inx[6:0] = o_index[6:0];
*/
////////////	Init Reset sig Gen	////////////	
// system reset  //

reset_delay	reset_delay_inst  (
	.iCLK(EXT_CLOCK_IN),
	.iRST_n(reset1),
	.oRST_0(DLY0),
	.oRST_1(DLY1),
	.oRST_2(DLY2)
);

	always @(negedge reset1 or posedge sysclk) begin
		if (!reset1) MCNT=0;
		else if(MCNT < 500) MCNT=MCNT+ 1'b1;
	end



//---				---//

MIDI_UART MIDI_UART_inst (
	.CLOCK_25		(CLOCK_25),		// input  reset sig
	.iRST_N			(iRST_N),		// input  reset_sig
	.midi_rxd		(midi_rxd),		// input  midi serial data in
	.midi_out_data	(midi_out_data),// input midi_out_data_sig
	.midi_send_byte (midi_send_byte),
	.midi_txd		(midi_txd),		// output midi serial data output
	.midi_out_ready (midi_out_ready),// output midi out buffer ready
	.byteready		(byteready),	// output  byteready_sig
	.sys_real		(sys_real),		// realtime sysex msg arrived
	.sys_real_dat	(sys_real_dat),	// realtime sysex msg databyte
	.cur_status		(cur_status),	// output [7:0] cur_status_sig
	.midibyte_nr	(midi_bytes),	// output [7:0] midi_bytes_sig
	.midibyte		(databyte) 		// output [7:0] databyte_sig
);

midi_decoder #(.VOICES(VOICES),.V_WIDTH(V_WIDTH)) midi_decoder_inst(

	.CLOCK_25(CLOCK_25) ,			// input  CLOCK_25_sig
//	.sys_clk(sysclk) ,				// input  sys_clk_sig
	.iRST_N(iRST_N) ,				// input  iRST_N_sig
	.byteready(byteready) ,			// input  byteready_sig
	.cur_status(cur_status) ,		// input [7:0] cur_status_sig
	.midibyte_nr(midi_bytes) ,		// input [7:0] midibyte_nr_sig
	.midibyte(databyte) ,			// input [7:0] midibyte_sig
	.voice_free(voice_free) ,		// input [VOICES-1:0] voice_free_sig
	.midi_ch(midi_ch_sig) ,			// input [3:0] midi_ch_sig
	.note_on(note_on) ,				// output  note_on_sig
	.keys_on(keys_on) ,				// output [VOICES-1:0] keys_on_sig
	.cur_key_adr(cur_key_adr) ,		// output [V_WIDTH-1:0] cur_key_adr_sig
	.cur_key_val(cur_key_val) ,		// output [7:0] cur_key_val_sig
	.cur_vel_on(cur_vel_on) ,		// output [7:0] cur_vel_on_sig
	.cur_vel_off(cur_vel_off) ,		// output [7:0] cur_vel_off_sig
	.octrl_cmd(octrl_cmd) ,			// output  octrl_cmd_sig
	.pitch_cmd(pitch_cmd) ,			// output  pitch_cmd_sig
	.octrl(octrl) ,					// output [7:0] octrl_sig
	.octrl_data(octrl_data) ,		// output [7:0] octrl_data_sig
	.prg_ch_cmd(prg_ch_cmd) ,		// output  prg_ch_cmd_sig
	.prg_ch_data(prg_ch_data) ,		// output [7:0] prg_ch_data_sig
// controller data bus
	.write(write) ,					// output  write_sig
	.read (read), 					// output read data signal
	.sysex_data_patch_send (sysex_data_patch_send),
	.adr(adr) ,						// output [6:0] adr_sig
	.data (data) ,					// output [7:0] data_sig
	.midi_out_ready (midi_out_ready),// input
	.midi_send_byte (midi_send_byte),// inout
	.midi_out_data (midi_out_data),	// output
	.env_sel(env_sel) ,				// output  env_sel_sig
	.osc_sel(osc_sel) ,				// output  osc_sel_sig
	.m1_sel(m1_sel) ,				// output  m1_sel_sig
	.m2_sel(m2_sel) ,				// output  m2_sel_sig
	.com_sel(com_sel) ,				// output  com_sel_sig
	.active_keys(active_keys) ,		// output [V_WIDTH:0] active_keys_sig
	.off_note_error(off_note_error) // output  off_note_error_sig
);

	
midi_controllers #(.VOICES(VOICES),.V_OSC(V_OSC)) midi_controllers_inst(
	.CLOCK_25			( CLOCK_25 ),
	.iRST_N			( iRST_N ),
//	.SW 			(SW),
// from midi_decoder
//	.ictrl_cmd		( ctrl_cmd ), 
	.ictrl			( octrl ), 
	.ictrl_data		( octrl_data ), 
	.pitch_cmd		( pitch_cmd ),
//	.sysex_cmd		( sysex_cmd ),			// 1 on last databyte 
//	.hex_disp( hex_disp ),
//	cpu signals //
/*	.N_adr_data_rdy		( N_adr_data_rdy ),					// midi data ready from Nios
	.N_adr			( N_adr[8:0] ),				// controller nr.
	.N_synth_out_data	( N_synth_out_data ),		// data byte from synth to nios
	.N_synth_in_data	( N_synth_in_data ),		// data byte from nios to synth
	.N_save_sig		( N_save_sig ),
	.N_load_sig		( N_load_sig ),
//	touch signals	 //
	.slide_val		( slide_val ),	//input
	.write_slide		( write_slide ),
*/
// outputs	
//	.synth_data( synth_data ),
	.pitch_val		( pitch_val )
);

//-----	Clockgens & Timing	----//
// TIME & Display CLOCK Generater //

	always @( posedge CLOCK_25) VGA_CLK_o = VGA_CLK_o + 1;
//  PLL

vga_pll	sys_disp_pll_inst	(	
`ifdef _CycloneV
	.refclk		( EXT_CLOCK_IN ),
	.outclk_0	( CLOCK_25 )
//	.c1			( HC_VGA_CLOCK ),// 75 Mhz
//	.c2			( HC_LCD_CLK )	// 39Mhx
`else
	.inclk0		( EXT_CLOCK_IN ),
	.c0			( CLOCK_25 )
//	.c1			( HC_VGA_CLOCK ),// 75 Mhz
//	.c2			( HC_LCD_CLK )	// 39Mhx
`endif
);
	// Sound clk gen //
`ifdef _Synth
	//	AUDIO SOUND
	`ifdef _271MhzOscs
		audio_271_pll	audio_pll_inst ( //  271.052632 MHz
	`else
		audio_pll	audio_pll_inst ( // 180.555556 Mhz
	`endif
	`ifdef _CycloneV
		.refclk		( EXT_CLOCK_IN ),
		.outclk_0	( TONE_CTRL_CLK ),  // 180.555556 Mhz --> 270 Mhz
		.outclk_1	( AUD_XCK ) // 16.927083 Mhz
	`else
		.inclk0		( EXT_CLOCK_IN ),
		.c0	( TONE_CTRL_CLK ),  // 180.555556 Mhz --> 270 Mhz
		.c1	( AUD_XCK ) // 16.927083 Mhz
	`endif
	);	
	//////////// Sound Generation /////////////	

	assign	AUD_ADCLRCK	=	AUD_DACLRCK;

	//assign	AUD_XCK		=	AUD_CTRL_CLK;			
					
	// 2CH Audio Sound output -- Audio Generater //
	synth_engine #(.VOICES(VOICES),.V_OSC(V_OSC),.V_ENVS(V_ENVS),.V_WIDTH(V_WIDTH),.O_WIDTH(O_WIDTH),.OE_WIDTH(OE_WIDTH)) synth_engine_inst	(		        
	// AUDIO CODEC //		
		.OSC_CLK( TONE_CTRL_CLK ),	//input
		.AUDIO_CLK( AUD_XCK ),		//input
		.iRST_N(iRST_N) ,	// input  reset_sig
		.AUD_BCK ( AUD_BCLK ),				//output
		.AUD_DATA( AUD_DACDAT ),			//output
		.AUD_LRCK( AUD_DACLRCK ),			//output																
	// KEY //		
	//    	.switch	  ( SW[17:0]),			//input			
	//	.button	  ( button[4:1]),		//input			
	// -- Sound Control -- //
	//	to pitch control //
		.note_on(note_on) ,	// output  note_on_sig
		.keys_on(keys_on) ,	// output [VOICES-1:0] keys_on_sig
		.cur_key_adr(cur_key_adr) ,	// output [V_WIDTH-1:0] cur_key_adr_sig
		.cur_key_val(cur_key_val) ,	// output [7:0] cur_key_val_sig
		.cur_vel_on(cur_vel_on) ,	// output [7:0] cur_vel_on_sig
		.cur_vel_off(cur_vel_off) ,	// output [7:0] cur_vel_off_sig
	// from midi_controller_unit
		.pitch_val ( pitch_val ),
	// controller data bus
		.write(write) ,	// output  write_sig
		.read (read), 	// output read data signal
		.sysex_data_patch_send (sysex_data_patch_send),
		.adr(adr) ,	// output [6:0] adr_sig
		.data (data) ,	// bi-dir [7:0] data_sig
		.env_sel(env_sel) ,	// output  env_sel_sig
		.osc_sel(osc_sel) ,	// output  osc_sel_sig
		.m1_sel(m1_sel) ,	// output  m1_sel_sig
		.m2_sel(m2_sel) ,	// output  m2_sel_sig
		.com_sel(com_sel), 	// output  com_sel_sig
	//   .LTM_SCEN(LTM_SCEN),
	//   .LTM_GREST(LTM_GREST),
	// from mixer
	//	.lvoice_out ( lvoice_out ),
	//	.rvoice_out ( rvoice_out ),
	// from env gen // 
		.voice_free( voice_free )		//output from envgen
	);
`endif

//wire key_on [VOICES-1:0] = keys_on;

/////// LED Display ////////
//assign GLED[8:1] = {key_on[7],key_on[6],key_on[5],key_on[4],key_on[3],key_on[2],key_on[1],key_on[0]};

//assign GLED[VOICES:1] = keys_on[VOICES-1:0];
assign GLED[8:1] = keys_on[((VOICES -1) & 7):0];

assign RLED[16:1] = voice_free[((VOICES - 1) & 15):0];

//assign RLED[8:1] = {voice_free[7],voice_free[6],voice_free[5],voice_free[4],
//	voice_free[3],voice_free[2],voice_free[1],voice_free[0]};	

//assign RLED[16:9] = {voice_free[15],voice_free[14],voice_free[13],voice_free[12],
//						voice_free[11],voice_free[10],voice_free[9],voice_free[8]};	
/*
	assign hex_disp[0] = y_coord[3:0];
	assign hex_disp[1] = y_coord[7:4];
	assign hex_disp[2] = y_coord[11:8];
	assign hex_disp[3] = 4'h0;
	assign hex_disp[4] = x_coord[3:0];
	assign hex_disp[5] = x_coord[7:4];
	assign hex_disp[6] = x_coord[11:8];
	assign hex_disp[7] = {3'b000,new_coord};
*/

`ifdef _Graphics             

`ifdef _LTM_Graphics	         
	assign VGA_CLK  = CLOCK_25 ;
`endif
`ifdef _VEEK_Graphics	         
	assign VGA_CLK  = HC_LCD_CLK ;
`endif

// LCD Display + Touch + +++++++++++++++++++--- Color ----------------------------------//
	wire [7:0]disp_data[94];
		
display display_inst_1(		
	// VGA output //		
	.VGA_CLK	( VGA_CLK ),   
	.HS	( HS ), 
	.VS	( VS ), 
	.SYNC	( SYNC ),	
	.inDisplayArea	( inDisplayArea ),
//	.inLcdDisplay	( LCD_BLANK ),
//	.inLcdDisplay	( ),
	.HD		( HD ),
	.VD		( VD ),
	.DEN		( DEN ),
	.VGA_R		( VGA_R ),
	.VGA_B		( VGA_B ),
	.VGA_G		( VGA_G ),
// Key code-in //
	.scan_code1	( key_val[0] ),
	.scan_code2	( key_val[1] ),
	.scan_code3	( key_val[2] ), // ON
	.scan_code4	( key_val[3] ), // OFF
	.disp_data	( disp_data ),
	.status_data	( status_data ),
	.DLY2		(DLY2),
	.chr_3		( chr_3 ),
	.col ( col ),
	.row( row ),
	.lne		( lne ),
	.slide_val	( slide_val )
);
wire [7:0]status_data[12];
///// Touch Controller files /////////////

wire [3:0] chr_3,lne,col,row;
wire [7:0]edit_chr,slide_val;
wire [7:0]disp_val;
wire write_slide;
reg transmit_en_r;
reg new_coord_r;

	touch	touch	(
		.iRST_n 	( DLY0 ),
		.sys_clk  ( touch_clk ),  		//input system clock		
		.x_in (~x_coord[11:4]),
		.y_in (y_coord[11:4]),
		.new_coord_r (new_coord_r),
		.transmit_en (transmit_en_r ),
		.disp_data( disp_data ),
		.penirq_n (LTM_ADC_PENIRQ_n),
		.touch_status_data (status_data[2:11]),
		.sys_real		(sys_real),		// realtime sysex msg arrived
		.sys_real_dat	(sys_real_dat),		// realtime sysex msg databyte
		.prg_ch_cmd		( prg_ch_cmd ), 
		.prg_ch_data		( prg_ch_data ), 
		.disp_val(disp_val),
		.chr_3 ( chr_3 ),
		.lne( lne ),
		.col ( col ),
		.row( row ),
		.slide_val(slide_val),
		.write_slide ( write_slide ),
		.N_save_sig ( N_save_sig ),	//save patch to sd
		.N_load_sig ( N_load_sig ),	//output load patch from sd
		.N_adr_9(N_adr[9]), // input end transfer
		.N_sound_nr(N_sound_nr)	// output file nr. name to sd			
	);

	always @(posedge CLOCK_50)begin
		new_coord_r <= new_coord;
		transmit_en_r <= transmit_en;
	end
	
assign LTM_ADC_DCLK	= ( adc_dclk & ltm_3wirebusy_n )  |  ( ~ltm_3wirebusy_n & ltm_sclk );

wire            adc_dclk;
wire            ltm_3wirebusy_n;
wire            ltm_sclk;
wire            touch_irq;
wire    [11:0]  x_coord,y_coord;
wire            new_coord;
wire 				 transmit_en;
	
	lcd_spi_controller	du2	(	
		// Host Side
		.iCLK(CLOCK_50),
		.iRST_n(DLY0),
		// 3wire Side
		.o3WIRE_SCLK(ltm_sclk),
		.io3WIRE_SDAT(LTM_SDA),
		.o3WIRE_SCEN(LTM_SCEN),
		.o3WIRE_BUSY_n(ltm_3wirebusy_n)
	);	

// Touch Screen Digitizer ADC configuration //

	adc_spi_controller		du4	(
		.iCLK(CLOCK_50),
		.iRST_n(DLY0),
		.oADC_DIN(LTM_ADC_DIN),
		.oADC_DCLK(adc_dclk),
		.oADC_CS(),
		.iADC_DOUT(LTM_ADC_DOUT),
		.iADC_BUSY(LTM_ADC_BUSY),
		.iADC_PENIRQ_n(LTM_ADC_PENIRQ_n),
		.oTOUCH_IRQ(touch_irq),
		.oX_COORD(x_coord),
		.oY_COORD(y_coord),
		.oNEW_COORD(new_coord),
		.transmit_en (transmit_en )
	);
`endif

endmodule
