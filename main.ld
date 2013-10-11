ENTRY(main)
MEMORY
{
  FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 128K
  RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 20K

}

SECTIONS
{
	.text :
	{
		KEEP(*(.isr_vector))
 		*(.text)
 		*(.text.*)
		*(.rodata)
		_sidata = .;
	} >FLASH

	/* Initialized data will initially be loaded in FLASH at the end of the .text section. */
	.data : AT (_sidata) 
    	{
		_sdata = .;
		*(.data)		/* Initialized data */
		_edata = .;
	} >RAM

	.bss : {
		_sbss = .;
		*(.bss)         /* Zero-filled run time allocate data memory */
		_ebss = .;
		. = ALIGN(4);
		_end = .;
	} >RAM

	_estack = ORIGIN(RAM) + LENGTH(RAM);

	PROVIDE(_HEAP = _end);
	PROVIDE( _EHEAP = ALIGN(ORIGIN(RAM) + LENGTH(RAM) -4,4));

 }  
