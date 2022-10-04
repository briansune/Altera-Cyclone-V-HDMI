module oserdese_hc(
	
	input wire					ddr_bit_clock,
	input wire		[9 : 0]		par_data,
	output wire					tmds_lane_p,
	output wire					tmds_lane_n
);
	
	wire [4:0] data_rise = {par_data[8],par_data[6],par_data[4],par_data[2],par_data[0]};
	wire [4:0] data_fall = {par_data[9],par_data[7],par_data[5],par_data[3],par_data[1]};
	
	//reg define
	reg [4:0] data_rise_s = 0;
	reg [4:0] data_fall_s = 0;
	reg [2:0] cnt = 0;

	always@(posedge ddr_bit_clock)begin
		cnt <= (cnt[2]) ? 3'd0 : cnt + 3'd1;
		data_fall_s <= cnt[2] ? data_fall : data_fall_s[4:1];
		data_rise_s <= cnt[2] ? data_rise : data_rise_s[4:1];
	end
	
	altddio_out	oddr_p (
		.datain_h (data_rise_s[0]),
		.datain_l (data_fall_s[0]),
		.outclock (~ddr_bit_clock),
		.dataout (tmds_lane_p),
		.aclr (1'b0),
		.aset (1'b0),
		.oe (1'b1),
		.oe_out (),
		.outclocken (1'b1),
		.sclr (1'b0),
		.sset (1'b0)
	);
	defparam
	oddr_p.extend_oe_disable = "OFF",
	oddr_p.intended_device_family = "Cyclone V",
	oddr_p.invert_output = "OFF",
	oddr_p.lpm_hint = "UNUSED",
	oddr_p.lpm_type = "altddio_out",
	oddr_p.oe_reg = "UNREGISTERED",
	oddr_p.power_up_high = "OFF",
	oddr_p.width = 1;
	
	altddio_out	oddr_n (
		.datain_h (~data_rise_s[0]),
		.datain_l (~data_fall_s[0]),
		.outclock (~ddr_bit_clock),
		.dataout (tmds_lane_n),
		.aclr (1'b0),
		.aset (1'b0),
		.oe (1'b1),
		.oe_out (),
		.outclocken (1'b1),
		.sclr (1'b0),
		.sset (1'b0)
	);
	defparam
	oddr_n.extend_oe_disable = "OFF",
	oddr_n.intended_device_family = "Cyclone V",
	oddr_n.invert_output = "OFF",
	oddr_n.lpm_hint = "UNUSED",
	oddr_n.lpm_type = "altddio_out",
	oddr_n.oe_reg = "UNREGISTERED",
	oddr_n.power_up_high = "OFF",
	oddr_n.width = 1;
	
endmodule
