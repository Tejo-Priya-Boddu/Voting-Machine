`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


//BUTTON CONTROL MODULE
module button_control(
input clk,rst,button,
output reg valid_vote);
reg[30:0]counter;
always @(posedge clk)
begin
    if(rst)
        counter <= 0;
    else
    begin
        if(button & counter <11)
            counter <= counter + 1;
        else if(!button)
            counter <= 0;
    end
end

always @(posedge clk)
begin
    if(rst)
        valid_vote<=1'b0;
    else if(counter == 10)
        valid_vote <=1'b1;
    else
        valid_vote <=1'b0;
end
endmodule
//VOTE LOGGER MODULE
module voteLogger(
input clk,rst,mode,
input cand1_vote_valid,
input cand2_vote_valid,
input cand3_vote_valid,
input cand4_vote_valid,
output reg [7:0] cand1_vote_recvd,
output reg [7:0] cand2_vote_recvd,
output reg [7:0] cand3_vote_recvd,
output reg [7:0] cand4_vote_recvd);
always @ (posedge clk)
begin
    if(rst)
    begin
        cand1_vote_recvd<=0;
        cand2_vote_recvd<=0;
        cand3_vote_recvd<=0;
        cand4_vote_recvd<=0;
    end
    else
    begin
        if(cand1_vote_valid & mode==0)
            cand1_vote_recvd <= cand1_vote_recvd + 1;
        else if(cand2_vote_valid & mode==0)
            cand2_vote_recvd <= cand2_vote_recvd + 1;
        else if(cand3_vote_valid & mode==0)
            cand3_vote_recvd <= cand3_vote_recvd + 1;
        else if(cand4_vote_valid & mode==0)
            cand4_vote_recvd <= cand4_vote_recvd + 1;    
    end
end   
endmodule
//MODE CONTROL MODULE
module modeControl(
input clk,rst,mode,valid_vote_casted,
input  [7:0] candidate1_vote,
input  [7:0] candidate2_vote,
input  [7:0] candidate3_vote,
input  [7:0] candidate4_vote,
input candidate1_button_press,
input candidate2_button_press,
input candidate3_button_press,
input candidate4_button_press,
output reg [7:0]leds 
);
reg [30:0] counter;
always @ (posedge clk)
begin
    if(rst)
        counter <= 0;
    else if(valid_vote_casted)
        counter <= counter+1;
    else if(counter != 0 & counter < 10)
        counter <= counter+1;
    else
        counter <= 0;
end

always @(posedge clk)
begin
    if(rst)
        leds <= 0;
    else
    begin
        if(mode==0 & counter > 0)
            leds<=8'hFF;
        else if(mode==0)
            leds<=8'h00;
        else if(mode==1)
        begin
            if(candidate1_button_press)
                leds<=candidate1_vote;
            else if(candidate2_button_press)
                leds<=candidate2_vote;
            else if(candidate3_button_press)
                leds<=candidate3_vote;
            else if(candidate4_button_press)
                leds<=candidate4_vote;
        end
    end
 end
 endmodule
            
module voting_machine(
input clk,rst,mode,
input button1,
input button2,
input button3,
input button4,
output [7:0]led
    );
 wire valid_vote_1;
 wire valid_vote_2;
 wire valid_vote_3;
 wire valid_vote_4;
 wire [7:0] cand1_vote_recvd;
 wire [7:0] cand2_vote_recvd;
 wire [7:0] cand3_vote_recvd;
 wire [7:0] cand4_vote_recvd;
 wire anyvalidvote;
 assign anyvalidvote = valid_vote_1|valid_vote_2|valid_vote_3|valid_vote_4;
 button_control be1(
 .clk(clk),
 .rst(rst),
 .button(button1),
 .valid_vote(valid_vote_1)
 );
  button_control be2(
 .clk(clk),
 .rst(rst),
 .button(button2),
 .valid_vote(valid_vote_2)
 );
  button_control be3(
 .clk(clk),
 .rst(rst),
 .button(button3),
 .valid_vote(valid_vote_3)
 ); button_control be4(
 .clk(clk),
 .rst(rst),
 .button(button4),
 .valid_vote(valid_vote_4)
 );
  voteLogger vl(
 .clk(clk),
 .rst(rst),
 .mode(mode),
 .cand1_vote_valid(valid_vote_1),
 .cand2_vote_valid(valid_vote_2),
 .cand3_vote_valid(valid_vote_3), 
 .cand4_vote_valid(valid_vote_4),
 .cand1_vote_recvd(cand1_vote_recvd),
 .cand2_vote_recvd(cand2_vote_recvd),
 .cand3_vote_recvd(cand3_vote_recvd),
 .cand4_vote_recvd(cand4_vote_recvd)
 );
 modeControl mc(
 .clk(clk),
 .rst(rst),
 .mode(mode),
 .valid_vote_casted(anyvalidvote),
 .candidate1_vote(cand1_vote_recvd),
 .candidate2_vote(cand2_vote_recvd),
 .candidate3_vote(cand3_vote_recvd),
 .candidate4_vote(cand4_vote_recvd),
 .candidate1_button_press(valid_vote_1),
 .candidate2_button_press(valid_vote_2),
 .candidate3_button_press(valid_vote_3),
 .candidate4_button_press(valid_vote_4),
 .leds(led)
 );
 
endmodule



