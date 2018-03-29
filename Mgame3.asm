.model tiny

org 100h

.data
arrayPos dw -992, -1058, -1586, -810, -578, -746, -1368, -960, -664, -928, -840, -138, -330, -1692, -354, -798, -1434, -710                                                                                                                                                    
tempPos dw 0
arrayChar dw 48, 49, 50, 51, 52, 53, 54, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34;18
pt dw 0
printX  db 0
printY  db 0
count db 1
char db 50 
countLine db 0
colorLine db 0Fh
lifePoint db 9
gameSpeed dw 65000                  ;easy 65000 normal 45000 hard 20000
                                                                          
.code

; =====================================================
;                         SETUP
; =====================================================                 
setup:
    ;set text mode 80 x 25
    mov ax ,@data
    mov ds ,ax
    mov ah ,00h         
    mov al ,03h
    int 10h
    
    ;hide cursor
    mov ch, 32
    mov ah, 1       
    int 10h

                                                                        
; =====================================================
;                   GAMEING LOGIC
; =====================================================    
setZeroPt:
    ; set zero 
    mov pt,00h
    mov si,00h
    mov count,1
    jmp waitInput
    
waitInput:
    ;delay and wait for keyboard input
    mov CX,20000           ;set loop time
    waitInputLoop:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    mov ah,01h              ;check keyboard buffer
    int 16h
    ;jnz checkInput                    ;if keyboard availibe then checkInput
    loop waitInputLoop 

main:
    ;main controll
    call printLife          
    cmp count,18            ;if it is last element of array then set next loop with first element
    je  setZeroPt            ;set pointer to Zero
    mov bx,0
    cmp [arrayPos+si],bx      ;if y < 0 then inc Y not print
    jl addY                 ;add y
    call printLine          ;printLine
    mov bx,5600
    cmp [arrayPos+si],bx      ;if y >= 35*160 then set line to Top line
    jge setTop
    mov bx,4000
    cmp [arrayPos+si],bx      ;if y >= 25*160 lost LP
    jge lostLifePoint  
    jmp addY
    
    
    ;mainLoop:
     ;   call printLife 
     ;  call printLine
     ;  
     ;  loop mainLoop
     ;  
     ;  jmp setZeroPt
     ;
addY:
    mov bx,160
    add [arrayPos+si],bx        ;y++
    inc count
    add si,2                    ;next cell in arrayPos
    jmp main    
    
setTop:
    mov bx,5600
    sub [arrayPos+si],bx ;set New Y -35*160
    ;call randomX      ;set Random X
    jmp addY

lostLifePoint:
    mov bx,4160
    cmp [arrayPos+si],bx        ;check range y 4000-4160
    jge addY 
    push si
    dec lifePoint
    ;call soundFail
    pop si
    cmp lifePoint,0
    je bye
    jmp addY
    
printLife:
    mov ax,0b800h
    mov es,ax
    mov di,156*2
    mov ah,4Eh
    mov al,lifePoint
    add al,48
    stosw
    ret     
    
    
    
printAll:
    push cx
    mov si,0
    mov cx,18 
    printAllLoop:
    call getRandomChar 
    call printLine 
    mov bx,160
    add [arrayPos+si],bx
    add si,2
    loop printAllLoop 
    pop cx
    ret

bye:
    jmp bye2    
     
getRandomChar:
    push cx
    push si    
    ;get time sec->dh
    mov ah,2ch
    int 21h

    ;time + char % 93 +33 
    add char,dh     ;time + char
    mov dx, 0       ;mod
    mov al,char     ;mod
    mov bx,26       ;mod
    div bx          ;char % 93
    mov char, dl    ;char = mod
    add char,97    ;char + 33
    pop si
    pop cx
    ret
    
printLine:
    push cx
    push si

    mov ax,0b800h
    mov es,ax
    mov di,[arrayPos+si]
    ;mov ax,[arrayChar+si]
    mov ah,0Fh
    mov al,char
    stosw
    mov ah,0Ah
    sub di,162
    stosw
    sub di,162
    stosw
    sub di,162
    stosw
    sub di,162
    stosw
    sub di,162
    stosw
    sub di,162
    stosw     
    sub di,162
    stosw
    mov ah,02h 
    sub di,162
    stosw 
    sub di,162
    stosw
    sub di,162
    stosw
    mov ah,00h
    sub di,162
    stosw
    
    pop si
    pop cx 
    ret
    
bye2:
    ;call clearScreen
    ;call soundLost 
    end setup 

