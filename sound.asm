;https://www.youtube.com/watch?v=NdztXxqMqV8
;D 8126
;C 9121
;E 7239

.model tiny
org 100h
.data
.code


start:

    mov ah,00h
    int 16h
    ;call getfreq
    ;mov si,6833
    ;mov cx,0FFFFh
    ;call noteon     ;turn ON speaker
    ;mov ah,86h
    ;mov cx,1h       ;high bit
    ;mov dx,0h       ;low bit
    ;int 15h         ;sound time
    ;call loop1
    ;call noteoff    ;turn OFF speaker
    
    call soundD
    call loop1
    ;call soundD
    ;call loop1
    ;call soundD
    ;call loop1
    ;call soundC
    ;call loop1
    ;call soundE
    ;call loop1
    ;call soundD
    ;call loop1
    ;call soundC
    
    jmp start

loop1:
    mov ah,86h
    mov cx,3h       ;high bit
    mov dx,0h       ;low bit
    int 15h         ;Delay sound time
    ret
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

soundC:
    mov si,9121
    mov cx,0FFFFh
    call noteon
    call loop1
    call noteoff
    ret
    
soundD:
    mov si,8126
    mov cx,0FFFFh
    call noteon
    call loop1
    call noteoff
    ret    

soundE:
    mov si,7239
    mov cx,0FFFFh
    call noteon
    call loop1
    call noteoff
    ret
    
end start