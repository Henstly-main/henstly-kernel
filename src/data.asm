; data.asm
;input
help_command: db "help",0
shutdown_command: db "shutdown",0

; output
prompt: db ">", 0
help_desc: db "There's nothing, soon...", 0x0d, 0xa, 0
wrong_command_print: db "Wrong command...", 0x0d, 0xa, 0
greet_print: db "Henstly OS version 0.0.1.", 0x0d, 0xa, "Type 'help' for more information", 0x0d, 0xa, 0xa, 0
shutdown_print: db 0x0d, 0xa, "Shutting down...", 0x0d, 0xa, 0


size: db 0
