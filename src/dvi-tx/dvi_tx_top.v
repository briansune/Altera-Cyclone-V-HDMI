module dvi_tx_top(
	
	input				pixel_clock,
	// input				dvi_en_clock,
	input				ddr_bit_clock,
	input				reset,
	
	input				den,
	input				hsync,
	input				vsync,
	input	[23 : 0]	pixel_data,
	
	output	[1 : 0]		tmds_clk,
	output	[1 : 0]		tmds_d0,
	output	[1 : 0]		tmds_d1,
	output	[1 : 0]		tmds_d2
);
	
	wire	[5 : 0]		ctrl;
	wire	[29 : 0]	tmds_enc;
	
	wire	[2 : 0]		int_dout;
	wire				int_clk;
	
	wire	[1 : 0]		data_out_to_pins	[2 : 0];
	
	// wire	[29 : 0]	tmds_reversed;
	// wire	[9 : 0]		tmds_clk_reversed;
	
	assign tmds_d0 = data_out_to_pins[0];
	assign tmds_d1 = data_out_to_pins[1];
	assign tmds_d2 = data_out_to_pins[2];
	
	assign ctrl[0] = hsync;
	assign ctrl[1] = vsync;
	assign ctrl[5 : 2] = 4'b0000;
	
	// generate
		// genvar j;
		// for (j = 0; j < 10; j=j+1)begin: tmds_rev
			// assign tmds_reversed[j] = tmds_enc[9-j];
			// assign tmds_reversed[10+j] = tmds_enc[19-j];
			// assign tmds_reversed[20+j] = tmds_enc[29-j];
		// end
	// endgenerate
	
	// assign tmds_clk_reversed = 10'b0011111000;
	
	// oserdese dvi_if0(
		// .tx_in			({tmds_clk_reversed, tmds_reversed}),
		// .tx_enable		(dvi_en_clock),
		// .tx_inclock		(ddr_bit_clock),
		// .tx_out			({int_clk, int_dout})
	// );
	
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
				.tmds_lane		(int_dout[i])
			);
			
			alt_outbuf_diff tmds_buf_dout(
				.i		(int_dout[i]),
				.o		(data_out_to_pins[i][1]),
				.obar	(data_out_to_pins[i][0])
			);
			
		end
	endgenerate
	
	oserdese_hc dvi_if_clk(
		.par_data		(10'b0001111100),
		.ddr_bit_clock	(ddr_bit_clock),
		.tmds_lane		(int_clk)
	);
	
	alt_outbuf_diff tmds_buf_clk(
		.i		(int_clk),
		.o		(tmds_clk[1]),
		.obar	(tmds_clk[0])
	);
	
	/*
	generate
		
		genvar i;
		
		for(i = 0; i < 3; i = i + 1)begin : gen_enc
			
			dvi_tx_tmds_enc dvi_tx_tmds_enc_inst(
				
				.clock		(pixel_clock),
				.reset		(reset),
				
				.den		(den),
				.data		(pixel_data[(8*i) +: 8]),
				.ctrl		(ctrl[(2*i) +: 2]),
				.tmds		(tmds_enc[(10*i) +: 10])
			);
			
			dvi_tx_tmds_phy dvi_tx_tmds_phy_inst(
				
				.pixel_clock		(pixel_clock),
				//.ddr_bit_clock		(ddr_bit_clock),
				.reset				(reset),
				.data				(tmds_enc[(10*i) +: 10]),
				.tmds_lane			(data_out_to_pins[i])
			);
		end
		
	endgenerate
	
	dvi_tx_clk_drv clock_phy(
		
		.pixel_clock	(pixel_clock),
		.tmds_clk		(tmds_clk)
	);
	*/
	
endmodule
