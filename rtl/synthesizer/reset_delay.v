module	reset_delay(iCLK,reset_reg_N,oRST_0,oRST_1,oRST_2);
input		iCLK;
input		reset_reg_N;
output reg	oRST_0;
output reg	oRST_1;
output reg	oRST_2;

reg	[21:0]	Cont;

always@(posedge iCLK or negedge reset_reg_N)
begin
	if(!reset_reg_N)
	begin
		Cont	<=	22'h0;
		oRST_0	<=	1'b0;
		oRST_1	<=	1'b0;
		oRST_2	<=	1'b0;
	end
	else
	begin
		if(Cont!=22'h3FFFFF)
		Cont	<=	Cont+1'b1;
		if(Cont>=22'h1FFFFF)
		oRST_0	<=	1'b1;
		if(Cont>=22'h2FFFFF)
		oRST_1	<=	1'b1;
		if(Cont>=22'h3FFFFF)
		oRST_2	<=	1'b1;
	end
end

endmodule