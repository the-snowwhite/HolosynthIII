module mixer_2 (
// Inputs -- //
    input                sCLK_XVXENVS,  // clk
    input                sCLK_XVXOSC,  // clk
    input                iRST_N,        // reset
    input [V_WIDTH+E_WIDTH-1:0] xxxx,
    input                     n_xxxx_zero,
    //  env gen
    input signed [7:0]          level_mul,    // envgen output
    input signed [16:0]         sine_lut_out, // sine

    input [7:0]          data,
    input [6:0]          adr,
    input                write,
    input                osc_sel,
    input                com_sel,
    input                m1_sel,
    input                m2_sel,
    // Outputs -- //
    // osc
//    output reg [10:0]modulation,
    output reg signed [10:0] modulation,
    // sound data out
    output signed [15:0]             lsound_out,   // 16-bits
    output signed [15:0]             rsound_out   // 16-bits
);

parameter VOICES	= 8;
parameter V_OSC		= 4; // oscs per Voice
parameter O_ENVS	= 2; // envs per Oscilator
parameter V_ENVS	= V_OSC * O_ENVS; // envs per Voice
parameter V_WIDTH	= 3;
parameter O_WIDTH	= 2;
parameter OE_WIDTH	= 1;
parameter E_WIDTH	= O_WIDTH + OE_WIDTH;

parameter x_offset = (V_OSC * VOICES ) - 2;

//parameter vo_x_offset = (V_ENVS * VOICES ) - 1;
parameter vo_x_offset = x_offset;

   reg  signed [7:0]osc_lvl[V_OSC-1:0];      // osc_lvl  osc_buf[2]
   reg  signed [7:0]osc_mod[V_OSC-1:0];      // osc_mod    osc_buf[3]
   reg  signed [7:0]osc_feedb[V_OSC-1:0];        // osc_feedb  osc_buf[4]
   reg  signed [7:0]osc_pan[V_OSC-1:0];        // osc_feedb  osc_buf[4]
   reg  signed [7:0]osc_mod_in[V_OSC-1:0];       // osc_mod    osc_buf[10]
   reg  signed [7:0]osc_feedb_in[V_OSC-1:0];     // osc_feedb  osc_buf[11]
   reg  signed [7:0]m_vol;               // m_vol        com_buf[1]
   reg  signed [7:0]mat_buf1[15:0][V_OSC-1:0];
   reg  signed [7:0]mat_buf2[15:0][V_OSC-1:0];

   reg [O_WIDTH-1:0]  ox_dly[x_offset:0];
   reg [V_WIDTH-1:0]  vx_dly[x_offset:0];

	reg signed [63:0] reg_sine_level_mul_data;
	reg signed [63:0] reg_sine_level_mul_osc_lvl_m_vol_data;
	
	reg signed [63:0] reg_osc_data_sum_l;
	reg signed [63:0] reg_osc_data_sum_r;
	
	reg signed [63:0] reg_voice_sound_sum_l;
	reg signed [63:0] reg_voice_sound_sum_r;
	
	reg signed [7:0] reg_voice_vol_env_lvl;

	reg signed [47:0] reg_sine_mod_data[V_OSC-1:0];
	reg signed [47:0] reg_sine_fb_data[V_OSC-1:0];

	reg signed [47:0] reg_mod_matrix_mul_sum[V_OSC-1:0];	
	reg signed [47:0] reg_fb_matrix_mul_sum[V_OSC-1:0];

	reg signed [47:0] reg_mod_matrix_mul[V_OSC-1:0];	
	reg signed [47:0] reg_fb_matrix_mul[V_OSC-1:0];

	wire signed [47:0] mod_matrix_mul[V_OSC-1:0];
	wire signed [47:0] fb_matrix_mul[V_OSC-1:0];
	
	wire signed [47:0] mod_matrix_out_sum;
	wire signed [47:0] fb_matrix_out_sum;
	
	reg signed [10:0] reg_matrix_data[VOICES-1:0][V_OSC-1:0];
	
	
	reg[V_OSC+2:0] sh_voice_reg;
	reg[V_ENVS:0] sh_osc_reg;
//	reg[(V_ENVS * VOICES )-1:0] sh_mod_reg;
 
	wire signed [63:0] sine_level_mul_osc_lvl_m_vol_osc_pan_main_vol_env_l;
	wire signed [63:0] sine_level_mul_osc_lvl_m_vol_osc_pan_main_vol_env_r;
			
	wire signed [10:0] modulation_sum;
	
	assign sine_level_mul_osc_lvl_m_vol_osc_pan_main_vol_env_l = reg_sine_level_mul_osc_lvl_m_vol_data * reg_voice_vol_env_lvl * (127 - osc_pan[ox_dly[1]]);
	assign sine_level_mul_osc_lvl_m_vol_osc_pan_main_vol_env_r = reg_sine_level_mul_osc_lvl_m_vol_data * reg_voice_vol_env_lvl * osc_pan[ox_dly[1]];

	assign modulation_sum = (( mod_matrix_out_sum + fb_matrix_out_sum ) >>> (26 + O_WIDTH ));  
//	assign modulation_sum = (( mod_matrix_out_sum + fb_matrix_out_sum ) >>> (24 + O_WIDTH ));  
	
	wire [O_WIDTH-1:0]  ox;
	wire [V_WIDTH-1:0]  vx;
	assign ox = xxxx[E_WIDTH-1:OE_WIDTH];
	assign vx = xxxx[V_WIDTH+E_WIDTH-1:E_WIDTH];
	 
   integer loop,oloop,iloop,osc1,ol1,il1,ol2,il2;
	integer slmloop,shloop,d1;
/**		@brief get midi controller data from midi decoder
*/	
    always@(negedge iRST_N or negedge write)begin : receive_midi_controller_data
        if(!iRST_N) begin
            for (loop=0;loop<V_OSC;loop=loop+1)begin
                if(loop <= 1)osc_lvl[loop] <= 8'h40;
                else osc_lvl[loop] <= 8'h00;
                osc_mod[loop] <= 8'h00;
                osc_feedb[loop] <= 8'h00;
                osc_pan[loop] <= 8'h40;
                osc_mod_in[loop] <= 8'h00;
                osc_feedb_in[loop] <= 8'h00;
            end
            for (oloop=0;oloop<16;oloop=oloop+1)begin
                for(iloop=0;iloop<V_OSC;iloop=iloop+1)begin
                    mat_buf1[oloop][iloop] <= 8'h00;
                    mat_buf2[oloop][iloop] <= 8'h00;
                end
            end
            m_vol <= 8'h40;
        end else if(!write) begin
            if(osc_sel)begin
                for (osc1=0;osc1<V_OSC;osc1=osc1+1)begin
                    case (adr)
                        2 +(osc1<<4): osc_lvl[osc1] <= data;
                        3 +(osc1<<4): osc_mod[osc1] <= data;
                        4 +(osc1<<4): osc_feedb[osc1] <= data;
                        7 +(osc1<<4): osc_pan[osc1] <= data;
                        10 +(osc1<<4): osc_mod_in[osc1] <= data;
                        11 +(osc1<<4): osc_feedb_in[osc1] <= data;
                        default:;
                    endcase
                end
            end
            else if(com_sel) begin
                if(adr == 1) m_vol <= data;
            end
            else if (m1_sel) begin
               for (ol1=0;ol1<16;ol1=ol1+1)begin
                   for(il1=0;il1<V_OSC;il1=il1+1)begin
                       if (adr == (il1 << 4)+ol1) mat_buf1[ol1][il1] <= data;
                   end
                end
            end
            else if (m2_sel) begin
               for (ol2=0;ol2<16;ol2=ol2+1)begin
                   for(il2=0;il2<V_OSC;il2=il2+1)begin
                       if (adr == (il2 << 4)+ol2)mat_buf2[ol2][il2] <= data;
                   end
                end
            end
        end
    end

/**	@brief sum modulation data and multiply with martix in for pr osc.
*/	 

	genvar modmatloop;
	generate
		for (modmatloop=0;modmatloop<V_OSC;modmatloop=modmatloop+1) begin : cal_mod_mat_mul
			assign mod_matrix_mul[modmatloop] = reg_sine_mod_data[ox_dly[1]] * mat_buf1[modmatloop][ox_dly[1]];
//			assign mod_matrix_mul[modmatloop] = reg_sine_mod_data[osc_counter] * mat_buf1[modmatloop][osc_counter];
		end
	endgenerate
	
	genvar fbmatloop;
	generate
		for (fbmatloop=0;fbmatloop<V_OSC;fbmatloop=fbmatloop+1) begin : cal_fb_mat_mul
			assign fb_matrix_mul[fbmatloop] = reg_sine_fb_data[ox_dly[1]] * mat_buf1[fbmatloop+8][ox_dly[1]];
//			assign fb_matrix_mul[fbmatloop] = reg_sine_fb_data[osc_counter] * mat_buf1[fbmatloop+8][osc_counter];
		end
	endgenerate

	assign mod_matrix_out_sum = (reg_mod_matrix_mul[ox_dly[V_OSC]] * osc_mod_in[ox_dly[V_OSC]]);// >>> ( O_WIDTH + V_WIDTH);
	assign fb_matrix_out_sum = (reg_fb_matrix_mul[ox_dly[V_OSC]] * osc_feedb_in[ox_dly[V_OSC]]);// >>> (O_WIDTH + V_WIDTH);

/*
	genvar modloop;
	generate
		wire [48:0 ]mod_sum[V_OSC:0];
		assign mod_sum[0] = 0;ox_dly[V_OSC+2]]
		assign mod_matrix_out_sum = (mod_sum[V_OSC] * osc_mod_in[ox_dly[V_OSC+2]]);// >>> ( O_WIDTH + V_WIDTH);
		for (modloop=0;modloop<V_OSC;modloop=modloop+1) begin : cal_mod_mat_out_sum
			assign mod_sum[modloop+1] = mod_sum[modloop] + reg_mod_matrix_mul[modloop];
		end
	endgenerate

	
	genvar fbloop;
	generate
		wire [48:0 ]fb_sum[V_OSC:0];
		assign fb_sum[0] = 0;
		assign fb_matrix_out_sum = (fb_sum[V_OSC] * osc_feedb_in[ox_dly[V_OSC+2]]);// >>> (O_WIDTH + V_WIDTH);
		for (fbloop=0;fbloop<V_OSC;fbloop=fbloop+1) begin : cal_fb_mat_out_sum
			assign fb_sum[fbloop+1] = fb_sum[fbloop] + reg_fb_matrix_mul[fbloop];
		end
	endgenerate
*/	
/**	@brief output mixed sounddata to out register
*/	 
	integer mmoloop;
	
	always @(negedge sCLK_XVXENVS)begin : sound_out
	if(sh_voice_reg[1]) begin
		for(mmoloop=0;mmoloop<V_OSC;mmoloop=mmoloop+1) begin
			reg_mod_matrix_mul[mmoloop] <= reg_mod_matrix_mul_sum[mmoloop];
			reg_fb_matrix_mul[mmoloop]	<= reg_fb_matrix_mul_sum[mmoloop];
		end
	end
	if (sh_voice_reg[2])begin 
			reg_voice_sound_sum_l <= reg_voice_sound_sum_l + reg_osc_data_sum_l; 
			reg_voice_sound_sum_r <= reg_voice_sound_sum_r + reg_osc_data_sum_r; 
		end
		if ( xxxx == ((VOICES - 1) * V_ENVS) )begin
//			lsound_out <= (reg_voice_sound_sum_l * m_vol) >>> (36 + V_WIDTH + O_WIDTH );// - + 1 
//			rsound_out <= (reg_voice_sound_sum_r * m_vol) >>> (36 + V_WIDTH + O_WIDTH );// - + 1 
			lsound_out <= (reg_voice_sound_sum_l * m_vol) >>> (34 + V_WIDTH + O_WIDTH );// - + 1 
			rsound_out <= (reg_voice_sound_sum_r * m_vol) >>> (34 + V_WIDTH + O_WIDTH );// - + 1 
		end	
		if (xxxx == ((VOICES - 1) * V_ENVS) + 1)begin reg_voice_sound_sum_l <= 0; reg_voice_sound_sum_r <= 0; end
	end

	always @(posedge sCLK_XVXENVS) begin
		if(sh_voice_reg[2]) begin reg_voice_vol_env_lvl <= level_mul; end
	end

	
/**	@brief main mix summing machine
*		multiply sine level mul data with main vol env (1), left/right pan value, osc vol level and main volume
*	
*/	
	integer mmmloop, mmcloop;
	
	always @(posedge sCLK_XVXENVS )begin : main_mix_summing
		if (sh_osc_reg[1])begin
			reg_sine_level_mul_data <= (level_mul * sine_lut_out);
			reg_sine_mod_data[ox_dly[0]] <= (level_mul * sine_lut_out * osc_mod[ox_dly[0]]);
			reg_sine_fb_data[ox_dly[0]] <= sine_lut_out * osc_feedb[ox_dly[0]];
		end
		if (sh_osc_reg[2])begin
			reg_sine_level_mul_osc_lvl_m_vol_data <= reg_sine_level_mul_data * osc_lvl[ox_dly[1]];
//			for(mmmloop=0;mmmloop<V_OSC;mmmloop=mmmloop+1) begin
//				reg_mod_matrix_mul_sum[mmmloop] <= reg_mod_matrix_mul_sum[mmmloop] + (mod_matrix_mul[mmmloop] >>> 7);
//				reg_fb_matrix_mul_sum[mmmloop] <= reg_fb_matrix_mul_sum[mmmloop] + fb_matrix_mul[mmmloop];
//			end
		end
		for(mmmloop=0;mmmloop<V_OSC;mmmloop=mmmloop+1) begin
//			if(osc_counter < V_OSC)begin
			if(sh_osc_reg[0])begin
				reg_mod_matrix_mul_sum[mmmloop] <= reg_mod_matrix_mul_sum[mmmloop] + (mod_matrix_mul[mmmloop] >>> 7);
				reg_fb_matrix_mul_sum[mmmloop] <= reg_fb_matrix_mul_sum[mmmloop] + fb_matrix_mul[mmmloop];
			end
		end
//		if(osc_counter == V_OSC +1)
		if(sh_osc_reg[3])begin
			reg_osc_data_sum_l <= reg_osc_data_sum_l + sine_level_mul_osc_lvl_m_vol_osc_pan_main_vol_env_l;
			reg_osc_data_sum_r <= reg_osc_data_sum_r + sine_level_mul_osc_lvl_m_vol_osc_pan_main_vol_env_r;

//			reg_matrix_data[vx_dly[2]][ox_dly[2]] <= modulation_sum;
		end

//		if (sh_osc_reg[3]) reg_matrix_data[vx_dly[2]][ox_dly[2]] <= modulation_sum;

		if (sh_voice_reg[1])begin
			for(mmcloop=0;mmcloop<V_OSC;mmcloop=mmcloop+1) begin
				reg_mod_matrix_mul_sum[mmcloop] <= 48'h0;
				reg_fb_matrix_mul_sum[mmcloop] <= 48'h0;
			end
		end

		if(sh_voice_reg[2])begin 
			reg_osc_data_sum_l <= 63'h0; reg_osc_data_sum_r <= 63'h0;
		end
//		if(sh_mod_reg[1])begin reg_osc_mod_data_sum[ox_dly[0]] <= 48'h0; reg_osc_fb_data_sum[ox_dly[0]] <= 48'h0; end
	end

	always @(posedge sCLK_XVXOSC)begin : ox_vx_delay_gen
		vx_dly[0] <= vx; ox_dly[0] <= ox;
		for(d1=0;d1<x_offset;d1=d1+1) begin // all Voices 2 osc's
			vx_dly[d1+1] <= vx_dly[d1]; ox_dly[d1+1] <= ox_dly[d1];
		end

//		if (sh_osc_reg[3]) reg_matrix_data[vx_dly[V_OSC]][ox_dly[V_OSC]] <= modulation_sum;
		reg_matrix_data[vx_dly[V_OSC]][ox_dly[V_OSC]] <= modulation_sum;

		modulation <= reg_matrix_data[vx_dly[vo_x_offset]][ox_dly[vo_x_offset]];
	end
	
	reg [E_WIDTH-1:0]osc_counter;
	
	always @(posedge sCLK_XVXENVS) begin
		if(sh_voice_reg[1]) osc_counter <= 0;
		else osc_counter <= osc_counter + 1;
	end
	
/**	@brief main shiftreg state driver
*/	 
	reg [E_WIDTH-1:0] sh_v_counter;
	reg [OE_WIDTH-1:0] sh_o_counter;
	
	always @(posedge sCLK_XVXENVS )begin : main_sh_regs_state_driver
		if (n_xxxx_zero) begin sh_v_counter <= 0;sh_o_counter <= 0; end
		else begin sh_v_counter <= sh_v_counter + 1; sh_o_counter <= sh_o_counter + 1; end

		if(sh_v_counter == 0 ) begin sh_voice_reg <= (sh_voice_reg << 1)+ 1; end 
		else begin sh_voice_reg <= sh_voice_reg << 1; end

		if(sh_o_counter == 0 ) begin sh_osc_reg <= (sh_osc_reg << 1)+ 1; end 
		else begin sh_osc_reg <= sh_osc_reg << 1; end
		
//		if( xxxx < (V_OSC * O_ENVS) && (!xxxx[OE_WIDTH-1]) ) begin sh_mod_reg <= (sh_mod_reg << 1)+ 1; end
//		else begin sh_mod_reg <= sh_mod_reg << 1; end
	end
	
endmodule
