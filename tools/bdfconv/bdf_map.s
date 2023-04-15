	.file	"bdf_map.c"
	.text
.Ltext0:
	.file 0 "/home/dev/Projects/bleskomat/bleskomat-bills-firmware/tools/bdfconv" "bdf_map.c"
	.local	range_from
	.comm	range_from,8,8
	.local	range_to
	.comm	range_to,8,8
	.local	is_exclude
	.comm	is_exclude,4,4
	.local	is_kern_exclude
	.comm	is_kern_exclude,4,4
	.local	map_to
	.comm	map_to,8,8
	.type	skip_space, @function
skip_space:
.LFB6:
	.file 1 "bdf_map.c"
	.loc 1 41 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
.L5:
	.loc 1 44 11
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 44 10
	movzbl	(%rax), %eax
	.loc 1 44 8
	testb	%al, %al
	je	.L6
	.loc 1 46 11
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 46 10
	movzbl	(%rax), %eax
	.loc 1 46 8
	cmpb	$32, %al
	jg	.L7
	.loc 1 48 6
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 48 9
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 44 8
	jmp	.L5
.L6:
	.loc 1 45 7
	nop
	jmp	.L8
.L7:
	.loc 1 47 7
	nop
.L8:
	.loc 1 50 1
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	skip_space, .-skip_space
	.type	get_dec, @function
get_dec:
.LFB7:
	.loc 1 53 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 54 8
	movq	$0, -8(%rbp)
.L11:
	.loc 1 57 12
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 57 11
	movzbl	(%rax), %eax
	.loc 1 57 8
	cmpb	$47, %al
	jle	.L10
	.loc 1 57 28 discriminator 1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 57 27 discriminator 1
	movzbl	(%rax), %eax
	.loc 1 57 23 discriminator 1
	cmpb	$57, %al
	jg	.L10
	.loc 1 59 8
	movq	-8(%rbp), %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, -8(%rbp)
	.loc 1 60 13
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 60 12
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	.loc 1 60 16
	subl	$48, %eax
	cltq
	.loc 1 60 8
	addq	%rax, -8(%rbp)
	.loc 1 61 8
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 61 11
	leaq	1(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 57 8
	jmp	.L11
.L10:
	.loc 1 68 3
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 69 10
	movq	-8(%rbp), %rax
	.loc 1 70 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	get_dec, .-get_dec
	.type	get_hex, @function
get_hex:
.LFB8:
	.loc 1 73 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 74 8
	movq	$0, -8(%rbp)
.L18:
	.loc 1 77 12
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 77 11
	movzbl	(%rax), %eax
	.loc 1 77 8
	cmpb	$47, %al
	jle	.L14
	.loc 1 77 28 discriminator 1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 77 27 discriminator 1
	movzbl	(%rax), %eax
	.loc 1 77 23 discriminator 1
	cmpb	$57, %al
	jg	.L14
	.loc 1 79 8
	salq	$4, -8(%rbp)
	.loc 1 80 13
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 80 12
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	.loc 1 80 16
	subl	$48, %eax
	cltq
	.loc 1 80 8
	addq	%rax, -8(%rbp)
	.loc 1 81 8
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 81 11
	leaq	1(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	jmp	.L15
.L14:
	.loc 1 83 17
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 83 16
	movzbl	(%rax), %eax
	.loc 1 83 13
	cmpb	$96, %al
	jle	.L16
	.loc 1 83 33 discriminator 1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 83 32 discriminator 1
	movzbl	(%rax), %eax
	.loc 1 83 28 discriminator 1
	cmpb	$102, %al
	jg	.L16
	.loc 1 85 8
	salq	$4, -8(%rbp)
	.loc 1 86 13
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 86 12
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	.loc 1 86 20
	subl	$87, %eax
	cltq
	.loc 1 86 8
	addq	%rax, -8(%rbp)
	.loc 1 87 8
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 87 11
	leaq	1(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	jmp	.L15
.L16:
	.loc 1 89 17
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 89 16
	movzbl	(%rax), %eax
	.loc 1 89 13
	cmpb	$64, %al
	jle	.L17
	.loc 1 89 33 discriminator 1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 89 32 discriminator 1
	movzbl	(%rax), %eax
	.loc 1 89 28 discriminator 1
	cmpb	$70, %al
	jg	.L17
	.loc 1 91 8
	salq	$4, -8(%rbp)
	.loc 1 92 13
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 92 12
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	.loc 1 92 20
	subl	$55, %eax
	cltq
	.loc 1 92 8
	addq	%rax, -8(%rbp)
	.loc 1 93 8
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 93 11
	leaq	1(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
.L15:
	.loc 1 77 8
	jmp	.L18
.L17:
	.loc 1 100 3
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 101 10
	movq	-8(%rbp), %rax
	.loc 1 102 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	get_hex, .-get_hex
	.type	get_num, @function
get_num:
.LFB9:
	.loc 1 105 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$8, %rsp
	movq	%rdi, -8(%rbp)
	.loc 1 106 10
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 106 9
	movzbl	(%rax), %eax
	.loc 1 106 6
	cmpb	$36, %al
	je	.L21
	.loc 1 107 12
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	get_dec
	jmp	.L22
.L21:
	.loc 1 108 4
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 108 7
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 109 3
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 110 10
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	get_hex
.L22:
	.loc 1 111 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	get_num, .-get_num
	.type	get_mul, @function
get_mul:
.LFB10:
	.loc 1 114 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 116 7
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	get_num
	movq	%rax, -8(%rbp)
	.loc 1 117 9
	jmp	.L24
.L25:
	.loc 1 119 6
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 119 9
	leaq	1(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 120 5
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 121 10
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	get_num
	.loc 1 121 7
	movq	-8(%rbp), %rdx
	imulq	%rdx, %rax
	movq	%rax, -8(%rbp)
.L24:
	.loc 1 117 13
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 117 12
	movzbl	(%rax), %eax
	.loc 1 117 17
	cmpb	$42, %al
	je	.L25
	.loc 1 123 10
	movq	-8(%rbp), %rax
	.loc 1 124 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	get_mul, .-get_mul
	.type	get_add, @function
get_add:
.LFB11:
	.loc 1 127 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 129 7
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	get_mul
	movq	%rax, -8(%rbp)
	.loc 1 130 9
	jmp	.L28
.L29:
	.loc 1 132 6
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 132 9
	leaq	1(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 133 5
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 134 10
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	get_mul
	.loc 1 134 7
	addq	%rax, -8(%rbp)
.L28:
	.loc 1 130 13
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 130 12
	movzbl	(%rax), %eax
	.loc 1 130 17
	cmpb	$43, %al
	je	.L29
	.loc 1 136 10
	movq	-8(%rbp), %rax
	.loc 1 137 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	get_add, .-get_add
	.type	get_addsub, @function
get_addsub:
.LFB12:
	.loc 1 140 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 143 7
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	get_mul
	movq	%rax, -8(%rbp)
	.loc 1 144 9
	jmp	.L32
.L34:
	.loc 1 146 11
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 146 10
	movzbl	(%rax), %eax
	.loc 1 146 8
	movsbl	%al, %eax
	movl	%eax, -12(%rbp)
	.loc 1 147 6
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 147 9
	leaq	1(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 148 5
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 149 8
	cmpl	$43, -12(%rbp)
	jne	.L33
	.loc 1 150 12
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	get_mul
	.loc 1 150 9
	addq	%rax, -8(%rbp)
	jmp	.L32
.L33:
	.loc 1 152 12
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	get_mul
	.loc 1 152 9
	subq	%rax, -8(%rbp)
.L32:
	.loc 1 144 13
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 144 12
	movzbl	(%rax), %eax
	.loc 1 144 24
	cmpb	$43, %al
	je	.L34
	.loc 1 144 29 discriminator 1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 144 28 discriminator 1
	movzbl	(%rax), %eax
	.loc 1 144 24 discriminator 1
	cmpb	$45, %al
	je	.L34
	.loc 1 154 10
	movq	-8(%rbp), %rax
	.loc 1 155 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	get_addsub, .-get_addsub
	.type	get_range, @function
get_range:
.LFB13:
	.loc 1 158 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$8, %rsp
	movq	%rdi, -8(%rbp)
	.loc 1 159 16
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	get_add
	.loc 1 159 14
	movq	%rax, range_from(%rip)
	.loc 1 160 9
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 160 8
	movzbl	(%rax), %eax
	.loc 1 160 6
	cmpb	$45, %al
	je	.L37
	.loc 1 162 14
	movq	range_from(%rip), %rax
	movq	%rax, range_to(%rip)
	.loc 1 170 1
	jmp	.L39
.L37:
	.loc 1 166 6
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 166 9
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 167 5
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 168 16
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	get_add
	.loc 1 168 14
	movq	%rax, range_to(%rip)
.L39:
	.loc 1 170 1
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	get_range, .-get_range
	.type	map_cmd, @function
map_cmd:
.LFB14:
	.loc 1 173 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$8, %rsp
	movq	%rdi, -8(%rbp)
	.loc 1 174 9
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 174 8
	movzbl	(%rax), %eax
	.loc 1 174 6
	cmpb	$42, %al
	jne	.L41
	.loc 1 176 16
	movq	$32, range_from(%rip)
	.loc 1 177 14
	movq	$255, range_to(%rip)
	.loc 1 178 12
	movq	$32, map_to(%rip)
	.loc 1 179 16
	movl	$0, is_exclude(%rip)
	.loc 1 180 21
	movl	$0, is_kern_exclude(%rip)
	.loc 1 182 6
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 182 9
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 183 5
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 216 1
	jmp	.L45
.L41:
	.loc 1 185 14
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 185 13
	movzbl	(%rax), %eax
	.loc 1 185 11
	cmpb	$126, %al
	jne	.L43
	.loc 1 187 16
	movl	$1, is_exclude(%rip)
	.loc 1 188 12
	movq	$0, map_to(%rip)
	.loc 1 190 6
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 190 9
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 191 5
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 192 5
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	get_range
	.loc 1 216 1
	jmp	.L45
.L43:
	.loc 1 195 14
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 195 13
	movzbl	(%rax), %eax
	.loc 1 195 11
	cmpb	$120, %al
	jne	.L44
	.loc 1 197 21
	movl	$1, is_kern_exclude(%rip)
	.loc 1 198 12
	movq	$0, map_to(%rip)
	.loc 1 200 6
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 200 9
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 201 5
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 202 5
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	get_range
	.loc 1 216 1
	jmp	.L45
.L44:
	.loc 1 206 16
	movl	$0, is_exclude(%rip)
	.loc 1 207 5
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	get_range
	.loc 1 208 12
	movq	range_from(%rip), %rax
	movq	%rax, map_to(%rip)
	.loc 1 209 11
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 209 10
	movzbl	(%rax), %eax
	.loc 1 209 8
	cmpb	$62, %al
	jne	.L45
	.loc 1 211 8
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 211 11
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 212 7
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 213 16
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	get_addsub
	.loc 1 213 14
	movq	%rax, map_to(%rip)
.L45:
	.loc 1 216 1
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	map_cmd, .-map_cmd
	.section	.rodata
	.align 8
.LC0:
	.string	"Map: exclude=%d from=%ld/$%lx to=%ld/$%lx map=%ld/$%lx"
	.align 8
.LC1:
	.string	"Map: exclude=%d from=%ld/$%lx to=%ld/$%lx map=%ld/$%lx (further single glyph logs disabled)"
	.text
	.globl	bf_map_cmd
	.type	bf_map_cmd, @function
bf_map_cmd:
.LFB15:
	.loc 1 219 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	.loc 1 224 9
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 224 8
	movzbl	(%rax), %eax
	.loc 1 224 6
	cmpb	$44, %al
	je	.L57
	.loc 1 224 23 discriminator 1
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 224 22 discriminator 1
	movzbl	(%rax), %eax
	.loc 1 224 19 discriminator 1
	testb	%al, %al
	je	.L57
	.loc 1 227 3
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	map_cmd
	.loc 1 230 19
	movq	range_from(%rip), %rdx
	movq	range_to(%rip), %rax
	.loc 1 230 6
	cmpq	%rax, %rdx
	je	.L50
	.loc 1 232 5
	movq	map_to(%rip), %r8
	movq	map_to(%rip), %rdi
	movq	range_to(%rip), %rsi
	movq	range_to(%rip), %r9
	movq	range_from(%rip), %r10
	movq	range_from(%rip), %rcx
	movl	is_exclude(%rip), %edx
	movq	-24(%rbp), %rax
	subq	$8, %rsp
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	movq	%r10, %r8
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	addq	$32, %rsp
	jmp	.L51
.L50:
	.loc 1 234 47
	movl	is_log_disabled_for_single_glyphs.0(%rip), %eax
	.loc 1 234 11
	testl	%eax, %eax
	jne	.L51
	.loc 1 236 5
	movq	map_to(%rip), %r8
	movq	map_to(%rip), %rdi
	movq	range_to(%rip), %rsi
	movq	range_to(%rip), %r9
	movq	range_from(%rip), %r10
	movq	range_from(%rip), %rcx
	movl	is_exclude(%rip), %edx
	movq	-24(%rbp), %rax
	subq	$8, %rsp
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	movq	%r10, %r8
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	addq	$32, %rsp
	.loc 1 237 39
	movl	$1, is_log_disabled_for_single_glyphs.0(%rip)
.L51:
	.loc 1 241 10
	movl	$0, -12(%rbp)
	.loc 1 241 3
	jmp	.L52
.L56:
	.loc 1 243 12
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 243 24
	movl	-12(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	.loc 1 243 8
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 244 12
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 244 23
	movq	range_from(%rip), %rax
	.loc 1 244 8
	cmpq	%rax, %rdx
	jl	.L53
	.loc 1 244 42 discriminator 1
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 244 53 discriminator 1
	movq	range_to(%rip), %rax
	.loc 1 244 37 discriminator 1
	cmpq	%rax, %rdx
	jg	.L53
	.loc 1 246 28
	movl	is_kern_exclude(%rip), %eax
	.loc 1 246 10
	testl	%eax, %eax
	je	.L54
	.loc 1 248 37
	movq	-8(%rbp), %rax
	movl	$1, 80(%rax)
	jmp	.L53
.L54:
	.loc 1 252 24
	movl	is_exclude(%rip), %eax
	.loc 1 252 11
	testl	%eax, %eax
	je	.L55
	.loc 1 254 14
	movq	-8(%rbp), %rax
	movq	$-1, 16(%rax)
	jmp	.L53
.L55:
	.loc 1 258 18
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 258 29
	movq	range_from(%rip), %rdx
	subq	%rdx, %rax
	movq	%rax, %rcx
	.loc 1 258 42
	movq	map_to(%rip), %rax
	leaq	(%rcx,%rax), %rdx
	.loc 1 258 14
	movq	-8(%rbp), %rax
	movq	%rdx, 16(%rax)
.L53:
	.loc 1 241 35 discriminator 2
	addl	$1, -12(%rbp)
.L52:
	.loc 1 241 21 discriminator 1
	movq	-24(%rbp), %rax
	movl	16(%rax), %eax
	.loc 1 241 17 discriminator 1
	cmpl	%eax, -12(%rbp)
	jl	.L56
	jmp	.L46
.L57:
	.loc 1 225 5
	nop
.L46:
	.loc 1 264 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	bf_map_cmd, .-bf_map_cmd
	.globl	bf_map_list
	.type	bf_map_list, @function
bf_map_list:
.LFB16:
	.loc 1 267 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	.loc 1 272 10
	movl	$0, -12(%rbp)
	.loc 1 272 3
	jmp	.L59
.L60:
	.loc 1 274 12 discriminator 3
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 274 24 discriminator 3
	movl	-12(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	.loc 1 274 8 discriminator 3
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 275 16 discriminator 3
	movq	-8(%rbp), %rax
	movq	$-1, 16(%rax)
	.loc 1 272 35 discriminator 3
	addl	$1, -12(%rbp)
.L59:
	.loc 1 272 21 discriminator 1
	movq	-24(%rbp), %rax
	movl	16(%rax), %eax
	.loc 1 272 17 discriminator 1
	cmpl	%eax, -12(%rbp)
	jl	.L60
	.loc 1 279 3
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
.L63:
	.loc 1 282 5
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	bf_map_cmd
	.loc 1 283 11
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 283 10
	movzbl	(%rax), %eax
	.loc 1 283 8
	cmpb	$44, %al
	jne	.L65
	.loc 1 285 6
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 285 9
	leaq	1(%rax), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 286 5
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	skip_space
	.loc 1 282 5
	jmp	.L63
.L65:
	.loc 1 284 7
	nop
	.loc 1 288 1
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	bf_map_list, .-bf_map_list
	.section	.rodata
.LC2:
	.string	"Map: map_cmd_list='%s'"
	.text
	.globl	bf_Map
	.type	bf_Map, @function
bf_Map:
.LFB17:
	.loc 1 291 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 292 8
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	.loc 1 292 6
	cmpq	$1023, %rax
	ja	.L67
	.loc 1 293 5
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	leaq	.LC2(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
.L67:
	.loc 1 294 3
	leaq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	bf_map_list
	.loc 1 295 1
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	bf_Map, .-bf_Map
	.section	.rodata
.LC3:
	.string	"r"
	.text
	.globl	bf_MapFile
	.type	bf_MapFile, @function
bf_MapFile:
.LFB18:
	.loc 1 298 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$192, %rsp
	movq	%rdi, -184(%rbp)
	movq	%rsi, -192(%rbp)
	.loc 1 298 1
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	.loc 1 302 6
	cmpq	$0, -192(%rbp)
	jne	.L69
	.loc 1 303 12
	movl	$1, %eax
	jmp	.L75
.L69:
	.loc 1 304 21
	movq	-192(%rbp), %rax
	movzbl	(%rax), %eax
	.loc 1 304 6
	testb	%al, %al
	jne	.L71
	.loc 1 305 12
	movl	$1, %eax
	jmp	.L75
.L71:
	.loc 1 308 8
	leaq	-160(%rbp), %rdx
	movq	-192(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stat@PLT
	.loc 1 308 6
	testl	%eax, %eax
	je	.L72
	.loc 1 309 12
	movl	$0, %eax
	jmp	.L75
.L72:
	.loc 1 310 8
	movq	-192(%rbp), %rax
	leaq	.LC3(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -176(%rbp)
	.loc 1 311 6
	cmpq	$0, -176(%rbp)
	jne	.L73
	.loc 1 312 12
	movl	$0, %eax
	jmp	.L75
.L73:
	.loc 1 313 17
	movq	-112(%rbp), %rax
	.loc 1 313 25
	addq	$1, %rax
	.loc 1 313 7
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -168(%rbp)
	.loc 1 314 6
	cmpq	$0, -168(%rbp)
	jne	.L74
	.loc 1 315 12
	movl	$0, %eax
	jmp	.L75
.L74:
	.loc 1 316 15
	movq	-112(%rbp), %rax
	.loc 1 316 3
	movq	%rax, %rsi
	movq	-176(%rbp), %rdx
	movq	-168(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movq	%rax, %rdi
	call	fread@PLT
	.loc 1 317 8
	movq	-112(%rbp), %rax
	movq	%rax, %rdx
	.loc 1 317 4
	movq	-168(%rbp), %rax
	addq	%rdx, %rax
	.loc 1 317 18
	movb	$0, (%rax)
	.loc 1 318 3
	movq	-176(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	.loc 1 319 3
	movq	-168(%rbp), %rdx
	movq	-184(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	bf_Map
	.loc 1 320 3
	movq	-168(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	.loc 1 321 10
	movl	$1, %eax
.L75:
	.loc 1 322 1 discriminator 1
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L76
	.loc 1 322 1 is_stmt 0
	call	__stack_chk_fail@PLT
.L76:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	bf_MapFile, .-bf_MapFile
	.local	is_log_disabled_for_single_glyphs.0
	.comm	is_log_disabled_for_single_glyphs.0,4,4
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h"
	.file 3 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 4 "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h"
	.file 5 "/usr/include/x86_64-linux-gnu/bits/types/FILE.h"
	.file 6 "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h"
	.file 7 "bdf_glyph.h"
	.file 8 "bdf_font.h"
	.file 9 "/usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h"
	.file 10 "/usr/include/x86_64-linux-gnu/bits/struct_stat.h"
	.file 11 "/usr/include/stdio.h"
	.file 12 "/usr/include/stdlib.h"
	.file 13 "/usr/include/x86_64-linux-gnu/sys/stat.h"
	.file 14 "/usr/include/string.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xc7f
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x19
	.long	.LASF165
	.byte	0x1d
	.long	.LASF0
	.long	.LASF1
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x3
	.long	.LASF7
	.byte	0x2
	.byte	0xd1
	.byte	0x17
	.long	0x3a
	.uleb128 0x6
	.byte	0x8
	.byte	0x7
	.long	.LASF2
	.uleb128 0x6
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x1a
	.byte	0x8
	.uleb128 0xe
	.long	0x48
	.uleb128 0x6
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x6
	.byte	0x2
	.byte	0x7
	.long	.LASF5
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x3
	.long	.LASF8
	.byte	0x3
	.byte	0x26
	.byte	0x17
	.long	0x4f
	.uleb128 0x6
	.byte	0x2
	.byte	0x5
	.long	.LASF9
	.uleb128 0x1b
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x6
	.byte	0x8
	.byte	0x5
	.long	.LASF10
	.uleb128 0x3
	.long	.LASF11
	.byte	0x3
	.byte	0x91
	.byte	0x19
	.long	0x3a
	.uleb128 0x3
	.long	.LASF12
	.byte	0x3
	.byte	0x92
	.byte	0x19
	.long	0x41
	.uleb128 0x3
	.long	.LASF13
	.byte	0x3
	.byte	0x93
	.byte	0x19
	.long	0x41
	.uleb128 0x3
	.long	.LASF14
	.byte	0x3
	.byte	0x94
	.byte	0x19
	.long	0x3a
	.uleb128 0x3
	.long	.LASF15
	.byte	0x3
	.byte	0x96
	.byte	0x1a
	.long	0x41
	.uleb128 0x3
	.long	.LASF16
	.byte	0x3
	.byte	0x97
	.byte	0x1b
	.long	0x3a
	.uleb128 0x3
	.long	.LASF17
	.byte	0x3
	.byte	0x98
	.byte	0x19
	.long	0x7e
	.uleb128 0x3
	.long	.LASF18
	.byte	0x3
	.byte	0x99
	.byte	0x1b
	.long	0x7e
	.uleb128 0x3
	.long	.LASF19
	.byte	0x3
	.byte	0xa0
	.byte	0x1a
	.long	0x7e
	.uleb128 0x3
	.long	.LASF20
	.byte	0x3
	.byte	0xaf
	.byte	0x1d
	.long	0x7e
	.uleb128 0x3
	.long	.LASF21
	.byte	0x3
	.byte	0xb4
	.byte	0x1c
	.long	0x7e
	.uleb128 0x3
	.long	.LASF22
	.byte	0x3
	.byte	0xc5
	.byte	0x21
	.long	0x7e
	.uleb128 0x4
	.long	0x11a
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.long	.LASF23
	.uleb128 0x1c
	.long	0x11a
	.uleb128 0xc
	.long	.LASF61
	.byte	0xd8
	.byte	0x4
	.byte	0x31
	.long	0x2ac
	.uleb128 0x1
	.long	.LASF24
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.long	0x77
	.byte	0
	.uleb128 0x1
	.long	.LASF25
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.long	0x115
	.byte	0x8
	.uleb128 0x1
	.long	.LASF26
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.long	0x115
	.byte	0x10
	.uleb128 0x1
	.long	.LASF27
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.long	0x115
	.byte	0x18
	.uleb128 0x1
	.long	.LASF28
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.long	0x115
	.byte	0x20
	.uleb128 0x1
	.long	.LASF29
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.long	0x115
	.byte	0x28
	.uleb128 0x1
	.long	.LASF30
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.long	0x115
	.byte	0x30
	.uleb128 0x1
	.long	.LASF31
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.long	0x115
	.byte	0x38
	.uleb128 0x1
	.long	.LASF32
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.long	0x115
	.byte	0x40
	.uleb128 0x1
	.long	.LASF33
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.long	0x115
	.byte	0x48
	.uleb128 0x1
	.long	.LASF34
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.long	0x115
	.byte	0x50
	.uleb128 0x1
	.long	.LASF35
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.long	0x115
	.byte	0x58
	.uleb128 0x1
	.long	.LASF36
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.long	0x2c5
	.byte	0x60
	.uleb128 0x1
	.long	.LASF37
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.long	0x2ca
	.byte	0x68
	.uleb128 0x1
	.long	.LASF38
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.long	0x77
	.byte	0x70
	.uleb128 0x1
	.long	.LASF39
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.long	0x77
	.byte	0x74
	.uleb128 0x1
	.long	.LASF40
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.long	0xcd
	.byte	0x78
	.uleb128 0x1
	.long	.LASF41
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.long	0x56
	.byte	0x80
	.uleb128 0x1
	.long	.LASF42
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.long	0x5d
	.byte	0x82
	.uleb128 0x1
	.long	.LASF43
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.long	0x2cf
	.byte	0x83
	.uleb128 0x1
	.long	.LASF44
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.long	0x2df
	.byte	0x88
	.uleb128 0x1
	.long	.LASF45
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.long	0xd9
	.byte	0x90
	.uleb128 0x1
	.long	.LASF46
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.long	0x2e9
	.byte	0x98
	.uleb128 0x1
	.long	.LASF47
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.long	0x2f3
	.byte	0xa0
	.uleb128 0x1
	.long	.LASF48
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.long	0x2ca
	.byte	0xa8
	.uleb128 0x1
	.long	.LASF49
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.long	0x48
	.byte	0xb0
	.uleb128 0x1
	.long	.LASF50
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.long	0x2e
	.byte	0xb8
	.uleb128 0x1
	.long	.LASF51
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.long	0x77
	.byte	0xc0
	.uleb128 0x1
	.long	.LASF52
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.long	0x2f8
	.byte	0xc4
	.byte	0
	.uleb128 0x3
	.long	.LASF53
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.long	0x126
	.uleb128 0x1d
	.long	.LASF166
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0x12
	.long	.LASF54
	.uleb128 0x4
	.long	0x2c0
	.uleb128 0x4
	.long	0x126
	.uleb128 0xf
	.long	0x11a
	.long	0x2df
	.uleb128 0x13
	.long	0x3a
	.byte	0
	.byte	0
	.uleb128 0x4
	.long	0x2b8
	.uleb128 0x12
	.long	.LASF55
	.uleb128 0x4
	.long	0x2e4
	.uleb128 0x12
	.long	.LASF56
	.uleb128 0x4
	.long	0x2ee
	.uleb128 0xf
	.long	0x11a
	.long	0x308
	.uleb128 0x13
	.long	0x3a
	.byte	0x13
	.byte	0
	.uleb128 0x4
	.long	0x2ac
	.uleb128 0xe
	.long	0x308
	.uleb128 0x3
	.long	.LASF57
	.byte	0x6
	.byte	0x18
	.byte	0x13
	.long	0x64
	.uleb128 0x6
	.byte	0x8
	.byte	0x5
	.long	.LASF58
	.uleb128 0x6
	.byte	0x10
	.byte	0x4
	.long	.LASF59
	.uleb128 0x3
	.long	.LASF60
	.byte	0x7
	.byte	0x9
	.byte	0x21
	.long	0x338
	.uleb128 0x1e
	.long	.LASF62
	.value	0x520
	.byte	0x8
	.byte	0x16
	.byte	0x8
	.long	0x559
	.uleb128 0x1
	.long	.LASF63
	.byte	0x8
	.byte	0x18
	.byte	0x7
	.long	0x77
	.byte	0
	.uleb128 0x1
	.long	.LASF64
	.byte	0x8
	.byte	0x1a
	.byte	0xa
	.long	0x6d8
	.byte	0x8
	.uleb128 0x1
	.long	.LASF65
	.byte	0x8
	.byte	0x1b
	.byte	0x7
	.long	0x77
	.byte	0x10
	.uleb128 0x1
	.long	.LASF66
	.byte	0x8
	.byte	0x1c
	.byte	0x7
	.long	0x77
	.byte	0x14
	.uleb128 0x1
	.long	.LASF67
	.byte	0x8
	.byte	0x1f
	.byte	0x8
	.long	0x6e2
	.byte	0x18
	.uleb128 0x2
	.long	.LASF68
	.byte	0x20
	.byte	0x7
	.long	0x77
	.value	0x418
	.uleb128 0x2
	.long	.LASF69
	.byte	0x21
	.byte	0x7
	.long	0x77
	.value	0x41c
	.uleb128 0x2
	.long	.LASF70
	.byte	0x23
	.byte	0x8
	.long	0x7e
	.value	0x420
	.uleb128 0x2
	.long	.LASF71
	.byte	0x25
	.byte	0x8
	.long	0x7e
	.value	0x428
	.uleb128 0x2
	.long	.LASF72
	.byte	0x26
	.byte	0x8
	.long	0x7e
	.value	0x430
	.uleb128 0x2
	.long	.LASF73
	.byte	0x28
	.byte	0x8
	.long	0x7e
	.value	0x438
	.uleb128 0x2
	.long	.LASF74
	.byte	0x29
	.byte	0x8
	.long	0x7e
	.value	0x440
	.uleb128 0x2
	.long	.LASF75
	.byte	0x2a
	.byte	0x8
	.long	0x7e
	.value	0x448
	.uleb128 0x2
	.long	.LASF76
	.byte	0x2b
	.byte	0x8
	.long	0x7e
	.value	0x450
	.uleb128 0x2
	.long	.LASF77
	.byte	0x2d
	.byte	0x7
	.long	0x77
	.value	0x458
	.uleb128 0x2
	.long	.LASF78
	.byte	0x2e
	.byte	0x7
	.long	0x77
	.value	0x45c
	.uleb128 0x2
	.long	.LASF79
	.byte	0x2f
	.byte	0x7
	.long	0x77
	.value	0x460
	.uleb128 0x14
	.string	"fp"
	.byte	0x30
	.long	0x308
	.value	0x468
	.uleb128 0x2
	.long	.LASF80
	.byte	0x32
	.byte	0x9
	.long	0x115
	.value	0x470
	.uleb128 0x2
	.long	.LASF81
	.byte	0x33
	.byte	0x9
	.long	0x115
	.value	0x478
	.uleb128 0x2
	.long	.LASF82
	.byte	0x35
	.byte	0x8
	.long	0x7e
	.value	0x480
	.uleb128 0x2
	.long	.LASF83
	.byte	0x37
	.byte	0x7
	.long	0x77
	.value	0x488
	.uleb128 0x14
	.string	"max"
	.byte	0x39
	.long	0x58e
	.value	0x490
	.uleb128 0x2
	.long	.LASF84
	.byte	0x3c
	.byte	0x8
	.long	0x7e
	.value	0x4b0
	.uleb128 0x2
	.long	.LASF85
	.byte	0x3d
	.byte	0x8
	.long	0x7e
	.value	0x4b8
	.uleb128 0x2
	.long	.LASF86
	.byte	0x3e
	.byte	0x8
	.long	0x7e
	.value	0x4c0
	.uleb128 0x2
	.long	.LASF87
	.byte	0x3f
	.byte	0x8
	.long	0x7e
	.value	0x4c8
	.uleb128 0x2
	.long	.LASF88
	.byte	0x42
	.byte	0x8
	.long	0x7e
	.value	0x4d0
	.uleb128 0x2
	.long	.LASF89
	.byte	0x43
	.byte	0x8
	.long	0x7e
	.value	0x4d8
	.uleb128 0x2
	.long	.LASF90
	.byte	0x46
	.byte	0x8
	.long	0x7e
	.value	0x4e0
	.uleb128 0x2
	.long	.LASF91
	.byte	0x47
	.byte	0x8
	.long	0x7e
	.value	0x4e8
	.uleb128 0x2
	.long	.LASF92
	.byte	0x4a
	.byte	0x7
	.long	0x77
	.value	0x4f0
	.uleb128 0x2
	.long	.LASF93
	.byte	0x4b
	.byte	0x7
	.long	0x77
	.value	0x4f4
	.uleb128 0x2
	.long	.LASF94
	.byte	0x4c
	.byte	0x7
	.long	0x77
	.value	0x4f8
	.uleb128 0x2
	.long	.LASF95
	.byte	0x4d
	.byte	0x7
	.long	0x77
	.value	0x4fc
	.uleb128 0x2
	.long	.LASF96
	.byte	0x4e
	.byte	0x7
	.long	0x77
	.value	0x500
	.uleb128 0x2
	.long	.LASF97
	.byte	0x51
	.byte	0xc
	.long	0x6c7
	.value	0x508
	.uleb128 0x2
	.long	.LASF98
	.byte	0x52
	.byte	0x7
	.long	0x77
	.value	0x510
	.uleb128 0x2
	.long	.LASF99
	.byte	0x53
	.byte	0x7
	.long	0x77
	.value	0x514
	.uleb128 0x2
	.long	.LASF100
	.byte	0x56
	.byte	0x7
	.long	0x77
	.value	0x518
	.uleb128 0x2
	.long	.LASF101
	.byte	0x57
	.byte	0x7
	.long	0x77
	.value	0x51c
	.byte	0
	.uleb128 0xc
	.long	.LASF102
	.byte	0x20
	.byte	0x7
	.byte	0xc
	.long	0x58e
	.uleb128 0x9
	.string	"w"
	.byte	0xe
	.byte	0x8
	.long	0x7e
	.byte	0
	.uleb128 0x9
	.string	"h"
	.byte	0xf
	.byte	0x8
	.long	0x7e
	.byte	0x8
	.uleb128 0x9
	.string	"x"
	.byte	0x10
	.byte	0x8
	.long	0x7e
	.byte	0x10
	.uleb128 0x9
	.string	"y"
	.byte	0x11
	.byte	0x8
	.long	0x7e
	.byte	0x18
	.byte	0
	.uleb128 0x3
	.long	.LASF103
	.byte	0x7
	.byte	0x13
	.byte	0x1c
	.long	0x559
	.uleb128 0xc
	.long	.LASF104
	.byte	0xa0
	.byte	0x7
	.byte	0x16
	.long	0x6c2
	.uleb128 0x9
	.string	"bf"
	.byte	0x18
	.byte	0x9
	.long	0x6c2
	.byte	0
	.uleb128 0x1
	.long	.LASF70
	.byte	0x7
	.byte	0x1a
	.byte	0x8
	.long	0x7e
	.byte	0x8
	.uleb128 0x1
	.long	.LASF105
	.byte	0x7
	.byte	0x1b
	.byte	0x8
	.long	0x7e
	.byte	0x10
	.uleb128 0x1
	.long	.LASF71
	.byte	0x7
	.byte	0x1d
	.byte	0x8
	.long	0x7e
	.byte	0x18
	.uleb128 0x1
	.long	.LASF72
	.byte	0x7
	.byte	0x1e
	.byte	0x8
	.long	0x7e
	.byte	0x20
	.uleb128 0x9
	.string	"bbx"
	.byte	0x20
	.byte	0x9
	.long	0x58e
	.byte	0x28
	.uleb128 0x1
	.long	.LASF106
	.byte	0x7
	.byte	0x21
	.byte	0x8
	.long	0x7e
	.byte	0x48
	.uleb128 0x1
	.long	.LASF107
	.byte	0x7
	.byte	0x22
	.byte	0x7
	.long	0x77
	.byte	0x50
	.uleb128 0x1
	.long	.LASF108
	.byte	0x7
	.byte	0x24
	.byte	0xc
	.long	0x6c7
	.byte	0x58
	.uleb128 0x1
	.long	.LASF109
	.byte	0x7
	.byte	0x25
	.byte	0x7
	.long	0x77
	.byte	0x60
	.uleb128 0x1
	.long	.LASF110
	.byte	0x7
	.byte	0x26
	.byte	0x7
	.long	0x77
	.byte	0x64
	.uleb128 0x1
	.long	.LASF97
	.byte	0x7
	.byte	0x2b
	.byte	0xc
	.long	0x6c7
	.byte	0x68
	.uleb128 0x1
	.long	.LASF98
	.byte	0x7
	.byte	0x2c
	.byte	0x7
	.long	0x77
	.byte	0x70
	.uleb128 0x1
	.long	.LASF99
	.byte	0x7
	.byte	0x2d
	.byte	0x7
	.long	0x77
	.byte	0x74
	.uleb128 0x1
	.long	.LASF111
	.byte	0x7
	.byte	0x2e
	.byte	0x7
	.long	0x77
	.byte	0x78
	.uleb128 0x1
	.long	.LASF112
	.byte	0x7
	.byte	0x32
	.byte	0xc
	.long	0x41
	.byte	0x7c
	.uleb128 0x1
	.long	.LASF113
	.byte	0x7
	.byte	0x33
	.byte	0xc
	.long	0x41
	.byte	0x80
	.uleb128 0x1
	.long	.LASF114
	.byte	0x7
	.byte	0x35
	.byte	0x7
	.long	0x77
	.byte	0x84
	.uleb128 0x1
	.long	.LASF115
	.byte	0x7
	.byte	0x36
	.byte	0xc
	.long	0x41
	.byte	0x88
	.uleb128 0x1
	.long	.LASF116
	.byte	0x7
	.byte	0x37
	.byte	0xc
	.long	0x41
	.byte	0x8c
	.uleb128 0x1
	.long	.LASF117
	.byte	0x7
	.byte	0x38
	.byte	0xc
	.long	0x41
	.byte	0x90
	.uleb128 0x1
	.long	.LASF118
	.byte	0x7
	.byte	0x3a
	.byte	0x8
	.long	0x7e
	.byte	0x98
	.byte	0
	.uleb128 0x4
	.long	0x32c
	.uleb128 0x4
	.long	0x312
	.uleb128 0x3
	.long	.LASF119
	.byte	0x7
	.byte	0x3d
	.byte	0x22
	.long	0x59a
	.uleb128 0x4
	.long	0x6dd
	.uleb128 0x4
	.long	0x6cc
	.uleb128 0xf
	.long	0x11a
	.long	0x6f3
	.uleb128 0x1f
	.long	0x3a
	.value	0x3ff
	.byte	0
	.uleb128 0xc
	.long	.LASF120
	.byte	0x10
	.byte	0x9
	.byte	0xb
	.long	0x71a
	.uleb128 0x1
	.long	.LASF121
	.byte	0x9
	.byte	0x10
	.byte	0xc
	.long	0xe5
	.byte	0
	.uleb128 0x1
	.long	.LASF122
	.byte	0x9
	.byte	0x15
	.byte	0x15
	.long	0x109
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.byte	0x7
	.long	.LASF123
	.uleb128 0x4
	.long	0x121
	.uleb128 0xe
	.long	0x721
	.uleb128 0xc
	.long	.LASF124
	.byte	0x90
	.byte	0xa
	.byte	0x1a
	.long	0x7fb
	.uleb128 0x1
	.long	.LASF125
	.byte	0xa
	.byte	0x1f
	.byte	0xd
	.long	0x85
	.byte	0
	.uleb128 0x1
	.long	.LASF126
	.byte	0xa
	.byte	0x24
	.byte	0xd
	.long	0xa9
	.byte	0x8
	.uleb128 0x1
	.long	.LASF127
	.byte	0xa
	.byte	0x2c
	.byte	0xf
	.long	0xc1
	.byte	0x10
	.uleb128 0x1
	.long	.LASF128
	.byte	0xa
	.byte	0x2d
	.byte	0xe
	.long	0xb5
	.byte	0x18
	.uleb128 0x1
	.long	.LASF129
	.byte	0xa
	.byte	0x2f
	.byte	0xd
	.long	0x91
	.byte	0x1c
	.uleb128 0x1
	.long	.LASF130
	.byte	0xa
	.byte	0x30
	.byte	0xd
	.long	0x9d
	.byte	0x20
	.uleb128 0x1
	.long	.LASF131
	.byte	0xa
	.byte	0x32
	.byte	0x9
	.long	0x77
	.byte	0x24
	.uleb128 0x1
	.long	.LASF132
	.byte	0xa
	.byte	0x34
	.byte	0xd
	.long	0x85
	.byte	0x28
	.uleb128 0x1
	.long	.LASF133
	.byte	0xa
	.byte	0x39
	.byte	0xd
	.long	0xcd
	.byte	0x30
	.uleb128 0x1
	.long	.LASF134
	.byte	0xa
	.byte	0x3d
	.byte	0x11
	.long	0xf1
	.byte	0x38
	.uleb128 0x1
	.long	.LASF135
	.byte	0xa
	.byte	0x3f
	.byte	0x10
	.long	0xfd
	.byte	0x40
	.uleb128 0x1
	.long	.LASF136
	.byte	0xa
	.byte	0x4a
	.byte	0x15
	.long	0x6f3
	.byte	0x48
	.uleb128 0x1
	.long	.LASF137
	.byte	0xa
	.byte	0x4b
	.byte	0x15
	.long	0x6f3
	.byte	0x58
	.uleb128 0x1
	.long	.LASF138
	.byte	0xa
	.byte	0x4c
	.byte	0x15
	.long	0x6f3
	.byte	0x68
	.uleb128 0x1
	.long	.LASF139
	.byte	0xa
	.byte	0x59
	.byte	0x17
	.long	0x7fb
	.byte	0x78
	.byte	0
	.uleb128 0xf
	.long	0x109
	.long	0x80b
	.uleb128 0x13
	.long	0x3a
	.byte	0x2
	.byte	0
	.uleb128 0xa
	.long	.LASF140
	.byte	0x22
	.byte	0xd
	.long	0x7e
	.uleb128 0x9
	.byte	0x3
	.quad	range_from
	.uleb128 0xa
	.long	.LASF141
	.byte	0x23
	.byte	0xd
	.long	0x7e
	.uleb128 0x9
	.byte	0x3
	.quad	range_to
	.uleb128 0xa
	.long	.LASF142
	.byte	0x24
	.byte	0xc
	.long	0x77
	.uleb128 0x9
	.byte	0x3
	.quad	is_exclude
	.uleb128 0xa
	.long	.LASF143
	.byte	0x25
	.byte	0xc
	.long	0x77
	.uleb128 0x9
	.byte	0x3
	.quad	is_kern_exclude
	.uleb128 0xa
	.long	.LASF105
	.byte	0x26
	.byte	0xd
	.long	0x7e
	.uleb128 0x9
	.byte	0x3
	.quad	map_to
	.uleb128 0x20
	.long	.LASF149
	.byte	0xc
	.value	0x22b
	.byte	0xd
	.long	0x887
	.uleb128 0x5
	.long	0x48
	.byte	0
	.uleb128 0x15
	.long	.LASF144
	.byte	0xb
	.byte	0xb2
	.long	0x77
	.long	0x89c
	.uleb128 0x5
	.long	0x308
	.byte	0
	.uleb128 0x10
	.long	.LASF145
	.byte	0xb
	.value	0x2a3
	.byte	0xf
	.long	0x2e
	.long	0x8c2
	.uleb128 0x5
	.long	0x4a
	.uleb128 0x5
	.long	0x2e
	.uleb128 0x5
	.long	0x2e
	.uleb128 0x5
	.long	0x30d
	.byte	0
	.uleb128 0x10
	.long	.LASF146
	.byte	0xc
	.value	0x21c
	.byte	0xe
	.long	0x48
	.long	0x8d9
	.uleb128 0x5
	.long	0x2e
	.byte	0
	.uleb128 0x10
	.long	.LASF147
	.byte	0xb
	.value	0x102
	.byte	0xe
	.long	0x308
	.long	0x8f5
	.uleb128 0x5
	.long	0x726
	.uleb128 0x5
	.long	0x726
	.byte	0
	.uleb128 0x15
	.long	.LASF124
	.byte	0xd
	.byte	0xcd
	.long	0x77
	.long	0x90f
	.uleb128 0x5
	.long	0x726
	.uleb128 0x5
	.long	0x914
	.byte	0
	.uleb128 0x4
	.long	0x72b
	.uleb128 0xe
	.long	0x90f
	.uleb128 0x10
	.long	.LASF148
	.byte	0xe
	.value	0x197
	.byte	0xf
	.long	0x2e
	.long	0x930
	.uleb128 0x5
	.long	0x721
	.byte	0
	.uleb128 0x21
	.long	.LASF150
	.byte	0x8
	.byte	0x5f
	.byte	0x6
	.long	0x948
	.uleb128 0x5
	.long	0x6c2
	.uleb128 0x5
	.long	0x115
	.uleb128 0x22
	.byte	0
	.uleb128 0x23
	.long	.LASF167
	.byte	0x1
	.value	0x129
	.byte	0x5
	.long	0x77
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0x9b8
	.uleb128 0x11
	.string	"bf"
	.value	0x129
	.byte	0x16
	.long	0x6c2
	.uleb128 0x3
	.byte	0x91
	.sleb128 -200
	.uleb128 0x16
	.long	.LASF151
	.value	0x129
	.byte	0x26
	.long	0x721
	.uleb128 0x3
	.byte	0x91
	.sleb128 -208
	.uleb128 0xd
	.string	"buf"
	.value	0x12b
	.byte	0xf
	.long	0x72b
	.uleb128 0x3
	.byte	0x91
	.sleb128 -176
	.uleb128 0xd
	.string	"s"
	.value	0x12c
	.byte	0x9
	.long	0x115
	.uleb128 0x3
	.byte	0x91
	.sleb128 -184
	.uleb128 0xd
	.string	"fp"
	.value	0x12d
	.byte	0x9
	.long	0x308
	.uleb128 0x3
	.byte	0x91
	.sleb128 -192
	.byte	0
	.uleb128 0x17
	.long	.LASF153
	.value	0x122
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0x9f3
	.uleb128 0x11
	.string	"bf"
	.value	0x122
	.byte	0x13
	.long	0x6c2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x16
	.long	.LASF152
	.value	0x122
	.byte	0x23
	.long	0x721
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x17
	.long	.LASF154
	.value	0x10a
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0xa47
	.uleb128 0x11
	.string	"bf"
	.value	0x10a
	.byte	0x18
	.long	0x6c2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x11
	.string	"s"
	.value	0x10a
	.byte	0x29
	.long	0xa47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0xd
	.string	"i"
	.value	0x10c
	.byte	0x7
	.long	0x77
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0xd
	.string	"bg"
	.value	0x10d
	.byte	0x9
	.long	0x6dd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x4
	.long	0x721
	.uleb128 0x24
	.long	.LASF155
	.byte	0x1
	.byte	0xda
	.byte	0x6
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0xab2
	.uleb128 0x7
	.string	"bf"
	.byte	0xda
	.byte	0x17
	.long	0x6c2
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x7
	.string	"s"
	.byte	0xda
	.byte	0x28
	.long	0xa47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x8
	.string	"i"
	.byte	0xdc
	.byte	0x7
	.long	0x77
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x8
	.string	"bg"
	.byte	0xdd
	.byte	0x9
	.long	0x6dd
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0xa
	.long	.LASF156
	.byte	0xde
	.byte	0xe
	.long	0x77
	.uleb128 0x9
	.byte	0x3
	.quad	is_log_disabled_for_single_glyphs.0
	.byte	0
	.uleb128 0x18
	.long	.LASF157
	.byte	0xac
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0xadb
	.uleb128 0x7
	.string	"s"
	.byte	0xac
	.byte	0x22
	.long	0xa47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x18
	.long	.LASF158
	.byte	0x9d
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0xb04
	.uleb128 0x7
	.string	"s"
	.byte	0x9d
	.byte	0x24
	.long	0xa47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0xb
	.long	.LASF159
	.byte	0x8b
	.long	0x7e
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xb4a
	.uleb128 0x7
	.string	"s"
	.byte	0x8b
	.byte	0x25
	.long	0xa47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x8
	.string	"v"
	.byte	0x8d
	.byte	0x8
	.long	0x7e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x8
	.string	"op"
	.byte	0x8e
	.byte	0x7
	.long	0x77
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.byte	0
	.uleb128 0xb
	.long	.LASF160
	.byte	0x7e
	.long	0x7e
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xb83
	.uleb128 0x7
	.string	"s"
	.byte	0x7e
	.byte	0x22
	.long	0xa47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x8
	.string	"v"
	.byte	0x80
	.byte	0x8
	.long	0x7e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0xb
	.long	.LASF161
	.byte	0x71
	.long	0x7e
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xbbc
	.uleb128 0x7
	.string	"s"
	.byte	0x71
	.byte	0x22
	.long	0xa47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x8
	.string	"v"
	.byte	0x73
	.byte	0x8
	.long	0x7e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0xb
	.long	.LASF162
	.byte	0x68
	.long	0x7e
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xbe9
	.uleb128 0x7
	.string	"s"
	.byte	0x68
	.byte	0x22
	.long	0xa47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0xb
	.long	.LASF163
	.byte	0x48
	.long	0x7e
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0xc22
	.uleb128 0x7
	.string	"s"
	.byte	0x48
	.byte	0x22
	.long	0xa47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x8
	.string	"v"
	.byte	0x4a
	.byte	0x8
	.long	0x7e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0xb
	.long	.LASF164
	.byte	0x34
	.long	0x7e
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0xc5b
	.uleb128 0x7
	.string	"s"
	.byte	0x34
	.byte	0x22
	.long	0xa47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x8
	.string	"v"
	.byte	0x36
	.byte	0x8
	.long	0x7e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x25
	.long	.LASF168
	.byte	0x1
	.byte	0x28
	.byte	0xd
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x7
	.string	"s"
	.byte	0x28
	.byte	0x25
	.long	0xa47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 7
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 13
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 9
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 12
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 6
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 13
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0x5
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF63:
	.string	"is_verbose"
.LASF143:
	.string	"is_kern_exclude"
.LASF43:
	.string	"_shortbuf"
.LASF80:
	.string	"str_font"
.LASF166:
	.string	"_IO_lock_t"
.LASF148:
	.string	"strlen"
.LASF32:
	.string	"_IO_buf_end"
.LASF104:
	.string	"_bdf_glyph_struct"
.LASF90:
	.string	"x_min"
.LASF62:
	.string	"_bdf_font_struct"
.LASF153:
	.string	"bf_Map"
.LASF105:
	.string	"map_to"
.LASF30:
	.string	"_IO_write_end"
.LASF3:
	.string	"unsigned int"
.LASF48:
	.string	"_freeres_list"
.LASF155:
	.string	"bf_map_cmd"
.LASF134:
	.string	"st_blksize"
.LASF24:
	.string	"_flags"
.LASF67:
	.string	"line_buf"
.LASF36:
	.string	"_markers"
.LASF16:
	.string	"__nlink_t"
.LASF97:
	.string	"target_data"
.LASF69:
	.string	"is_bitmap_parsing"
.LASF158:
	.string	"get_range"
.LASF167:
	.string	"bf_MapFile"
.LASF116:
	.string	"rle_last_0"
.LASF117:
	.string	"rle_last_1"
.LASF106:
	.string	"shift_x"
.LASF115:
	.string	"rle_bitcnt"
.LASF14:
	.string	"__ino_t"
.LASF100:
	.string	"tile_h_size"
.LASF102:
	.string	"_bbx_struct"
.LASF130:
	.string	"st_gid"
.LASF35:
	.string	"_IO_save_end"
.LASF55:
	.string	"_IO_codecvt"
.LASF146:
	.string	"malloc"
.LASF108:
	.string	"bitmap_data"
.LASF65:
	.string	"glyph_cnt"
.LASF123:
	.string	"long long unsigned int"
.LASF135:
	.string	"st_blocks"
.LASF152:
	.string	"map_cmd_list"
.LASF141:
	.string	"range_to"
.LASF151:
	.string	"map_file_name"
.LASF74:
	.string	"bbx_h"
.LASF154:
	.string	"bf_map_list"
.LASF34:
	.string	"_IO_backup_base"
.LASF45:
	.string	"_offset"
.LASF103:
	.string	"bbx_t"
.LASF73:
	.string	"bbx_w"
.LASF75:
	.string	"bbx_x"
.LASF76:
	.string	"bbx_y"
.LASF68:
	.string	"line_pos"
.LASF88:
	.string	"dx_min"
.LASF38:
	.string	"_fileno"
.LASF124:
	.string	"stat"
.LASF119:
	.string	"bg_t"
.LASF122:
	.string	"tv_nsec"
.LASF7:
	.string	"size_t"
.LASF15:
	.string	"__mode_t"
.LASF27:
	.string	"_IO_read_base"
.LASF84:
	.string	"enc_w"
.LASF71:
	.string	"dwidth_x"
.LASF72:
	.string	"dwidth_y"
.LASF29:
	.string	"_IO_write_ptr"
.LASF149:
	.string	"free"
.LASF66:
	.string	"glyph_max"
.LASF144:
	.string	"fclose"
.LASF127:
	.string	"st_nlink"
.LASF114:
	.string	"rle_is_first"
.LASF120:
	.string	"timespec"
.LASF23:
	.string	"char"
.LASF51:
	.string	"_mode"
.LASF70:
	.string	"encoding"
.LASF54:
	.string	"_IO_marker"
.LASF25:
	.string	"_IO_read_ptr"
.LASF163:
	.string	"get_hex"
.LASF57:
	.string	"uint8_t"
.LASF96:
	.string	"dx_max_bit_size"
.LASF79:
	.string	"glyph_pos"
.LASF161:
	.string	"get_mul"
.LASF126:
	.string	"st_ino"
.LASF28:
	.string	"_IO_write_base"
.LASF58:
	.string	"long long int"
.LASF33:
	.string	"_IO_save_base"
.LASF11:
	.string	"__dev_t"
.LASF99:
	.string	"target_cnt"
.LASF142:
	.string	"is_exclude"
.LASF22:
	.string	"__syscall_slong_t"
.LASF91:
	.string	"x_max"
.LASF64:
	.string	"glyph_list"
.LASF49:
	.string	"_freeres_buf"
.LASF128:
	.string	"st_mode"
.LASF131:
	.string	"__pad0"
.LASF50:
	.string	"__pad5"
.LASF78:
	.string	"bitmap_y"
.LASF139:
	.string	"__glibc_reserved"
.LASF150:
	.string	"bf_Log"
.LASF93:
	.string	"bbx_y_max_bit_size"
.LASF111:
	.string	"target_bit_pos"
.LASF112:
	.string	"rle_bits_per_0"
.LASF113:
	.string	"rle_bits_per_1"
.LASF147:
	.string	"fopen"
.LASF42:
	.string	"_vtable_offset"
.LASF92:
	.string	"bbx_x_max_bit_size"
.LASF59:
	.string	"long double"
.LASF13:
	.string	"__gid_t"
.LASF98:
	.string	"target_max"
.LASF107:
	.string	"is_excluded_from_kerning"
.LASF159:
	.string	"get_addsub"
.LASF81:
	.string	"str_copyright"
.LASF94:
	.string	"bbx_w_max_bit_size"
.LASF26:
	.string	"_IO_read_end"
.LASF77:
	.string	"bitmap_x"
.LASF160:
	.string	"get_add"
.LASF9:
	.string	"short int"
.LASF137:
	.string	"st_mtim"
.LASF10:
	.string	"long int"
.LASF145:
	.string	"fread"
.LASF101:
	.string	"tile_v_size"
.LASF56:
	.string	"_IO_wide_data"
.LASF118:
	.string	"width_deviation"
.LASF82:
	.string	"selected_glyphs"
.LASF20:
	.string	"__blksize_t"
.LASF157:
	.string	"map_cmd"
.LASF12:
	.string	"__uid_t"
.LASF8:
	.string	"__uint8_t"
.LASF136:
	.string	"st_atim"
.LASF89:
	.string	"dx_max"
.LASF47:
	.string	"_wide_data"
.LASF44:
	.string	"_lock"
.LASF121:
	.string	"tv_sec"
.LASF2:
	.string	"long unsigned int"
.LASF40:
	.string	"_old_offset"
.LASF61:
	.string	"_IO_FILE"
.LASF83:
	.string	"bbx_mode"
.LASF156:
	.string	"is_log_disabled_for_single_glyphs"
.LASF85:
	.string	"enc_h"
.LASF4:
	.string	"unsigned char"
.LASF86:
	.string	"enc_x"
.LASF87:
	.string	"enc_y"
.LASF109:
	.string	"bitmap_width"
.LASF164:
	.string	"get_dec"
.LASF165:
	.string	"GNU C17 11.3.0 -mtune=generic -march=x86-64 -g -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF168:
	.string	"skip_space"
.LASF162:
	.string	"get_num"
.LASF19:
	.string	"__time_t"
.LASF133:
	.string	"st_size"
.LASF46:
	.string	"_codecvt"
.LASF129:
	.string	"st_uid"
.LASF95:
	.string	"bbx_h_max_bit_size"
.LASF17:
	.string	"__off_t"
.LASF138:
	.string	"st_ctim"
.LASF125:
	.string	"st_dev"
.LASF6:
	.string	"signed char"
.LASF60:
	.string	"bf_t"
.LASF5:
	.string	"short unsigned int"
.LASF140:
	.string	"range_from"
.LASF21:
	.string	"__blkcnt_t"
.LASF37:
	.string	"_chain"
.LASF132:
	.string	"st_rdev"
.LASF53:
	.string	"FILE"
.LASF39:
	.string	"_flags2"
.LASF110:
	.string	"bitmap_height"
.LASF41:
	.string	"_cur_column"
.LASF18:
	.string	"__off64_t"
.LASF52:
	.string	"_unused2"
.LASF31:
	.string	"_IO_buf_base"
	.section	.debug_line_str,"MS",@progbits,1
.LASF1:
	.string	"/home/dev/Projects/bleskomat/bleskomat-bills-firmware/tools/bdfconv"
.LASF0:
	.string	"bdf_map.c"
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
