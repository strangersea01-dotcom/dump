//					PROGRAM COUNTER (PC) MODULE 


module 		program_counter 	(

						input 			clk 		,
						input 			rst 		,
						input 		[9:0] 	pc_in 		,

						output 	reg 	[9:0] 	pc_out 

					) 						;


always@(posedge clk or posedge rst)
begin

if(rst)
pc_out 		<= 	10'd0		;

else
pc_out 		<= 	pc_in 		;

end


endmodule
