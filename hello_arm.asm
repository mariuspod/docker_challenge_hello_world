format ELF executable 
        entry start 
        segment readable executable 

start:  add     r1,pc,hello-$-8  ; the string
        mov     r2,hello_len     ; the length of the string
        mov     r7,4             ; write
        swi     0                ; invoke
        mov     r7,1             ; exit
        mov     r0,0             ; set exit_code
        swi     0                ; invoke

hello:  db      'Hello Docker World!', 0x0A, 20
hello_len=$-hello 

        segment writeable
