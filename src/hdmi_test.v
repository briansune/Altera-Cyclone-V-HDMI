`timescale 1ns / 1ps

module hdmi_test(
	
	input				sys_clock,
	input				sys_nrst,
	
	output	[1 : 0]		hdmi_clk,
	output	[1 : 0]		hdmi_d0,
	output	[1 : 0]		hdmi_d1,
	output	[1 : 0]		hdmi_d2
);
	
	wire				dvi_pixel_clock;
	wire				dvi_bit_clock;
	// wire				dvi_en_clock;
	
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
		
		// 148.5 MHz
		// .outclk_2			(dvi_en_clock),
		// 148.5 MHz
		.outclk_1			(dvi_pixel_clock),
		// 742.5 MHz
		.outclk_0			(dvi_bit_clock),
		
		.locked				(global_nrst)
	);
	
	dvi_tx_top dvi_tx_top_inst0(
		
		.pixel_clock		(dvi_pixel_clock),
		// .dvi_en_clock		(dvi_en_clock),
		.ddr_bit_clock		(dvi_bit_clock),
		.reset				(global_rst),
		
		.den				(dvi_den),
		.hsync				(dvi_hsync),
		.vsync				(dvi_vsync),
		.pixel_data			(dvi_data),
		
		.tmds_clk			(hdmi_clk),
		.tmds_d0			(hdmi_d0),
		.tmds_d1			(hdmi_d1),
		.tmds_d2			(hdmi_d2)
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
