//		PIPELINE REGISTER BETWEEN INSTRUCTION FETCH AND INSTRUCTION DECODE STAGE
//
//					OR
//
//			INSTRUCTION REGISTER MODULE


module 		IF_ID_register 		(

						input 		[31:0] 	instruction 		,
						input 			clk 			,
						input 			rst 			,

						output 	reg 	[31:0]	IF_ID_instruction
	
					) 							;


always@(posedge clk or posedge rst)
begin

if(rst)
IF_ID_instruction 	<= 	32'd0 			;

else
IF_ID_instruction 	<= 	instruction 		;

end

endmodule
