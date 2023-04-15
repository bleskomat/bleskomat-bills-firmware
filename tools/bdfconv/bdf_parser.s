	.file	"bdf_parser.c"
	.text
.Ltext0:
	.file 0 "/home/dev/Projects/bleskomat/bleskomat-bills-firmware/tools/bdfconv" "bdf_parser.c"
	.type	bf_curr, @function
bf_curr:
.LFB6:
	.file 1 "bdf_parser.c"
	.loc 1 9 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	.loc 1 10 10
	movq	-8(%rbp), %rax
	movl	1048(%rax), %eax
	.loc 1 10 6
	cmpl	$1023, %eax
	jle	.L2
	.loc 1 11 12
	movl	$0, %eax
	jmp	.L3
.L2:
	.loc 1 12 25
	movq	-8(%rbp), %rax
	movl	1048(%rax), %eax
	.loc 1 12 22
	movq	-8(%rbp), %rdx
	cltq
	movzbl	24(%rdx,%rax), %eax
	movsbl	%al, %eax
.L3:
	.loc 1 13 1
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	bf_curr, .-bf_curr
	.type	bf_next, @function
bf_next:
.LFB7:
	.loc 1 16 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$8, %rsp
	movq	%rdi, -8(%rbp)
	.loc 1 17 8
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	bf_curr
	.loc 1 17 6
	testl	%eax, %eax
	je	.L8
	.loc 1 19 10
	movq	-8(%rbp), %rax
	movl	1048(%rax), %eax
	.loc 1 19 6
	cmpl	$1023, %eax
	jg	.L9
	.loc 1 21 5
	movq	-8(%rbp), %rax
	movl	1048(%rax), %eax
	.loc 1 21 15
	leal	1(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 1048(%rax)
	jmp	.L4
.L8:
	.loc 1 18 5
	nop
	jmp	.L4
.L9:
	.loc 1 20 5
	nop
.L4:
	.loc 1 22 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	bf_next, .-bf_next
	.type	bf_skipspace, @function
bf_skipspace:
.LFB8:
	.loc 1 25 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
.L14:
	.loc 1 30 9
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_curr
	movl	%eax, -4(%rbp)
	.loc 1 31 8
	cmpl	$0, -4(%rbp)
	je	.L15
	.loc 1 33 8
	cmpl	$32, -4(%rbp)
	jg	.L16
	.loc 1 35 5
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_next
	.loc 1 30 7
	jmp	.L14
.L15:
	.loc 1 32 7
	nop
	jmp	.L10
.L16:
	.loc 1 34 7
	nop
.L10:
	.loc 1 37 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	bf_skipspace, .-bf_skipspace
	.type	bf_get_identifier, @function
bf_get_identifier:
.LFB9:
	.loc 1 40 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 43 7
	movl	$0, -8(%rbp)
	.loc 1 44 10
	movb	$0, buf.4(%rip)
.L21:
	.loc 1 47 9
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_curr
	movl	%eax, -4(%rbp)
	.loc 1 48 8
	cmpl	$32, -4(%rbp)
	jle	.L23
	.loc 1 50 8
	cmpl	$1021, -8(%rbp)
	jg	.L24
	.loc 1 52 10
	movl	-8(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -8(%rbp)
	.loc 1 52 14
	movl	-4(%rbp), %edx
	movl	%edx, %ecx
	cltq
	leaq	buf.4(%rip), %rdx
	movb	%cl, (%rax,%rdx)
	.loc 1 53 12
	movl	-8(%rbp), %eax
	cltq
	leaq	buf.4(%rip), %rdx
	movb	$0, (%rax,%rdx)
	.loc 1 54 5
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_next
	.loc 1 47 7
	jmp	.L21
.L23:
	.loc 1 49 7
	nop
	jmp	.L19
.L24:
	.loc 1 51 7
	nop
.L19:
	.loc 1 56 3
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_skipspace
	.loc 1 57 10
	leaq	buf.4(%rip), %rax
	.loc 1 58 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	bf_get_identifier, .-bf_get_identifier
	.type	bf_get_string, @function
bf_get_string:
.LFB10:
	.loc 1 61 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 63 7
	movl	$0, -8(%rbp)
	.loc 1 66 10
	movb	$0, buf.3(%rip)
	.loc 1 68 8
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_curr
	.loc 1 68 6
	cmpl	$34, %eax
	je	.L26
	.loc 1 69 12
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_identifier
	jmp	.L27
.L26:
	.loc 1 71 3
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_next
.L33:
	.loc 1 75 9
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_curr
	movl	%eax, -4(%rbp)
	.loc 1 76 8
	cmpl	$0, -4(%rbp)
	je	.L35
	.loc 1 78 8
	cmpl	$34, -4(%rbp)
	je	.L36
	.loc 1 80 8
	cmpl	$1021, -8(%rbp)
	jg	.L37
	.loc 1 82 8
	cmpl	$13, -4(%rbp)
	je	.L32
	.loc 1 82 20 discriminator 1
	cmpl	$10, -4(%rbp)
	je	.L32
	.loc 1 84 12
	movl	-8(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -8(%rbp)
	.loc 1 84 16
	movl	-4(%rbp), %edx
	movl	%edx, %ecx
	cltq
	leaq	buf.3(%rip), %rdx
	movb	%cl, (%rax,%rdx)
	.loc 1 85 14
	movl	-8(%rbp), %eax
	cltq
	leaq	buf.3(%rip), %rdx
	movb	$0, (%rax,%rdx)
.L32:
	.loc 1 87 5
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_next
	.loc 1 75 7
	jmp	.L33
.L35:
	.loc 1 77 7
	nop
	jmp	.L29
.L36:
	.loc 1 79 7
	nop
	jmp	.L29
.L37:
	.loc 1 81 7
	nop
.L29:
	.loc 1 89 8
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_curr
	.loc 1 89 6
	cmpl	$34, %eax
	jne	.L34
	.loc 1 90 5
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_next
.L34:
	.loc 1 92 3
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_skipspace
	.loc 1 93 10
	leaq	buf.3(%rip), %rax
.L27:
	.loc 1 94 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	bf_get_string, .-bf_get_string
	.type	bf_get_eol_string, @function
bf_get_eol_string:
.LFB11:
	.loc 1 97 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 99 7
	movl	$0, -8(%rbp)
	.loc 1 102 10
	movb	$0, buf.2(%rip)
	.loc 1 104 8
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_curr
	.loc 1 104 6
	cmpl	$34, %eax
	jne	.L39
	.loc 1 105 12
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_string
	jmp	.L40
.L39:
	.loc 1 110 9
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_curr
	movl	%eax, -4(%rbp)
	.loc 1 111 8
	cmpl	$0, -4(%rbp)
	je	.L44
	.loc 1 113 8
	cmpl	$10, -4(%rbp)
	je	.L42
	.loc 1 113 20 discriminator 1
	cmpl	$13, -4(%rbp)
	je	.L42
	.loc 1 115 8
	cmpl	$1021, -8(%rbp)
	jg	.L45
	.loc 1 117 10
	movl	-8(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -8(%rbp)
	.loc 1 117 14
	movl	-4(%rbp), %edx
	movl	%edx, %ecx
	cltq
	leaq	buf.2(%rip), %rdx
	movb	%cl, (%rax,%rdx)
	.loc 1 118 12
	movl	-8(%rbp), %eax
	cltq
	leaq	buf.2(%rip), %rdx
	movb	$0, (%rax,%rdx)
	.loc 1 119 5
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_next
	.loc 1 110 7
	jmp	.L39
.L44:
	.loc 1 112 7
	nop
	jmp	.L42
.L45:
	.loc 1 116 7
	nop
.L42:
	.loc 1 122 3
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_skipspace
	.loc 1 123 10
	leaq	buf.2(%rip), %rax
.L40:
	.loc 1 124 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	bf_get_eol_string, .-bf_get_eol_string
	.type	bf_get_long, @function
bf_get_long:
.LFB12:
	.loc 1 127 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$40, %rsp
	movq	%rdi, -40(%rbp)
	.loc 1 129 8
	movq	$0, -16(%rbp)
	.loc 1 130 8
	movq	$1, -8(%rbp)
	.loc 1 132 8
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	bf_curr
	.loc 1 132 6
	cmpl	$45, %eax
	jne	.L51
	.loc 1 134 10
	movq	$-1, -8(%rbp)
	.loc 1 135 5
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	bf_next
	.loc 1 136 5
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	bf_skipspace
.L51:
	.loc 1 141 9
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	bf_curr
	movl	%eax, -20(%rbp)
	.loc 1 142 8
	cmpl	$47, -20(%rbp)
	jle	.L53
	.loc 1 144 8
	cmpl	$57, -20(%rbp)
	jg	.L54
	.loc 1 146 7
	movq	-16(%rbp), %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, -16(%rbp)
	.loc 1 147 18
	movl	-20(%rbp), %eax
	subl	$48, %eax
	.loc 1 147 10
	cltq
	.loc 1 147 7
	addq	%rax, -16(%rbp)
	.loc 1 148 5
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	bf_next
	.loc 1 141 7
	jmp	.L51
.L53:
	.loc 1 143 7
	nop
	jmp	.L49
.L54:
	.loc 1 145 7
	nop
.L49:
	.loc 1 150 3
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	bf_skipspace
	.loc 1 152 11
	movq	-16(%rbp), %rax
	imulq	-8(%rbp), %rax
	.loc 1 153 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	bf_get_long, .-bf_get_long
	.section	.rodata
	.align 8
.LC0:
	.string	"Can not add glyph (memory error?)"
	.align 8
.LC1:
	.string	"Can not create bitmap (memory error?)"
	.text
	.type	bf_add_glyph_to_list, @function
bf_add_glyph_to_list:
.LFB13:
	.loc 1 185 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 187 19
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_AddGlyph@PLT
	.loc 1 187 17
	movq	-24(%rbp), %rdx
	movl	%eax, 1120(%rdx)
	.loc 1 188 10
	movq	-24(%rbp), %rax
	movl	1120(%rax), %eax
	.loc 1 188 6
	testl	%eax, %eax
	jns	.L56
	.loc 1 190 5
	movq	-24(%rbp), %rax
	leaq	.LC0(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Error@PLT
	.loc 1 191 12
	movl	$0, %eax
	jmp	.L57
.L56:
	.loc 1 194 10
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 194 25
	movq	-24(%rbp), %rax
	movl	1120(%rax), %eax
	cltq
	.loc 1 194 22
	salq	$3, %rax
	addq	%rdx, %rax
	.loc 1 194 6
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 197 20
	movq	-24(%rbp), %rax
	movq	1056(%rax), %rdx
	.loc 1 197 16
	movq	-8(%rbp), %rax
	movq	%rdx, 8(%rax)
	.loc 1 198 20
	movq	-24(%rbp), %rax
	movq	1064(%rax), %rdx
	.loc 1 198 16
	movq	-8(%rbp), %rax
	movq	%rdx, 24(%rax)
	.loc 1 199 20
	movq	-24(%rbp), %rax
	movq	1072(%rax), %rdx
	.loc 1 199 16
	movq	-8(%rbp), %rax
	movq	%rdx, 32(%rax)
	.loc 1 200 17
	movq	-24(%rbp), %rax
	movq	1080(%rax), %rdx
	.loc 1 200 13
	movq	-8(%rbp), %rax
	movq	%rdx, 40(%rax)
	.loc 1 201 17
	movq	-24(%rbp), %rax
	movq	1088(%rax), %rdx
	.loc 1 201 13
	movq	-8(%rbp), %rax
	movq	%rdx, 48(%rax)
	.loc 1 202 17
	movq	-24(%rbp), %rax
	movq	1096(%rax), %rdx
	.loc 1 202 13
	movq	-8(%rbp), %rax
	movq	%rdx, 56(%rax)
	.loc 1 203 17
	movq	-24(%rbp), %rax
	movq	1104(%rax), %rdx
	.loc 1 203 13
	movq	-8(%rbp), %rax
	movq	%rdx, 64(%rax)
	.loc 1 205 42
	movq	-24(%rbp), %rax
	movq	1088(%rax), %rax
	.loc 1 205 8
	movl	%eax, %edx
	.loc 1 205 31
	movq	-24(%rbp), %rax
	movq	1080(%rax), %rax
	.loc 1 205 8
	movl	%eax, %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_SetBitmapSize@PLT
	.loc 1 205 6
	testl	%eax, %eax
	jne	.L58
	.loc 1 207 5
	movq	-24(%rbp), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Error@PLT
	.loc 1 208 12
	movl	$0, %eax
	jmp	.L57
.L58:
	.loc 1 211 24
	movq	-24(%rbp), %rax
	movq	1080(%rax), %rax
	.loc 1 211 20
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, 96(%rax)
	.loc 1 212 25
	movq	-24(%rbp), %rax
	movq	1088(%rax), %rax
	.loc 1 212 21
	movl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, 100(%rax)
	.loc 1 220 10
	movl	$1, %eax
.L57:
	.loc 1 221 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	bf_add_glyph_to_list, .-bf_add_glyph_to_list
	.section	.rodata
.LC2:
	.string	"bdf_parser.c"
.LC3:
	.string	"bf->glyph_list != NULL"
	.text
	.type	bf_set_pixel_by_halfbyte, @function
bf_set_pixel_by_halfbyte:
.LFB14:
	.loc 1 224 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	.loc 1 228 3
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	jne	.L60
	.loc 1 228 3 is_stmt 0 discriminator 1
	leaq	__PRETTY_FUNCTION__.1(%rip), %rax
	movq	%rax, %rcx
	movl	$228, %edx
	leaq	.LC2(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	__assert_fail@PLT
.L60:
	.loc 1 230 10 is_stmt 1
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 230 25
	movq	-24(%rbp), %rax
	movl	1120(%rax), %eax
	cltq
	.loc 1 230 22
	salq	$3, %rax
	addq	%rdx, %rax
	.loc 1 230 6
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 232 11
	movl	$0, -12(%rbp)
	.loc 1 232 3
	jmp	.L61
.L63:
	.loc 1 234 20
	movl	-28(%rbp), %eax
	andl	$8, %eax
	.loc 1 234 8
	testl	%eax, %eax
	je	.L62
	.loc 1 236 7
	movq	-24(%rbp), %rax
	movl	1116(%rax), %edx
	movq	-24(%rbp), %rax
	movl	1112(%rax), %esi
	movq	-8(%rbp), %rax
	movl	$1, %ecx
	movq	%rax, %rdi
	call	bg_SetBitmapPixel@PLT
.L62:
	.loc 1 238 13 discriminator 2
	sall	-28(%rbp)
	.loc 1 239 7 discriminator 2
	movq	-24(%rbp), %rax
	movl	1112(%rax), %eax
	.loc 1 239 17 discriminator 2
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, 1112(%rax)
	.loc 1 232 24 discriminator 2
	addl	$1, -12(%rbp)
.L61:
	.loc 1 232 18 discriminator 1
	cmpl	$3, -12(%rbp)
	jle	.L63
	.loc 1 241 1
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	bf_set_pixel_by_halfbyte, .-bf_set_pixel_by_halfbyte
	.type	bf_set_pixel_by_hex_char, @function
bf_set_pixel_by_hex_char:
.LFB15:
	.loc 1 244 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	.loc 1 245 6
	cmpl	$47, -12(%rbp)
	jle	.L65
	.loc 1 245 19 discriminator 1
	cmpl	$57, -12(%rbp)
	jg	.L65
	.loc 1 246 12
	movl	-12(%rbp), %eax
	leal	-48(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_set_pixel_by_halfbyte
	jmp	.L64
.L65:
	.loc 1 247 6
	cmpl	$96, -12(%rbp)
	jle	.L67
	.loc 1 247 19 discriminator 1
	cmpl	$102, -12(%rbp)
	jg	.L67
	.loc 1 248 12
	movl	-12(%rbp), %eax
	leal	-87(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_set_pixel_by_halfbyte
	jmp	.L64
.L67:
	.loc 1 249 6
	cmpl	$64, -12(%rbp)
	jle	.L68
	.loc 1 249 19 discriminator 1
	cmpl	$70, -12(%rbp)
	jg	.L68
	.loc 1 250 12
	movl	-12(%rbp), %eax
	leal	-55(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_set_pixel_by_halfbyte
	jmp	.L64
.L68:
	.loc 1 251 10
	movq	-8(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_set_pixel_by_halfbyte
.L64:
	.loc 1 252 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	bf_set_pixel_by_hex_char, .-bf_set_pixel_by_hex_char
	.section	.rodata
.LC4:
	.string	"STARTFONT"
.LC5:
	.string	"FONT"
.LC6:
	.string	"SIZE"
.LC7:
	.string	"FONTBOUNDINGBOX"
.LC8:
	.string	"STARTPROPERTIES"
.LC9:
	.string	"FONTNAME_REGISTRY"
.LC10:
	.string	"FOUNDRY"
.LC11:
	.string	"FAMILY_NAME"
.LC12:
	.string	"WEIGHT_NAME"
.LC13:
	.string	"SLANT"
.LC14:
	.string	"SETWIDTH_NAME"
.LC15:
	.string	"ADD_STYLE_NAME"
.LC16:
	.string	"PIXEL_SIZE"
.LC17:
	.string	"POINT_SIZE"
.LC18:
	.string	"RESOLUTION_X"
.LC19:
	.string	"RESOLUTION_Y"
.LC20:
	.string	"SPACING"
.LC21:
	.string	"AVERAGE_WIDTH"
.LC22:
	.string	"CHARSET_REGISTRY"
.LC23:
	.string	"CHARSET_ENCODING"
.LC24:
	.string	"DESTINATION"
.LC25:
	.string	"COPYRIGHT"
.LC26:
	.string	"_XMBDFED_INFO"
.LC27:
	.string	"CAP_HEIGHT"
.LC28:
	.string	"X_HEIGHT"
.LC29:
	.string	"WEIGHT"
.LC30:
	.string	"QUAD_WIDTH"
.LC31:
	.string	"DEFAULT_CHAR"
.LC32:
	.string	"FONT_DESCENT"
.LC33:
	.string	"FONT_ASCENT"
.LC34:
	.string	"ENDPROPERTIES"
.LC35:
	.string	"CHARS"
.LC36:
	.string	"STARTCHAR"
.LC37:
	.string	"ENCODING"
.LC38:
	.string	"SWIDTH"
.LC39:
	.string	"DWIDTH"
.LC40:
	.string	"BBX"
.LC41:
	.string	"BITMAP"
.LC42:
	.string	"ENDCHAR"
.LC43:
	.string	"Unexpected ENDCHAR found"
	.text
	.type	bf_parse_line, @function
bf_parse_line:
.LFB16:
	.loc 1 255 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 258 16
	movq	-24(%rbp), %rax
	movl	$0, 1048(%rax)
	.loc 1 259 3
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_skipspace
	.loc 1 261 10
	movq	-24(%rbp), %rax
	movl	1052(%rax), %eax
	.loc 1 261 6
	testl	%eax, %eax
	jne	.L70
	.loc 1 264 18
	movq	-24(%rbp), %rax
	movl	$0, 1116(%rax)
	.loc 1 265 5
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_string
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcpy@PLT
	.loc 1 267 10
	movzbl	cmd.0(%rip), %eax
	movzbl	%al, %eax
	.loc 1 267 8
	testl	%eax, %eax
	jne	.L71
	.loc 1 269 14
	movl	$1, %eax
	jmp	.L72
.L71:
	.loc 1 271 15
	leaq	.LC4(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 271 13
	testl	%eax, %eax
	je	.L73
	.loc 1 274 15
	leaq	.LC5(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 274 13
	testl	%eax, %eax
	jne	.L74
	.loc 1 276 14
	movq	-24(%rbp), %rax
	movq	1136(%rax), %rax
	.loc 1 276 10
	testq	%rax, %rax
	je	.L75
	.loc 1 277 9
	movq	-24(%rbp), %rax
	movq	1136(%rax), %rax
	.loc 1 277 2
	movq	%rax, %rdi
	call	free@PLT
.L75:
	.loc 1 278 22
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_eol_string
	movq	%rax, %rdi
	call	strdup@PLT
	movq	%rax, %rdx
	.loc 1 278 20
	movq	-24(%rbp), %rax
	movq	%rdx, 1136(%rax)
	jmp	.L73
.L74:
	.loc 1 280 15
	leaq	.LC6(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 280 13
	testl	%eax, %eax
	je	.L73
	.loc 1 283 15
	leaq	.LC7(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 283 13
	testl	%eax, %eax
	je	.L73
	.loc 1 286 15
	leaq	.LC8(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 286 13
	testl	%eax, %eax
	je	.L73
	.loc 1 289 15
	leaq	.LC9(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 289 13
	testl	%eax, %eax
	je	.L73
	.loc 1 292 15
	leaq	.LC10(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 292 13
	testl	%eax, %eax
	je	.L73
	.loc 1 295 15
	leaq	.LC11(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 295 13
	testl	%eax, %eax
	je	.L73
	.loc 1 298 15
	leaq	.LC12(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 298 13
	testl	%eax, %eax
	je	.L73
	.loc 1 301 15
	leaq	.LC13(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 301 13
	testl	%eax, %eax
	je	.L73
	.loc 1 304 15
	leaq	.LC14(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 304 13
	testl	%eax, %eax
	je	.L73
	.loc 1 307 15
	leaq	.LC15(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 307 13
	testl	%eax, %eax
	je	.L73
	.loc 1 310 15
	leaq	.LC16(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 310 13
	testl	%eax, %eax
	je	.L73
	.loc 1 313 15
	leaq	.LC17(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 313 13
	testl	%eax, %eax
	je	.L73
	.loc 1 316 15
	leaq	.LC18(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 316 13
	testl	%eax, %eax
	je	.L73
	.loc 1 319 15
	leaq	.LC19(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 319 13
	testl	%eax, %eax
	je	.L73
	.loc 1 322 15
	leaq	.LC20(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 322 13
	testl	%eax, %eax
	je	.L73
	.loc 1 325 15
	leaq	.LC21(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 325 13
	testl	%eax, %eax
	je	.L73
	.loc 1 328 15
	leaq	.LC22(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 328 13
	testl	%eax, %eax
	je	.L73
	.loc 1 331 15
	leaq	.LC23(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 331 13
	testl	%eax, %eax
	je	.L73
	.loc 1 334 15
	leaq	.LC24(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 334 13
	testl	%eax, %eax
	je	.L73
	.loc 1 337 15
	leaq	.LC25(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 337 13
	testl	%eax, %eax
	jne	.L76
	.loc 1 339 14
	movq	-24(%rbp), %rax
	movq	1144(%rax), %rax
	.loc 1 339 10
	testq	%rax, %rax
	je	.L77
	.loc 1 340 9
	movq	-24(%rbp), %rax
	movq	1144(%rax), %rax
	.loc 1 340 2
	movq	%rax, %rdi
	call	free@PLT
.L77:
	.loc 1 341 27
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_eol_string
	movq	%rax, %rdi
	call	strdup@PLT
	movq	%rax, %rdx
	.loc 1 341 25
	movq	-24(%rbp), %rax
	movq	%rdx, 1144(%rax)
	jmp	.L73
.L76:
	.loc 1 343 15
	leaq	.LC26(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 343 13
	testl	%eax, %eax
	je	.L73
	.loc 1 346 15
	leaq	.LC27(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 346 13
	testl	%eax, %eax
	je	.L73
	.loc 1 349 15
	leaq	.LC28(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 349 13
	testl	%eax, %eax
	je	.L73
	.loc 1 352 15
	leaq	.LC29(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 352 13
	testl	%eax, %eax
	je	.L73
	.loc 1 355 15
	leaq	.LC30(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 355 13
	testl	%eax, %eax
	je	.L73
	.loc 1 358 15
	leaq	.LC31(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 358 13
	testl	%eax, %eax
	je	.L73
	.loc 1 361 15
	leaq	.LC32(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 361 13
	testl	%eax, %eax
	je	.L73
	.loc 1 364 15
	leaq	.LC33(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 364 13
	testl	%eax, %eax
	je	.L73
	.loc 1 367 15
	leaq	.LC34(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 367 13
	testl	%eax, %eax
	je	.L73
	.loc 1 370 15
	leaq	.LC35(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 370 13
	testl	%eax, %eax
	je	.L73
	.loc 1 373 15
	leaq	.LC36(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 373 13
	testl	%eax, %eax
	je	.L73
	.loc 1 376 15
	leaq	.LC37(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 376 13
	testl	%eax, %eax
	jne	.L78
	.loc 1 378 22
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_long
	.loc 1 378 20
	movq	-24(%rbp), %rdx
	movq	%rax, 1056(%rdx)
	jmp	.L73
.L78:
	.loc 1 381 15
	leaq	.LC38(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 381 13
	testl	%eax, %eax
	je	.L73
	.loc 1 384 15
	leaq	.LC39(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 384 13
	testl	%eax, %eax
	jne	.L79
	.loc 1 386 22
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_long
	.loc 1 386 20
	movq	-24(%rbp), %rdx
	movq	%rax, 1064(%rdx)
	.loc 1 387 22
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_long
	.loc 1 387 20
	movq	-24(%rbp), %rdx
	movq	%rax, 1072(%rdx)
	jmp	.L73
.L79:
	.loc 1 390 15
	leaq	.LC40(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 390 13
	testl	%eax, %eax
	jne	.L80
	.loc 1 392 19
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_long
	.loc 1 392 17
	movq	-24(%rbp), %rdx
	movq	%rax, 1080(%rdx)
	.loc 1 393 19
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_long
	.loc 1 393 17
	movq	-24(%rbp), %rdx
	movq	%rax, 1088(%rdx)
	.loc 1 394 19
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_long
	.loc 1 394 17
	movq	-24(%rbp), %rdx
	movq	%rax, 1096(%rdx)
	.loc 1 395 19
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_long
	.loc 1 395 17
	movq	-24(%rbp), %rdx
	movq	%rax, 1104(%rdx)
	jmp	.L73
.L80:
	.loc 1 397 15
	leaq	.LC41(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 397 13
	testl	%eax, %eax
	jne	.L81
	.loc 1 399 12
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_add_glyph_to_list
	.loc 1 399 10
	testl	%eax, %eax
	jne	.L82
	.loc 1 400 9
	movl	$0, %eax
	jmp	.L72
.L82:
	.loc 1 401 29
	movq	-24(%rbp), %rax
	movl	$1, 1052(%rax)
	jmp	.L73
.L81:
	.loc 1 403 15
	leaq	.LC42(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 403 13
	testl	%eax, %eax
	jne	.L73
	.loc 1 405 7
	movq	-24(%rbp), %rax
	leaq	.LC43(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Error@PLT
	.loc 1 406 14
	movl	$0, %eax
	jmp	.L72
.L70:
.LBB2:
	.loc 1 413 5
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_get_string
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcpy@PLT
	.loc 1 414 13
	movzbl	cmd.0(%rip), %eax
	.loc 1 414 8
	testb	%al, %al
	je	.L73
	.loc 1 416 12
	leaq	.LC42(%rip), %rax
	movq	%rax, %rsi
	leaq	cmd.0(%rip), %rax
	movq	%rax, %rdi
	call	strcmp@PLT
	.loc 1 416 10
	testl	%eax, %eax
	jne	.L83
	.loc 1 418 24
	movq	-24(%rbp), %rax
	movl	$0, 1052(%rax)
	jmp	.L73
.L83:
	.loc 1 423 15
	movq	-24(%rbp), %rax
	movl	$0, 1048(%rax)
	.loc 1 424 2
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_skipspace
	.loc 1 427 15
	movq	-24(%rbp), %rax
	movl	$0, 1112(%rax)
.L86:
	.loc 1 432 8
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_curr
	movl	%eax, -4(%rbp)
	.loc 1 433 7
	cmpl	$47, -4(%rbp)
	jle	.L88
	.loc 1 435 4
	movl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_set_pixel_by_hex_char
	.loc 1 436 4
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_next
	.loc 1 432 6
	jmp	.L86
.L88:
	.loc 1 434 6
	nop
	.loc 1 439 4
	movq	-24(%rbp), %rax
	movl	1116(%rax), %eax
	.loc 1 439 14
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, 1116(%rax)
.L73:
.LBE2:
	.loc 1 443 10
	movl	$1, %eax
.L72:
	.loc 1 444 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	bf_parse_line, .-bf_parse_line
	.section	.rodata
.LC44:
	.string	"perse error in line %ld"
	.text
	.type	bf_parse_file, @function
bf_parse_file:
.LFB17:
	.loc 1 447 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 448 8
	movq	$0, -8(%rbp)
	.loc 1 449 25
	movq	-24(%rbp), %rax
	movl	$0, 1052(%rax)
.L94:
	.loc 1 452 13
	addq	$1, -8(%rbp)
	.loc 1 453 10
	movq	-24(%rbp), %rax
	movq	1128(%rax), %rax
	.loc 1 453 18
	movq	-24(%rbp), %rdx
	leaq	24(%rdx), %rcx
	.loc 1 453 10
	movq	%rax, %rdx
	movl	$1024, %esi
	movq	%rcx, %rdi
	call	fgets@PLT
	.loc 1 453 8
	testq	%rax, %rax
	je	.L96
	.loc 1 455 10
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_parse_line
	.loc 1 455 8
	testl	%eax, %eax
	jne	.L94
	.loc 1 457 7
	movq	-8(%rbp), %rdx
	movq	-24(%rbp), %rax
	leaq	.LC44(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Error@PLT
	.loc 1 458 14
	movl	$0, %eax
	jmp	.L93
.L96:
	.loc 1 454 7
	nop
	.loc 1 461 10
	movl	$1, %eax
.L93:
	.loc 1 462 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	bf_parse_file, .-bf_parse_file
	.section	.rodata
.LC45:
	.string	"r"
.LC46:
	.string	"Can not open bdf file '%s'"
	.align 8
.LC47:
	.string	"Parse File %s: %d glyph(s) found"
	.text
	.globl	bf_ParseFile
	.type	bf_ParseFile, @function
bf_ParseFile:
.LFB18:
	.loc 1 465 1
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
	.loc 1 467 12
	movq	-32(%rbp), %rax
	leaq	.LC45(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, %rdx
	.loc 1 467 10
	movq	-24(%rbp), %rax
	movq	%rdx, 1128(%rax)
	.loc 1 468 10
	movq	-24(%rbp), %rax
	movq	1128(%rax), %rax
	.loc 1 468 6
	testq	%rax, %rax
	jne	.L98
	.loc 1 470 5
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	leaq	.LC46(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Error@PLT
	.loc 1 471 12
	movl	$0, %eax
	jmp	.L99
.L98:
	.loc 1 473 7
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	bf_parse_file
	movl	%eax, -4(%rbp)
	.loc 1 474 3
	movq	-24(%rbp), %rax
	movq	1128(%rax), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	.loc 1 475 3
	movq	-24(%rbp), %rax
	movl	16(%rax), %ecx
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	leaq	.LC47(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 476 10
	movl	-4(%rbp), %eax
.L99:
	.loc 1 477 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	bf_ParseFile, .-bf_ParseFile
	.local	buf.4
	.comm	buf.4,1024,32
	.local	buf.3
	.comm	buf.3,1024,32
	.local	buf.2
	.comm	buf.2,1024,32
	.section	.rodata
	.align 16
	.type	__PRETTY_FUNCTION__.1, @object
	.size	__PRETTY_FUNCTION__.1, 25
__PRETTY_FUNCTION__.1:
	.string	"bf_set_pixel_by_halfbyte"
	.local	cmd.0
	.comm	cmd.0,1024,32
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h"
	.file 3 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 4 "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h"
	.file 5 "/usr/include/x86_64-linux-gnu/bits/types/FILE.h"
	.file 6 "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h"
	.file 7 "bdf_glyph.h"
	.file 8 "bdf_font.h"
	.file 9 "/usr/include/stdio.h"
	.file 10 "/usr/include/string.h"
	.file 11 "/usr/include/stdlib.h"
	.file 12 "/usr/include/assert.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xbb5
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x19
	.long	.LASF140
	.byte	0x1d
	.long	.LASF0
	.long	.LASF1
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x8
	.long	.LASF9
	.byte	0x2
	.byte	0xd1
	.byte	0x17
	.long	0x3a
	.uleb128 0x7
	.byte	0x8
	.byte	0x7
	.long	.LASF2
	.uleb128 0x1a
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x7
	.byte	0x8
	.byte	0x5
	.long	.LASF3
	.uleb128 0x7
	.byte	0x8
	.byte	0x5
	.long	.LASF4
	.uleb128 0x7
	.byte	0x1
	.byte	0x8
	.long	.LASF5
	.uleb128 0x7
	.byte	0x2
	.byte	0x7
	.long	.LASF6
	.uleb128 0x7
	.byte	0x4
	.byte	0x7
	.long	.LASF7
	.uleb128 0x7
	.byte	0x1
	.byte	0x6
	.long	.LASF8
	.uleb128 0x8
	.long	.LASF10
	.byte	0x3
	.byte	0x26
	.byte	0x17
	.long	0x56
	.uleb128 0x7
	.byte	0x2
	.byte	0x5
	.long	.LASF11
	.uleb128 0x8
	.long	.LASF12
	.byte	0x3
	.byte	0x98
	.byte	0x19
	.long	0x48
	.uleb128 0x8
	.long	.LASF13
	.byte	0x3
	.byte	0x99
	.byte	0x1b
	.long	0x48
	.uleb128 0x1b
	.byte	0x8
	.uleb128 0x5
	.long	0xa9
	.uleb128 0xe
	.long	0x9f
	.uleb128 0x7
	.byte	0x1
	.byte	0x6
	.long	.LASF14
	.uleb128 0x14
	.long	0xa9
	.uleb128 0x7
	.byte	0x8
	.byte	0x7
	.long	.LASF15
	.uleb128 0x5
	.long	0xb0
	.uleb128 0xe
	.long	0xbc
	.uleb128 0xf
	.long	.LASF52
	.byte	0xd8
	.byte	0x4
	.byte	0x31
	.long	0x24c
	.uleb128 0x1
	.long	.LASF16
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.long	0x41
	.byte	0
	.uleb128 0x1
	.long	.LASF17
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.long	0x9f
	.byte	0x8
	.uleb128 0x1
	.long	.LASF18
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.long	0x9f
	.byte	0x10
	.uleb128 0x1
	.long	.LASF19
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.long	0x9f
	.byte	0x18
	.uleb128 0x1
	.long	.LASF20
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.long	0x9f
	.byte	0x20
	.uleb128 0x1
	.long	.LASF21
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.long	0x9f
	.byte	0x28
	.uleb128 0x1
	.long	.LASF22
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.long	0x9f
	.byte	0x30
	.uleb128 0x1
	.long	.LASF23
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.long	0x9f
	.byte	0x38
	.uleb128 0x1
	.long	.LASF24
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.long	0x9f
	.byte	0x40
	.uleb128 0x1
	.long	.LASF25
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.long	0x9f
	.byte	0x48
	.uleb128 0x1
	.long	.LASF26
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.long	0x9f
	.byte	0x50
	.uleb128 0x1
	.long	.LASF27
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.long	0x9f
	.byte	0x58
	.uleb128 0x1
	.long	.LASF28
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.long	0x265
	.byte	0x60
	.uleb128 0x1
	.long	.LASF29
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.long	0x26a
	.byte	0x68
	.uleb128 0x1
	.long	.LASF30
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.long	0x41
	.byte	0x70
	.uleb128 0x1
	.long	.LASF31
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.long	0x41
	.byte	0x74
	.uleb128 0x1
	.long	.LASF32
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.long	0x85
	.byte	0x78
	.uleb128 0x1
	.long	.LASF33
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.long	0x5d
	.byte	0x80
	.uleb128 0x1
	.long	.LASF34
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.long	0x6b
	.byte	0x82
	.uleb128 0x1
	.long	.LASF35
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.long	0x26f
	.byte	0x83
	.uleb128 0x1
	.long	.LASF36
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.long	0x27f
	.byte	0x88
	.uleb128 0x1
	.long	.LASF37
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.long	0x91
	.byte	0x90
	.uleb128 0x1
	.long	.LASF38
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.long	0x289
	.byte	0x98
	.uleb128 0x1
	.long	.LASF39
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.long	0x293
	.byte	0xa0
	.uleb128 0x1
	.long	.LASF40
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.long	0x26a
	.byte	0xa8
	.uleb128 0x1
	.long	.LASF41
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.long	0x9d
	.byte	0xb0
	.uleb128 0x1
	.long	.LASF42
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.long	0x2e
	.byte	0xb8
	.uleb128 0x1
	.long	.LASF43
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.long	0x41
	.byte	0xc0
	.uleb128 0x1
	.long	.LASF44
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.long	0x298
	.byte	0xc4
	.byte	0
	.uleb128 0x8
	.long	.LASF45
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.long	0xc6
	.uleb128 0x1c
	.long	.LASF141
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0x10
	.long	.LASF46
	.uleb128 0x5
	.long	0x260
	.uleb128 0x5
	.long	0xc6
	.uleb128 0xc
	.long	0xa9
	.long	0x27f
	.uleb128 0x11
	.long	0x3a
	.byte	0
	.byte	0
	.uleb128 0x5
	.long	0x258
	.uleb128 0x10
	.long	.LASF47
	.uleb128 0x5
	.long	0x284
	.uleb128 0x10
	.long	.LASF48
	.uleb128 0x5
	.long	0x28e
	.uleb128 0xc
	.long	0xa9
	.long	0x2a8
	.uleb128 0x11
	.long	0x3a
	.byte	0x13
	.byte	0
	.uleb128 0x5
	.long	0x24c
	.uleb128 0xe
	.long	0x2a8
	.uleb128 0x8
	.long	.LASF49
	.byte	0x6
	.byte	0x18
	.byte	0x13
	.long	0x72
	.uleb128 0x7
	.byte	0x10
	.byte	0x4
	.long	.LASF50
	.uleb128 0x8
	.long	.LASF51
	.byte	0x7
	.byte	0x9
	.byte	0x21
	.long	0x2d1
	.uleb128 0x1d
	.long	.LASF53
	.value	0x520
	.byte	0x8
	.byte	0x16
	.byte	0x8
	.long	0x4f2
	.uleb128 0x1
	.long	.LASF54
	.byte	0x8
	.byte	0x18
	.byte	0x7
	.long	0x41
	.byte	0
	.uleb128 0x1
	.long	.LASF55
	.byte	0x8
	.byte	0x1a
	.byte	0xa
	.long	0x671
	.byte	0x8
	.uleb128 0x1
	.long	.LASF56
	.byte	0x8
	.byte	0x1b
	.byte	0x7
	.long	0x41
	.byte	0x10
	.uleb128 0x1
	.long	.LASF57
	.byte	0x8
	.byte	0x1c
	.byte	0x7
	.long	0x41
	.byte	0x14
	.uleb128 0x1
	.long	.LASF58
	.byte	0x8
	.byte	0x1f
	.byte	0x8
	.long	0x67b
	.byte	0x18
	.uleb128 0x2
	.long	.LASF59
	.byte	0x20
	.byte	0x7
	.long	0x41
	.value	0x418
	.uleb128 0x2
	.long	.LASF60
	.byte	0x21
	.byte	0x7
	.long	0x41
	.value	0x41c
	.uleb128 0x2
	.long	.LASF61
	.byte	0x23
	.byte	0x8
	.long	0x48
	.value	0x420
	.uleb128 0x2
	.long	.LASF62
	.byte	0x25
	.byte	0x8
	.long	0x48
	.value	0x428
	.uleb128 0x2
	.long	.LASF63
	.byte	0x26
	.byte	0x8
	.long	0x48
	.value	0x430
	.uleb128 0x2
	.long	.LASF64
	.byte	0x28
	.byte	0x8
	.long	0x48
	.value	0x438
	.uleb128 0x2
	.long	.LASF65
	.byte	0x29
	.byte	0x8
	.long	0x48
	.value	0x440
	.uleb128 0x2
	.long	.LASF66
	.byte	0x2a
	.byte	0x8
	.long	0x48
	.value	0x448
	.uleb128 0x2
	.long	.LASF67
	.byte	0x2b
	.byte	0x8
	.long	0x48
	.value	0x450
	.uleb128 0x2
	.long	.LASF68
	.byte	0x2d
	.byte	0x7
	.long	0x41
	.value	0x458
	.uleb128 0x2
	.long	.LASF69
	.byte	0x2e
	.byte	0x7
	.long	0x41
	.value	0x45c
	.uleb128 0x2
	.long	.LASF70
	.byte	0x2f
	.byte	0x7
	.long	0x41
	.value	0x460
	.uleb128 0x15
	.string	"fp"
	.byte	0x30
	.long	0x2a8
	.value	0x468
	.uleb128 0x2
	.long	.LASF71
	.byte	0x32
	.byte	0x9
	.long	0x9f
	.value	0x470
	.uleb128 0x2
	.long	.LASF72
	.byte	0x33
	.byte	0x9
	.long	0x9f
	.value	0x478
	.uleb128 0x2
	.long	.LASF73
	.byte	0x35
	.byte	0x8
	.long	0x48
	.value	0x480
	.uleb128 0x2
	.long	.LASF74
	.byte	0x37
	.byte	0x7
	.long	0x41
	.value	0x488
	.uleb128 0x15
	.string	"max"
	.byte	0x39
	.long	0x527
	.value	0x490
	.uleb128 0x2
	.long	.LASF75
	.byte	0x3c
	.byte	0x8
	.long	0x48
	.value	0x4b0
	.uleb128 0x2
	.long	.LASF76
	.byte	0x3d
	.byte	0x8
	.long	0x48
	.value	0x4b8
	.uleb128 0x2
	.long	.LASF77
	.byte	0x3e
	.byte	0x8
	.long	0x48
	.value	0x4c0
	.uleb128 0x2
	.long	.LASF78
	.byte	0x3f
	.byte	0x8
	.long	0x48
	.value	0x4c8
	.uleb128 0x2
	.long	.LASF79
	.byte	0x42
	.byte	0x8
	.long	0x48
	.value	0x4d0
	.uleb128 0x2
	.long	.LASF80
	.byte	0x43
	.byte	0x8
	.long	0x48
	.value	0x4d8
	.uleb128 0x2
	.long	.LASF81
	.byte	0x46
	.byte	0x8
	.long	0x48
	.value	0x4e0
	.uleb128 0x2
	.long	.LASF82
	.byte	0x47
	.byte	0x8
	.long	0x48
	.value	0x4e8
	.uleb128 0x2
	.long	.LASF83
	.byte	0x4a
	.byte	0x7
	.long	0x41
	.value	0x4f0
	.uleb128 0x2
	.long	.LASF84
	.byte	0x4b
	.byte	0x7
	.long	0x41
	.value	0x4f4
	.uleb128 0x2
	.long	.LASF85
	.byte	0x4c
	.byte	0x7
	.long	0x41
	.value	0x4f8
	.uleb128 0x2
	.long	.LASF86
	.byte	0x4d
	.byte	0x7
	.long	0x41
	.value	0x4fc
	.uleb128 0x2
	.long	.LASF87
	.byte	0x4e
	.byte	0x7
	.long	0x41
	.value	0x500
	.uleb128 0x2
	.long	.LASF88
	.byte	0x51
	.byte	0xc
	.long	0x660
	.value	0x508
	.uleb128 0x2
	.long	.LASF89
	.byte	0x52
	.byte	0x7
	.long	0x41
	.value	0x510
	.uleb128 0x2
	.long	.LASF90
	.byte	0x53
	.byte	0x7
	.long	0x41
	.value	0x514
	.uleb128 0x2
	.long	.LASF91
	.byte	0x56
	.byte	0x7
	.long	0x41
	.value	0x518
	.uleb128 0x2
	.long	.LASF92
	.byte	0x57
	.byte	0x7
	.long	0x41
	.value	0x51c
	.byte	0
	.uleb128 0xf
	.long	.LASF93
	.byte	0x20
	.byte	0x7
	.byte	0xc
	.long	0x527
	.uleb128 0x9
	.string	"w"
	.byte	0xe
	.byte	0x8
	.long	0x48
	.byte	0
	.uleb128 0x9
	.string	"h"
	.byte	0xf
	.byte	0x8
	.long	0x48
	.byte	0x8
	.uleb128 0x9
	.string	"x"
	.byte	0x10
	.byte	0x8
	.long	0x48
	.byte	0x10
	.uleb128 0x9
	.string	"y"
	.byte	0x11
	.byte	0x8
	.long	0x48
	.byte	0x18
	.byte	0
	.uleb128 0x8
	.long	.LASF94
	.byte	0x7
	.byte	0x13
	.byte	0x1c
	.long	0x4f2
	.uleb128 0xf
	.long	.LASF95
	.byte	0xa0
	.byte	0x7
	.byte	0x16
	.long	0x65b
	.uleb128 0x9
	.string	"bf"
	.byte	0x18
	.byte	0x9
	.long	0x65b
	.byte	0
	.uleb128 0x1
	.long	.LASF61
	.byte	0x7
	.byte	0x1a
	.byte	0x8
	.long	0x48
	.byte	0x8
	.uleb128 0x1
	.long	.LASF96
	.byte	0x7
	.byte	0x1b
	.byte	0x8
	.long	0x48
	.byte	0x10
	.uleb128 0x1
	.long	.LASF62
	.byte	0x7
	.byte	0x1d
	.byte	0x8
	.long	0x48
	.byte	0x18
	.uleb128 0x1
	.long	.LASF63
	.byte	0x7
	.byte	0x1e
	.byte	0x8
	.long	0x48
	.byte	0x20
	.uleb128 0x9
	.string	"bbx"
	.byte	0x20
	.byte	0x9
	.long	0x527
	.byte	0x28
	.uleb128 0x1
	.long	.LASF97
	.byte	0x7
	.byte	0x21
	.byte	0x8
	.long	0x48
	.byte	0x48
	.uleb128 0x1
	.long	.LASF98
	.byte	0x7
	.byte	0x22
	.byte	0x7
	.long	0x41
	.byte	0x50
	.uleb128 0x1
	.long	.LASF99
	.byte	0x7
	.byte	0x24
	.byte	0xc
	.long	0x660
	.byte	0x58
	.uleb128 0x1
	.long	.LASF100
	.byte	0x7
	.byte	0x25
	.byte	0x7
	.long	0x41
	.byte	0x60
	.uleb128 0x1
	.long	.LASF101
	.byte	0x7
	.byte	0x26
	.byte	0x7
	.long	0x41
	.byte	0x64
	.uleb128 0x1
	.long	.LASF88
	.byte	0x7
	.byte	0x2b
	.byte	0xc
	.long	0x660
	.byte	0x68
	.uleb128 0x1
	.long	.LASF89
	.byte	0x7
	.byte	0x2c
	.byte	0x7
	.long	0x41
	.byte	0x70
	.uleb128 0x1
	.long	.LASF90
	.byte	0x7
	.byte	0x2d
	.byte	0x7
	.long	0x41
	.byte	0x74
	.uleb128 0x1
	.long	.LASF102
	.byte	0x7
	.byte	0x2e
	.byte	0x7
	.long	0x41
	.byte	0x78
	.uleb128 0x1
	.long	.LASF103
	.byte	0x7
	.byte	0x32
	.byte	0xc
	.long	0x64
	.byte	0x7c
	.uleb128 0x1
	.long	.LASF104
	.byte	0x7
	.byte	0x33
	.byte	0xc
	.long	0x64
	.byte	0x80
	.uleb128 0x1
	.long	.LASF105
	.byte	0x7
	.byte	0x35
	.byte	0x7
	.long	0x41
	.byte	0x84
	.uleb128 0x1
	.long	.LASF106
	.byte	0x7
	.byte	0x36
	.byte	0xc
	.long	0x64
	.byte	0x88
	.uleb128 0x1
	.long	.LASF107
	.byte	0x7
	.byte	0x37
	.byte	0xc
	.long	0x64
	.byte	0x8c
	.uleb128 0x1
	.long	.LASF108
	.byte	0x7
	.byte	0x38
	.byte	0xc
	.long	0x64
	.byte	0x90
	.uleb128 0x1
	.long	.LASF109
	.byte	0x7
	.byte	0x3a
	.byte	0x8
	.long	0x48
	.byte	0x98
	.byte	0
	.uleb128 0x5
	.long	0x2c5
	.uleb128 0x5
	.long	0x2b2
	.uleb128 0x8
	.long	.LASF110
	.byte	0x7
	.byte	0x3d
	.byte	0x22
	.long	0x533
	.uleb128 0x5
	.long	0x676
	.uleb128 0x5
	.long	0x665
	.uleb128 0xc
	.long	0xa9
	.long	0x68c
	.uleb128 0x1e
	.long	0x3a
	.value	0x3ff
	.byte	0
	.uleb128 0x12
	.long	.LASF115
	.byte	0x8
	.byte	0x5f
	.long	0x6a3
	.uleb128 0x3
	.long	0x65b
	.uleb128 0x3
	.long	0x9f
	.uleb128 0x16
	.byte	0
	.uleb128 0xa
	.long	.LASF111
	.byte	0x9
	.byte	0xb2
	.byte	0xc
	.long	0x41
	.long	0x6b9
	.uleb128 0x3
	.long	0x2a8
	.byte	0
	.uleb128 0x17
	.long	.LASF112
	.value	0x102
	.long	0x2a8
	.long	0x6d3
	.uleb128 0x3
	.long	0xc1
	.uleb128 0x3
	.long	0xc1
	.byte	0
	.uleb128 0x17
	.long	.LASF113
	.value	0x250
	.long	0x9f
	.long	0x6f2
	.uleb128 0x3
	.long	0xa4
	.uleb128 0x3
	.long	0x41
	.uleb128 0x3
	.long	0x2ad
	.byte	0
	.uleb128 0xa
	.long	.LASF114
	.byte	0xa
	.byte	0xbb
	.byte	0xe
	.long	0x9f
	.long	0x708
	.uleb128 0x3
	.long	0xbc
	.byte	0
	.uleb128 0x1f
	.long	.LASF116
	.byte	0xb
	.value	0x22b
	.byte	0xd
	.long	0x71b
	.uleb128 0x3
	.long	0x9d
	.byte	0
	.uleb128 0xa
	.long	.LASF117
	.byte	0xa
	.byte	0x9c
	.byte	0xc
	.long	0x41
	.long	0x736
	.uleb128 0x3
	.long	0xbc
	.uleb128 0x3
	.long	0xbc
	.byte	0
	.uleb128 0xa
	.long	.LASF118
	.byte	0xa
	.byte	0x8d
	.byte	0xe
	.long	0x9f
	.long	0x751
	.uleb128 0x3
	.long	0x9f
	.uleb128 0x3
	.long	0xbc
	.byte	0
	.uleb128 0x12
	.long	.LASF119
	.byte	0x7
	.byte	0x48
	.long	0x771
	.uleb128 0x3
	.long	0x676
	.uleb128 0x3
	.long	0x41
	.uleb128 0x3
	.long	0x41
	.uleb128 0x3
	.long	0x41
	.byte	0
	.uleb128 0x20
	.long	.LASF120
	.byte	0xc
	.byte	0x45
	.byte	0xd
	.long	0x792
	.uleb128 0x3
	.long	0xbc
	.uleb128 0x3
	.long	0xbc
	.uleb128 0x3
	.long	0x64
	.uleb128 0x3
	.long	0xbc
	.byte	0
	.uleb128 0xa
	.long	.LASF121
	.byte	0x7
	.byte	0x47
	.byte	0x5
	.long	0x41
	.long	0x7b2
	.uleb128 0x3
	.long	0x676
	.uleb128 0x3
	.long	0x41
	.uleb128 0x3
	.long	0x41
	.byte	0
	.uleb128 0x12
	.long	.LASF122
	.byte	0x8
	.byte	0x5e
	.long	0x7c9
	.uleb128 0x3
	.long	0x65b
	.uleb128 0x3
	.long	0x9f
	.uleb128 0x16
	.byte	0
	.uleb128 0xa
	.long	.LASF123
	.byte	0x8
	.byte	0x66
	.byte	0x5
	.long	0x41
	.long	0x7df
	.uleb128 0x3
	.long	0x65b
	.byte	0
	.uleb128 0x21
	.long	.LASF142
	.byte	0x1
	.value	0x1d0
	.byte	0x5
	.long	0x41
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0x82e
	.uleb128 0x18
	.string	"bf"
	.value	0x1d0
	.byte	0x18
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x22
	.long	.LASF124
	.byte	0x1
	.value	0x1d0
	.byte	0x28
	.long	0xbc
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x13
	.string	"r"
	.value	0x1d2
	.byte	0x7
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x23
	.long	.LASF126
	.byte	0x1
	.value	0x1be
	.byte	0xc
	.long	0x41
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0x870
	.uleb128 0x18
	.string	"bf"
	.value	0x1be
	.byte	0x20
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x24
	.long	.LASF125
	.byte	0x1
	.value	0x1c0
	.byte	0x8
	.long	0x48
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0xb
	.long	.LASF127
	.byte	0xfe
	.byte	0xc
	.long	0x41
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0x8d4
	.uleb128 0x6
	.string	"bf"
	.byte	0xfe
	.byte	0x20
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x13
	.string	"cmd"
	.value	0x100
	.byte	0xf
	.long	0x67b
	.uleb128 0x9
	.byte	0x3
	.quad	cmd.0
	.uleb128 0x25
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.uleb128 0x13
	.string	"c"
	.value	0x19c
	.byte	0x9
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.byte	0
	.uleb128 0xd
	.long	.LASF128
	.byte	0xf3
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0x90c
	.uleb128 0x6
	.string	"bf"
	.byte	0xf3
	.byte	0x2c
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x6
	.string	"hex"
	.byte	0xf3
	.byte	0x34
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.byte	0
	.uleb128 0xd
	.long	.LASF129
	.byte	0xdf
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0x971
	.uleb128 0x6
	.string	"bf"
	.byte	0xdf
	.byte	0x2c
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x26
	.long	.LASF130
	.byte	0x1
	.byte	0xdf
	.byte	0x34
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x4
	.string	"i"
	.byte	0xe1
	.byte	0x7
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x4
	.string	"bg"
	.byte	0xe2
	.byte	0x9
	.long	0x676
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x27
	.long	.LASF143
	.long	0x981
	.uleb128 0x9
	.byte	0x3
	.quad	__PRETTY_FUNCTION__.1
	.byte	0
	.uleb128 0xc
	.long	0xb0
	.long	0x981
	.uleb128 0x11
	.long	0x3a
	.byte	0x18
	.byte	0
	.uleb128 0x14
	.long	0x971
	.uleb128 0xb
	.long	.LASF131
	.byte	0xb8
	.byte	0xc
	.long	0x41
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x9c2
	.uleb128 0x6
	.string	"bf"
	.byte	0xb8
	.byte	0x27
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x4
	.string	"bg"
	.byte	0xba
	.byte	0x9
	.long	0x676
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0xb
	.long	.LASF132
	.byte	0x7e
	.byte	0xd
	.long	0x48
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xa18
	.uleb128 0x6
	.string	"bf"
	.byte	0x7e
	.byte	0x1f
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x4
	.string	"c"
	.byte	0x80
	.byte	0x7
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x4
	.string	"v"
	.byte	0x81
	.byte	0x8
	.long	0x48
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x28
	.long	.LASF133
	.byte	0x1
	.byte	0x82
	.byte	0x8
	.long	0x48
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0xb
	.long	.LASF134
	.byte	0x60
	.byte	0x14
	.long	0xbc
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xa74
	.uleb128 0x6
	.string	"bf"
	.byte	0x60
	.byte	0x2c
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x4
	.string	"buf"
	.byte	0x62
	.byte	0xf
	.long	0x67b
	.uleb128 0x9
	.byte	0x3
	.quad	buf.2
	.uleb128 0x4
	.string	"i"
	.byte	0x63
	.byte	0x7
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x4
	.string	"c"
	.byte	0x64
	.byte	0x7
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0xb
	.long	.LASF135
	.byte	0x3c
	.byte	0x14
	.long	0xbc
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xad0
	.uleb128 0x6
	.string	"bf"
	.byte	0x3c
	.byte	0x28
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x4
	.string	"buf"
	.byte	0x3e
	.byte	0xf
	.long	0x67b
	.uleb128 0x9
	.byte	0x3
	.quad	buf.3
	.uleb128 0x4
	.string	"i"
	.byte	0x3f
	.byte	0x7
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x4
	.string	"c"
	.byte	0x40
	.byte	0x7
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0xb
	.long	.LASF136
	.byte	0x27
	.byte	0x14
	.long	0xbc
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xb2c
	.uleb128 0x6
	.string	"bf"
	.byte	0x27
	.byte	0x2c
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x4
	.string	"buf"
	.byte	0x29
	.byte	0xf
	.long	0x67b
	.uleb128 0x9
	.byte	0x3
	.quad	buf.4
	.uleb128 0x4
	.string	"c"
	.byte	0x2a
	.byte	0x7
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x4
	.string	"i"
	.byte	0x2b
	.byte	0x7
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0xd
	.long	.LASF137
	.byte	0x18
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0xb62
	.uleb128 0x6
	.string	"bf"
	.byte	0x18
	.byte	0x20
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x4
	.string	"c"
	.byte	0x1a
	.byte	0x7
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0xd
	.long	.LASF138
	.byte	0xf
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0xb8c
	.uleb128 0x6
	.string	"bf"
	.byte	0xf
	.byte	0x1b
	.long	0x65b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x29
	.long	.LASF139
	.byte	0x1
	.byte	0x8
	.byte	0xc
	.long	0x41
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x6
	.string	"bf"
	.byte	0x8
	.byte	0x1b
	.long	0x65b
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
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
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
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
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
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
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
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
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
	.uleb128 0xe
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0x10
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x12
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
	.sleb128 6
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
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
	.uleb128 0x14
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
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
	.uleb128 0x16
	.uleb128 0x18
	.byte	0
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
	.sleb128 9
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 14
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
	.uleb128 0x18
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
	.uleb128 0x1b
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1c
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
	.uleb128 0x1d
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
	.uleb128 0x1e
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x1f
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
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x87
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
	.uleb128 0x22
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
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
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
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
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
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
	.uleb128 0x25
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x5
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
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x34
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
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x29
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
	.uleb128 0x49
	.uleb128 0x13
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
.LASF54:
	.string	"is_verbose"
.LASF35:
	.string	"_shortbuf"
.LASF71:
	.string	"str_font"
.LASF141:
	.string	"_IO_lock_t"
.LASF24:
	.string	"_IO_buf_end"
.LASF95:
	.string	"_bdf_glyph_struct"
.LASF81:
	.string	"x_min"
.LASF53:
	.string	"_bdf_font_struct"
.LASF125:
	.string	"line_cnt"
.LASF96:
	.string	"map_to"
.LASF22:
	.string	"_IO_write_end"
.LASF7:
	.string	"unsigned int"
.LASF40:
	.string	"_freeres_list"
.LASF16:
	.string	"_flags"
.LASF58:
	.string	"line_buf"
.LASF28:
	.string	"_markers"
.LASF88:
	.string	"target_data"
.LASF60:
	.string	"is_bitmap_parsing"
.LASF131:
	.string	"bf_add_glyph_to_list"
.LASF107:
	.string	"rle_last_0"
.LASF108:
	.string	"rle_last_1"
.LASF97:
	.string	"shift_x"
.LASF106:
	.string	"rle_bitcnt"
.LASF91:
	.string	"tile_h_size"
.LASF118:
	.string	"strcpy"
.LASF93:
	.string	"_bbx_struct"
.LASF134:
	.string	"bf_get_eol_string"
.LASF27:
	.string	"_IO_save_end"
.LASF47:
	.string	"_IO_codecvt"
.LASF99:
	.string	"bitmap_data"
.LASF56:
	.string	"glyph_cnt"
.LASF15:
	.string	"long long unsigned int"
.LASF137:
	.string	"bf_skipspace"
.LASF123:
	.string	"bf_AddGlyph"
.LASF129:
	.string	"bf_set_pixel_by_halfbyte"
.LASF65:
	.string	"bbx_h"
.LASF26:
	.string	"_IO_backup_base"
.LASF37:
	.string	"_offset"
.LASF94:
	.string	"bbx_t"
.LASF64:
	.string	"bbx_w"
.LASF66:
	.string	"bbx_x"
.LASF67:
	.string	"bbx_y"
.LASF59:
	.string	"line_pos"
.LASF79:
	.string	"dx_min"
.LASF138:
	.string	"bf_next"
.LASF30:
	.string	"_fileno"
.LASF110:
	.string	"bg_t"
.LASF9:
	.string	"size_t"
.LASF133:
	.string	"sign"
.LASF19:
	.string	"_IO_read_base"
.LASF75:
	.string	"enc_w"
.LASF62:
	.string	"dwidth_x"
.LASF63:
	.string	"dwidth_y"
.LASF21:
	.string	"_IO_write_ptr"
.LASF116:
	.string	"free"
.LASF57:
	.string	"glyph_max"
.LASF111:
	.string	"fclose"
.LASF130:
	.string	"halfbyte"
.LASF105:
	.string	"rle_is_first"
.LASF127:
	.string	"bf_parse_line"
.LASF14:
	.string	"char"
.LASF43:
	.string	"_mode"
.LASF61:
	.string	"encoding"
.LASF46:
	.string	"_IO_marker"
.LASF17:
	.string	"_IO_read_ptr"
.LASF117:
	.string	"strcmp"
.LASF49:
	.string	"uint8_t"
.LASF87:
	.string	"dx_max_bit_size"
.LASF70:
	.string	"glyph_pos"
.LASF20:
	.string	"_IO_write_base"
.LASF4:
	.string	"long long int"
.LASF135:
	.string	"bf_get_string"
.LASF25:
	.string	"_IO_save_base"
.LASF119:
	.string	"bg_SetBitmapPixel"
.LASF90:
	.string	"target_cnt"
.LASF82:
	.string	"x_max"
.LASF55:
	.string	"glyph_list"
.LASF41:
	.string	"_freeres_buf"
.LASF42:
	.string	"__pad5"
.LASF69:
	.string	"bitmap_y"
.LASF115:
	.string	"bf_Log"
.LASF84:
	.string	"bbx_y_max_bit_size"
.LASF102:
	.string	"target_bit_pos"
.LASF103:
	.string	"rle_bits_per_0"
.LASF104:
	.string	"rle_bits_per_1"
.LASF112:
	.string	"fopen"
.LASF34:
	.string	"_vtable_offset"
.LASF113:
	.string	"fgets"
.LASF83:
	.string	"bbx_x_max_bit_size"
.LASF50:
	.string	"long double"
.LASF89:
	.string	"target_max"
.LASF98:
	.string	"is_excluded_from_kerning"
.LASF72:
	.string	"str_copyright"
.LASF85:
	.string	"bbx_w_max_bit_size"
.LASF18:
	.string	"_IO_read_end"
.LASF68:
	.string	"bitmap_x"
.LASF11:
	.string	"short int"
.LASF3:
	.string	"long int"
.LASF92:
	.string	"tile_v_size"
.LASF48:
	.string	"_IO_wide_data"
.LASF109:
	.string	"width_deviation"
.LASF73:
	.string	"selected_glyphs"
.LASF10:
	.string	"__uint8_t"
.LASF124:
	.string	"name"
.LASF136:
	.string	"bf_get_identifier"
.LASF132:
	.string	"bf_get_long"
.LASF80:
	.string	"dx_max"
.LASF39:
	.string	"_wide_data"
.LASF36:
	.string	"_lock"
.LASF126:
	.string	"bf_parse_file"
.LASF2:
	.string	"long unsigned int"
.LASF32:
	.string	"_old_offset"
.LASF52:
	.string	"_IO_FILE"
.LASF74:
	.string	"bbx_mode"
.LASF120:
	.string	"__assert_fail"
.LASF122:
	.string	"bf_Error"
.LASF76:
	.string	"enc_h"
.LASF5:
	.string	"unsigned char"
.LASF77:
	.string	"enc_x"
.LASF78:
	.string	"enc_y"
.LASF100:
	.string	"bitmap_width"
.LASF128:
	.string	"bf_set_pixel_by_hex_char"
.LASF140:
	.string	"GNU C17 11.3.0 -mtune=generic -march=x86-64 -g -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF142:
	.string	"bf_ParseFile"
.LASF38:
	.string	"_codecvt"
.LASF139:
	.string	"bf_curr"
.LASF86:
	.string	"bbx_h_max_bit_size"
.LASF12:
	.string	"__off_t"
.LASF8:
	.string	"signed char"
.LASF51:
	.string	"bf_t"
.LASF114:
	.string	"strdup"
.LASF6:
	.string	"short unsigned int"
.LASF143:
	.string	"__PRETTY_FUNCTION__"
.LASF29:
	.string	"_chain"
.LASF45:
	.string	"FILE"
.LASF31:
	.string	"_flags2"
.LASF101:
	.string	"bitmap_height"
.LASF33:
	.string	"_cur_column"
.LASF121:
	.string	"bg_SetBitmapSize"
.LASF13:
	.string	"__off64_t"
.LASF44:
	.string	"_unused2"
.LASF23:
	.string	"_IO_buf_base"
	.section	.debug_line_str,"MS",@progbits,1
.LASF1:
	.string	"/home/dev/Projects/bleskomat/bleskomat-bills-firmware/tools/bdfconv"
.LASF0:
	.string	"bdf_parser.c"
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
