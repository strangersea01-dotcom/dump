//					INSTRUCTION MEMORY OF BYTE 2


module 		instruction_mem_B2		(

							input 		clk 				,	//	CLOCK
							input 		rst				,	//	RESET
							input 		write_en_B2 			,	//	WRITE ENABLE
							input 	[7:0] 	data_in_B2 			,	//	DATA IN FOR INSTRUCTION MEMORY
							input 	[7:0] 	write_address_B2 		,	//	WRITE ADDRESS  
							input 	[7:0] 	read_address_B2 		,	//	READ ADDRESS
							output 	[7:0] 	instruction_mem_out_B2 			//	DATA OUT OF INSTRUCTION MEMORY

						) 							;



//			USED .HEX FILE TO HAVE INITIAL VALUE IN MEMORY SO HELP IN VERIFICATION 

initial begin
$readmemh("instruction_mem_B2.hex" ,instruction_memory_B2)				;
end


integer 	i 								;


//		ACTUAL MEMORY

reg 	[7:0] 	instruction_memory_B2 	[0:255] 				;



//		WRITE LOGIC

always@(posedge clk or posedge rst)
begin


//		WHEN RESET IS LOGIC 1 RESET ALL MEMORY TO ZERO

if(rst)
begin
for(i=0; i<256 ; i= i+1 )
instruction_memory_B2[i] 		<= 		8'd0 				;
end


//		WHEN WRITE ENABLE IS LOGIC 1

else if(write_en_B2)
instruction_memory_B2[write_address_B2] 	<=	data_in_B2 				;

end



//				READ LOGIC

assign  	instruction_mem_out_B2 	= 	instruction_memory_B2[read_address_B2] 	;


endmodule
