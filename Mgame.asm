.model tiny

org 100h

.data      
arrayX db 58, 0, 15, 32, 68, 24, 57, 60, 21, 31, 46, 79, 43, 76, 7, 18, 37, 28 ;18
arrayY db 0,-2,-4,-6,-8,-10,-12,-14,-16,-18,-20,-22,-24,-26,-28,-30,-32,-34 ;18
arraySaveY db 0,-2,-4,-6,-8,-10,-12,-14,-16,-18,-20,-22,-24,-26,-28,-30,-32,-34 ;18
arrayChar db 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34;18
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

menu1   db 10
        db 10
        db 10
        db 10
        db 10
        db 10
        db 10
        db "                    ========================================"
        db 10
        db 13
        db "                    =              METRIX GAME             ="
        db 10
        db 13
        db "                    =                                      ="
        db 10
        db 13
        db "                    =             Select  level            ="
        db 10
        db 13
        db "                    =             1) Easy                  ="
        db 10
        db 13
        db "                    =             2) Normal                ="
        db 10
        db 13
        db "                    =             3) Hard                  ="
        db 10
        db 13
        db "                    =             4) ???                   ="
        db 10
        db 13
        db "                    ========================================"
        db "$"
                              


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
;                         MENU
; ===================================================== 

menu:

    mov dx, offset menu1
    mov ah, 9
    int 21h
    menuInput:
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
    jmp goMain

setLevel2:
    mov gameSpeed,45000
    jmp goMain

setLevel3:
    mov gameSpeed,20000
    jmp goMain

setLevel4:
    mov gameSpeed,0FFFFh
    jmp goMain
    
printNewline:
    mov dh,2
    mov al,10
    int 21h

    mov al,13
    int 21h
    ret
; =====================================================
;                       SOUND
; ===================================================== 

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
    push cx
    mov si,3619
    call noteon
    mov cx,30000
    call soundDelay
    call noteoff
    pop cx
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
    mov ah,0
    int 10h
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
        cmp pt,18
        jl checkInputLoop
    call soundMiss
    mov pt,00h
    mov si,00h
    mov count,1
    pop cx
    jmp waitInputLoop

delLine:
    push cx
    dec [arrayY+si]                 ;Y is +1 than current head print
    mov cx,11                       ;set loop print blank
    mov bl,00h
    delLineLoop:
        push cx
        call setCurserPosition
        call print
        dec [arrayY+si]
        pop cx
        loop delLineLoop
    
    mov dl,[arraySaveY+si]
    mov [arrayY+si],dl              ;set Line to first Y
    mov [arrayChar+si],1            ;clear char
    
    call soundBeep
    mov pt,00h
    mov si,00h
    mov count,1
    pop cx
    jmp waitInputLoop

bye:
    jmp bye2

    
printLife:
    mov dh, 1      ;set row (y)
    mov dl, 78     ;set col (x)
    mov bh, 00h
    mov ah, 02h
    int 10h         ;set curser
    
    mov ah,9
    mov bh,0
    mov bl,0eh
    mov cx,1
    mov al,lifePoint      ;print LP
    add al,48
    int 10h         ;print
    ret     
    
printLine:
    call getRandomChar            ;random character
    call setCurserPosition        ;set new curser x,y
    mov  bl,colorLine             ;set color
    call print                    ;print 1 char 
    dec  [arrayY+si]              ;y--
    cmp  countLine,0
    je   head
    inc  countLine                ; conunt line for change color
    cmp  countLine,1
    je   changeColorLIGHTGREEN
    cmp  countLine,8
    je   changeColorGREEN
    cmp  countLine,11
    je   changeColorBLACK
    cmp  countLine,12
    je   changeColorWHITE
    jmp printLine  

   
head:
    inc countLine               ;0 -> 1
    mov dl,char
    mov [arrayChar+si],dl
    
changeColorLIGHTGREEN:
    mov colorLine,0Ah
    jmp printLine

changeColorGREEN:
    mov colorLine,02h
    jmp printLine
    
changeColorBLACK:
    mov colorLine,00h
    jmp printLine
    
changeColorWHITE:
    mov colorLine,0Fh
    mov countLine,0
    add [arrayY+si],12
    ret        ;exit printLine
    
getRandomChar:
        
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
    ret    
    
setCurserPosition:
    
    mov dh, [arrayY + si]      ;set row (y)
    mov dl, [arrayX + si]     ;set col (x)
    mov bh, 00h
    mov ah, 02h
    int 10h
    ret       
                   
print:
    mov ah,9
    mov bh,0
    mov cx,1
    mov al,char         ;print char
    int 10h 
    ret

bye2:
    call soundLost 
    end setup 

