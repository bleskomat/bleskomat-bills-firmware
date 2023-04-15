	.file	"bdf_8x8.c"
	.text
.Ltext0:
	.file 0 "/home/dev/Projects/bleskomat/bleskomat-bills-firmware/tools/bdfconv" "bdf_8x8.c"
	.type	bg_8x8_convert, @function
bg_8x8_convert:
.LFB6:
	.file 1 "bdf_8x8.c"
	.loc 1 23 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movl	%ecx, -40(%rbp)
	.loc 1 28 6
	cmpq	$0, -32(%rbp)
	jne	.L2
	.loc 1 29 9
	movq	-24(%rbp), %rax
	addq	$40, %rax
	movq	%rax, -32(%rbp)
.L2:
	.loc 1 56 15
	movq	-32(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 56 10
	movl	%eax, -12(%rbp)
	.loc 1 56 3
	jmp	.L3
.L9:
	.loc 1 58 7
	movl	$0, -4(%rbp)
	.loc 1 59 17
	movq	-32(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 59 20
	movl	%eax, %edx
	.loc 1 59 24
	movq	-32(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 59 20
	addl	%edx, %eax
	.loc 1 59 27
	subl	$1, %eax
	.loc 1 59 12
	movl	%eax, -8(%rbp)
	.loc 1 59 5
	jmp	.L4
.L6:
	.loc 1 61 9
	sarl	-4(%rbp)
	.loc 1 62 12
	movl	-8(%rbp), %edx
	movl	-40(%rbp), %eax
	addl	%eax, %edx
	movl	-12(%rbp), %ecx
	movl	-36(%rbp), %eax
	addl	%eax, %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_GetBBXPixel@PLT
	.loc 1 62 10
	testl	%eax, %eax
	je	.L5
	.loc 1 64 4
	orl	$128, -4(%rbp)
.L5:
	.loc 1 59 45 discriminator 2
	subl	$1, -8(%rbp)
.L4:
	.loc 1 59 33 discriminator 1
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 59 39 discriminator 1
	movq	-32(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 59 33 discriminator 1
	cmpq	%rax, %rdx
	jge	.L6
	.loc 1 67 10
	movl	-4(%rbp), %eax
	movzbl	%al, %edx
	movq	-24(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetData@PLT
	.loc 1 67 8
	testl	%eax, %eax
	jns	.L7
	.loc 1 68 14
	movl	$0, %eax
	jmp	.L8
.L7:
	.loc 1 56 42 discriminator 2
	addl	$1, -12(%rbp)
.L3:
	.loc 1 56 22 discriminator 1
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 56 27 discriminator 1
	movq	-32(%rbp), %rax
	movq	16(%rax), %rcx
	.loc 1 56 36 discriminator 1
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 56 31 discriminator 1
	addq	%rcx, %rax
	.loc 1 56 22 discriminator 1
	cmpq	%rax, %rdx
	jl	.L9
	.loc 1 71 10
	movl	$1, %eax
.L8:
	.loc 1 72 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	bg_8x8_convert, .-bg_8x8_convert
	.section	.rodata
	.align 8
.LC0:
	.string	"Generate8x8Font: Error, glyph width is not multiple of 8, width=%d, encoding=%d"
	.align 8
.LC1:
	.string	"Generate8x8Font: Error, glyph height is not multiple of 8, height=%d, encoding=%d"
	.align 8
.LC2:
	.string	"Generate8x8Font: Error, 8x8 conversion, encoding=%d"
	.align 8
.LC3:
	.string	"Generate8x8Font: Error, glyph size incorrect, size=%d, encoding=%d"
	.align 8
.LC4:
	.string	"Generate8x8Font: Tile size width=%d height=%d"
.LC5:
	.string	"Generate8x8Font: Font size %d"
	.text
	.globl	bf_Generate8x8Font
	.type	bf_Generate8x8Font, @function
bf_Generate8x8Font:
.LFB7:
	.loc 1 76 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -104(%rbp)
	movl	%esi, -108(%rbp)
	movl	%edx, -112(%rbp)
	.loc 1 76 1
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	.loc 1 86 10
	movl	$0, -88(%rbp)
	.loc 1 86 3
	jmp	.L11
.L20:
	.loc 1 88 12
	movq	-104(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 88 24
	movl	-88(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	.loc 1 88 8
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	.loc 1 89 12
	movq	-56(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 89 8
	testq	%rax, %rax
	js	.L12
	.loc 1 91 7
	movq	-56(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	movq	-104(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	bf_copy_bbx_and_update_shift@PLT
	.loc 1 93 22
	movq	-48(%rbp), %rax
	.loc 1 93 25
	andl	$7, %eax
	.loc 1 93 10
	testq	%rax, %rax
	je	.L13
	.loc 1 95 2
	movq	-56(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-48(%rbp), %rdx
	movq	-104(%rbp), %rax
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	jmp	.L12
.L13:
	.loc 1 99 17
	movq	-40(%rbp), %rax
	.loc 1 99 20
	andl	$7, %eax
	.loc 1 99 5
	testq	%rax, %rax
	je	.L14
	.loc 1 101 4
	movq	-56(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-40(%rbp), %rdx
	movq	-104(%rbp), %rax
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	jmp	.L12
.L14:
	.loc 1 105 4
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	bg_ClearTargetData@PLT
	.loc 1 106 11
	movl	$0, -60(%rbp)
	.loc 1 106 4
	jmp	.L15
.L19:
	.loc 1 108 13
	movl	$0, -64(%rbp)
	.loc 1 108 6
	jmp	.L16
.L18:
	.loc 1 112 60
	movq	-104(%rbp), %rax
	movl	1308(%rax), %eax
	.loc 1 112 73
	subl	-60(%rbp), %eax
	.loc 1 112 75
	subl	$1, %eax
	.loc 1 112 56
	leal	0(,%rax,8), %edx
	.loc 1 112 13
	movl	-112(%rbp), %eax
	leal	(%rdx,%rax), %ecx
	.loc 1 112 48
	movl	-64(%rbp), %eax
	leal	0(,%rax,8), %edx
	.loc 1 112 13
	movl	-108(%rbp), %eax
	addl	%eax, %edx
	leaq	-48(%rbp), %rsi
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	bg_8x8_convert
	.loc 1 112 11
	testl	%eax, %eax
	jne	.L17
	.loc 1 114 3
	movq	-56(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-56(%rbp), %rax
	movl	116(%rax), %edx
	movq	-104(%rbp), %rax
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
.L17:
	.loc 1 108 40 discriminator 2
	addl	$1, -64(%rbp)
.L16:
	.loc 1 108 24 discriminator 1
	movq	-104(%rbp), %rax
	movl	1304(%rax), %eax
	.loc 1 108 20 discriminator 1
	cmpl	%eax, -64(%rbp)
	jl	.L18
	.loc 1 106 38 discriminator 2
	addl	$1, -60(%rbp)
.L15:
	.loc 1 106 22 discriminator 1
	movq	-104(%rbp), %rax
	movl	1308(%rax), %eax
	.loc 1 106 18 discriminator 1
	cmpl	%eax, -60(%rbp)
	jl	.L19
.L12:
	.loc 1 86 35 discriminator 2
	addl	$1, -88(%rbp)
.L11:
	.loc 1 86 21 discriminator 1
	movq	-104(%rbp), %rax
	movl	16(%rax), %eax
	.loc 1 86 17 discriminator 1
	cmpl	%eax, -88(%rbp)
	jl	.L20
	.loc 1 125 9
	movl	$-1, -76(%rbp)
	.loc 1 126 8
	movl	$-1, -72(%rbp)
	.loc 1 128 10
	movl	$0, -84(%rbp)
	.loc 1 128 3
	jmp	.L21
.L27:
	.loc 1 130 12
	movl	$0, -88(%rbp)
	.loc 1 130 5
	jmp	.L22
.L26:
	.loc 1 132 14
	movq	-104(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 132 26
	movl	-88(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	.loc 1 132 10
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	.loc 1 133 14
	movq	-56(%rbp), %rax
	movq	16(%rax), %rdx
	.loc 1 133 23
	movl	-84(%rbp), %eax
	cltq
	.loc 1 133 10
	cmpq	%rax, %rdx
	jne	.L23
	.loc 1 135 9
	movq	-56(%rbp), %rax
	movq	104(%rax), %rax
	.loc 1 135 5
	testq	%rax, %rax
	je	.L23
	.loc 1 139 11
	movq	-56(%rbp), %rax
	movl	116(%rax), %edx
	.loc 1 139 29
	movq	-104(%rbp), %rax
	movl	1304(%rax), %ecx
	.loc 1 139 45
	movq	-104(%rbp), %rax
	movl	1308(%rax), %eax
	.loc 1 139 42
	imull	%ecx, %eax
	.loc 1 139 58
	sall	$3, %eax
	.loc 1 139 7
	cmpl	%eax, %edx
	je	.L24
	.loc 1 141 6
	movq	-56(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-56(%rbp), %rax
	movl	116(%rax), %edx
	movq	-104(%rbp), %rax
	leaq	.LC3(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	jmp	.L23
.L24:
	.loc 1 145 9
	cmpl	$0, -76(%rbp)
	jns	.L25
	.loc 1 146 14
	movl	-84(%rbp), %eax
	movl	%eax, -76(%rbp)
.L25:
	.loc 1 147 11
	movl	-84(%rbp), %eax
	movl	%eax, -72(%rbp)
.L23:
	.loc 1 130 37 discriminator 2
	addl	$1, -88(%rbp)
.L22:
	.loc 1 130 23 discriminator 1
	movq	-104(%rbp), %rax
	movl	16(%rax), %eax
	.loc 1 130 19 discriminator 1
	cmpl	%eax, -88(%rbp)
	jl	.L26
	.loc 1 128 25 discriminator 2
	addl	$1, -84(%rbp)
.L21:
	.loc 1 128 17 discriminator 1
	cmpl	$255, -84(%rbp)
	jle	.L27
	.loc 1 156 3
	movl	-76(%rbp), %eax
	movzbl	%al, %edx
	movq	-104(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 157 3
	movl	-72(%rbp), %eax
	movzbl	%al, %edx
	movq	-104(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 158 26
	movq	-104(%rbp), %rax
	movl	1304(%rax), %eax
	.loc 1 158 3
	movzbl	%al, %edx
	movq	-104(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 159 26
	movq	-104(%rbp), %rax
	movl	1308(%rax), %eax
	.loc 1 159 3
	movzbl	%al, %edx
	movq	-104(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 160 3
	movq	-104(%rbp), %rax
	movl	1308(%rax), %ecx
	movq	-104(%rbp), %rax
	movl	1304(%rax), %edx
	movq	-104(%rbp), %rax
	leaq	.LC4(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 163 10
	movl	-76(%rbp), %eax
	movl	%eax, -84(%rbp)
	.loc 1 163 3
	jmp	.L28
.L37:
	.loc 1 165 22
	movl	$0, -68(%rbp)
	.loc 1 166 12
	movl	$0, -88(%rbp)
	.loc 1 166 5
	jmp	.L29
.L33:
	.loc 1 168 14
	movq	-104(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 168 26
	movl	-88(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	.loc 1 168 10
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	.loc 1 169 14
	movq	-56(%rbp), %rax
	movq	16(%rax), %rdx
	.loc 1 169 23
	movl	-84(%rbp), %eax
	cltq
	.loc 1 169 10
	cmpq	%rax, %rdx
	jne	.L30
	.loc 1 171 9
	movq	-56(%rbp), %rax
	movq	104(%rax), %rax
	.loc 1 171 5
	testq	%rax, %rax
	je	.L30
	.loc 1 174 11
	movq	-56(%rbp), %rax
	movl	116(%rax), %edx
	.loc 1 174 29
	movq	-104(%rbp), %rax
	movl	1304(%rax), %ecx
	.loc 1 174 45
	movq	-104(%rbp), %rax
	movl	1308(%rax), %eax
	.loc 1 174 42
	imull	%ecx, %eax
	.loc 1 174 58
	sall	$3, %eax
	.loc 1 174 7
	cmpl	%eax, %edx
	jne	.L30
	.loc 1 176 13
	movl	$0, -80(%rbp)
	.loc 1 176 6
	jmp	.L31
.L32:
	.loc 1 178 31 discriminator 3
	movq	-56(%rbp), %rax
	movq	104(%rax), %rdx
	.loc 1 178 44 discriminator 3
	movl	-80(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	.loc 1 178 8 discriminator 3
	movzbl	%al, %edx
	movq	-104(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 176 39 discriminator 3
	addl	$1, -80(%rbp)
.L31:
	.loc 1 176 24 discriminator 1
	movq	-56(%rbp), %rax
	movl	116(%rax), %eax
	.loc 1 176 20 discriminator 1
	cmpl	%eax, -80(%rbp)
	jl	.L32
	.loc 1 180 23
	movl	$1, -68(%rbp)
.L30:
	.loc 1 166 37 discriminator 2
	addl	$1, -88(%rbp)
.L29:
	.loc 1 166 23 discriminator 1
	movq	-104(%rbp), %rax
	movl	16(%rax), %eax
	.loc 1 166 19 discriminator 1
	cmpl	%eax, -88(%rbp)
	jl	.L33
	.loc 1 185 8
	cmpl	$0, -68(%rbp)
	jne	.L34
	.loc 1 187 14
	movl	$0, -80(%rbp)
	.loc 1 187 7
	jmp	.L35
.L36:
	.loc 1 189 2 discriminator 3
	movq	-104(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 187 59 discriminator 3
	addl	$1, -80(%rbp)
.L35:
	.loc 1 187 25 discriminator 1
	movq	-104(%rbp), %rax
	movl	1304(%rax), %edx
	.loc 1 187 41 discriminator 1
	movq	-104(%rbp), %rax
	movl	1308(%rax), %eax
	.loc 1 187 38 discriminator 1
	imull	%edx, %eax
	.loc 1 187 54 discriminator 1
	sall	$3, %eax
	.loc 1 187 21 discriminator 1
	cmpl	%eax, -80(%rbp)
	jl	.L36
.L34:
	.loc 1 163 31 discriminator 2
	addl	$1, -84(%rbp)
.L28:
	.loc 1 163 21 discriminator 1
	movl	-84(%rbp), %eax
	cmpl	-72(%rbp), %eax
	jle	.L37
	.loc 1 195 3
	movq	-104(%rbp), %rax
	movl	1300(%rax), %edx
	movq	-104(%rbp), %rax
	leaq	.LC5(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 196 1
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L38
	call	__stack_chk_fail@PLT
.L38:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	bf_Generate8x8Font, .-bf_Generate8x8Font
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h"
	.file 3 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 4 "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h"
	.file 5 "/usr/include/x86_64-linux-gnu/bits/types/FILE.h"
	.file 6 "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h"
	.file 7 "bdf_glyph.h"
	.file 8 "bdf_font.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x856
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x12
	.long	.LASF121
	.byte	0x1d
	.long	.LASF0
	.long	.LASF1
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x6
	.long	.LASF7
	.byte	0x2
	.byte	0xd1
	.byte	0x17
	.long	0x3a
	.uleb128 0x5
	.byte	0x8
	.byte	0x7
	.long	.LASF2
	.uleb128 0x5
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x13
	.byte	0x8
	.uleb128 0x5
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x5
	.byte	0x2
	.byte	0x7
	.long	.LASF5
	.uleb128 0x5
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x6
	.long	.LASF8
	.byte	0x3
	.byte	0x26
	.byte	0x17
	.long	0x4a
	.uleb128 0x5
	.byte	0x2
	.byte	0x5
	.long	.LASF9
	.uleb128 0x14
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x5
	.byte	0x8
	.byte	0x5
	.long	.LASF10
	.uleb128 0x6
	.long	.LASF11
	.byte	0x3
	.byte	0x98
	.byte	0x19
	.long	0x79
	.uleb128 0x6
	.long	.LASF12
	.byte	0x3
	.byte	0x99
	.byte	0x1b
	.long	0x79
	.uleb128 0x4
	.long	0x9d
	.uleb128 0x5
	.byte	0x1
	.byte	0x6
	.long	.LASF13
	.uleb128 0xb
	.long	.LASF52
	.byte	0xd8
	.byte	0x4
	.byte	0x31
	.long	0x22a
	.uleb128 0x1
	.long	.LASF14
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.long	0x72
	.byte	0
	.uleb128 0x1
	.long	.LASF15
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.long	0x98
	.byte	0x8
	.uleb128 0x1
	.long	.LASF16
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.long	0x98
	.byte	0x10
	.uleb128 0x1
	.long	.LASF17
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.long	0x98
	.byte	0x18
	.uleb128 0x1
	.long	.LASF18
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.long	0x98
	.byte	0x20
	.uleb128 0x1
	.long	.LASF19
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.long	0x98
	.byte	0x28
	.uleb128 0x1
	.long	.LASF20
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.long	0x98
	.byte	0x30
	.uleb128 0x1
	.long	.LASF21
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.long	0x98
	.byte	0x38
	.uleb128 0x1
	.long	.LASF22
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.long	0x98
	.byte	0x40
	.uleb128 0x1
	.long	.LASF23
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.long	0x98
	.byte	0x48
	.uleb128 0x1
	.long	.LASF24
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.long	0x98
	.byte	0x50
	.uleb128 0x1
	.long	.LASF25
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.long	0x98
	.byte	0x58
	.uleb128 0x1
	.long	.LASF26
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.long	0x243
	.byte	0x60
	.uleb128 0x1
	.long	.LASF27
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.long	0x248
	.byte	0x68
	.uleb128 0x1
	.long	.LASF28
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.long	0x72
	.byte	0x70
	.uleb128 0x1
	.long	.LASF29
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.long	0x72
	.byte	0x74
	.uleb128 0x1
	.long	.LASF30
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.long	0x80
	.byte	0x78
	.uleb128 0x1
	.long	.LASF31
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.long	0x51
	.byte	0x80
	.uleb128 0x1
	.long	.LASF32
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.long	0x58
	.byte	0x82
	.uleb128 0x1
	.long	.LASF33
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.long	0x24d
	.byte	0x83
	.uleb128 0x1
	.long	.LASF34
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.long	0x25d
	.byte	0x88
	.uleb128 0x1
	.long	.LASF35
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.long	0x8c
	.byte	0x90
	.uleb128 0x1
	.long	.LASF36
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.long	0x267
	.byte	0x98
	.uleb128 0x1
	.long	.LASF37
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.long	0x271
	.byte	0xa0
	.uleb128 0x1
	.long	.LASF38
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.long	0x248
	.byte	0xa8
	.uleb128 0x1
	.long	.LASF39
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.long	0x48
	.byte	0xb0
	.uleb128 0x1
	.long	.LASF40
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.long	0x2e
	.byte	0xb8
	.uleb128 0x1
	.long	.LASF41
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.long	0x72
	.byte	0xc0
	.uleb128 0x1
	.long	.LASF42
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.long	0x276
	.byte	0xc4
	.byte	0
	.uleb128 0x6
	.long	.LASF43
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.long	0xa4
	.uleb128 0x15
	.long	.LASF122
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0xc
	.long	.LASF44
	.uleb128 0x4
	.long	0x23e
	.uleb128 0x4
	.long	0xa4
	.uleb128 0xd
	.long	0x9d
	.long	0x25d
	.uleb128 0x10
	.long	0x3a
	.byte	0
	.byte	0
	.uleb128 0x4
	.long	0x236
	.uleb128 0xc
	.long	.LASF45
	.uleb128 0x4
	.long	0x262
	.uleb128 0xc
	.long	.LASF46
	.uleb128 0x4
	.long	0x26c
	.uleb128 0xd
	.long	0x9d
	.long	0x286
	.uleb128 0x10
	.long	0x3a
	.byte	0x13
	.byte	0
	.uleb128 0x4
	.long	0x22a
	.uleb128 0x5
	.byte	0x8
	.byte	0x5
	.long	.LASF47
	.uleb128 0x5
	.byte	0x8
	.byte	0x7
	.long	.LASF48
	.uleb128 0x6
	.long	.LASF49
	.byte	0x6
	.byte	0x18
	.byte	0x13
	.long	0x5f
	.uleb128 0x5
	.byte	0x10
	.byte	0x4
	.long	.LASF50
	.uleb128 0x6
	.long	.LASF51
	.byte	0x7
	.byte	0x9
	.byte	0x21
	.long	0x2b8
	.uleb128 0x16
	.long	.LASF53
	.value	0x520
	.byte	0x8
	.byte	0x16
	.byte	0x8
	.long	0x4d9
	.uleb128 0x1
	.long	.LASF54
	.byte	0x8
	.byte	0x18
	.byte	0x7
	.long	0x72
	.byte	0
	.uleb128 0x1
	.long	.LASF55
	.byte	0x8
	.byte	0x1a
	.byte	0xa
	.long	0x658
	.byte	0x8
	.uleb128 0x1
	.long	.LASF56
	.byte	0x8
	.byte	0x1b
	.byte	0x7
	.long	0x72
	.byte	0x10
	.uleb128 0x1
	.long	.LASF57
	.byte	0x8
	.byte	0x1c
	.byte	0x7
	.long	0x72
	.byte	0x14
	.uleb128 0x1
	.long	.LASF58
	.byte	0x8
	.byte	0x1f
	.byte	0x8
	.long	0x662
	.byte	0x18
	.uleb128 0x2
	.long	.LASF59
	.byte	0x20
	.byte	0x7
	.long	0x72
	.value	0x418
	.uleb128 0x2
	.long	.LASF60
	.byte	0x21
	.byte	0x7
	.long	0x72
	.value	0x41c
	.uleb128 0x2
	.long	.LASF61
	.byte	0x23
	.byte	0x8
	.long	0x79
	.value	0x420
	.uleb128 0x2
	.long	.LASF62
	.byte	0x25
	.byte	0x8
	.long	0x79
	.value	0x428
	.uleb128 0x2
	.long	.LASF63
	.byte	0x26
	.byte	0x8
	.long	0x79
	.value	0x430
	.uleb128 0x2
	.long	.LASF64
	.byte	0x28
	.byte	0x8
	.long	0x79
	.value	0x438
	.uleb128 0x2
	.long	.LASF65
	.byte	0x29
	.byte	0x8
	.long	0x79
	.value	0x440
	.uleb128 0x2
	.long	.LASF66
	.byte	0x2a
	.byte	0x8
	.long	0x79
	.value	0x448
	.uleb128 0x2
	.long	.LASF67
	.byte	0x2b
	.byte	0x8
	.long	0x79
	.value	0x450
	.uleb128 0x2
	.long	.LASF68
	.byte	0x2d
	.byte	0x7
	.long	0x72
	.value	0x458
	.uleb128 0x2
	.long	.LASF69
	.byte	0x2e
	.byte	0x7
	.long	0x72
	.value	0x45c
	.uleb128 0x2
	.long	.LASF70
	.byte	0x2f
	.byte	0x7
	.long	0x72
	.value	0x460
	.uleb128 0x11
	.string	"fp"
	.byte	0x30
	.long	0x286
	.value	0x468
	.uleb128 0x2
	.long	.LASF71
	.byte	0x32
	.byte	0x9
	.long	0x98
	.value	0x470
	.uleb128 0x2
	.long	.LASF72
	.byte	0x33
	.byte	0x9
	.long	0x98
	.value	0x478
	.uleb128 0x2
	.long	.LASF73
	.byte	0x35
	.byte	0x8
	.long	0x79
	.value	0x480
	.uleb128 0x2
	.long	.LASF74
	.byte	0x37
	.byte	0x7
	.long	0x72
	.value	0x488
	.uleb128 0x11
	.string	"max"
	.byte	0x39
	.long	0x50e
	.value	0x490
	.uleb128 0x2
	.long	.LASF75
	.byte	0x3c
	.byte	0x8
	.long	0x79
	.value	0x4b0
	.uleb128 0x2
	.long	.LASF76
	.byte	0x3d
	.byte	0x8
	.long	0x79
	.value	0x4b8
	.uleb128 0x2
	.long	.LASF77
	.byte	0x3e
	.byte	0x8
	.long	0x79
	.value	0x4c0
	.uleb128 0x2
	.long	.LASF78
	.byte	0x3f
	.byte	0x8
	.long	0x79
	.value	0x4c8
	.uleb128 0x2
	.long	.LASF79
	.byte	0x42
	.byte	0x8
	.long	0x79
	.value	0x4d0
	.uleb128 0x2
	.long	.LASF80
	.byte	0x43
	.byte	0x8
	.long	0x79
	.value	0x4d8
	.uleb128 0x2
	.long	.LASF81
	.byte	0x46
	.byte	0x8
	.long	0x79
	.value	0x4e0
	.uleb128 0x2
	.long	.LASF82
	.byte	0x47
	.byte	0x8
	.long	0x79
	.value	0x4e8
	.uleb128 0x2
	.long	.LASF83
	.byte	0x4a
	.byte	0x7
	.long	0x72
	.value	0x4f0
	.uleb128 0x2
	.long	.LASF84
	.byte	0x4b
	.byte	0x7
	.long	0x72
	.value	0x4f4
	.uleb128 0x2
	.long	.LASF85
	.byte	0x4c
	.byte	0x7
	.long	0x72
	.value	0x4f8
	.uleb128 0x2
	.long	.LASF86
	.byte	0x4d
	.byte	0x7
	.long	0x72
	.value	0x4fc
	.uleb128 0x2
	.long	.LASF87
	.byte	0x4e
	.byte	0x7
	.long	0x72
	.value	0x500
	.uleb128 0x2
	.long	.LASF88
	.byte	0x51
	.byte	0xc
	.long	0x647
	.value	0x508
	.uleb128 0x2
	.long	.LASF89
	.byte	0x52
	.byte	0x7
	.long	0x72
	.value	0x510
	.uleb128 0x2
	.long	.LASF90
	.byte	0x53
	.byte	0x7
	.long	0x72
	.value	0x514
	.uleb128 0x2
	.long	.LASF91
	.byte	0x56
	.byte	0x7
	.long	0x72
	.value	0x518
	.uleb128 0x2
	.long	.LASF92
	.byte	0x57
	.byte	0x7
	.long	0x72
	.value	0x51c
	.byte	0
	.uleb128 0xb
	.long	.LASF93
	.byte	0x20
	.byte	0x7
	.byte	0xc
	.long	0x50e
	.uleb128 0x9
	.string	"w"
	.byte	0xe
	.byte	0x8
	.long	0x79
	.byte	0
	.uleb128 0x9
	.string	"h"
	.byte	0xf
	.byte	0x8
	.long	0x79
	.byte	0x8
	.uleb128 0x9
	.string	"x"
	.byte	0x10
	.byte	0x8
	.long	0x79
	.byte	0x10
	.uleb128 0x9
	.string	"y"
	.byte	0x11
	.byte	0x8
	.long	0x79
	.byte	0x18
	.byte	0
	.uleb128 0x6
	.long	.LASF94
	.byte	0x7
	.byte	0x13
	.byte	0x1c
	.long	0x4d9
	.uleb128 0xb
	.long	.LASF95
	.byte	0xa0
	.byte	0x7
	.byte	0x16
	.long	0x642
	.uleb128 0x9
	.string	"bf"
	.byte	0x18
	.byte	0x9
	.long	0x642
	.byte	0
	.uleb128 0x1
	.long	.LASF61
	.byte	0x7
	.byte	0x1a
	.byte	0x8
	.long	0x79
	.byte	0x8
	.uleb128 0x1
	.long	.LASF96
	.byte	0x7
	.byte	0x1b
	.byte	0x8
	.long	0x79
	.byte	0x10
	.uleb128 0x1
	.long	.LASF62
	.byte	0x7
	.byte	0x1d
	.byte	0x8
	.long	0x79
	.byte	0x18
	.uleb128 0x1
	.long	.LASF63
	.byte	0x7
	.byte	0x1e
	.byte	0x8
	.long	0x79
	.byte	0x20
	.uleb128 0x9
	.string	"bbx"
	.byte	0x20
	.byte	0x9
	.long	0x50e
	.byte	0x28
	.uleb128 0x1
	.long	.LASF97
	.byte	0x7
	.byte	0x21
	.byte	0x8
	.long	0x79
	.byte	0x48
	.uleb128 0x1
	.long	.LASF98
	.byte	0x7
	.byte	0x22
	.byte	0x7
	.long	0x72
	.byte	0x50
	.uleb128 0x1
	.long	.LASF99
	.byte	0x7
	.byte	0x24
	.byte	0xc
	.long	0x647
	.byte	0x58
	.uleb128 0x1
	.long	.LASF100
	.byte	0x7
	.byte	0x25
	.byte	0x7
	.long	0x72
	.byte	0x60
	.uleb128 0x1
	.long	.LASF101
	.byte	0x7
	.byte	0x26
	.byte	0x7
	.long	0x72
	.byte	0x64
	.uleb128 0x1
	.long	.LASF88
	.byte	0x7
	.byte	0x2b
	.byte	0xc
	.long	0x647
	.byte	0x68
	.uleb128 0x1
	.long	.LASF89
	.byte	0x7
	.byte	0x2c
	.byte	0x7
	.long	0x72
	.byte	0x70
	.uleb128 0x1
	.long	.LASF90
	.byte	0x7
	.byte	0x2d
	.byte	0x7
	.long	0x72
	.byte	0x74
	.uleb128 0x1
	.long	.LASF102
	.byte	0x7
	.byte	0x2e
	.byte	0x7
	.long	0x72
	.byte	0x78
	.uleb128 0x1
	.long	.LASF103
	.byte	0x7
	.byte	0x32
	.byte	0xc
	.long	0x41
	.byte	0x7c
	.uleb128 0x1
	.long	.LASF104
	.byte	0x7
	.byte	0x33
	.byte	0xc
	.long	0x41
	.byte	0x80
	.uleb128 0x1
	.long	.LASF105
	.byte	0x7
	.byte	0x35
	.byte	0x7
	.long	0x72
	.byte	0x84
	.uleb128 0x1
	.long	.LASF106
	.byte	0x7
	.byte	0x36
	.byte	0xc
	.long	0x41
	.byte	0x88
	.uleb128 0x1
	.long	.LASF107
	.byte	0x7
	.byte	0x37
	.byte	0xc
	.long	0x41
	.byte	0x8c
	.uleb128 0x1
	.long	.LASF108
	.byte	0x7
	.byte	0x38
	.byte	0xc
	.long	0x41
	.byte	0x90
	.uleb128 0x1
	.long	.LASF109
	.byte	0x7
	.byte	0x3a
	.byte	0x8
	.long	0x79
	.byte	0x98
	.byte	0
	.uleb128 0x4
	.long	0x2ac
	.uleb128 0x4
	.long	0x299
	.uleb128 0x6
	.long	.LASF110
	.byte	0x7
	.byte	0x3d
	.byte	0x22
	.long	0x51a
	.uleb128 0x4
	.long	0x65d
	.uleb128 0x4
	.long	0x64c
	.uleb128 0xd
	.long	0x9d
	.long	0x673
	.uleb128 0x17
	.long	0x3a
	.value	0x3ff
	.byte	0
	.uleb128 0xe
	.long	.LASF114
	.byte	0x8
	.byte	0x6a
	.long	0x72
	.long	0x68d
	.uleb128 0x3
	.long	0x642
	.uleb128 0x3
	.long	0x299
	.byte	0
	.uleb128 0xf
	.long	.LASF111
	.byte	0x7
	.byte	0x42
	.long	0x69e
	.uleb128 0x3
	.long	0x65d
	.byte	0
	.uleb128 0xf
	.long	.LASF112
	.byte	0x8
	.byte	0x5f
	.long	0x6b5
	.uleb128 0x3
	.long	0x642
	.uleb128 0x3
	.long	0x98
	.uleb128 0x18
	.byte	0
	.uleb128 0xf
	.long	.LASF113
	.byte	0x8
	.byte	0x7c
	.long	0x6d0
	.uleb128 0x3
	.long	0x642
	.uleb128 0x3
	.long	0x6d0
	.uleb128 0x3
	.long	0x65d
	.byte	0
	.uleb128 0x4
	.long	0x50e
	.uleb128 0xe
	.long	.LASF115
	.byte	0x7
	.byte	0x41
	.long	0x72
	.long	0x6ef
	.uleb128 0x3
	.long	0x65d
	.uleb128 0x3
	.long	0x299
	.byte	0
	.uleb128 0xe
	.long	.LASF116
	.byte	0x7
	.byte	0x4a
	.long	0x72
	.long	0x70e
	.uleb128 0x3
	.long	0x65d
	.uleb128 0x3
	.long	0x72
	.uleb128 0x3
	.long	0x72
	.byte	0
	.uleb128 0x19
	.long	.LASF123
	.byte	0x1
	.byte	0x4b
	.byte	0x6
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x7e1
	.uleb128 0x8
	.string	"bf"
	.byte	0x4b
	.byte	0x1f
	.long	0x642
	.uleb128 0x3
	.byte	0x91
	.sleb128 -120
	.uleb128 0x8
	.string	"xo"
	.byte	0x4b
	.byte	0x27
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -124
	.uleb128 0x8
	.string	"yo"
	.byte	0x4b
	.byte	0x2f
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x7
	.string	"i"
	.byte	0x4d
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x7
	.string	"j"
	.byte	0x4d
	.byte	0xa
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -100
	.uleb128 0x7
	.string	"k"
	.byte	0x4d
	.byte	0xd
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x7
	.string	"bg"
	.byte	0x4e
	.byte	0x9
	.long	0x65d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0xa
	.long	.LASF117
	.byte	0x4f
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -92
	.uleb128 0xa
	.long	.LASF118
	.byte	0x4f
	.byte	0xe
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0xa
	.long	.LASF119
	.byte	0x50
	.byte	0x9
	.long	0x50e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0xa
	.long	.LASF120
	.byte	0x51
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -84
	.uleb128 0x7
	.string	"x"
	.byte	0x52
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x7
	.string	"y"
	.byte	0x52
	.byte	0xa
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -76
	.byte	0
	.uleb128 0x1a
	.long	.LASF124
	.byte	0x1
	.byte	0x16
	.byte	0xc
	.long	0x72
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x8
	.string	"bg"
	.byte	0x16
	.byte	0x21
	.long	0x65d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x8
	.string	"bbx"
	.byte	0x16
	.byte	0x2c
	.long	0x6d0
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x8
	.string	"xo"
	.byte	0x16
	.byte	0x35
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x8
	.string	"yo"
	.byte	0x16
	.byte	0x3d
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x7
	.string	"x"
	.byte	0x18
	.byte	0x7
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x7
	.string	"y"
	.byte	0x19
	.byte	0x7
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x7
	.string	"d"
	.byte	0x1a
	.byte	0x7
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
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
	.uleb128 0x6
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
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0xc
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
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
	.sleb128 5
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
	.uleb128 0xf
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
	.uleb128 0x10
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x11
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
	.uleb128 0x12
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
	.uleb128 0x13
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x14
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
	.uleb128 0x15
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
	.uleb128 0x16
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
	.uleb128 0x17
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x19
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
	.uleb128 0x1a
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
	.uleb128 0x7c
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
.LASF118:
	.string	"last"
.LASF54:
	.string	"is_verbose"
.LASF33:
	.string	"_shortbuf"
.LASF71:
	.string	"str_font"
.LASF122:
	.string	"_IO_lock_t"
.LASF22:
	.string	"_IO_buf_end"
.LASF95:
	.string	"_bdf_glyph_struct"
.LASF81:
	.string	"x_min"
.LASF53:
	.string	"_bdf_font_struct"
.LASF96:
	.string	"map_to"
.LASF20:
	.string	"_IO_write_end"
.LASF3:
	.string	"unsigned int"
.LASF38:
	.string	"_freeres_list"
.LASF14:
	.string	"_flags"
.LASF58:
	.string	"line_buf"
.LASF26:
	.string	"_markers"
.LASF88:
	.string	"target_data"
.LASF60:
	.string	"is_bitmap_parsing"
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
.LASF93:
	.string	"_bbx_struct"
.LASF25:
	.string	"_IO_save_end"
.LASF45:
	.string	"_IO_codecvt"
.LASF115:
	.string	"bg_AddTargetData"
.LASF99:
	.string	"bitmap_data"
.LASF56:
	.string	"glyph_cnt"
.LASF48:
	.string	"long long unsigned int"
.LASF114:
	.string	"bf_AddTargetData"
.LASF65:
	.string	"bbx_h"
.LASF24:
	.string	"_IO_backup_base"
.LASF35:
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
.LASF28:
	.string	"_fileno"
.LASF110:
	.string	"bg_t"
.LASF7:
	.string	"size_t"
.LASF17:
	.string	"_IO_read_base"
.LASF75:
	.string	"enc_w"
.LASF62:
	.string	"dwidth_x"
.LASF63:
	.string	"dwidth_y"
.LASF19:
	.string	"_IO_write_ptr"
.LASF57:
	.string	"glyph_max"
.LASF105:
	.string	"rle_is_first"
.LASF13:
	.string	"char"
.LASF41:
	.string	"_mode"
.LASF61:
	.string	"encoding"
.LASF44:
	.string	"_IO_marker"
.LASF15:
	.string	"_IO_read_ptr"
.LASF49:
	.string	"uint8_t"
.LASF87:
	.string	"dx_max_bit_size"
.LASF70:
	.string	"glyph_pos"
.LASF18:
	.string	"_IO_write_base"
.LASF47:
	.string	"long long int"
.LASF23:
	.string	"_IO_save_base"
.LASF90:
	.string	"target_cnt"
.LASF82:
	.string	"x_max"
.LASF55:
	.string	"glyph_list"
.LASF39:
	.string	"_freeres_buf"
.LASF40:
	.string	"__pad5"
.LASF69:
	.string	"bitmap_y"
.LASF112:
	.string	"bf_Log"
.LASF84:
	.string	"bbx_y_max_bit_size"
.LASF102:
	.string	"target_bit_pos"
.LASF103:
	.string	"rle_bits_per_0"
.LASF104:
	.string	"rle_bits_per_1"
.LASF32:
	.string	"_vtable_offset"
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
.LASF16:
	.string	"_IO_read_end"
.LASF68:
	.string	"bitmap_x"
.LASF120:
	.string	"is_glyph_written"
.LASF9:
	.string	"short int"
.LASF10:
	.string	"long int"
.LASF92:
	.string	"tile_v_size"
.LASF46:
	.string	"_IO_wide_data"
.LASF109:
	.string	"width_deviation"
.LASF73:
	.string	"selected_glyphs"
.LASF8:
	.string	"__uint8_t"
.LASF113:
	.string	"bf_copy_bbx_and_update_shift"
.LASF80:
	.string	"dx_max"
.LASF37:
	.string	"_wide_data"
.LASF34:
	.string	"_lock"
.LASF2:
	.string	"long unsigned int"
.LASF30:
	.string	"_old_offset"
.LASF52:
	.string	"_IO_FILE"
.LASF74:
	.string	"bbx_mode"
.LASF76:
	.string	"enc_h"
.LASF4:
	.string	"unsigned char"
.LASF77:
	.string	"enc_x"
.LASF78:
	.string	"enc_y"
.LASF100:
	.string	"bitmap_width"
.LASF123:
	.string	"bf_Generate8x8Font"
.LASF121:
	.string	"GNU C17 11.3.0 -mtune=generic -march=x86-64 -g -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF117:
	.string	"first"
.LASF119:
	.string	"local_bbx"
.LASF36:
	.string	"_codecvt"
.LASF86:
	.string	"bbx_h_max_bit_size"
.LASF11:
	.string	"__off_t"
.LASF116:
	.string	"bg_GetBBXPixel"
.LASF6:
	.string	"signed char"
.LASF51:
	.string	"bf_t"
.LASF5:
	.string	"short unsigned int"
.LASF124:
	.string	"bg_8x8_convert"
.LASF27:
	.string	"_chain"
.LASF43:
	.string	"FILE"
.LASF29:
	.string	"_flags2"
.LASF101:
	.string	"bitmap_height"
.LASF31:
	.string	"_cur_column"
.LASF12:
	.string	"__off64_t"
.LASF111:
	.string	"bg_ClearTargetData"
.LASF42:
	.string	"_unused2"
.LASF21:
	.string	"_IO_buf_base"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"bdf_8x8.c"
.LASF1:
	.string	"/home/dev/Projects/bleskomat/bleskomat-bills-firmware/tools/bdfconv"
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
