module dvi_tx_clk_drv(
	
	input				pixel_clock,
	output	[1 : 0]		tmds_clk
);
	
	wire tmds_clk_pre;
	
	/*
	ODDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"),
		.INIT(1'b0),
		.SRTYPE("SYNC")
	) ODDR_inst (
		.Q	(tmds_clk_pre),
		.C	(pixel_clock),
		.CE	(1),
		.D1	(1),
		.D2	(0),
		.R	(0),
		.S	(0)
	);
	*/
	
	oddr oddr_inst(
		.dataout	(tmds_clk_pre),
		.outclock	(pixel_clock),
		.datain_h	(1),
		.datain_l	(0)
	);
	
	/*
	OBUFDS #(
		.IOSTANDARD("DEFAULT"),
		.SLEW("FAST")
	)OBUFDS_hdmi_clk(
		.I		(tmds_clk_pre),
		.O		(tmds_clk[1]),
		.OB		(tmds_clk[0])
	);
	*/
	
	alt_outbuf_diff OBUFDS_hdmi_clk(
		.i		(tmds_clk_pre),
		.o		(tmds_clk[1]),
		.obar	(tmds_clk[0])
	);
	
endmodule
