//			PIPELINE REGISTER BETWEEN INSTRUCTION_DECODE AND MEMORY_READ STAGE


module 		ID_MR_register 		(
			
						input 			clk 				,
						input 			rst 				,
						input 			sel_data_for_mem 		,
						input 			write_reg_en 			,
						input 			write_mem_en_amo 		,
						input			write_mem_en_store 		,
						input 		[2:0] 	alu_op 				,
						input 		[4:0] 	rd_address 			,
						input 			set_reservation 		,
						input 		[31:0] 	data_from_rs1 			,
						input 		[31:0]	data_from_rs2_address 		,

						output 	reg 		ID_MR_sel_data_for_mem 		,
						output 	reg 		ID_MR_write_reg_en 		,
						output 	reg 		ID_MR_write_mem_en_amo 		,
						output 	reg 		ID_MR_write_mem_en_store 	,
						output 	reg 	[2:0] 	ID_MR_alu_op 			,
						output 	reg 	[4:0] 	ID_MR_rd_address 		,
						output 	reg 		ID_MR_set_reservation 		,
						output 	reg 	[31:0] 	ID_MR_data_from_rs1 		,
						output 	reg 	[31:0] 	ID_MR_data_from_rs2 

					) 								;


always@(posedge clk or posedge rst)
begin

if(rst)
begin

ID_MR_sel_data_for_mem 		<= 	1'd0 			;
ID_MR_write_reg_en 		<= 	1'd0 			;
ID_MR_write_mem_en_amo 		<= 	1'd0 			;
ID_MR_write_mem_en_store 	<= 	1'd0 			;
ID_MR_alu_op 			<= 	3'd0 			;
ID_MR_rd_address 		<=	5'd0 			;
ID_MR_set_reservation 		<= 	1'd0 			;
ID_MR_data_from_rs1 		<= 	32'd0 			;
ID_MR_data_from_rs2 		<= 	32'd0 			;

end


else
begin

ID_MR_sel_data_for_mem		<= 	sel_data_for_mem 	;
ID_MR_write_reg_en 		<= 	write_reg_en 		;
ID_MR_write_mem_en_amo 		<= 	write_mem_en_amo 	;
ID_MR_write_mem_en_store 	<= 	write_mem_en_store 	;
ID_MR_alu_op 			<= 	alu_op 			;
ID_MR_rd_address 		<= 	rd_address 		;
ID_MR_set_reservation 		<= 	set_reservation 	;
ID_MR_data_from_rs1 		<= 	data_from_rs1 		;
ID_MR_data_from_rs2 		<= 	data_from_rs2_address 		;

end

end


endmodule
