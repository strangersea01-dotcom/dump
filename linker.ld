/*OUTPUT_ARCH("riscv")
ENTRY(_start)

MEMORY
{
  RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 264K
}

SECTIONS
{
  . = ORIGIN(RAM);

  .text : {
      *(.text.start)
      *(.text*)
  } > RAM

  .rodata : {
      *(.rodata*)
  } > RAM

  .data : {
      *(.data*)
  } > RAM


  . =ALIGN(8);

  .tohost 0x80001000 : {
        *(.tohost)
    } > RAM

  .bss : {
      *(.bss*)
      *(COMMON)
  } > RAM

  . = ALIGN(4);

  _stack_top = ORIGIN(RAM) + LENGTH(RAM);
  S
    */


OUTPUT_ARCH( "riscv" )
ENTRY(_start)

SECTIONS
{
  . = 0x80000000;
  .text : { *(.text) }
  . = ALIGN(0x1000);
  .tohost : { *(.tohost) }
  . = ALIGN(0x1000);
  .page_table : { *(.page_table) }
  .data : { *(.data) }
  .user_stack : { *(.user_stack) }
  .kernel_data : { *(.kernel_data) }
  .kernel_stack : { *(.kernel_stack) }
  .bss : { *(.bss) }
  _end = .; 
}
