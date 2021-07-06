//-- inputs:  clk reset switch key 
//-- outputs: display
//--if switch is pressed, toggle between exposure time and number of photos -- need debouncing circuit
//--key is 3 bit word containing exposure time

//-- signal is closer to reg?
//-- variable is closer to wire?


//assume 50 MHz clock freq, 1 second debounce/timeout after first press
//assumes input goes LOW when button is pressed
module CAMERA_SM(
input i_clk,
input i_rst_n,
input [2:0] i_key,
input i_switch,
output [2:0] o_data,
input photo_taken
	);

reg [2:0] photo_cnt = 0;
reg [3:0] r_SM = 0;
reg [31:0] r_debounce_cnt = 0;
reg hold = 0; //1 if we are displaying photos, 0 if we are displaying key


always@(posedge i_clk) begin
if(~i_rst_n)begin
//reset my values here
end
else begin
case(r_SM)
0:begin //initialize display as photo count, toggle to key if button press
if(i_switch == 1'b0) begin r_SM <= 1; o_data <= i_key; hold <= 0; end
else begin r_SM <= 0; o_data <= photo_cnt; hold <= 1; end
end
1:begin //run debouncing circuit
if(r_debounce_cnt == 32'd50000000)begin
 r_debounce_cnt <= 0; 
if(hold == 0) r_SM <= 2;
else r_SM <= 0; 
end
else r_debounce_cnt <= r_debounce_cnt + 1; r_SM <= 1; end
end
2:begin //toggle to photo count if button press
if(i_switch == 1'b0) begin r_SM <= 1; o_data <= photo_cnt; hold <= 1; end
else begin r_SM <= 2; o_data <= i_key; hold <= 0; end
end
endcase
end
end

always@(posedge i_clk) //increment photo_count
begin
if(~i_rst_n)begin
//reset my values here
end
else begin
if(photo_taken) photo_cnt <= photo_cnt + 1;
else photo_cnt <= photo_cnt;
end
end

endmodule