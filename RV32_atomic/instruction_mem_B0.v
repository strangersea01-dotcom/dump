//					INSTRUCTION MEMORY OF BYTE 0


module 		instruction_mem_B0		(

							input 		clk 				,	//	CLOCK
							input 		rst				,	//	RESET
							input 		write_en_B0 			,	//	WRITE ENABLE
							input 	[7:0] 	data_in_B0 			,	//	DATA IN FOR INSTRUCTION MEMORY
							input 	[7:0] 	write_address_B0 		,	//	WRITE ADDRESS  
							input 	[7:0] 	read_address_B0 		,	//	READ ADDRESS
							output 	[7:0] 	instruction_mem_out_B0 			//	DATA OUT OF INSTRUCTION MEMORY

						) 							;



//			USED .HEX FILE TO HAVE INITIAL VALUE IN MEMORY SO HELP IN VERIFICATION 

initial begin
$readmemh("instruction_mem_B0.hex" ,instruction_memory_B0)				;
end


integer 	i 								;


//		ACTUAL MEMORY

reg 	[7:0] 	instruction_memory_B0 	[0:255] 				;



//		WRITE LOGIC

always@(posedge clk or posedge rst)
begin


//		WHEN RESET IS LOGIC 1 RESET ALL MEMORY TO ZERO

if(rst)
begin
for(i=0; i<256 ; i= i+1 )
instruction_memory_B0[i] 		<= 		8'd0 				;
end


//		WHEN WRITE ENABLE IS LOGIC 1

else if(write_en_B0)
instruction_memory_B0[write_address_B0] 	<=	data_in_B0 				;

end



//				READ LOGIC

assign  	instruction_mem_out_B0 	= 	instruction_memory_B0[read_address_B0] 	;


endmodule
