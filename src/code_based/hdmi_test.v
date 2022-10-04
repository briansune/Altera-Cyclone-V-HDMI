`timescale 1ns / 1ps

module hdmi_test(
	
	input				sys_clock,
	input				sys_nrst,
	
	output				hdmi_clk_p,
	output				hdmi_clk_n,
	output				hdmi_d0_p,
	output				hdmi_d0_n,
	output				hdmi_d1_p,
	output				hdmi_d1_n,
	output				hdmi_d2_p,
	output				hdmi_d2_n
);
	
	wire				dvi_pixel_clock;
	wire				dvi_bit_clock;
	
	wire				global_nrst;
	wire				global_rst;
	
	wire				dvi_den;
	wire				dvi_hsync;
	wire				dvi_vsync;
	wire	[23 : 0]	dvi_data;
	
	assign global_rst = ~global_nrst;
	
	dvi_pll dvi_pll_inst0(
		
		.refclk				(sys_clock),
		.rst				(!sys_nrst),
		
		.outclk_1			(dvi_pixel_clock),
		.outclk_0			(dvi_bit_clock),
		
		.locked				(global_nrst)
	);
	
	dvi_tx_top dvi_tx_top_inst0(
		
		.pixel_clock		(dvi_pixel_clock),
		.ddr_bit_clock		(dvi_bit_clock),
		.reset				(global_rst),
		
		.den				(dvi_den),
		.hsync				(dvi_hsync),
		.vsync				(dvi_vsync),
		.pixel_data			(dvi_data),
		
		.tmds_clk_p			(hdmi_clk_p),
		.tmds_clk_n			(hdmi_clk_n),
		.tmds_d0_p			(hdmi_d0_p),
		.tmds_d0_n			(hdmi_d0_n),
		.tmds_d1_p			(hdmi_d1_p),
		.tmds_d1_n			(hdmi_d1_n),
		.tmds_d2_p			(hdmi_d2_p),
		.tmds_d2_n			(hdmi_d2_n)
	);
	
	test_pattern_gen test_gen0(
		
		.pixel_clock		(dvi_pixel_clock),
		.reset				(global_rst),
		
		.video_vsync		(dvi_vsync),
		.video_hsync		(dvi_hsync),
		.video_den			(dvi_den),
		.video_pixel_even	(dvi_data)
	);
	
endmodule
