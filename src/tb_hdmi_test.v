`timescale 1ns / 1ps

module tb_hdmi_test;
	
	reg		clk, nrst;
	
	wire	[1 : 0]		hdmi_clk;
	wire	[1 : 0]		hdmi_d0;
	wire	[1 : 0]		hdmi_d1;
	wire	[1 : 0]		hdmi_d2;
	
	hdmi_test DUT(
		
		.sys_clock			(clk),
		.sys_nrst			(nrst),
		.hdmi_clk			(hdmi_clk),
		.hdmi_d0			(hdmi_d0),
		.hdmi_d1			(hdmi_d1),
		.hdmi_d2			(hdmi_d2)
	);
	
	always begin
		#10.0 clk = ~clk;
	end
	
	initial begin
		
		fork begin
			
			#200 clk = 1'b0;
			nrst = 1'b0;
			
			#50 nrst = 1'b1;
			
			#1000 nrst = 1'b0;
			
			#1234 nrst = 1'b1;
			
		end join
	end
	
endmodule
