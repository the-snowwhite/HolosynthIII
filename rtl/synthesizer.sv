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
	input					EXT_CLOCK_IN,				
// reset
	output				DLY0,
// MIDI uart
	input					MIDI_Rx_DAT,		//	MIDI Data
	output				midi_txd,

	input		[4:1]		button,				//	Button[4:1]

	output	[8:1]		GLED,					//	LED[4:1] 
	output	[18:1]	RLED,					//	LED[4:1] 

	inout					AUD_ADCLRCK,		//	Audio CODEC ADC LR Clock
	inout					AUD_DACLRCK,		//	Audio CODEC DAC LR Clock
	input					AUD_ADCDAT,			//	Audio CODEC ADC Data
	output				AUD_DACDAT,			//	Audio CODEC DAC Data
	inout					AUD_BCLK,			//	Audio CODEC Bit-Stream Clock
	output				AUD_XCK,				//	Audio CODEC Chip Clock
	inout [7:0]			data
);

parameter VOICES = 128;
parameter V_OSC = 4;	// number of oscilators pr. voice.
parameter O_ENVS = 2;	// number of envelope generators pr. oscilator.

parameter V_ENVS = V_OSC * O_ENVS;	// number of envelope generators  pr. voice.

parameter V_WIDTH = utils::clogb2(VOICES);
parameter O_WIDTH = utils::clogb2(V_OSC);
parameter OE_WIDTH = utils::clogb2(O_ENVS);
parameter E_WIDTH = O_WIDTH + OE_WIDTH;


//-----		Registers		-----//

	reg	[10:0] MCNT;
	reg	[31:0]VGA_CLK_o;

//-----		Wires		-----//
	wire   sysclk = VGA_CLK_o[10];
//---	Reset gen		---//	

//	wire initial_reset=(MCNT<12)?1'b1:1'b0;

	wire reset1 = button[1];
	wire reset2 = button[2];
	wire reset3 = button[3];
	
	wire reset_reg_N = ((MCNT==200) || (!reset2))?1'b0:1'b1;

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
	.reset_reg_N(reset1),
	.oRST_0(DLY0),
	.oRST_1(DLY1),
	.oRST_2(DLY2)
);

	always @(negedge reset1 or posedge sysclk) begin
		if (!reset1) MCNT=0;
		else if(MCNT < 500) MCNT=MCNT+ 1'b1;
	end

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
		.outclk_0	( TONE_CTRL_CLK ),  // 180.555556 Mhz  Mhz
//		.outclk_1	( AUD_XCK ) // 16.927083 Mhz
		.outclk_1	( ) // 16.927083 Mhz
	`else
		.inclk0		( EXT_CLOCK_IN ),
		.c0	( TONE_CTRL_CLK ),  // 180.555556 Mhz --> 270 Mhz
//		.c1	( AUD_XCK ) // 16.927083 Mhz
		.c1	( ) // 16.927083 Mhz
	`endif
	);	


//---				---//

MIDI_UART MIDI_UART_inst (
	.CLOCK_25		(CLOCK_25),		// input  reset sig
	.reset_reg_N			(reset_reg_N),		// input  reset_sig
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
	.reset_reg_N(reset_reg_N) ,				// input  reset_reg_N_sig
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
	.reset_reg_N			( reset_reg_N ),
// from midi_decoder
	.ictrl			( octrl ), 
	.ictrl_data		( octrl_data ), 
	.pitch_cmd		( pitch_cmd ),
// outputs	
	.pitch_val		( pitch_val )
);

	//////////// Sound Generation /////////////	

	assign	AUD_ADCLRCK	=	AUD_DACLRCK;

	//assign	AUD_XCK		=	AUD_CTRL_CLK;			
					
	// 2CH Audio Sound output -- Audio Generater //
	synth_engine #(.VOICES(VOICES),.V_OSC(V_OSC),.V_ENVS(V_ENVS),.V_WIDTH(V_WIDTH),.O_WIDTH(O_WIDTH),.OE_WIDTH(OE_WIDTH)) synth_engine_inst	(		        
	// AUDIO CODEC //		
		.OSC_CLK( TONE_CTRL_CLK ),	// input
//		.AUDIO_CLK( AUD_XCK ),		// input
		.AUDIO_CLK( AUD_XCK ),		// output
		.reset_reg_N(reset_reg_N) ,	// input  reset_sig
		.AUD_BCK ( AUD_BCLK ),				// output
		.AUD_DATA( AUD_DACDAT ),			// output
		.AUD_LRCK( AUD_DACLRCK ),			// output																
	// KEY //		
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
	// from env gen // 
		.voice_free( voice_free )		//output from envgen
	);
`endif


/////// LED Display ////////
assign GLED[8:1] = keys_on[((VOICES -1) & 7):0];

assign RLED[16:1] = voice_free[((VOICES - 1) & 15):0];


endmodule
