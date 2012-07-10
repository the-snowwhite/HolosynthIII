module synth_engine (
	input			OSC_CLK,
	input			AUDIO_CLK,
	input 		iRST_N,
	output			AUD_DATA,
	output			AUD_LRCK,
	output	   	AUD_BCK,
// buttons & switches	
	input   [17:0]	switch,
	input   [4:1]	button,
// -- Sound control -- //
//	input   			clock_25,
//	input   			sys_clk,
// from midi_decoder
// note events
    input [VOICES-1:0]  keys_on,
    input               note_on,
    input [V_WIDTH-1:0] cur_key_adr,
    input [7:0]         cur_key_val,
    input [7:0]         cur_vel_on,
    input [7:0]         cur_vel_off,
// midi data events
    input               write ,
    input [6:0]         adr,
    input [7:0]         data,
    input               env_sel,
    input               osc_sel,
    input               m1_sel,
    input               m2_sel,
    input               com_sel,
// from midi_controller_unit
	input [13:0] pitch_val,
// debugging
	output		LTM_SCEN,
	output		LTM_GREST,
// from env gen
	output [VOICES-1:0] voice_free
	);	


parameter VOICES	= 8;
parameter V_OSC		= 4;				// number of oscilators pr. voice.
parameter O_ENVS	= 2;				// number of envelope generators pr. oscilator.
parameter V_ENVS	= O_ENVS * V_OSC;	// number of envelope generators  pr. voice.

parameter V_WIDTH	= 3;
parameter O_WIDTH	= 2;
parameter OE_WIDTH	= 1;
parameter E_WIDTH	= O_WIDTH + OE_WIDTH;

//-----		Wires		-----//
wire          sCLK_XVXENVS;       // ObjectKind=Net|PrimaryId=sCLK_XVXENVS
wire          sCLK_XVXOSC;        // ObjectKind=Net|PrimaryId=sCLK_XVXOSC
wire          n_xxxx_zero;            // ObjectKind=Net|PrimaryId=NetU1_xxxx_max
wire [V_WIDTH+E_WIDTH-1:0]  xxxx;                  // ObjectKind=Net|PrimaryId=NetU1_xxxx[5..0]
wire [7:0]  level_mul;        // ObjectKind=Net|PrimaryId=level_mul

wire          byteready;              // ObjectKind=Net|PrimaryId=byteready
wire [7:0]  cur_status;             // ObjectKind=Net|PrimaryId=cur_status
wire [7:0]  octrl;               // ObjectKind=Net|PrimaryId=ictrl
wire [7:0]  octrl_data;          // ObjectKind=Net|PrimaryId=ictrl_data
wire          pitch_cmd;           // ObjectKind=Net|PrimaryId=pitch_cmd
wire [7:0]  midibyte;               // ObjectKind=Net|PrimaryId=midibyte
wire [7:0]  midibyte_nr;            // ObjectKind=Net|PrimaryId=midibyte_nr
wire [10:0] modulation;                 // ObjectKind=Net|PrimaryId=modulation
wire [15:0] lsound_out;                 // ObjectKind=Net|PrimaryId=NetU1_rsound_out[23..0]
wire [15:0] rsound_out;                 // ObjectKind=Net|PrimaryId=NetU1_rsound_out[23..0]
wire [16:0] sine_lut_out;                 // ObjectKind=Net|PrimaryId=sine_lut_out
wire [23:0] osc_pitch_val;      // ObjectKind=Net|PrimaryId=osc_pitch_val

wire [V_ENVS-1:0] osc_accum_zero;
assign LTM_SCEN = sCLK_XVXENVS;

assign LTM_GREST = n_xxxx_zero;

	reg               reg_note_on[2:0];
	reg [V_WIDTH-1:0] reg_cur_key_adr;
	reg [7:0]         reg_cur_key_val;
	
	reg [VOICES-1:0]	reg_keys_on;
//	reg [VOICES-1:0] 	reg_voice_free;

	always @(posedge OSC_CLK )begin
		if(OSC_CLK)begin
			reg_note_on[1] <= reg_note_on[0];
			reg_note_on[2] <= reg_note_on[1];
		end
	end		

	always @(negedge n_xxxx_zero)begin
		if(!n_xxxx_zero)begin
			reg_note_on[0] <= note_on;
			reg_cur_key_adr <= cur_key_adr;
			reg_cur_key_val <= cur_key_val;
			reg_keys_on <= keys_on;
//			reg_voice_free <= voice_free;
		end
	 end


synth_clk_gen #(.VOICES(VOICES),.V_OSC(V_OSC),.V_ENVS(V_ENVS))synth_clk_gen_inst  // ObjectKind=Sheet Symbol|PrimaryId=U_synth_clk_gen
 (
	.iRST_N( iRST_N ),                               // ObjectKind=Sheet Entry|PrimaryId=synth_clk_gen.v-iRST_N
	.AUDIO_CLK( AUDIO_CLK ),                        // ObjectKind=Sheet Entry|PrimaryId=synth_clk_gen.v-AUDIO_CLK
	.OSC_CLK( OSC_CLK ),                 // ObjectKind=Sheet Entry|PrimaryId=synth_clk_gen.v-OSC_CLK
	.sCLK_XVXENVS( sCLK_XVXENVS ),// ObjectKind=Sheet Entry|PrimaryId=synth_clk_gen.v-sCLK_XVXENVS
	.sCLK_XVXOSC( sCLK_XVXOSC ), // ObjectKind=Sheet Entry|PrimaryId=synth_clk_gen.v-sCLK_XVXOSC
	.LRCK_1X( AUD_LRCK ) ,	// output  LRCK_1X_sig
	.oAUD_BCK( AUD_BCK ) 	// output  oAUD_BCK_sig
);

audio_i2s_driver U_audio_i2s_driver                         // ObjectKind=Sheet Symbol|PrimaryId=U_audio_i2s_driver
(
	.iRST_N( iRST_N ),                               // ObjectKind=Sheet Entry|PrimaryId=audio_i2s_driver.v-iRST_N
	.iAUD_BCK( AUD_BCK ),                          // ObjectKind=Sheet Entry|PrimaryId=audio_i2s_driver.v-oAUD_BCK
	.iAUD_LRCK( AUD_LRCK ),                         // ObjectKind=Sheet Entry|PrimaryId=audio_i2s_driver.v-oAUD_LRCK
	.i_lsound_out( lsound_out ),           // ObjectKind=Sheet Entry|PrimaryId=audio_i2s_driver.v-rsound_out[23..0]
	.i_rsound_out( rsound_out ),           // ObjectKind=Sheet Entry|PrimaryId=audio_i2s_driver.v-rsound_out[23..0]
	.oAUD_DATA( AUD_DATA ) // ObjectKind=Sheet Entry|PrimaryId=audio_i2s_driver.v-oAUD_DATA
);

timing_gen #(.VOICES(VOICES),.V_ENVS(V_ENVS),.V_WIDTH(V_WIDTH),.E_WIDTH(E_WIDTH))timing_gen_inst  // ObjectKind=Sheet Symbol|PrimaryId=U_timing_gen
(
	.iRST_N(iRST_N),                               // ObjectKind=Sheet Entry|PrimaryId=timing_gen.v-iRST_N
	.n_xxxx_zero( n_xxxx_zero ),     // ObjectKind=Sheet Entry|PrimaryId=timing_gen.v-n_xxxx_zero
	.sCLK_XVXENVS( sCLK_XVXENVS ),// ObjectKind=Sheet Entry|PrimaryId=timing_gen.v-sCLK_XVXOSC
	.xxxx( xxxx )                  // ObjectKind=Sheet Entry|PrimaryId=timing_gen.v-xxxx[5..0]
);



pitch_control #(.VOICES(VOICES),.V_OSC(V_OSC),.V_WIDTH(V_WIDTH),.O_WIDTH(O_WIDTH),.OE_WIDTH(OE_WIDTH)) pitch_control_inst  // ObjectKind=Sheet Symbol|PrimaryId=U_pitch_control
(
	.iRST_N( iRST_N ),                               // ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-iRST_N
	.xxxx( xxxx ),                  // ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-xxxx[5..0]
	.note_on( reg_note_on[2] ),         // ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-note_on
	.cur_key_adr( reg_cur_key_adr ), // ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-cur_key_adr[2..0]
	.cur_key_val( reg_cur_key_val ), // ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-cur_key_val[7..0]
	.pitch_val( pitch_val ), // ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-pitch_val[13..0]
	.write( write ),             // ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-write
	.adr( adr ),                 // ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-adr[6..0]
	.data( data ),               // ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-data[7..0]
	.osc_sel( osc_sel ),         // ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-osc_sel
	.com_sel( com_sel ),         // ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-com_sel
	.osc_pitch_val( osc_pitch_val )// ObjectKind=Sheet Entry|PrimaryId=pitch_control.v-osc_pitch_val[23..0]
);
		
osc #(.VOICES(VOICES),.V_OSC(V_OSC),.V_ENVS(V_ENVS),.V_WIDTH(V_WIDTH),.O_WIDTH(O_WIDTH),.OE_WIDTH(OE_WIDTH)) osc_inst // ObjectKind=Sheet Symbol|PrimaryId=U_osc
(
	.iRST_N( iRST_N ),                               // ObjectKind=Sheet Entry|PrimaryId=osc.v-iRST_N
	.OSC_CLK( OSC_CLK ),                 // ObjectKind=Sheet Entry|PrimaryId=osc.v-OSC_CLK
	.sCLK_XVXENVS( sCLK_XVXENVS ),// ObjectKind=Sheet Entry|PrimaryId=osc.v-sCLK_XVXENVS
	.sCLK_XVXOSC( sCLK_XVXOSC ),// ObjectKind=Sheet Entry|PrimaryId=osc.v-sCLK_XVXOSC
	.xxxx( xxxx ),                  // ObjectKind=Sheet Entry|PrimaryId=osc.v-xxxx[5..0]
	.modulation( modulation ),          // ObjectKind=Sheet Entry|PrimaryId=osc.v-modulation[10..0]
	.osc_pitch_val( osc_pitch_val ),// ObjectKind=Sheet Entry|PrimaryId=osc.v-osc_pitch_val[23..0]
	.osc_accum_zero( osc_accum_zero ),  	// ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-osc_accum_zero[V_ENVS..0]
	.voice_free ( voice_free ),// ObjectKind=Sheet Entry|PrimaryId=osc.v-voice_free[7..0]
	.write( write ),             // ObjectKind=Sheet Entry|PrimaryId=osc.v-write
	.adr( adr ),                 // ObjectKind=Sheet Entry|PrimaryId=osc.v-adr[6..0]
	.data( data ),               // ObjectKind=Sheet Entry|PrimaryId=osc.v-data[7..0]
	.osc_sel( osc_sel ),         // ObjectKind=Sheet Entry|PrimaryId=osc.v-osc_sel
	.sine_lut_out( sine_lut_out )        // ObjectKind=Sheet Entry|PrimaryId=osc.v-sine_lut_out[16..0]
);

mixer_2 #(.VOICES(VOICES),.V_OSC(V_OSC),.O_ENVS(O_ENVS),.V_WIDTH(V_WIDTH),.O_WIDTH(O_WIDTH),.OE_WIDTH(OE_WIDTH)) mixer_2_inst  // ObjectKind=Sheet Symbol|PrimaryId=U_mixer
(
	.iRST_N( iRST_N ),                               // ObjectKind=Sheet Entry|PrimaryId=mixer.v-iRST_N
	.sCLK_XVXENVS( sCLK_XVXENVS ),// ObjectKind=Sheet Entry|PrimaryId=mixer.v-sCLK_XVXENVS
	.sCLK_XVXOSC( sCLK_XVXOSC ), // ObjectKind=Sheet Entry|PrimaryId=synth_clk_gen.v-sCLK_XVXOSC
	.xxxx( xxxx ),                 // ObjectKind=Sheet Entry|PrimaryId=mixer.v-xxxx[5..0]
	.n_xxxx_zero( n_xxxx_zero ),        // ObjectKind=Sheet Entry|PrimaryId=mixer.v-n_xxxx_zero
	.level_mul( level_mul ),  // ObjectKind=Sheet Entry|PrimaryId=mixer.v-level_mul[7..0]
	.sine_lut_out( sine_lut_out ),        // ObjectKind=Sheet Entry|PrimaryId=mixer.v-sine_lut_out[16..0]
	.modulation( modulation ),          // ObjectKind=Sheet Entry|PrimaryId=mixer.v-modulation[10..0]
	.write( write ),             // ObjectKind=Sheet Entry|PrimaryId=mixer.v-write
	.adr( adr ),                 // ObjectKind=Sheet Entry|PrimaryId=mixer.v-adr[6..0]
	.data( data ),               // ObjectKind=Sheet Entry|PrimaryId=mixer.v-data[7..0]
	.osc_sel( osc_sel ),         // ObjectKind=Sheet Entry|PrimaryId=mixer.v-osc_sel
	.m1_sel( m1_sel ),           // ObjectKind=Sheet Entry|PrimaryId=mixer.v-m1_sel
	.m2_sel( m2_sel ),           // ObjectKind=Sheet Entry|PrimaryId=mixer.v-m2_sel
	.com_sel( com_sel ),         // ObjectKind=Sheet Entry|PrimaryId=mixer.v-com_sel
	.lsound_out( lsound_out ),         // ObjectKind=Sheet Entry|PrimaryId=mixer.v-rsound_out[23..0]
	.rsound_out( rsound_out )          // ObjectKind=Sheet Entry|PrimaryId=mixer.v-rsound_out[23..0]
);
		
env_gen_indexed #(.VOICES(VOICES),.V_ENVS(V_ENVS),.V_WIDTH(V_WIDTH),.E_WIDTH(E_WIDTH)) env_gen_indexed_inst  // ObjectKind=Sheet Symbol|PrimaryId=U_env_gen_indexed
(
	.iRST_N( iRST_N ),                               // ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-iRST_N
	.sCLK_XVXENVS( sCLK_XVXENVS ),// ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-sCLK_XVXENVS
	.xxxx( xxxx ),                  // ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-xxxx[5..0]
	.keys_on( reg_keys_on ),         // ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-keys_on[7..0]
	.write( write ),             // ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-write
	.adr( adr ),                 // ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-adr[6..0]
	.data( data ),               // ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-data[7..0]
	.env_sel( env_sel ),         // ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-env_sel
	.level_mul( level_mul ),  	// ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-level_mul[7..0]
	.osc_accum_zero( osc_accum_zero ),  	// ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-osc_accum_zero[V_ENVS..0]
	.voice_free( voice_free )	// ObjectKind=Sheet Entry|PrimaryId=env_gen_indexed.v-voice_free[7..0]
);


endmodule
