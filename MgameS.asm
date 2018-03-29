.model tiny

org 100h

.data      
arrayX db 58, 0, 15, 32, 68, 24, 57, 60, 21, 31, 46, 79, 43, 76, 7, 18, 37, 28 ;18
arrayY db 0,-2,-4,-6,-8,-10,-12,-14,-16,-18,-20,-22,-24,-26,-28,-30,-32,-34 ;18\
arraySaveY db 0,-2,-4,-6,-8,-10,-12,-14,-16,-18,-20,-22,-24,-26,-28,-30,-32,-34 ;18
arrayChar db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;18
pos dw 0
pt dw 0
printX  db 0
printY  db 0
count db 1
char db 50 
countLine db 0
colorLine db 0Fh
lifePoint db 9
gameSpeed dw 20000                  ;easy 65000 normal 45000 hard 20000

;menu

menu1   db "                    ========================================                    "
        db "                    =              METRIX GAME             =                    "
        db "                    =                                      =                    "
        db "                    =             Select  level            =                    "
        db "                    =             1) Easy                  =                    "
        db "                    =             2) Normal                =                    "
        db "                    =             3) Hard                  =                    "
        db "                    =             4) GOD                   =                    "
        db "                    ========================================                    "
                              
byemenu1    db "                    ========================================                    "
            db "                    =               GAME OVER              =                    "
            db "                    =                                      =                    "
            db "                    =      press any key to play agein     =                    "
            db "                    =                                      =                    "
            db "                    =           press ESC to exit          =                    "
            db "                    =                                      =                    "
            db "                    ========================================                    "

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
    
    mov si,0
    mov lifePoint,9
    mov pos,0
    mov count,1
    mov pt,0
    
    mov cx,18
    setupLoop:
        mov al,[arraySaveY+si]
        mov [arrayY+si],al
        mov [arrayChar+si],1
        inc si 
        loop setupLoop   
; =====================================================
;                         MENU
; ===================================================== 

menu:
    ;setup menu
    mov di,160*8
    mov ax,0b800h
    mov es,ax
    mov si,offset menu1
    mov cx,9*80
printMenu:
    mov ah,0Ah
    mov al,[si]         ;print 1 char
    stosw
    inc si              ;next char
    loop printMenu
    
    menuInput:
    call soundMenu
    mov ah,7
    int 21h         ; wait for in put
    cmp al,49       ;set level
    je setLevel1
    cmp al,50        
    je setLevel2
    cmp al,51        
    je setLevel3
    cmp al,52       
    je setLevel4
    jmp menuInput

setLevel1:
    mov gameSpeed,0FFFFh
    call clearScreen
    jmp goMain

setLevel2:
    mov gameSpeed,45000
    call clearScreen
    jmp goMain

setLevel3:
    mov gameSpeed,20000
    call clearScreen
    jmp goMain

setLevel4:
    mov gameSpeed,2000
    call clearScreen
    jmp goMain
    
clearScreen:
    mov cx,80*25
    mov ax,0b800h
    mov es,ax
    mov di,0
    mov ah,00h
    mov al,' '
    rep stosw
    ret
    
byeMenu:
    mov di,160*8
    mov ax,0b800h
    mov es,ax
    mov si,offset byemenu1
    mov cx,8*80
    byeMenuLoop:
        mov ah,0Ah
        mov al,[si]         ;print 1 char
        stosw
        inc si              ;next char
        loop byeMenuLoop
    ret
        
    
; =====================================================
;                       SOUND
; ===================================================== 

; ================== key and delay ====================
    
soundCh:
    mov si,9121
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret

soundC:
    mov si,4560
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret

soundCs:
    mov si,4304
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundD:
    mov si,4063
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundDs:
    mov si,3834
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundE:
    mov si,3619
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundF:
    mov si,3416
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundFs:
    mov si,3224
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundG:
    mov si,3043
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundGs:
    mov si,2873
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundA:
    mov si,2711
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundAs:
    mov si,2559
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundB:
    mov si,2415
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret

;low

soundcl:
    mov si,2280
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret

    soundcls:
    mov si,2152
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
    sounddl:
    mov si,2031
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
    sounddls:
    mov si,1917
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
    soundel:
    mov si,1809
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
    soundfl:
    mov si,1715
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
    soundfls:
    mov si,1612
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundgl:
    mov si,1521
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
soundgls:
    mov si,1436
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
    soundal:
    mov si,1355
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
    soundals:
    mov si,1292
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
    soundbl:
    mov si,1207
    mov cx,0FFFFh
    call noteon
    call loopx
    call noteoff
    ret
    
loop5:              
    mov ah,86h
    mov cx,4h       ;high bit
    mov dx,0h       ;low bit
    int 15h         ;Delay sound time
    ret
    
loop2:              
    mov ah,86h
    mov cx,1h       ;high bit
    mov dx,0h       ;low bit
    int 15h         ;Delay sound time
    ret

loop3:              
    mov ah,86h
    mov cx,2h       ;high bit
    mov dx,0h       ;low bit
    int 15h         ;Delay sound time
    ret

loop4:              
    mov ah,86h
    mov cx,3h       ;high bit
    mov dx,0h       ;low bit
    int 15h         ;Delay sound time
    ret  

loop6:              
    mov ah,86h
    mov cx,5h       ;high bit
    mov dx,0h       ;low bit
    int 15h         ;Delay sound time
    ret   
    
loop7:              
    mov ah,86h
    mov cx,06h       ;high bit
    mov dx,0h       ;low bit
    int 15h         ;Delay sound time
    ret 
loop8:              
    mov ah,86h
    mov cx,7h       ;high bit
    mov dx,0h       ;low bit
    int 15h         ;Delay sound time
    ret
loopx:              
    mov ah,86h
    mov cx,02h       ;high bit
    mov dx,0h       ;low bit
    int 15h         ;Delay sound time
    ret    
    
soundBeep:
    push cx
    mov si,2280
    call noteon
    mov cx,30000
    call soundDelay
    call noteoff
    pop cx
    ret

soundMiss:
    push cx
    mov si,6833
    call noteon
    mov cx,0FFFFh
    call soundDelay
    call noteoff
    pop cx
    ret

soundFail:
    push cx
    mov si,4560
    call noteon
    mov cx,0FFFFh
    call soundDelay
    call noteoff
    pop cx
    ret
    
soundLost:
    push ax
    push bx
    push cx
    push dx
    push si
    call soundD
    call loop4
    call soundD
    call loop4
    call soundD
    call loop4
    call soundC
    call loop4
    call soundE
    call loop4
    call soundD
    call loop4
    call soundC
    call loop6
    call soundal
    call loop4
    call soundal
    call loop4
    call soundal
    call loop4
    call soundgl
    call loop4
    call soundfl
    call loop4
    call soundgl
    call loop4
    call soundal
    call loop8
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

soundMenu:
    push ax
    push bx
    push cx
    push dx
    push si
    call sounde
    call loop2
    call sounde
    call loop2
    call sounde 
    call loop3
    call soundc
    call loop2
    call sounde 
    call loop3
    call soundg 
    call loop6
    call soundgl   
    call loop5
    call soundgl   
    call loop5
    call sounde
    call loop2
    call sounde
    call loop2
    call sounde
    call loop2
    call sounde 
    call loop3
    call soundc
    call loop2
    call sounde 
    call loop3
    call soundg 
    call loop6
    call soundgl   
    call loop5
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    
soundStart:
    push cx
    mov si,3619
    call noteon
    mov cx,30000
    call soundDelay
    call noteoff
    pop cx
    ret
       
soundDelay:
    nop
    loop soundDelay
    ret

goMain:
    call soundStart
    call clearScreen
    jmp main
    
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
    mov CX,gameSpeed            ;set loop time
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
    jnz checkInput                    ;if keyboard availibe then checkInput
    loop waitInputLoop 

main:    
    ;main controll
    call printLife          
    cmp count,18            ;if it is last element of array then set next loop with first element
    je  setZeroPt            ;set pointer to Zero
    cmp [arrayY+si],0       ;if y < 0 then inc Y not print
    jl addY                 ;add y
    call printLine          ;printLine
    cmp [arrayY+si],35      ;if y = 35 then set line to Top line
    je setTop
    cmp [arrayY+si],25      ;if y = 25 lost LP
    je lostLifePoint  
    jmp addY
    
addY:
    inc [arrayY+si] ;y++    
    inc count       ;count++
    inc pt         ;next array
    mov si,pt
    jmp main

setTop:
    mov [arrayY+si],0 ;set New Y
    ;call randomX      ;set Random X
    jmp addY

lostLifePoint:
    push si
    dec lifePoint
    call soundFail
    pop si
    cmp lifePoint,0
    je bye
    jmp addY

checkInput:
    push cx
    mov pt,0
    mov si,0
    mov ah,00h    
    int 16h                         ;get input -> al
    cmp al,27                       ;check ESC
    je bye                          
    checkInputLoop:
        cmp [arrayChar+si],al       ;compare input with head line in arrayChar
        je delLine                      ;if correct delete that line
        inc pt
        mov si,pt
        cmp pt,18                   ;next cell
        jl checkInputLoop
        call soundMiss                  ;sound miss
    mov pt,00h
    mov si,00h
    mov count,1
    pop cx
    jmp waitInputLoop
    
bye:
    jmp bye2
  
delLine:
    push cx
    dec [arrayY+si]                 ;Y is +1 than current head print
    call setCurserPosition
    mov ax,0b800h
    mov es,ax
    mov di,pos
    mov ah,00h
    mov al,' '
    mov cx,11
    delLineLoop:
        stosw
        sub di,162   
        loop delLineLoop
    mov [arrayChar+si],1            ;clear char
    mov [arrayY+si],-1    
    call soundBeep
    mov pt,00h
    mov si,00h
    mov count,1
    pop cx
    jmp waitInput



    
printLife:
    mov ax,0b800h
    mov es,ax
    mov di,156*2
    mov ah,4Eh
    mov al,lifePoint
    add al,48
    stosw
    ret     
    
printLine:
    cmp [arrayChar+si],1
    je getRandomChar
    ;call getRandomChar            ;random character
    call setCurserPosition        ;set new curser x,y
    call print                    ;print 1 line 
    ret  
    
getRandomChar:
    ;get time sec->dh
    mov ah,2ch
    int 21h

    ;time + char % 93 +33 
    add dh,char                ;time + oldChar
    add [arrayChar+si],dh     ;char +(time + oldchar)
    mov dx, 0       ;mod
    mov al,[arrayChar+si]     ;mod
    mov bx,26       ;mod
    div bx          ;char % 93
    mov [arrayChar+si], dl    ;char = mod
    mov char,dl
    add [arrayChar+si],97    ;char + 33
    jmp printLine
    
setCurserPosition:
    mov pos,0
    mov al,2
    mul [arrayX+si]   ;x*2 -> ah al
    mov pos,ax
    
    mov ax,160
    mul [arrayY+si]     ;y*160 -> dx ax
    add pos,ax
    ret       
                   
print:
    mov ax,0b800h
    mov es,ax
    mov di,pos
    mov ah,0Fh
    mov al,[arrayChar+si]
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
    ret

    

    
    
    
bye2:
    call clearScreen
    call byeMenu
    call soundLost
    mov ah,7
    int 21h         ; wait for in put
    cmp al,27       ;set level
    je exitBye
    call setup
    exitBye:
    call clearScreen
    end setup 

