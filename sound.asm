;https://www.youtube.com/watch?v=NdztXxqMqV8


.model tiny
org 100h
.data
.code


start:

    mov ah,00h
    int 16h
    ;call getfreq
    mov si,6833
    mov cx,65000
    call noteon     ;turn ON speaker
    ;mov ah,86h
    ;mov cx,1h       ;high bit
    ;mov dx,0h       ;low bit
    ;int 15h         ;sound time
    loop1:
    nop
    loop loop1
    call noteoff    ;turn OFF speaker
    jmp start


noteon:
    mov ax,si       ;ax set freq sound
    
    out 42h,al
    mov al,ah
    out 42h,al
    
    ;mov al,61h
    mov al,11b
    out 61h,al
    ret
    
noteoff:
    mov al,61h
    out 61h,al
    ret
    
    
end start