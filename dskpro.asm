.model small
.stack 100h

.data
judul db 13,10,'=== DSKPRO : TRACKER PRODUKTIVITAS ===',13,10,'$'

l1 db 13,10,'Kerja        : $'
l2 db 13,10,'Belajar      : $'
l3 db 13,10,'Kuliah       : $'
l4 db 13,10,'Olahraga     : $'
l5 db 13,10,'Tidur        : $'
l6 db 13,10,'Main         : $'
l7 db 13,10,'Menonton     : $'
l8 db 13,10,'Berbincang   : $'

h1 db 13,10,'Total Jam Produktif       : $'
h2 db 13,10,'Total Jam Tidak Produktif : $'
h3 db 13,10,'Total Jam Aktivitas       : $'

tingkat1 db 13,10,'Tingkat Produktivitas : TIDAK PRODUKTIF$'
tingkat2 db 13,10,'Tingkat Produktivitas : CUKUP PRODUKTIF$'
tingkat3 db 13,10,'Tingkat Produktivitas : PRODUKTIF$'

prod  db 0
nonp  db 0
total db 0

.code
main:
    mov ax,@data
    mov ds,ax

    mov ah,09h
    lea dx,judul
    int 21h

    ; ===== PRODUKTIF =====
    lea dx,l1
    call cetak_input_prod
    lea dx,l2
    call cetak_input_prod
    lea dx,l3
    call cetak_input_prod
    lea dx,l4
    call cetak_input_prod

    ; ===== TIDAK PRODUKTIF =====
    lea dx,l5
    call cetak_input_non
    lea dx,l6
    call cetak_input_non
    lea dx,l7
    call cetak_input_non
    lea dx,l8
    call cetak_input_non

    ; ===== HASIL =====
    mov ah,09h
    lea dx,h1
    int 21h
    mov al,prod
    call printNum

    mov ah,09h
    lea dx,h2
    int 21h
    mov al,nonp
    call printNum

    mov ah,09h
    lea dx,h3
    int 21h
    mov al,total
    call printNum

    ; ===== CEK TINGKAT PRODUKTIVITAS =====
    mov al,prod
    cmp al,nonp
    jb tampil_tidak
    je tampil_cukup
    ja tampil_prod

tampil_tidak:
    mov ah,09h
    lea dx,tingkat1
    int 21h
    jmp selesai

tampil_cukup:
    mov ah,09h
    lea dx,tingkat2
    int 21h
    jmp selesai

tampil_prod:
    mov ah,09h
    lea dx,tingkat3
    int 21h

selesai:
    mov ah,4Ch
    int 21h

; ===== CETAK LABEL + INPUT PRODUKTIF =====
cetak_input_prod proc
    mov ah,09h
    int 21h
    call getNumber
    add prod,al
    add total,al
    ret
cetak_input_prod endp

; ===== CETAK LABEL + INPUT NON PRODUKTIF =====
cetak_input_non proc
    mov ah,09h
    int 21h
    call getNumber
    add nonp,al
    add total,al
    ret
cetak_input_non endp

; ===== INPUT ANGKA 1 DIGIT =====
getNumber proc
ulang:
    mov ah,01h
    int 21h
    cmp al,13
    je ulang
    sub al,'0'
    ret
getNumber endp

; ===== CETAK ANGKA =====
printNum proc
    mov ah,0
    mov bl,10
    div bl
    cmp al,0
    je satu
    add al,'0'
    mov dl,al
    mov ah,02h
    int 21h
satu:
    mov al,ah
    add al,'0'
    mov dl,al
    mov ah,02h
    int 21h
    ret
printNum endp

end main
