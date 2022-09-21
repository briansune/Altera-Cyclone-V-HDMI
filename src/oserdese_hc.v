module oserdese_hc(
	
	input wire				ddr_bit_clock,
	input wire		[9:0]	par_data,
	output wire				tmds_lane
);
	
	wire [4:0] data_rise = {par_data[8],par_data[6],par_data[4],par_data[2],par_data[0]};
	wire [4:0] data_fall = {par_data[9],par_data[7],par_data[5],par_data[3],par_data[1]};
	
	//reg define
	reg [4:0] data_rise_s = 0;
	reg [4:0] data_fall_s = 0;
	reg [2:0] cnt = 0;
	
	reg p = 1'b0;
	reg n = 1'b0;

	always@(posedge ddr_bit_clock)begin
		cnt <= (cnt[2]) ? 3'd0 : cnt + 3'd1;
	end
	
	always@(posedge ddr_bit_clock)begin
		data_fall_s <= cnt[2] ? data_fall : data_fall_s[4:1];
		p <= data_rise_s[0] ^ n;
	end
	
	always@(negedge ddr_bit_clock)begin
		data_rise_s <= cnt[2] ? data_rise : data_rise_s[4:1];
		n <= data_fall_s[0] ^ p;
	end
	
	assign tmds_lane = p ^ n;
	
endmodule
