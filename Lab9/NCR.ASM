.model small
.data
n db 05h
r db 02h
ncrval dw 01h dup(?)
.code
start:mov ax, @data
        mov ds,ax
        mov cl,r
        mov ch,n
        xor ax,ax
        call ncr
        mov [ncrval], ax
        mov ah, 4ch
        int 21h
ncr proc near
        cmp ch,cl
        je equal
        jc finish
        cmp cl,01h
        je next
        cmp cl,00h
        je equal
        dec ch
        push cx
        call ncr
        pop cx
        dec cl
        call ncr
        ret
next : xor bx,bx
        mov bl,ch
        add ax,bx
ret
equal : add  ax, 01h
finish : ret
ncr endp

end start
