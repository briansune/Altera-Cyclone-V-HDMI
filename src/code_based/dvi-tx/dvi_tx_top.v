module dvi_tx_top(
	
	input				pixel_clock,
	// input				dvi_en_clock,
	input				ddr_bit_clock,
	input				reset,
	
	input				den,
	input				hsync,
	input				vsync,
	input	[23 : 0]	pixel_data,
	
	output				tmds_clk_p,
	output				tmds_clk_n,
	
	output				tmds_d0_p,
	output				tmds_d0_n,
	output				tmds_d1_p,
	output				tmds_d1_n,
	output				tmds_d2_p,
	output				tmds_d2_n
);
	
	wire	[5 : 0]		ctrl;
	wire	[29 : 0]	tmds_enc;
	
	wire	[2 : 0]		int_dout;
	wire				int_clk;
	
	wire	[1 : 0]		data_out_to_pins	[2 : 0];
	
	assign tmds_d0_p = data_out_to_pins[0][1];
	assign tmds_d0_n = data_out_to_pins[0][0];
	assign tmds_d1_p = data_out_to_pins[1][1];
	assign tmds_d1_n = data_out_to_pins[1][0];
	assign tmds_d2_p = data_out_to_pins[2][1];
	assign tmds_d2_n = data_out_to_pins[2][0];
	
	assign ctrl[0] = hsync;
	assign ctrl[1] = vsync;
	assign ctrl[5 : 2] = 4'b0000;
	
	generate
		genvar i;
		for(i = 0; i < 3; i = i + 1)begin : gen_buff
			
			dvi_tx_tmds_enc dvi_tx_tmds_enc_inst(
				
				.clock		(pixel_clock),
				.reset		(reset),
				
				.den		(den),
				.data		(pixel_data[(8*i) +: 8]),
				.ctrl		(ctrl[(2*i) +: 2]),
				.tmds		(tmds_enc[(10*i) +: 10])
			);
			
			oserdese_hc dvi_if0(
				.par_data		(tmds_enc[(10*i) +: 10]),
				.ddr_bit_clock	(ddr_bit_clock),
				.tmds_lane_p	(data_out_to_pins[i][1]),
				.tmds_lane_n	(data_out_to_pins[i][0])
			);
		end
	endgenerate
	
	oserdese_hc dvi_if_clk(
		.par_data		(10'b1111100000),
		.ddr_bit_clock	(ddr_bit_clock),
		.tmds_lane_p	(tmds_clk_p),
		.tmds_lane_n	(tmds_clk_n)
	);
	
endmodule
