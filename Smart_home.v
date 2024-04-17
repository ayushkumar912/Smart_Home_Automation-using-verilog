`timescale 1ns / 1ps
module Comfort1
(
input clk,reset,motion_sen,
input [5:0]temp_sen,lume_sen,
output reg heater,cooler,light_high
);
reg [2:0]current_state,next_state;
parameter A=3'b000,B=3'b001,C=3'b010,D=3'b011,E=3'b100;
always@(posedge clk or posedge reset or negedge motion_sen) begin
if(reset) current_state<=A;
else if(!motion_sen) current_state<=0;
else current_state<=next_state;
end
always@(posedge clk,current_state,motion_sen,reset,temp_sen,lume_sen) begin
case(current_state)
A:begin
if(temp_sen<15&&lume_sen<15)begin
next_state<=B;
heater=1'b1;
cooler=1'b0;
light_high=1'b1;
end
else if(temp_sen<15&&lume_sen>15)begin
next_state<=C;
heater=1'b1;
cooler=1'b0;
light_high=1'b0;end
else if(temp_sen>30&&lume_sen<15)begin
next_state<=D;
heater=1'b0;
cooler=1'b1;
light_high=1'b1;
end
else if(temp_sen>30&&lume_sen>15)begin
next_state<=E;
heater=1'b0;
cooler=1'b1;
light_high=1'b0;
end
else begin next_state<=A;
heater=1'b0;
cooler=1'b0;
light_high=1'b0;
end
end
B:begin
if(temp_sen<15&&lume_sen>15)begin
next_state<=C;
heater=1'b1;
cooler=1'b0;
light_high=1'b0;
end
else if(temp_sen>30&&lume_sen<15)begin
next_state<=D;
heater=1'b0;
cooler=1'b1;
light_high=1'b1;
end
else if(temp_sen>30&&lume_sen>15)begin
next_state<=E;
heater=1'b0;
cooler=1'b1;
light_high=1'b0;
end
else begin
next_state<=B;
heater=1'b1;
cooler=1'b0;
light_high=1'b1;
end
end
C:begin
if(temp_sen<15&&lume_sen<15)begin
next_state<=B;
heater=1'b1;
cooler=1'b0;
light_high=1'b1;
end
else if(temp_sen>30&&lume_sen<15)begin
next_state<=D;
heater=1'b0;
cooler=1'b1;light_high=1'b1;
end
else if(temp_sen>30&&lume_sen>15)begin
next_state<=E;
heater=1'b0;
cooler=1'b1;
light_high=1'b0;
end
else begin
next_state<=C;
heater=1'b1;
cooler=1'b0;
light_high=1'b0;
end
end
D:begin
if(temp_sen<15&&lume_sen<15)begin
next_state<=B;
heater=1'b1;
cooler=1'b0;
light_high=1'b1;
end
else if(temp_sen<15&&lume_sen>15)begin
next_state<=C;
heater=1'b1;
cooler=1'b0;
light_high=1'b0;
end
else if(temp_sen>30&&lume_sen>15)begin
next_state<=E;
heater=1'b0;
cooler=1'b1;
light_high=1'b0;
end
else begin
next_state<=D;
heater=1'b0;
cooler=1'b1;
light_high=1'b1;
end
end
E:begin
if(temp_sen<15&&lume_sen<15)begin
next_state<=B;
heater=1'b1;
cooler=1'b0;
light_high=1'b1;
end
else if(temp_sen<15&&lume_sen>15)begin
next_state<=C;
heater=1'b1;
cooler=1'b0;light_high=1'b0;
end
else if(temp_sen>30&&lume_sen<15)begin
next_state<=D;
heater=1'b0;
cooler=1'b1;
light_high=1'b1;
end
else begin
next_state<=E;
heater=1'b0;
cooler=1'b1;
light_high=1'b0;
end
end
default: next_state<=A;
endcase
end
endmodule
