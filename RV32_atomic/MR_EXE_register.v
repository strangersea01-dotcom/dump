// 				PIPELINE REGISTER BETWEEN MEMORY_READ STAGE AND EXECUTE STAGE


module 		MR_EXE_register 		(

							input 			clk 				,
							input 			rst 				,
							
							input 			ID_MR_sel_data_for_mem 		,
							input 			ID_MR_write_reg_en 		,
							input 			ID_MR_write_mem_en_amo 		,
							input 			ID_MR_write_mem_en_store 	,
							input 		[2:0] 	ID_MR_alu_op 			,
							input 		[4:0] 	ID_MR_rd_address 		,
							input 		[31:0] 	ID_MR_data_from_rs1 		,
							input 		[31:0] 	ID_MR_data_from_rs2 		,
							input 		[31:0] 	memory_out 			,

							output 	reg		MR_EXE_sel_data_for_mem 	,
							output 	reg 		MR_EXE_write_reg_en 		,
							output 	reg 		MR_EXE_write_mem_en_amo 	,
							output 	reg 		MR_EXE_write_mem_en_store 	,
							output 	reg 	[2:0] 	MR_EXE_alu_op 			,
							output 	reg 	[4:0] 	MR_EXE_rd_address 		,
							output 	reg 	[31:0] 	MR_EXE_data_from_rs1 		,
							output 	reg 	[31:0] 	MR_EXE_data_from_rs2 		,
							output 	reg 	[31:0] 	MR_EXE_mem_out 

						) 								;


always@(posedge clk or posedge rst)
begin

if(rst)
begin

MR_EXE_sel_data_for_mem 	<= 	1'd0 				;
MR_EXE_write_reg_en 		<= 	1'd0 				;
MR_EXE_write_mem_en_amo 	<= 	1'd0 				;
MR_EXE_write_mem_en_store 	<= 	1'd0 				;
MR_EXE_alu_op 			<= 	3'd0 				;
MR_EXE_rd_address 		<= 	5'd0 				;
MR_EXE_data_from_rs1 		<= 	32'd0 				;
MR_EXE_data_from_rs2 		<= 	32'd0 				;
MR_EXE_mem_out 			<= 	32'd0 				;

end

else
begin

MR_EXE_sel_data_for_mem 	<= 	ID_MR_sel_data_for_mem 		;
MR_EXE_write_reg_en 		<= 	ID_MR_write_reg_en 		;
MR_EXE_write_mem_en_amo 	<= 	ID_MR_write_mem_en_amo 		;
MR_EXE_write_mem_en_store 	<= 	ID_MR_write_mem_en_store 	;
MR_EXE_alu_op 			<= 	ID_MR_alu_op  			;
MR_EXE_rd_address 		<= 	ID_MR_rd_address		;
MR_EXE_data_from_rs1 		<= 	ID_MR_data_from_rs1 		;
MR_EXE_data_from_rs2 		<= 	ID_MR_data_from_rs2  		;
MR_EXE_mem_out 			<= 	memory_out 			;

end

end


endmodule
