	.file	"bdf_rle.c"
	.text
.Ltext0:
	.file 0 "/home/dev/Projects/bleskomat/bleskomat-bills-firmware/tools/bdfconv" "bdf_rle.c"
	.type	bg_err, @function
bg_err:
.LFB6:
	.file 1 "bdf_rle.c"
	.loc 1 276 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	.loc 1 277 3
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
	.loc 1 278 1
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	bg_err, .-bg_err
	.type	bg_init_rle, @function
bg_init_rle:
.LFB7:
	.loc 1 281 1
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
	movl	%edx, -16(%rbp)
	.loc 1 282 18
	movq	-8(%rbp), %rax
	movl	$0, 136(%rax)
	.loc 1 283 20
	movq	-8(%rbp), %rax
	movl	$1, 132(%rax)
	.loc 1 284 22
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, 124(%rax)
	.loc 1 285 22
	movq	-8(%rbp), %rax
	movl	-16(%rbp), %edx
	movl	%edx, 128(%rax)
	.loc 1 286 18
	movq	-8(%rbp), %rax
	movl	$0, 140(%rax)
	.loc 1 287 18
	movq	-8(%rbp), %rax
	movl	$1, 144(%rax)
	.loc 1 288 3
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	bg_ClearTargetData@PLT
	.loc 1 289 1
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	bg_init_rle, .-bg_init_rle
	.section	.rodata
.LC0:
	.string	"error in bg_01_rle 1 0"
.LC1:
	.string	"error in bg_01_rle 1 a"
.LC2:
	.string	"error in bg_01_rle 1 b"
	.text
	.type	bg_01_rle, @function
bg_01_rle:
.LFB8:
	.loc 1 292 1
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
	movl	%edx, -16(%rbp)
	.loc 1 293 10
	movq	-8(%rbp), %rax
	movl	132(%rax), %eax
	.loc 1 293 6
	testl	%eax, %eax
	jne	.L4
	.loc 1 293 35 discriminator 1
	movq	-8(%rbp), %rax
	movl	140(%rax), %eax
	.loc 1 293 30 discriminator 1
	cmpl	%eax, -12(%rbp)
	jne	.L4
	.loc 1 293 58 discriminator 2
	movq	-8(%rbp), %rax
	movl	144(%rax), %eax
	.loc 1 293 53 discriminator 2
	cmpl	%eax, -16(%rbp)
	jne	.L4
	.loc 1 295 7
	movq	-8(%rbp), %rax
	movl	136(%rax), %eax
	.loc 1 295 19
	leal	1(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 136(%rax)
	.loc 1 296 10
	movq	-8(%rbp), %rax
	movl	$1, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 296 8
	testl	%eax, %eax
	jne	.L7
	.loc 1 297 14
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 297 46
	movl	$0, %eax
	jmp	.L6
.L4:
	.loc 1 301 12
	movq	-8(%rbp), %rax
	movl	132(%rax), %eax
	.loc 1 301 8
	testl	%eax, %eax
	jne	.L8
	.loc 1 303 12
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 303 10
	testl	%eax, %eax
	jne	.L9
	.loc 1 304 9
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 304 41
	movl	$0, %eax
	jmp	.L6
.L9:
	.loc 1 305 9
	movq	-8(%rbp), %rax
	movl	136(%rax), %eax
	.loc 1 305 21
	leal	1(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 136(%rax)
.L8:
	.loc 1 307 10
	movq	-8(%rbp), %rax
	movl	124(%rax), %ecx
	movl	-12(%rbp), %edx
	movq	-8(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 307 8
	testl	%eax, %eax
	jne	.L10
	.loc 1 308 14
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 308 46
	movl	$0, %eax
	jmp	.L6
.L10:
	.loc 1 309 10
	movq	-8(%rbp), %rax
	movl	128(%rax), %ecx
	movl	-16(%rbp), %edx
	movq	-8(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 309 8
	testl	%eax, %eax
	jne	.L11
	.loc 1 310 14
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 310 46
	movl	$0, %eax
	jmp	.L6
.L11:
	.loc 1 321 22
	movq	-8(%rbp), %rax
	movl	$0, 132(%rax)
	.loc 1 322 20
	movq	-8(%rbp), %rax
	movl	136(%rax), %edx
	.loc 1 322 24
	movq	-8(%rbp), %rax
	movl	124(%rax), %eax
	.loc 1 322 20
	addl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, 136(%rax)
	.loc 1 323 20
	movq	-8(%rbp), %rax
	movl	136(%rax), %edx
	.loc 1 323 24
	movq	-8(%rbp), %rax
	movl	128(%rax), %eax
	.loc 1 323 20
	addl	%eax, %edx
	movq	-8(%rbp), %rax
	movl	%edx, 136(%rax)
	.loc 1 324 20
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, 140(%rax)
	.loc 1 325 20
	movq	-8(%rbp), %rax
	movl	-16(%rbp), %edx
	movl	%edx, 144(%rax)
.L7:
	.loc 1 327 10
	movl	$1, %eax
.L6:
	.loc 1 328 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	bg_01_rle, .-bg_01_rle
	.type	bg_prepare_01_rle, @function
bg_prepare_01_rle:
.LFB9:
	.loc 1 340 1
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
	movl	%edx, -16(%rbp)
	.loc 1 342 8
	jmp	.L13
.L16:
	.loc 1 344 30
	movq	-8(%rbp), %rax
	movl	124(%rax), %eax
	.loc 1 344 26
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	.loc 1 344 48
	subl	$1, %eax
	.loc 1 344 10
	movl	%eax, %ecx
	movq	-8(%rbp), %rax
	movl	$0, %edx
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_01_rle
	.loc 1 344 8
	testl	%eax, %eax
	jne	.L14
	.loc 1 345 14
	movl	$0, %eax
	jmp	.L15
.L14:
	.loc 1 346 16
	movq	-8(%rbp), %rax
	movl	124(%rax), %eax
	.loc 1 346 12
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	.loc 1 346 7
	movl	%eax, %edx
	movl	-12(%rbp), %eax
	subl	%edx, %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
.L13:
	.loc 1 342 20
	movq	-8(%rbp), %rax
	movl	124(%rax), %eax
	.loc 1 342 16
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	.loc 1 342 38
	subl	$1, %eax
	.loc 1 342 12
	cmpl	%eax, -12(%rbp)
	ja	.L16
	.loc 1 348 8
	jmp	.L17
.L19:
	.loc 1 350 33
	movq	-8(%rbp), %rax
	movl	128(%rax), %eax
	.loc 1 350 29
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	.loc 1 350 51
	subl	$1, %eax
	.loc 1 350 10
	movl	%eax, %edx
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_01_rle
	.loc 1 350 8
	testl	%eax, %eax
	jne	.L18
	.loc 1 351 14
	movl	$0, %eax
	jmp	.L15
.L18:
	.loc 1 352 7
	movl	$0, -12(%rbp)
	.loc 1 353 16
	movq	-8(%rbp), %rax
	movl	128(%rax), %eax
	.loc 1 353 12
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	.loc 1 353 7
	movl	%eax, %edx
	movl	-16(%rbp), %eax
	subl	%edx, %eax
	addl	$1, %eax
	movl	%eax, -16(%rbp)
.L17:
	.loc 1 348 20
	movq	-8(%rbp), %rax
	movl	128(%rax), %eax
	.loc 1 348 16
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	.loc 1 348 38
	subl	$1, %eax
	.loc 1 348 12
	cmpl	%eax, -16(%rbp)
	ja	.L19
	.loc 1 355 6
	cmpl	$0, -12(%rbp)
	jne	.L20
	.loc 1 355 15 discriminator 1
	cmpl	$0, -16(%rbp)
	je	.L21
.L20:
	.loc 1 356 10
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_01_rle
	.loc 1 356 8
	testl	%eax, %eax
	jne	.L21
	.loc 1 357 14
	movl	$0, %eax
	jmp	.L15
.L21:
	.loc 1 358 10
	movl	$1, %eax
.L15:
	.loc 1 359 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	bg_prepare_01_rle, .-bg_prepare_01_rle
	.section	.rodata
.LC3:
	.string	"error in bg_rle_compress"
.LC4:
	.string	"bdf_rle.c"
.LC5:
	.string	"bd_is_one == 0"
	.text
	.globl	bg_rle_compress
	.type	bg_rle_compress, @function
bg_rle_compress:
.LFB10:
	.loc 1 363 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movl	%edx, -52(%rbp)
	movl	%ecx, -56(%rbp)
	movl	%r8d, -60(%rbp)
	.loc 1 374 6
	cmpq	$0, -48(%rbp)
	jne	.L23
	.loc 1 375 9
	movq	-40(%rbp), %rax
	addq	$40, %rax
	movq	%rax, -48(%rbp)
.L23:
	.loc 1 377 3
	movl	-56(%rbp), %edx
	movl	-52(%rbp), %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_init_rle
	.loc 1 382 10
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 382 6
	cmpq	$255, %rax
	jg	.L24
	.loc 1 384 33
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 384 10
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetData@PLT
	.loc 1 384 8
	testl	%eax, %eax
	jns	.L25
	.loc 1 385 14
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 385 48
	movl	$0, %eax
	jmp	.L26
.L24:
	.loc 1 389 33
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 389 42
	sarq	$8, %rax
	.loc 1 389 10
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetData@PLT
	.loc 1 389 8
	testl	%eax, %eax
	jns	.L27
	.loc 1 390 14
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 390 48
	movl	$0, %eax
	jmp	.L26
.L27:
	.loc 1 391 33
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 391 10
	movzbl	%al, %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetData@PLT
	.loc 1 391 8
	testl	%eax, %eax
	jns	.L25
	.loc 1 392 14
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 392 48
	movl	$0, %eax
	jmp	.L26
.L25:
	.loc 1 395 8
	movq	-40(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bg_AddTargetData@PLT
	.loc 1 395 6
	testl	%eax, %eax
	jns	.L28
	.loc 1 396 12
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 396 46
	movl	$0, %eax
	jmp	.L26
.L28:
	.loc 1 402 60
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 402 8
	movl	%eax, %edx
	.loc 1 402 31
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 402 35
	movl	1272(%rax), %eax
	.loc 1 402 8
	movl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 402 6
	testl	%eax, %eax
	jne	.L29
	.loc 1 403 12
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 403 46
	movl	$0, %eax
	jmp	.L26
.L29:
	.loc 1 404 60
	movq	-48(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 404 8
	movl	%eax, %edx
	.loc 1 404 31
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 404 35
	movl	1276(%rax), %eax
	.loc 1 404 8
	movl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 404 6
	testl	%eax, %eax
	jne	.L30
	.loc 1 405 12
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 405 46
	movl	$0, %eax
	jmp	.L26
.L30:
	.loc 1 406 60
	movq	-48(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 406 8
	movl	%eax, %esi
	.loc 1 406 73
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 406 77
	movl	1264(%rax), %eax
	.loc 1 406 97
	subl	$1, %eax
	.loc 1 406 68
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	.loc 1 406 8
	leal	(%rsi,%rax), %edx
	.loc 1 406 31
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 406 35
	movl	1264(%rax), %eax
	.loc 1 406 8
	movl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 406 6
	testl	%eax, %eax
	jne	.L31
	.loc 1 407 12
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 407 46
	movl	$0, %eax
	jmp	.L26
.L31:
	.loc 1 408 60
	movq	-48(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 408 8
	movl	%eax, %esi
	.loc 1 408 73
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 408 77
	movl	1268(%rax), %eax
	.loc 1 408 97
	subl	$1, %eax
	.loc 1 408 68
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	.loc 1 408 8
	leal	(%rsi,%rax), %edx
	.loc 1 408 31
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 408 35
	movl	1268(%rax), %eax
	.loc 1 408 8
	movl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 408 6
	testl	%eax, %eax
	jne	.L32
	.loc 1 409 12
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 409 46
	movl	$0, %eax
	jmp	.L26
.L32:
	.loc 1 411 10
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 411 14
	movl	1160(%rax), %eax
	.loc 1 411 6
	testl	%eax, %eax
	jne	.L33
	.loc 1 413 58
	movq	-40(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 413 10
	movl	%eax, %esi
	.loc 1 413 78
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 413 82
	movl	1280(%rax), %eax
	.loc 1 413 99
	subl	$1, %eax
	.loc 1 413 73
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	.loc 1 413 10
	leal	(%rsi,%rax), %edx
	.loc 1 413 33
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 413 37
	movl	1280(%rax), %eax
	.loc 1 413 10
	movl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 413 8
	testl	%eax, %eax
	jne	.L34
	.loc 1 414 14
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 414 48
	movl	$0, %eax
	jmp	.L26
.L33:
	.loc 1 416 15
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 416 19
	movl	1160(%rax), %eax
	.loc 1 416 11
	cmpl	$2, %eax
	jne	.L35
	.loc 1 418 59
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 418 10
	movl	%eax, %esi
	.loc 1 418 71
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 418 75
	movl	1280(%rax), %eax
	.loc 1 418 92
	subl	$1, %eax
	.loc 1 418 66
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	.loc 1 418 10
	leal	(%rsi,%rax), %edx
	.loc 1 418 33
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 418 37
	movl	1280(%rax), %eax
	.loc 1 418 10
	movl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 418 8
	testl	%eax, %eax
	jne	.L34
	.loc 1 419 14
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 419 48
	movl	$0, %eax
	jmp	.L26
.L35:
	.loc 1 423 59
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 423 10
	movl	%eax, %esi
	.loc 1 423 71
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 423 75
	movl	1280(%rax), %eax
	.loc 1 423 92
	subl	$1, %eax
	.loc 1 423 66
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	.loc 1 423 10
	leal	(%rsi,%rax), %edx
	.loc 1 423 33
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 423 37
	movl	1280(%rax), %eax
	.loc 1 423 10
	movl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 423 8
	testl	%eax, %eax
	jne	.L34
	.loc 1 424 14
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	bg_err
	.loc 1 424 48
	movl	$0, %eax
	jmp	.L26
.L34:
	.loc 1 427 13
	movl	$0, -16(%rbp)
	.loc 1 428 15
	movl	$0, -12(%rbp)
	.loc 1 429 14
	movl	$0, -8(%rbp)
	.loc 1 430 14
	movl	$0, -4(%rbp)
	.loc 1 434 15
	movq	-48(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 434 18
	movl	%eax, %edx
	.loc 1 434 22
	movq	-48(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 434 18
	addl	%edx, %eax
	.loc 1 434 25
	subl	$1, %eax
	.loc 1 434 10
	movl	%eax, -24(%rbp)
	.loc 1 434 3
	jmp	.L36
.L44:
	.loc 1 436 17
	movq	-48(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 436 12
	movl	%eax, -28(%rbp)
	.loc 1 436 5
	jmp	.L37
.L43:
	.loc 1 438 12
	movl	-24(%rbp), %edx
	movl	-28(%rbp), %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_GetBBXPixel@PLT
	.loc 1 438 10
	testl	%eax, %eax
	jne	.L38
	.loc 1 440 5
	cmpl	$0, -16(%rbp)
	je	.L39
	.loc 1 442 24
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	leaq	bd_list.2(%rip), %rdx
	movl	-12(%rbp), %eax
	movl	%eax, (%rcx,%rdx)
	.loc 1 443 14
	movl	$0, -16(%rbp)
	.loc 1 444 14
	addl	$1, -4(%rbp)
	.loc 1 445 16
	movl	$0, -12(%rbp)
.L39:
	.loc 1 447 13
	addl	$1, -12(%rbp)
	jmp	.L40
.L38:
	.loc 1 451 5
	cmpl	$0, -16(%rbp)
	jne	.L41
	.loc 1 453 24
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	leaq	bd_list.2(%rip), %rdx
	movl	-12(%rbp), %eax
	movl	%eax, (%rcx,%rdx)
	.loc 1 454 14
	movl	$1, -16(%rbp)
	.loc 1 455 14
	addl	$1, -4(%rbp)
	.loc 1 456 16
	movl	$0, -12(%rbp)
.L41:
	.loc 1 458 13
	addl	$1, -12(%rbp)
.L40:
	.loc 1 461 10
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.L42
	.loc 1 462 13
	movl	-12(%rbp), %eax
	movl	%eax, -8(%rbp)
.L42:
	.loc 1 436 44 discriminator 2
	addl	$1, -28(%rbp)
.L37:
	.loc 1 436 24 discriminator 1
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 436 29 discriminator 1
	movq	-48(%rbp), %rax
	movq	16(%rax), %rcx
	.loc 1 436 38 discriminator 1
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 436 33 discriminator 1
	addq	%rcx, %rax
	.loc 1 436 24 discriminator 1
	cmpq	%rax, %rdx
	jl	.L43
	.loc 1 434 43 discriminator 2
	subl	$1, -24(%rbp)
.L36:
	.loc 1 434 31 discriminator 1
	movl	-24(%rbp), %eax
	movslq	%eax, %rdx
	.loc 1 434 37 discriminator 1
	movq	-48(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 434 31 discriminator 1
	cmpq	%rax, %rdx
	jge	.L44
	.loc 1 467 23
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	leaq	bd_list.2(%rip), %rdx
	movl	-12(%rbp), %eax
	movl	%eax, (%rcx,%rdx)
	.loc 1 468 13
	addl	$1, -4(%rbp)
	.loc 1 470 20
	movl	-4(%rbp), %eax
	andl	$1, %eax
	.loc 1 470 6
	testl	%eax, %eax
	je	.L45
	.loc 1 472 5
	cmpl	$0, -16(%rbp)
	je	.L46
	.loc 1 472 5 is_stmt 0 discriminator 1
	leaq	__PRETTY_FUNCTION__.1(%rip), %rax
	movq	%rax, %rcx
	movl	$472, %edx
	leaq	.LC4(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	__assert_fail@PLT
.L46:
	.loc 1 473 25 is_stmt 1
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	bd_list.2(%rip), %rax
	movl	$0, (%rdx,%rax)
	.loc 1 474 15
	addl	$1, -4(%rbp)
.L45:
	.loc 1 484 10
	movl	$0, -20(%rbp)
	.loc 1 484 3
	jmp	.L47
.L49:
	.loc 1 489 53
	movl	-20(%rbp), %eax
	addl	$1, %eax
	.loc 1 489 51
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	bd_list.2(%rip), %rax
	movl	(%rdx,%rax), %eax
	.loc 1 489 10
	movl	%eax, %esi
	.loc 1 489 39
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	bd_list.2(%rip), %rax
	movl	(%rdx,%rax), %eax
	.loc 1 489 10
	movl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	%esi, %edx
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	bg_prepare_01_rle
	.loc 1 489 8
	testl	%eax, %eax
	jne	.L48
	.loc 1 490 14
	movl	$0, %eax
	jmp	.L26
.L48:
	.loc 1 484 32 discriminator 2
	addl	$2, -20(%rbp)
.L47:
	.loc 1 484 17 discriminator 1
	movl	-20(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jl	.L49
	.loc 1 497 8
	movq	-40(%rbp), %rax
	movl	$0, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	bg_AddTargetBits@PLT
	.loc 1 497 6
	testl	%eax, %eax
	jne	.L50
	.loc 1 498 12
	movl	$0, %eax
	jmp	.L26
.L50:
	.loc 1 500 8
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	bg_FlushTargetBits@PLT
	.loc 1 500 6
	testl	%eax, %eax
	jne	.L51
	.loc 1 501 12
	movl	$0, %eax
	jmp	.L26
.L51:
	.loc 1 504 10
	movq	-40(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 504 6
	cmpq	$255, %rax
	jg	.L52
	.loc 1 506 28
	movq	-40(%rbp), %rax
	movl	116(%rax), %edx
	.loc 1 506 7
	movq	-40(%rbp), %rax
	movq	104(%rax), %rax
	.loc 1 506 20
	addq	$1, %rax
	.loc 1 506 24
	movb	%dl, (%rax)
	jmp	.L53
.L52:
	.loc 1 510 28
	movq	-40(%rbp), %rax
	movl	116(%rax), %edx
	.loc 1 510 7
	movq	-40(%rbp), %rax
	movq	104(%rax), %rax
	.loc 1 510 20
	addq	$2, %rax
	.loc 1 510 24
	movb	%dl, (%rax)
.L53:
	.loc 1 526 10
	movl	$1, %eax
.L26:
	.loc 1 527 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	bg_rle_compress, .-bg_rle_compress
	.section	.rodata
	.align 8
.LC6:
	.string	"RLE Compress: Encoding %ld bits %u/%u"
	.text
	.globl	bf_RLECompressAllGlyphsWithFieldSize
	.type	bf_RLECompressAllGlyphsWithFieldSize, @function
bf_RLECompressAllGlyphsWithFieldSize:
.LFB11:
	.loc 1 530 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -88(%rbp)
	movl	%esi, -92(%rbp)
	movl	%edx, -96(%rbp)
	movl	%ecx, -100(%rbp)
	.loc 1 530 1
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	.loc 1 533 17
	movq	$0, -64(%rbp)
	.loc 1 536 10
	movl	$0, -68(%rbp)
	.loc 1 536 3
	jmp	.L55
.L57:
	.loc 1 538 12
	movq	-88(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 538 24
	movl	-68(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	.loc 1 538 8
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	.loc 1 539 12
	movq	-56(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 539 8
	testq	%rax, %rax
	js	.L56
	.loc 1 541 7
	movq	-56(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	movq	-88(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	bf_copy_bbx_and_update_shift@PLT
	.loc 1 597 7
	movl	-96(%rbp), %ecx
	movl	-92(%rbp), %edx
	movl	-100(%rbp), %edi
	leaq	-48(%rbp), %rsi
	movq	-56(%rbp), %rax
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	bg_rle_compress
	.loc 1 598 23
	movq	-56(%rbp), %rax
	movl	116(%rax), %eax
	.loc 1 598 35
	leal	0(,%rax,8), %edx
	.loc 1 598 40
	movq	-56(%rbp), %rax
	movl	120(%rax), %eax
	.loc 1 598 37
	addl	%edx, %eax
	cltq
	.loc 1 598 18
	addq	%rax, -64(%rbp)
	.loc 1 599 10
	cmpl	$0, -100(%rbp)
	je	.L56
	.loc 1 601 86
	movq	-56(%rbp), %rax
	movl	116(%rax), %eax
	.loc 1 601 98
	leal	0(,%rax,8), %edx
	.loc 1 601 103
	movq	-56(%rbp), %rax
	movl	120(%rax), %eax
	.loc 1 601 2
	leal	(%rdx,%rax), %esi
	movq	-56(%rbp), %rax
	movl	136(%rax), %ecx
	movq	-56(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-88(%rbp), %rax
	movl	%esi, %r8d
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
.L56:
	.loc 1 536 35 discriminator 2
	addl	$1, -68(%rbp)
.L55:
	.loc 1 536 21 discriminator 1
	movq	-88(%rbp), %rax
	movl	16(%rax), %eax
	.loc 1 536 17 discriminator 1
	cmpl	%eax, -68(%rbp)
	jl	.L57
	.loc 1 606 10
	movq	-64(%rbp), %rax
	.loc 1 607 1
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L59
	call	__stack_chk_fail@PLT
.L59:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	bf_RLECompressAllGlyphsWithFieldSize, .-bf_RLECompressAllGlyphsWithFieldSize
	.globl	bf_RLE_get_glyph_data
	.type	bf_RLE_get_glyph_data, @function
bf_RLE_get_glyph_data:
.LFB12:
	.loc 1 611 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, %eax
	movb	%al, -28(%rbp)
	.loc 1 612 12
	movq	-24(%rbp), %rax
	movq	1288(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 613 8
	addq	$23, -8(%rbp)
.L65:
	.loc 1 616 14
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	.loc 1 616 8
	testb	%al, %al
	je	.L67
	.loc 1 618 14
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	.loc 1 618 8
	cmpb	%al, -28(%rbp)
	jne	.L63
	.loc 1 620 22
	movq	-24(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 620 19
	movq	-8(%rbp), %rax
	subq	%rdx, %rax
	.loc 1 620 36
	subl	$23, %eax
	jmp	.L64
.L63:
	.loc 1 622 17
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	.loc 1 622 10
	addq	%rax, -8(%rbp)
	.loc 1 616 8
	jmp	.L65
.L67:
	.loc 1 617 7
	nop
	.loc 1 624 10
	movl	$0, %eax
.L64:
	.loc 1 625 1
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	bf_RLE_get_glyph_data, .-bf_RLE_get_glyph_data
	.section	.rodata
	.align 8
.LC7:
	.string	"RLE Compress: best zero bits %d, one bits %d, total bit size %lu"
	.align 8
.LC8:
	.string	"RLE Compress: Font code generation, selected glyphs=%d, total glyphs=%d"
	.align 8
.LC9:
	.string	"RLE Compress: Error, glyph too large, encoding=%ld cnt=%d"
	.align 8
.LC10:
	.string	"RLE Compress: ASCII gylphs=%d, Unicode glyphs=%d"
	.align 8
.LC11:
	.string	"RLE Compress: Glyphs per unicode lookup table entry=%d"
	.align 8
.LC12:
	.string	"RLE Compress: Error, glyph too large, encoding=%ld"
	.align 8
.LC13:
	.string	"RLE Compress: Unicode lookup table len=%d, written entries=%d"
	.align 8
.LC14:
	.string	"RLE Compress: Unicode lookup table first entry: delta=%d, encoding=%d"
	.align 8
.LC15:
	.string	"RLE Compress: Unicode lookup table last entry: delta=%d, encoding=%d"
	.align 8
.LC16:
	.string	"RLE Compress: Unicode glyphs written=%d"
	.align 8
.LC17:
	.string	"unicode_lookup_table_len == unicode_lookup_table_pos"
	.align 8
.LC18:
	.string	"RLE Compress: 'A' pos = %u, 'a' pos = %u"
.LC19:
	.string	"RLE Compress: Font size %d"
	.text
	.globl	bf_RLECompressAllGlyphs
	.type	bf_RLECompressAllGlyphs, @function
bf_RLECompressAllGlyphs:
.LFB13:
	.loc 1 629 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$152, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -152(%rbp)
	.loc 1 634 7
	movl	$0, -124(%rbp)
	.loc 1 634 21
	movl	$0, -120(%rbp)
	.loc 1 635 17
	movq	$0, -32(%rbp)
	.loc 1 636 17
	movl	$4294967295, %eax
	movq	%rax, -40(%rbp)
	.loc 1 657 12
	movl	$0, -76(%rbp)
	.loc 1 659 20
	movl	$0, -116(%rbp)
	.loc 1 660 15
	movq	-152(%rbp), %rax
	movl	$65, %esi
	movq	%rax, %rdi
	call	bf_GetIndexByEncoding@PLT
	movl	%eax, -72(%rbp)
	.loc 1 661 6
	cmpl	$0, -72(%rbp)
	js	.L69
	.loc 1 663 26
	movq	-152(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 663 38
	movl	-72(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	.loc 1 663 54
	movq	48(%rax), %rax
	.loc 1 663 56
	movl	%eax, %ecx
	.loc 1 663 59
	movq	-152(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 663 71
	movl	-72(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	.loc 1 663 87
	movq	64(%rax), %rax
	.loc 1 663 56
	addl	%ecx, %eax
	.loc 1 663 22
	movl	%eax, -116(%rbp)
.L69:
	.loc 1 666 16
	movl	$0, -112(%rbp)
	.loc 1 667 11
	movq	-152(%rbp), %rax
	movl	$49, %esi
	movq	%rax, %rdi
	call	bf_GetIndexByEncoding@PLT
	movl	%eax, -68(%rbp)
	.loc 1 668 6
	cmpl	$0, -68(%rbp)
	js	.L70
	.loc 1 670 22
	movq	-152(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 670 34
	movl	-68(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	.loc 1 670 46
	movq	48(%rax), %rax
	.loc 1 670 48
	movl	%eax, %ecx
	.loc 1 670 51
	movq	-152(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 670 63
	movl	-68(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	.loc 1 670 75
	movq	64(%rax), %rax
	.loc 1 670 48
	addl	%ecx, %eax
	.loc 1 670 18
	movl	%eax, -112(%rbp)
.L70:
	.loc 1 673 17
	movl	$0, -108(%rbp)
	.loc 1 674 11
	movq	-152(%rbp), %rax
	movl	$103, %esi
	movq	%rax, %rdi
	call	bf_GetIndexByEncoding@PLT
	movl	%eax, -64(%rbp)
	.loc 1 675 6
	cmpl	$0, -64(%rbp)
	js	.L71
	.loc 1 677 23
	movq	-152(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 677 35
	movl	-64(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	.loc 1 677 47
	movq	64(%rax), %rax
	.loc 1 677 19
	movl	%eax, -108(%rbp)
.L71:
	.loc 1 681 19
	movl	$0, -104(%rbp)
	.loc 1 682 14
	movq	-152(%rbp), %rax
	movl	$40, %esi
	movq	%rax, %rdi
	call	bf_GetIndexByEncoding@PLT
	movl	%eax, -60(%rbp)
	.loc 1 683 6
	cmpl	$0, -60(%rbp)
	js	.L72
	.loc 1 685 25
	movq	-152(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 685 37
	movl	-60(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	.loc 1 685 52
	movq	48(%rax), %rax
	.loc 1 685 54
	movl	%eax, %ecx
	.loc 1 685 57
	movq	-152(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 685 69
	movl	-60(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	.loc 1 685 84
	movq	64(%rax), %rax
	.loc 1 685 54
	addl	%ecx, %eax
	.loc 1 685 21
	movl	%eax, -104(%rbp)
	.loc 1 686 26
	movq	-152(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 686 38
	movl	-60(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	.loc 1 686 53
	movq	64(%rax), %rax
	.loc 1 686 22
	movl	%eax, -100(%rbp)
	jmp	.L73
.L72:
	.loc 1 690 21
	movl	-116(%rbp), %eax
	movl	%eax, -104(%rbp)
	.loc 1 691 8
	cmpl	$0, -104(%rbp)
	jne	.L74
	.loc 1 692 23
	movl	-112(%rbp), %eax
	movl	%eax, -104(%rbp)
.L74:
	.loc 1 694 22
	movl	-108(%rbp), %eax
	movl	%eax, -100(%rbp)
.L73:
	.loc 1 698 14
	movl	$2, -132(%rbp)
	.loc 1 698 3
	jmp	.L75
.L79:
	.loc 1 700 16
	movl	$2, -128(%rbp)
	.loc 1 700 5
	jmp	.L76
.L78:
	.loc 1 702 20
	movl	-128(%rbp), %edx
	movl	-132(%rbp), %esi
	movq	-152(%rbp), %rax
	movl	$0, %ecx
	movq	%rax, %rdi
	call	bf_RLECompressAllGlyphsWithFieldSize
	movq	%rax, -32(%rbp)
	.loc 1 703 10
	movq	-40(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jbe	.L77
	.loc 1 705 17
	movq	-32(%rbp), %rax
	movq	%rax, -40(%rbp)
	.loc 1 706 13
	movl	-132(%rbp), %eax
	movl	%eax, -124(%rbp)
	.loc 1 707 13
	movl	-128(%rbp), %eax
	movl	%eax, -120(%rbp)
.L77:
	.loc 1 700 37 discriminator 2
	addl	$1, -128(%rbp)
.L76:
	.loc 1 700 27 discriminator 1
	cmpl	$6, -128(%rbp)
	jle	.L78
	.loc 1 698 35 discriminator 2
	addl	$1, -132(%rbp)
.L75:
	.loc 1 698 25 discriminator 1
	cmpl	$8, -132(%rbp)
	jle	.L79
	.loc 1 712 3
	movq	-40(%rbp), %rsi
	movl	-120(%rbp), %ecx
	movl	-124(%rbp), %edx
	movq	-152(%rbp), %rax
	movq	%rsi, %r8
	leaq	.LC7(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 713 3
	movl	-120(%rbp), %edx
	movl	-124(%rbp), %esi
	movq	-152(%rbp), %rax
	movl	$0, %ecx
	movq	%rax, %rdi
	call	bf_RLECompressAllGlyphsWithFieldSize
	.loc 1 716 3
	movq	-152(%rbp), %rax
	movq	%rax, %rdi
	call	bf_ClearTargetData@PLT
	.loc 1 729 3
	movq	-152(%rbp), %rax
	movl	16(%rax), %ecx
	movq	-152(%rbp), %rax
	movq	1152(%rax), %rdx
	movq	-152(%rbp), %rax
	leaq	.LC8(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 732 26
	movq	-152(%rbp), %rax
	movq	1152(%rax), %rax
	.loc 1 732 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 733 26
	movq	-152(%rbp), %rax
	movl	1160(%rax), %eax
	.loc 1 733 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 734 3
	movl	-124(%rbp), %eax
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 735 3
	movl	-120(%rbp), %eax
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 738 26
	movq	-152(%rbp), %rax
	movl	1272(%rax), %eax
	.loc 1 738 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 739 26
	movq	-152(%rbp), %rax
	movl	1276(%rax), %eax
	.loc 1 739 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 740 26
	movq	-152(%rbp), %rax
	movl	1264(%rax), %eax
	.loc 1 740 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 741 26
	movq	-152(%rbp), %rax
	movl	1268(%rax), %eax
	.loc 1 741 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 742 26
	movq	-152(%rbp), %rax
	movl	1280(%rax), %eax
	.loc 1 742 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 745 31
	movq	-152(%rbp), %rax
	movq	1168(%rax), %rax
	.loc 1 745 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 746 31
	movq	-152(%rbp), %rax
	movq	1176(%rax), %rax
	.loc 1 746 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 747 31
	movq	-152(%rbp), %rax
	movq	1184(%rax), %rax
	.loc 1 747 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 748 31
	movq	-152(%rbp), %rax
	movq	1192(%rax), %rax
	.loc 1 748 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 751 6
	cmpl	$0, -116(%rbp)
	jle	.L80
	.loc 1 752 5
	movl	-116(%rbp), %eax
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	jmp	.L81
.L80:
	.loc 1 754 5
	movl	-112(%rbp), %eax
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
.L81:
	.loc 1 755 3
	movl	-108(%rbp), %eax
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 758 3
	movl	-104(%rbp), %eax
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 759 3
	movl	-100(%rbp), %eax
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 762 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 763 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 766 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 767 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 770 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 771 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 775 16
	movl	$0, -96(%rbp)
	.loc 1 776 10
	movl	$0, -140(%rbp)
	.loc 1 776 3
	jmp	.L82
.L87:
	.loc 1 778 12
	movq	-152(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 778 24
	movl	-140(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	.loc 1 778 8
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
	.loc 1 779 12
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 779 8
	testq	%rax, %rax
	js	.L83
	.loc 1 779 31 discriminator 1
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 779 26 discriminator 1
	cmpq	$255, %rax
	jg	.L83
	.loc 1 781 14
	movq	-24(%rbp), %rax
	movq	104(%rax), %rax
	.loc 1 781 10
	testq	%rax, %rax
	je	.L83
	.loc 1 784 9
	movq	-24(%rbp), %rax
	movl	116(%rax), %eax
	.loc 1 784 5
	cmpl	$254, %eax
	jle	.L84
	.loc 1 786 4
	movq	-24(%rbp), %rax
	movl	116(%rax), %ecx
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-152(%rbp), %rax
	leaq	.LC9(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Error@PLT
	.loc 1 787 4
	movl	$1, %edi
	call	exit@PLT
.L84:
	.loc 1 790 9
	movl	$0, -136(%rbp)
	.loc 1 790 2
	jmp	.L85
.L86:
	.loc 1 792 27 discriminator 3
	movq	-24(%rbp), %rax
	movq	104(%rax), %rdx
	.loc 1 792 40 discriminator 3
	movl	-136(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	.loc 1 792 4 discriminator 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 790 35 discriminator 3
	addl	$1, -136(%rbp)
.L85:
	.loc 1 790 20 discriminator 1
	movq	-24(%rbp), %rax
	movl	116(%rax), %eax
	.loc 1 790 16 discriminator 1
	cmpl	%eax, -136(%rbp)
	jl	.L86
	.loc 1 794 14
	addl	$1, -96(%rbp)
.L83:
	.loc 1 776 35 discriminator 2
	addl	$1, -140(%rbp)
.L82:
	.loc 1 776 21 discriminator 1
	movq	-152(%rbp), %rax
	movl	16(%rax), %eax
	.loc 1 776 17 discriminator 1
	cmpl	%eax, -140(%rbp)
	jl	.L87
	.loc 1 799 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 800 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 802 25
	movq	-152(%rbp), %rax
	movl	1300(%rax), %eax
	.loc 1 802 37
	subl	$23, %eax
	.loc 1 802 21
	movl	%eax, -56(%rbp)
	.loc 1 806 82
	movq	-152(%rbp), %rax
	movq	1152(%rax), %rax
	.loc 1 806 3
	movl	-96(%rbp), %edx
	subq	%rdx, %rax
	movq	%rax, %rcx
	movl	-96(%rbp), %edx
	movq	-152(%rbp), %rax
	leaq	.LC10(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 807 33
	movq	-152(%rbp), %rax
	movq	1152(%rax), %rax
	.loc 1 807 50
	movl	-96(%rbp), %edx
	subq	%rdx, %rax
	movq	%rax, %rcx
	.loc 1 807 65
	movabsq	$-6757718126012409997, %rdx
	movq	%rcx, %rax
	imulq	%rdx
	leaq	(%rdx,%rcx), %rax
	sarq	$6, %rax
	sarq	$63, %rcx
	movq	%rcx, %rdx
	subq	%rdx, %rax
	.loc 1 807 28
	movl	%eax, -52(%rbp)
	.loc 1 810 3
	movq	-152(%rbp), %rax
	movl	$101, %edx
	leaq	.LC11(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 811 34
	movq	-152(%rbp), %rax
	movl	1300(%rax), %eax
	.loc 1 811 30
	movl	%eax, -48(%rbp)
	.loc 1 814 10
	movl	$1, -140(%rbp)
	.loc 1 814 3
	jmp	.L88
.L89:
	.loc 1 816 5 discriminator 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 817 5 discriminator 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 818 5 discriminator 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 819 5 discriminator 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 814 46 discriminator 3
	addl	$1, -140(%rbp)
.L88:
	.loc 1 814 17 discriminator 1
	movl	-140(%rbp), %eax
	cmpl	%eax, -52(%rbp)
	ja	.L89
	.loc 1 822 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 823 3
	movq	-152(%rbp), %rax
	movl	$4, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 824 3
	movq	-152(%rbp), %rax
	movl	$255, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 825 3
	movq	-152(%rbp), %rax
	movl	$255, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 829 28
	movl	$0, -84(%rbp)
	.loc 1 830 34
	movl	$0, -80(%rbp)
	.loc 1 831 26
	movq	-152(%rbp), %rax
	movl	1300(%rax), %eax
	.loc 1 831 22
	subl	-48(%rbp), %eax
	movl	%eax, -92(%rbp)
	.loc 1 832 31
	movq	-152(%rbp), %rax
	movl	1300(%rax), %eax
	.loc 1 832 27
	movl	%eax, -88(%rbp)
	.loc 1 833 21
	movl	$0, -76(%rbp)
	.loc 1 836 10
	movl	$0, -140(%rbp)
	.loc 1 836 3
	jmp	.L90
.L96:
	.loc 1 838 12
	movq	-152(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 838 24
	movl	-140(%rbp), %eax
	cltq
	salq	$3, %rax
	addq	%rdx, %rax
	.loc 1 838 8
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
	.loc 1 839 12
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 839 8
	cmpq	$255, %rax
	jle	.L91
	.loc 1 841 14
	movq	-24(%rbp), %rax
	movq	104(%rax), %rax
	.loc 1 841 10
	testq	%rax, %rax
	je	.L91
	.loc 1 844 9
	movq	-24(%rbp), %rax
	movl	116(%rax), %eax
	.loc 1 844 5
	cmpl	$254, %eax
	jle	.L92
	.loc 1 846 4
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-152(%rbp), %rax
	leaq	.LC12(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Error@PLT
	.loc 1 847 4
	movl	$1, %edi
	call	exit@PLT
.L92:
	.loc 1 850 9
	movl	$0, -136(%rbp)
	.loc 1 850 2
	jmp	.L93
.L94:
	.loc 1 852 27 discriminator 3
	movq	-24(%rbp), %rax
	movq	104(%rax), %rdx
	.loc 1 852 40 discriminator 3
	movl	-136(%rbp), %eax
	cltq
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	.loc 1 852 4 discriminator 3
	movzbl	%al, %edx
	movq	-152(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 850 35 discriminator 3
	addl	$1, -136(%rbp)
.L93:
	.loc 1 850 20 discriminator 1
	movq	-24(%rbp), %rax
	movl	116(%rax), %eax
	.loc 1 850 16 discriminator 1
	cmpl	%eax, -136(%rbp)
	jl	.L94
	.loc 1 860 32
	addl	$1, -80(%rbp)
	.loc 1 862 6
	cmpl	$100, -80(%rbp)
	jbe	.L95
	.loc 1 865 7
	movl	-84(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jnb	.L95
	.loc 1 867 99
	movl	-92(%rbp), %eax
	shrl	$8, %eax
	movl	%eax, %ecx
	.loc 1 867 8
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 867 73
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %esi
	.loc 1 867 75
	movl	-48(%rbp), %eax
	addl	%esi, %eax
	movl	%eax, %eax
	.loc 1 867 21
	addq	%rdx, %rax
	.loc 1 867 79
	movl	%ecx, %edx
	movb	%dl, (%rax)
	.loc 1 868 8
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 868 73
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %ecx
	.loc 1 868 48
	movl	-48(%rbp), %eax
	addl	%ecx, %eax
	.loc 1 868 75
	addl	$1, %eax
	movl	%eax, %eax
	.loc 1 868 21
	addq	%rdx, %rax
	.loc 1 868 79
	movl	-92(%rbp), %edx
	movb	%dl, (%rax)
	.loc 1 869 8
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 869 79
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %ecx
	movl	-48(%rbp), %eax
	addl	%ecx, %eax
	addl	$2, %eax
	movl	%eax, %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movl	%eax, %edx
	.loc 1 869 84
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 869 94
	sarq	$8, %rax
	.loc 1 869 79
	movl	%edx, %ecx
	orl	%eax, %ecx
	.loc 1 869 8
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 869 79
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %esi
	movl	-48(%rbp), %eax
	addl	%esi, %eax
	addl	$2, %eax
	movl	%eax, %eax
	addq	%rdx, %rax
	movl	%ecx, %edx
	movb	%dl, (%rax)
	.loc 1 870 8
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 870 79
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %ecx
	movl	-48(%rbp), %eax
	addl	%ecx, %eax
	addl	$3, %eax
	movl	%eax, %eax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movl	%eax, %edx
	.loc 1 870 84
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 870 79
	movl	%edx, %ecx
	orl	%eax, %ecx
	.loc 1 870 8
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 870 79
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %esi
	movl	-48(%rbp), %eax
	addl	%esi, %eax
	addl	$3, %eax
	movl	%eax, %eax
	addq	%rdx, %rax
	movl	%ecx, %edx
	movb	%dl, (%rax)
	.loc 1 872 30
	addl	$1, -84(%rbp)
	.loc 1 873 37
	movl	$0, -80(%rbp)
	.loc 1 874 29
	movq	-152(%rbp), %rax
	movl	1300(%rax), %eax
	.loc 1 874 25
	subl	-88(%rbp), %eax
	movl	%eax, -92(%rbp)
	.loc 1 875 34
	movq	-152(%rbp), %rax
	movl	1300(%rax), %eax
	.loc 1 875 30
	movl	%eax, -88(%rbp)
.L95:
	.loc 1 880 26
	addl	$1, -76(%rbp)
.L91:
	.loc 1 836 35 discriminator 2
	addl	$1, -140(%rbp)
.L90:
	.loc 1 836 21 discriminator 1
	movq	-152(%rbp), %rax
	movl	16(%rax), %eax
	.loc 1 836 17 discriminator 1
	cmpl	%eax, -140(%rbp)
	jl	.L96
	.loc 1 887 6
	movl	-84(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jnb	.L97
	.loc 1 889 98
	movl	-92(%rbp), %eax
	shrl	$8, %eax
	movl	%eax, %ecx
	.loc 1 889 7
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 889 72
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %esi
	.loc 1 889 74
	movl	-48(%rbp), %eax
	addl	%esi, %eax
	movl	%eax, %eax
	.loc 1 889 20
	addq	%rdx, %rax
	.loc 1 889 78
	movl	%ecx, %edx
	movb	%dl, (%rax)
	.loc 1 890 7
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 890 72
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %ecx
	.loc 1 890 47
	movl	-48(%rbp), %eax
	addl	%ecx, %eax
	.loc 1 890 74
	addl	$1, %eax
	movl	%eax, %eax
	.loc 1 890 20
	addq	%rdx, %rax
	.loc 1 890 78
	movl	-92(%rbp), %edx
	movb	%dl, (%rax)
	.loc 1 891 7
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 891 72
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %ecx
	.loc 1 891 47
	movl	-48(%rbp), %eax
	addl	%ecx, %eax
	.loc 1 891 74
	addl	$2, %eax
	movl	%eax, %eax
	.loc 1 891 20
	addq	%rdx, %rax
	.loc 1 891 78
	movb	$-1, (%rax)
	.loc 1 892 7
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 892 72
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %ecx
	.loc 1 892 47
	movl	-48(%rbp), %eax
	addl	%ecx, %eax
	.loc 1 892 74
	addl	$3, %eax
	movl	%eax, %eax
	.loc 1 892 20
	addq	%rdx, %rax
	.loc 1 892 78
	movb	$-1, (%rax)
	.loc 1 893 29
	addl	$1, -84(%rbp)
.L97:
	.loc 1 897 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 898 3
	movq	-152(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	bf_AddTargetData@PLT
	.loc 1 900 3
	movl	-84(%rbp), %ecx
	movl	-52(%rbp), %edx
	movq	-152(%rbp), %rax
	leaq	.LC13(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 903 7
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 903 47
	movl	-48(%rbp), %eax
	addl	$2, %eax
	movl	%eax, %eax
	.loc 1 903 20
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	.loc 1 903 50
	sall	$8, %eax
	movl	%eax, %ecx
	.loc 1 903 57
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 903 97
	movl	-48(%rbp), %eax
	addl	$3, %eax
	movl	%eax, %eax
	.loc 1 903 70
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	.loc 1 901 3
	addl	%eax, %ecx
	.loc 1 902 7
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 902 47
	movl	-48(%rbp), %eax
	.loc 1 902 20
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	.loc 1 902 50
	sall	$8, %eax
	movl	%eax, %esi
	.loc 1 902 57
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 902 97
	movl	-48(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %eax
	.loc 1 902 70
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	.loc 1 901 3
	leal	(%rsi,%rax), %edx
	movq	-152(%rbp), %rax
	leaq	.LC14(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 907 7
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 907 72
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %ecx
	.loc 1 907 47
	movl	-48(%rbp), %eax
	addl	%ecx, %eax
	.loc 1 907 76
	subl	$2, %eax
	movl	%eax, %eax
	.loc 1 907 20
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	.loc 1 907 79
	sall	$8, %eax
	movl	%eax, %ecx
	.loc 1 907 86
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 907 151
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %esi
	.loc 1 907 126
	movl	-48(%rbp), %eax
	addl	%esi, %eax
	.loc 1 907 155
	subl	$1, %eax
	movl	%eax, %eax
	.loc 1 907 99
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	.loc 1 905 3
	addl	%eax, %ecx
	.loc 1 906 7
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 906 72
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %esi
	.loc 1 906 47
	movl	-48(%rbp), %eax
	addl	%esi, %eax
	.loc 1 906 76
	subl	$4, %eax
	movl	%eax, %eax
	.loc 1 906 20
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	.loc 1 906 79
	sall	$8, %eax
	movl	%eax, %esi
	.loc 1 906 86
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rdx
	.loc 1 906 151
	movl	-84(%rbp), %eax
	leal	0(,%rax,4), %edi
	.loc 1 906 126
	movl	-48(%rbp), %eax
	addl	%edi, %eax
	.loc 1 906 155
	subl	$3, %eax
	movl	%eax, %eax
	.loc 1 906 99
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	.loc 1 905 3
	leal	(%rsi,%rax), %edx
	movq	-152(%rbp), %rax
	leaq	.LC15(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 909 3
	movl	-76(%rbp), %edx
	movq	-152(%rbp), %rax
	leaq	.LC16(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 912 3
	movl	-52(%rbp), %eax
	cmpl	-84(%rbp), %eax
	je	.L98
	.loc 1 912 3 is_stmt 0 discriminator 1
	leaq	__PRETTY_FUNCTION__.0(%rip), %rax
	movq	%rax, %rcx
	movl	$912, %edx
	leaq	.LC4(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC17(%rip), %rax
	movq	%rax, %rdi
	call	__assert_fail@PLT
.L98:
	.loc 1 914 9 is_stmt 1
	movq	-152(%rbp), %rax
	movl	$65, %esi
	movq	%rax, %rdi
	call	bf_RLE_get_glyph_data
	movl	%eax, -44(%rbp)
	.loc 1 915 29
	movl	-44(%rbp), %eax
	shrl	$8, %eax
	movl	%eax, %edx
	.loc 1 915 5
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rax
	.loc 1 915 18
	addq	$17, %rax
	.loc 1 915 23
	movb	%dl, (%rax)
	.loc 1 916 5
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rax
	.loc 1 916 18
	addq	$18, %rax
	.loc 1 916 23
	movl	-44(%rbp), %edx
	movb	%dl, (%rax)
	.loc 1 918 9
	movq	-152(%rbp), %rax
	movl	$97, %esi
	movq	%rax, %rdi
	call	bf_RLE_get_glyph_data
	movl	%eax, -44(%rbp)
	.loc 1 919 29
	movl	-44(%rbp), %eax
	shrl	$8, %eax
	movl	%eax, %edx
	.loc 1 919 5
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rax
	.loc 1 919 18
	addq	$19, %rax
	.loc 1 919 23
	movb	%dl, (%rax)
	.loc 1 920 5
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rax
	.loc 1 920 18
	addq	$20, %rax
	.loc 1 920 23
	movl	-44(%rbp), %edx
	movb	%dl, (%rax)
	.loc 1 922 43
	movl	-56(%rbp), %eax
	shrl	$8, %eax
	movl	%eax, %edx
	.loc 1 922 5
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rax
	.loc 1 922 18
	addq	$21, %rax
	.loc 1 922 23
	movb	%dl, (%rax)
	.loc 1 923 5
	movq	-152(%rbp), %rax
	movq	1288(%rax), %rax
	.loc 1 923 18
	addq	$22, %rax
	.loc 1 923 23
	movl	-56(%rbp), %edx
	movb	%dl, (%rax)
	.loc 1 925 3
	movq	-152(%rbp), %rax
	movl	$97, %esi
	movq	%rax, %rdi
	call	bf_RLE_get_glyph_data
	movl	%eax, %ebx
	movq	-152(%rbp), %rax
	movl	$65, %esi
	movq	%rax, %rdi
	call	bf_RLE_get_glyph_data
	movl	%eax, %edx
	movq	-152(%rbp), %rax
	movl	%ebx, %ecx
	leaq	.LC18(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 927 3
	movq	-152(%rbp), %rax
	movl	1300(%rax), %edx
	movq	-152(%rbp), %rax
	leaq	.LC19(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	bf_Log@PLT
	.loc 1 929 1
	nop
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	bf_RLECompressAllGlyphs, .-bf_RLECompressAllGlyphs
	.local	bd_list.2
	.comm	bd_list.2,8192,32
	.section	.rodata
	.align 16
	.type	__PRETTY_FUNCTION__.1, @object
	.size	__PRETTY_FUNCTION__.1, 16
__PRETTY_FUNCTION__.1:
	.string	"bg_rle_compress"
	.align 16
	.type	__PRETTY_FUNCTION__.0, @object
	.size	__PRETTY_FUNCTION__.0, 24
__PRETTY_FUNCTION__.0:
	.string	"bf_RLECompressAllGlyphs"
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h"
	.file 3 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 4 "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h"
	.file 5 "/usr/include/x86_64-linux-gnu/bits/types/FILE.h"
	.file 6 "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h"
	.file 7 "bdf_glyph.h"
	.file 8 "bdf_font.h"
	.file 9 "/usr/include/stdlib.h"
	.file 10 "/usr/include/assert.h"
	.file 11 "/usr/include/stdio.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xd14
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
	.uleb128 0x7
	.long	.LASF7
	.byte	0x2
	.byte	0xd1
	.byte	0x17
	.long	0x3a
	.uleb128 0x8
	.byte	0x8
	.byte	0x7
	.long	.LASF2
	.uleb128 0x8
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x1a
	.byte	0x8
	.uleb128 0x8
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x8
	.byte	0x2
	.byte	0x7
	.long	.LASF5
	.uleb128 0x8
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x7
	.long	.LASF8
	.byte	0x3
	.byte	0x26
	.byte	0x17
	.long	0x4a
	.uleb128 0x8
	.byte	0x2
	.byte	0x5
	.long	.LASF9
	.uleb128 0x1b
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x7
	.long	.LASF10
	.byte	0x3
	.byte	0x2a
	.byte	0x16
	.long	0x41
	.uleb128 0x8
	.byte	0x8
	.byte	0x5
	.long	.LASF11
	.uleb128 0x7
	.long	.LASF12
	.byte	0x3
	.byte	0x98
	.byte	0x19
	.long	0x85
	.uleb128 0x7
	.long	.LASF13
	.byte	0x3
	.byte	0x99
	.byte	0x1b
	.long	0x85
	.uleb128 0x5
	.long	0xa9
	.uleb128 0x8
	.byte	0x1
	.byte	0x6
	.long	.LASF14
	.uleb128 0x10
	.long	0xa9
	.uleb128 0x11
	.long	.LASF54
	.byte	0xd8
	.byte	0x4
	.byte	0x31
	.long	0x23b
	.uleb128 0x1
	.long	.LASF15
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.long	0x72
	.byte	0
	.uleb128 0x1
	.long	.LASF16
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.long	0xa4
	.byte	0x8
	.uleb128 0x1
	.long	.LASF17
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.long	0xa4
	.byte	0x10
	.uleb128 0x1
	.long	.LASF18
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.long	0xa4
	.byte	0x18
	.uleb128 0x1
	.long	.LASF19
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.long	0xa4
	.byte	0x20
	.uleb128 0x1
	.long	.LASF20
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.long	0xa4
	.byte	0x28
	.uleb128 0x1
	.long	.LASF21
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.long	0xa4
	.byte	0x30
	.uleb128 0x1
	.long	.LASF22
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.long	0xa4
	.byte	0x38
	.uleb128 0x1
	.long	.LASF23
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.long	0xa4
	.byte	0x40
	.uleb128 0x1
	.long	.LASF24
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.long	0xa4
	.byte	0x48
	.uleb128 0x1
	.long	.LASF25
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.long	0xa4
	.byte	0x50
	.uleb128 0x1
	.long	.LASF26
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.long	0xa4
	.byte	0x58
	.uleb128 0x1
	.long	.LASF27
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.long	0x254
	.byte	0x60
	.uleb128 0x1
	.long	.LASF28
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.long	0x259
	.byte	0x68
	.uleb128 0x1
	.long	.LASF29
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.long	0x72
	.byte	0x70
	.uleb128 0x1
	.long	.LASF30
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.long	0x72
	.byte	0x74
	.uleb128 0x1
	.long	.LASF31
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.long	0x8c
	.byte	0x78
	.uleb128 0x1
	.long	.LASF32
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.long	0x51
	.byte	0x80
	.uleb128 0x1
	.long	.LASF33
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.long	0x58
	.byte	0x82
	.uleb128 0x1
	.long	.LASF34
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.long	0x25e
	.byte	0x83
	.uleb128 0x1
	.long	.LASF35
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.long	0x26e
	.byte	0x88
	.uleb128 0x1
	.long	.LASF36
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.long	0x98
	.byte	0x90
	.uleb128 0x1
	.long	.LASF37
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.long	0x278
	.byte	0x98
	.uleb128 0x1
	.long	.LASF38
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.long	0x282
	.byte	0xa0
	.uleb128 0x1
	.long	.LASF39
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.long	0x259
	.byte	0xa8
	.uleb128 0x1
	.long	.LASF40
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.long	0x48
	.byte	0xb0
	.uleb128 0x1
	.long	.LASF41
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.long	0x2e
	.byte	0xb8
	.uleb128 0x1
	.long	.LASF42
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.long	0x72
	.byte	0xc0
	.uleb128 0x1
	.long	.LASF43
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.long	0x287
	.byte	0xc4
	.byte	0
	.uleb128 0x7
	.long	.LASF44
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.long	0xb5
	.uleb128 0x1c
	.long	.LASF166
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0x12
	.long	.LASF45
	.uleb128 0x5
	.long	0x24f
	.uleb128 0x5
	.long	0xb5
	.uleb128 0xb
	.long	0xa9
	.long	0x26e
	.uleb128 0xf
	.long	0x3a
	.byte	0
	.byte	0
	.uleb128 0x5
	.long	0x247
	.uleb128 0x12
	.long	.LASF46
	.uleb128 0x5
	.long	0x273
	.uleb128 0x12
	.long	.LASF47
	.uleb128 0x5
	.long	0x27d
	.uleb128 0xb
	.long	0xa9
	.long	0x297
	.uleb128 0xf
	.long	0x3a
	.byte	0x13
	.byte	0
	.uleb128 0x5
	.long	0x23b
	.uleb128 0x8
	.byte	0x8
	.byte	0x5
	.long	.LASF48
	.uleb128 0x8
	.byte	0x8
	.byte	0x7
	.long	.LASF49
	.uleb128 0x7
	.long	.LASF50
	.byte	0x6
	.byte	0x18
	.byte	0x13
	.long	0x5f
	.uleb128 0x7
	.long	.LASF51
	.byte	0x6
	.byte	0x1a
	.byte	0x14
	.long	0x79
	.uleb128 0x8
	.byte	0x10
	.byte	0x4
	.long	.LASF52
	.uleb128 0x7
	.long	.LASF53
	.byte	0x7
	.byte	0x9
	.byte	0x21
	.long	0x2d5
	.uleb128 0x1d
	.long	.LASF55
	.value	0x520
	.byte	0x8
	.byte	0x16
	.byte	0x8
	.long	0x4f6
	.uleb128 0x1
	.long	.LASF56
	.byte	0x8
	.byte	0x18
	.byte	0x7
	.long	0x72
	.byte	0
	.uleb128 0x1
	.long	.LASF57
	.byte	0x8
	.byte	0x1a
	.byte	0xa
	.long	0x675
	.byte	0x8
	.uleb128 0x1
	.long	.LASF58
	.byte	0x8
	.byte	0x1b
	.byte	0x7
	.long	0x72
	.byte	0x10
	.uleb128 0x1
	.long	.LASF59
	.byte	0x8
	.byte	0x1c
	.byte	0x7
	.long	0x72
	.byte	0x14
	.uleb128 0x1
	.long	.LASF60
	.byte	0x8
	.byte	0x1f
	.byte	0x8
	.long	0x67f
	.byte	0x18
	.uleb128 0x2
	.long	.LASF61
	.byte	0x20
	.byte	0x7
	.long	0x72
	.value	0x418
	.uleb128 0x2
	.long	.LASF62
	.byte	0x21
	.byte	0x7
	.long	0x72
	.value	0x41c
	.uleb128 0x2
	.long	.LASF63
	.byte	0x23
	.byte	0x8
	.long	0x85
	.value	0x420
	.uleb128 0x2
	.long	.LASF64
	.byte	0x25
	.byte	0x8
	.long	0x85
	.value	0x428
	.uleb128 0x2
	.long	.LASF65
	.byte	0x26
	.byte	0x8
	.long	0x85
	.value	0x430
	.uleb128 0x2
	.long	.LASF66
	.byte	0x28
	.byte	0x8
	.long	0x85
	.value	0x438
	.uleb128 0x2
	.long	.LASF67
	.byte	0x29
	.byte	0x8
	.long	0x85
	.value	0x440
	.uleb128 0x2
	.long	.LASF68
	.byte	0x2a
	.byte	0x8
	.long	0x85
	.value	0x448
	.uleb128 0x2
	.long	.LASF69
	.byte	0x2b
	.byte	0x8
	.long	0x85
	.value	0x450
	.uleb128 0x2
	.long	.LASF70
	.byte	0x2d
	.byte	0x7
	.long	0x72
	.value	0x458
	.uleb128 0x2
	.long	.LASF71
	.byte	0x2e
	.byte	0x7
	.long	0x72
	.value	0x45c
	.uleb128 0x2
	.long	.LASF72
	.byte	0x2f
	.byte	0x7
	.long	0x72
	.value	0x460
	.uleb128 0x13
	.string	"fp"
	.byte	0x30
	.long	0x297
	.value	0x468
	.uleb128 0x2
	.long	.LASF73
	.byte	0x32
	.byte	0x9
	.long	0xa4
	.value	0x470
	.uleb128 0x2
	.long	.LASF74
	.byte	0x33
	.byte	0x9
	.long	0xa4
	.value	0x478
	.uleb128 0x2
	.long	.LASF75
	.byte	0x35
	.byte	0x8
	.long	0x85
	.value	0x480
	.uleb128 0x2
	.long	.LASF76
	.byte	0x37
	.byte	0x7
	.long	0x72
	.value	0x488
	.uleb128 0x13
	.string	"max"
	.byte	0x39
	.long	0x52b
	.value	0x490
	.uleb128 0x2
	.long	.LASF77
	.byte	0x3c
	.byte	0x8
	.long	0x85
	.value	0x4b0
	.uleb128 0x2
	.long	.LASF78
	.byte	0x3d
	.byte	0x8
	.long	0x85
	.value	0x4b8
	.uleb128 0x2
	.long	.LASF79
	.byte	0x3e
	.byte	0x8
	.long	0x85
	.value	0x4c0
	.uleb128 0x2
	.long	.LASF80
	.byte	0x3f
	.byte	0x8
	.long	0x85
	.value	0x4c8
	.uleb128 0x2
	.long	.LASF81
	.byte	0x42
	.byte	0x8
	.long	0x85
	.value	0x4d0
	.uleb128 0x2
	.long	.LASF82
	.byte	0x43
	.byte	0x8
	.long	0x85
	.value	0x4d8
	.uleb128 0x2
	.long	.LASF83
	.byte	0x46
	.byte	0x8
	.long	0x85
	.value	0x4e0
	.uleb128 0x2
	.long	.LASF84
	.byte	0x47
	.byte	0x8
	.long	0x85
	.value	0x4e8
	.uleb128 0x2
	.long	.LASF85
	.byte	0x4a
	.byte	0x7
	.long	0x72
	.value	0x4f0
	.uleb128 0x2
	.long	.LASF86
	.byte	0x4b
	.byte	0x7
	.long	0x72
	.value	0x4f4
	.uleb128 0x2
	.long	.LASF87
	.byte	0x4c
	.byte	0x7
	.long	0x72
	.value	0x4f8
	.uleb128 0x2
	.long	.LASF88
	.byte	0x4d
	.byte	0x7
	.long	0x72
	.value	0x4fc
	.uleb128 0x2
	.long	.LASF89
	.byte	0x4e
	.byte	0x7
	.long	0x72
	.value	0x500
	.uleb128 0x2
	.long	.LASF90
	.byte	0x51
	.byte	0xc
	.long	0x664
	.value	0x508
	.uleb128 0x2
	.long	.LASF91
	.byte	0x52
	.byte	0x7
	.long	0x72
	.value	0x510
	.uleb128 0x2
	.long	.LASF92
	.byte	0x53
	.byte	0x7
	.long	0x72
	.value	0x514
	.uleb128 0x2
	.long	.LASF93
	.byte	0x56
	.byte	0x7
	.long	0x72
	.value	0x518
	.uleb128 0x2
	.long	.LASF94
	.byte	0x57
	.byte	0x7
	.long	0x72
	.value	0x51c
	.byte	0
	.uleb128 0x11
	.long	.LASF95
	.byte	0x20
	.byte	0x7
	.byte	0xc
	.long	0x52b
	.uleb128 0xc
	.string	"w"
	.byte	0xe
	.byte	0x8
	.long	0x85
	.byte	0
	.uleb128 0xc
	.string	"h"
	.byte	0xf
	.byte	0x8
	.long	0x85
	.byte	0x8
	.uleb128 0xc
	.string	"x"
	.byte	0x10
	.byte	0x8
	.long	0x85
	.byte	0x10
	.uleb128 0xc
	.string	"y"
	.byte	0x11
	.byte	0x8
	.long	0x85
	.byte	0x18
	.byte	0
	.uleb128 0x7
	.long	.LASF96
	.byte	0x7
	.byte	0x13
	.byte	0x1c
	.long	0x4f6
	.uleb128 0x11
	.long	.LASF97
	.byte	0xa0
	.byte	0x7
	.byte	0x16
	.long	0x65f
	.uleb128 0xc
	.string	"bf"
	.byte	0x18
	.byte	0x9
	.long	0x65f
	.byte	0
	.uleb128 0x1
	.long	.LASF63
	.byte	0x7
	.byte	0x1a
	.byte	0x8
	.long	0x85
	.byte	0x8
	.uleb128 0x1
	.long	.LASF98
	.byte	0x7
	.byte	0x1b
	.byte	0x8
	.long	0x85
	.byte	0x10
	.uleb128 0x1
	.long	.LASF64
	.byte	0x7
	.byte	0x1d
	.byte	0x8
	.long	0x85
	.byte	0x18
	.uleb128 0x1
	.long	.LASF65
	.byte	0x7
	.byte	0x1e
	.byte	0x8
	.long	0x85
	.byte	0x20
	.uleb128 0xc
	.string	"bbx"
	.byte	0x20
	.byte	0x9
	.long	0x52b
	.byte	0x28
	.uleb128 0x1
	.long	.LASF99
	.byte	0x7
	.byte	0x21
	.byte	0x8
	.long	0x85
	.byte	0x48
	.uleb128 0x1
	.long	.LASF100
	.byte	0x7
	.byte	0x22
	.byte	0x7
	.long	0x72
	.byte	0x50
	.uleb128 0x1
	.long	.LASF101
	.byte	0x7
	.byte	0x24
	.byte	0xc
	.long	0x664
	.byte	0x58
	.uleb128 0x1
	.long	.LASF102
	.byte	0x7
	.byte	0x25
	.byte	0x7
	.long	0x72
	.byte	0x60
	.uleb128 0x1
	.long	.LASF103
	.byte	0x7
	.byte	0x26
	.byte	0x7
	.long	0x72
	.byte	0x64
	.uleb128 0x1
	.long	.LASF90
	.byte	0x7
	.byte	0x2b
	.byte	0xc
	.long	0x664
	.byte	0x68
	.uleb128 0x1
	.long	.LASF91
	.byte	0x7
	.byte	0x2c
	.byte	0x7
	.long	0x72
	.byte	0x70
	.uleb128 0x1
	.long	.LASF92
	.byte	0x7
	.byte	0x2d
	.byte	0x7
	.long	0x72
	.byte	0x74
	.uleb128 0x1
	.long	.LASF104
	.byte	0x7
	.byte	0x2e
	.byte	0x7
	.long	0x72
	.byte	0x78
	.uleb128 0x1
	.long	.LASF105
	.byte	0x7
	.byte	0x32
	.byte	0xc
	.long	0x41
	.byte	0x7c
	.uleb128 0x1
	.long	.LASF106
	.byte	0x7
	.byte	0x33
	.byte	0xc
	.long	0x41
	.byte	0x80
	.uleb128 0x1
	.long	.LASF107
	.byte	0x7
	.byte	0x35
	.byte	0x7
	.long	0x72
	.byte	0x84
	.uleb128 0x1
	.long	.LASF108
	.byte	0x7
	.byte	0x36
	.byte	0xc
	.long	0x41
	.byte	0x88
	.uleb128 0x1
	.long	.LASF109
	.byte	0x7
	.byte	0x37
	.byte	0xc
	.long	0x41
	.byte	0x8c
	.uleb128 0x1
	.long	.LASF110
	.byte	0x7
	.byte	0x38
	.byte	0xc
	.long	0x41
	.byte	0x90
	.uleb128 0x1
	.long	.LASF111
	.byte	0x7
	.byte	0x3a
	.byte	0x8
	.long	0x85
	.byte	0x98
	.byte	0
	.uleb128 0x5
	.long	0x2c9
	.uleb128 0x5
	.long	0x2aa
	.uleb128 0x7
	.long	.LASF112
	.byte	0x7
	.byte	0x3d
	.byte	0x22
	.long	0x537
	.uleb128 0x5
	.long	0x67a
	.uleb128 0x5
	.long	0x669
	.uleb128 0xb
	.long	0xa9
	.long	0x690
	.uleb128 0x14
	.long	0x3a
	.value	0x3ff
	.byte	0
	.uleb128 0x1e
	.long	.LASF113
	.byte	0x9
	.value	0x270
	.byte	0xd
	.long	0x6a3
	.uleb128 0x4
	.long	0x72
	.byte	0
	.uleb128 0xe
	.long	.LASF115
	.byte	0x8
	.byte	0x5e
	.long	0x6ba
	.uleb128 0x4
	.long	0x65f
	.uleb128 0x4
	.long	0xa4
	.uleb128 0x15
	.byte	0
	.uleb128 0xd
	.long	.LASF114
	.byte	0x8
	.byte	0x6a
	.long	0x72
	.long	0x6d4
	.uleb128 0x4
	.long	0x65f
	.uleb128 0x4
	.long	0x2aa
	.byte	0
	.uleb128 0xe
	.long	.LASF116
	.byte	0x8
	.byte	0x69
	.long	0x6e5
	.uleb128 0x4
	.long	0x65f
	.byte	0
	.uleb128 0xd
	.long	.LASF117
	.byte	0x8
	.byte	0x70
	.long	0x72
	.long	0x6ff
	.uleb128 0x4
	.long	0x65f
	.uleb128 0x4
	.long	0x85
	.byte	0
	.uleb128 0xe
	.long	.LASF118
	.byte	0x8
	.byte	0x5f
	.long	0x716
	.uleb128 0x4
	.long	0x65f
	.uleb128 0x4
	.long	0xa4
	.uleb128 0x15
	.byte	0
	.uleb128 0xe
	.long	.LASF119
	.byte	0x8
	.byte	0x7c
	.long	0x731
	.uleb128 0x4
	.long	0x65f
	.uleb128 0x4
	.long	0x731
	.uleb128 0x4
	.long	0x67a
	.byte	0
	.uleb128 0x5
	.long	0x52b
	.uleb128 0xd
	.long	.LASF120
	.byte	0x7
	.byte	0x44
	.long	0x72
	.long	0x74b
	.uleb128 0x4
	.long	0x67a
	.byte	0
	.uleb128 0x1f
	.long	.LASF121
	.byte	0xa
	.byte	0x45
	.byte	0xd
	.long	0x76c
	.uleb128 0x4
	.long	0x76c
	.uleb128 0x4
	.long	0x76c
	.uleb128 0x4
	.long	0x41
	.uleb128 0x4
	.long	0x76c
	.byte	0
	.uleb128 0x5
	.long	0xb0
	.uleb128 0xd
	.long	.LASF122
	.byte	0x7
	.byte	0x4a
	.long	0x72
	.long	0x790
	.uleb128 0x4
	.long	0x67a
	.uleb128 0x4
	.long	0x72
	.uleb128 0x4
	.long	0x72
	.byte	0
	.uleb128 0xd
	.long	.LASF123
	.byte	0x7
	.byte	0x41
	.long	0x72
	.long	0x7aa
	.uleb128 0x4
	.long	0x67a
	.uleb128 0x4
	.long	0x2aa
	.byte	0
	.uleb128 0xd
	.long	.LASF124
	.byte	0x7
	.byte	0x43
	.long	0x72
	.long	0x7c9
	.uleb128 0x4
	.long	0x67a
	.uleb128 0x4
	.long	0x41
	.uleb128 0x4
	.long	0x41
	.byte	0
	.uleb128 0xe
	.long	.LASF125
	.byte	0x7
	.byte	0x42
	.long	0x7da
	.uleb128 0x4
	.long	0x67a
	.byte	0
	.uleb128 0x20
	.long	.LASF126
	.byte	0xb
	.value	0x295
	.byte	0xc
	.long	0x72
	.long	0x7f1
	.uleb128 0x4
	.long	0x76c
	.byte	0
	.uleb128 0x21
	.long	.LASF167
	.byte	0x1
	.value	0x274
	.byte	0x6
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x9e9
	.uleb128 0x6
	.string	"bf"
	.value	0x274
	.byte	0x24
	.long	0x65f
	.uleb128 0x3
	.byte	0x91
	.sleb128 -168
	.uleb128 0x9
	.string	"i"
	.value	0x276
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -156
	.uleb128 0x9
	.string	"j"
	.value	0x276
	.byte	0xa
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -152
	.uleb128 0x9
	.string	"bg"
	.value	0x277
	.byte	0x9
	.long	0x67a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x3
	.long	.LASF127
	.value	0x279
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -148
	.uleb128 0x3
	.long	.LASF128
	.value	0x279
	.byte	0xe
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -144
	.uleb128 0x3
	.long	.LASF129
	.value	0x27a
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -140
	.uleb128 0x3
	.long	.LASF130
	.value	0x27a
	.byte	0x15
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -136
	.uleb128 0x3
	.long	.LASF131
	.value	0x27b
	.byte	0x11
	.long	0x3a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x3
	.long	.LASF132
	.value	0x27c
	.byte	0x11
	.long	0x3a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x3
	.long	.LASF133
	.value	0x27e
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x3
	.long	.LASF134
	.value	0x27f
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -132
	.uleb128 0x3
	.long	.LASF135
	.value	0x280
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -84
	.uleb128 0x3
	.long	.LASF136
	.value	0x281
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x3
	.long	.LASF137
	.value	0x282
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x3
	.long	.LASF138
	.value	0x283
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -124
	.uleb128 0x3
	.long	.LASF139
	.value	0x284
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -76
	.uleb128 0x3
	.long	.LASF140
	.value	0x285
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -120
	.uleb128 0x3
	.long	.LASF141
	.value	0x286
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -116
	.uleb128 0x9
	.string	"pos"
	.value	0x288
	.byte	0xc
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x3
	.long	.LASF142
	.value	0x289
	.byte	0xc
	.long	0x41
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x3
	.long	.LASF143
	.value	0x28a
	.byte	0xc
	.long	0x41
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x3
	.long	.LASF144
	.value	0x28b
	.byte	0xc
	.long	0x41
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x3
	.long	.LASF145
	.value	0x28c
	.byte	0xc
	.long	0x2b6
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x3
	.long	.LASF146
	.value	0x28d
	.byte	0xc
	.long	0x2b6
	.uleb128 0x3
	.byte	0x91
	.sleb128 -108
	.uleb128 0x3
	.long	.LASF147
	.value	0x28e
	.byte	0xc
	.long	0x2b6
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x3
	.long	.LASF148
	.value	0x28f
	.byte	0xc
	.long	0x41
	.uleb128 0x3
	.byte	0x91
	.sleb128 -100
	.uleb128 0x3
	.long	.LASF149
	.value	0x290
	.byte	0xc
	.long	0x41
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x3
	.long	.LASF150
	.value	0x291
	.byte	0xc
	.long	0x2b6
	.uleb128 0x3
	.byte	0x91
	.sleb128 -92
	.uleb128 0x16
	.long	.LASF162
	.long	0x9f9
	.uleb128 0x9
	.byte	0x3
	.quad	__PRETTY_FUNCTION__.0
	.byte	0
	.uleb128 0xb
	.long	0xb0
	.long	0x9f9
	.uleb128 0xf
	.long	0x3a
	.byte	0x17
	.byte	0
	.uleb128 0x10
	.long	0x9e9
	.uleb128 0x22
	.long	.LASF152
	.byte	0x1
	.value	0x262
	.byte	0xa
	.long	0x41
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0xa4e
	.uleb128 0x6
	.string	"bf"
	.value	0x262
	.byte	0x26
	.long	0x65f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0xa
	.long	.LASF63
	.value	0x262
	.byte	0x32
	.long	0x2aa
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x3
	.long	.LASF151
	.value	0x264
	.byte	0xc
	.long	0x664
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x17
	.long	.LASF153
	.value	0x211
	.byte	0xf
	.long	0x3a
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0xaec
	.uleb128 0x6
	.string	"bf"
	.value	0x211
	.byte	0x3a
	.long	0x65f
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0xa
	.long	.LASF127
	.value	0x211
	.byte	0x42
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -108
	.uleb128 0xa
	.long	.LASF128
	.value	0x211
	.byte	0x4d
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0xa
	.long	.LASF154
	.value	0x211
	.byte	0x58
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -116
	.uleb128 0x9
	.string	"i"
	.value	0x213
	.byte	0x7
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -84
	.uleb128 0x9
	.string	"bg"
	.value	0x214
	.byte	0x9
	.long	0x67a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x3
	.long	.LASF131
	.value	0x215
	.byte	0x11
	.long	0x3a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x3
	.long	.LASF155
	.value	0x216
	.byte	0x9
	.long	0x52b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.byte	0
	.uleb128 0x17
	.long	.LASF156
	.value	0x16a
	.byte	0x5
	.long	0x72
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0xbe8
	.uleb128 0x6
	.string	"bg"
	.value	0x16a
	.byte	0x1b
	.long	0x67a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x6
	.string	"bbx"
	.value	0x16a
	.byte	0x26
	.long	0x731
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0xa
	.long	.LASF105
	.value	0x16a
	.byte	0x34
	.long	0x41
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0xa
	.long	.LASF106
	.value	0x16a
	.byte	0x4d
	.long	0x41
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0xa
	.long	.LASF154
	.value	0x16a
	.byte	0x61
	.long	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -76
	.uleb128 0x9
	.string	"x"
	.value	0x16c
	.byte	0x7
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x9
	.string	"y"
	.value	0x16d
	.byte	0x7
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x9
	.string	"i"
	.value	0x16e
	.byte	0x7
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x3
	.long	.LASF157
	.value	0x16f
	.byte	0x7
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x3
	.long	.LASF158
	.value	0x170
	.byte	0x7
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x3
	.long	.LASF159
	.value	0x171
	.byte	0x7
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x3
	.long	.LASF160
	.value	0x172
	.byte	0x7
	.long	0x72
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x3
	.long	.LASF161
	.value	0x174
	.byte	0xe
	.long	0xbe8
	.uleb128 0x9
	.byte	0x3
	.quad	bd_list.2
	.uleb128 0x16
	.long	.LASF162
	.long	0xc09
	.uleb128 0x9
	.byte	0x3
	.quad	__PRETTY_FUNCTION__.1
	.byte	0
	.uleb128 0xb
	.long	0x72
	.long	0xbf9
	.uleb128 0x14
	.long	0x3a
	.value	0x7ff
	.byte	0
	.uleb128 0xb
	.long	0xb0
	.long	0xc09
	.uleb128 0xf
	.long	0x3a
	.byte	0xf
	.byte	0
	.uleb128 0x10
	.long	0xbf9
	.uleb128 0x18
	.long	.LASF163
	.value	0x153
	.long	0x72
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xc58
	.uleb128 0x6
	.string	"bg"
	.value	0x153
	.byte	0x24
	.long	0x67a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x6
	.string	"a"
	.value	0x153
	.byte	0x31
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x6
	.string	"b"
	.value	0x153
	.byte	0x3d
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x18
	.long	.LASF164
	.value	0x123
	.long	0x72
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0xca2
	.uleb128 0x6
	.string	"bg"
	.value	0x123
	.byte	0x1c
	.long	0x67a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x6
	.string	"a"
	.value	0x123
	.byte	0x29
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x6
	.string	"b"
	.value	0x123
	.byte	0x35
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x23
	.long	.LASF168
	.byte	0x1
	.value	0x118
	.byte	0xd
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0xcee
	.uleb128 0x6
	.string	"bg"
	.value	0x118
	.byte	0x1f
	.long	0x67a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0xa
	.long	.LASF105
	.value	0x118
	.byte	0x2c
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0xa
	.long	.LASF106
	.value	0x118
	.byte	0x45
	.long	0x41
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x24
	.long	.LASF169
	.byte	0x1
	.value	0x113
	.byte	0xd
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x6
	.string	"s"
	.value	0x113
	.byte	0x20
	.long	0x76c
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
	.uleb128 0x34
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
	.uleb128 0x4
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x7
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
	.uleb128 0x8
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
	.uleb128 0x9
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
	.uleb128 0xa
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
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
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
	.uleb128 0xd
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
	.sleb128 6
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
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
	.uleb128 0x14
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x16
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
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 12
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
	.uleb128 0x87
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
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
	.uleb128 0x49
	.uleb128 0x13
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
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
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
.LASF56:
	.string	"is_verbose"
.LASF34:
	.string	"_shortbuf"
.LASF73:
	.string	"str_font"
.LASF166:
	.string	"_IO_lock_t"
.LASF23:
	.string	"_IO_buf_end"
.LASF97:
	.string	"_bdf_glyph_struct"
.LASF134:
	.string	"idx_cap_a_ascent"
.LASF83:
	.string	"x_min"
.LASF55:
	.string	"_bdf_font_struct"
.LASF98:
	.string	"map_to"
.LASF21:
	.string	"_IO_write_end"
.LASF3:
	.string	"unsigned int"
.LASF133:
	.string	"idx_cap_a"
.LASF39:
	.string	"_freeres_list"
.LASF15:
	.string	"_flags"
.LASF153:
	.string	"bf_RLECompressAllGlyphsWithFieldSize"
.LASF157:
	.string	"bd_is_one"
.LASF60:
	.string	"line_buf"
.LASF27:
	.string	"_markers"
.LASF156:
	.string	"bg_rle_compress"
.LASF90:
	.string	"target_data"
.LASF62:
	.string	"is_bitmap_parsing"
.LASF163:
	.string	"bg_prepare_01_rle"
.LASF109:
	.string	"rle_last_0"
.LASF110:
	.string	"rle_last_1"
.LASF99:
	.string	"shift_x"
.LASF164:
	.string	"bg_01_rle"
.LASF108:
	.string	"rle_bitcnt"
.LASF93:
	.string	"tile_h_size"
.LASF132:
	.string	"min_total_bits"
.LASF141:
	.string	"idx_para_descent"
.LASF51:
	.string	"uint32_t"
.LASF95:
	.string	"_bbx_struct"
.LASF169:
	.string	"bg_err"
.LASF26:
	.string	"_IO_save_end"
.LASF46:
	.string	"_IO_codecvt"
.LASF161:
	.string	"bd_list"
.LASF123:
	.string	"bg_AddTargetData"
.LASF101:
	.string	"bitmap_data"
.LASF58:
	.string	"glyph_cnt"
.LASF49:
	.string	"long long unsigned int"
.LASF114:
	.string	"bf_AddTargetData"
.LASF67:
	.string	"bbx_h"
.LASF124:
	.string	"bg_AddTargetBits"
.LASF25:
	.string	"_IO_backup_base"
.LASF36:
	.string	"_offset"
.LASF96:
	.string	"bbx_t"
.LASF130:
	.string	"best_rle_1"
.LASF66:
	.string	"bbx_w"
.LASF68:
	.string	"bbx_x"
.LASF69:
	.string	"bbx_y"
.LASF61:
	.string	"line_pos"
.LASF81:
	.string	"dx_min"
.LASF29:
	.string	"_fileno"
.LASF112:
	.string	"bg_t"
.LASF126:
	.string	"puts"
.LASF136:
	.string	"idx_1_ascent"
.LASF7:
	.string	"size_t"
.LASF18:
	.string	"_IO_read_base"
.LASF77:
	.string	"enc_w"
.LASF64:
	.string	"dwidth_x"
.LASF65:
	.string	"dwidth_y"
.LASF117:
	.string	"bf_GetIndexByEncoding"
.LASF160:
	.string	"bd_chg_cnt"
.LASF168:
	.string	"bg_init_rle"
.LASF20:
	.string	"_IO_write_ptr"
.LASF59:
	.string	"glyph_max"
.LASF107:
	.string	"rle_is_first"
.LASF14:
	.string	"char"
.LASF129:
	.string	"best_rle_0"
.LASF42:
	.string	"_mode"
.LASF63:
	.string	"encoding"
.LASF149:
	.string	"unicode_lookup_table_glyph_cnt"
.LASF45:
	.string	"_IO_marker"
.LASF148:
	.string	"unicode_lookup_table_pos"
.LASF16:
	.string	"_IO_read_ptr"
.LASF113:
	.string	"exit"
.LASF154:
	.string	"is_output"
.LASF152:
	.string	"bf_RLE_get_glyph_data"
.LASF50:
	.string	"uint8_t"
.LASF89:
	.string	"dx_max_bit_size"
.LASF72:
	.string	"glyph_pos"
.LASF146:
	.string	"unicode_last_delta"
.LASF138:
	.string	"idx_g_descent"
.LASF19:
	.string	"_IO_write_base"
.LASF48:
	.string	"long long int"
.LASF24:
	.string	"_IO_save_base"
.LASF92:
	.string	"target_cnt"
.LASF150:
	.string	"unicode_glyph_cnt"
.LASF139:
	.string	"idx_para"
.LASF84:
	.string	"x_max"
.LASF57:
	.string	"glyph_list"
.LASF151:
	.string	"font"
.LASF40:
	.string	"_freeres_buf"
.LASF41:
	.string	"__pad5"
.LASF71:
	.string	"bitmap_y"
.LASF118:
	.string	"bf_Log"
.LASF86:
	.string	"bbx_y_max_bit_size"
.LASF104:
	.string	"target_bit_pos"
.LASF105:
	.string	"rle_bits_per_0"
.LASF106:
	.string	"rle_bits_per_1"
.LASF33:
	.string	"_vtable_offset"
.LASF140:
	.string	"idx_para_ascent"
.LASF85:
	.string	"bbx_x_max_bit_size"
.LASF52:
	.string	"long double"
.LASF91:
	.string	"target_max"
.LASF100:
	.string	"is_excluded_from_kerning"
.LASF143:
	.string	"unicode_start_pos"
.LASF147:
	.string	"unicode_last_target_cnt"
.LASF74:
	.string	"str_copyright"
.LASF145:
	.string	"unicode_lookup_table_start"
.LASF87:
	.string	"bbx_w_max_bit_size"
.LASF158:
	.string	"bd_curr_len"
.LASF17:
	.string	"_IO_read_end"
.LASF70:
	.string	"bitmap_x"
.LASF9:
	.string	"short int"
.LASF11:
	.string	"long int"
.LASF94:
	.string	"tile_v_size"
.LASF47:
	.string	"_IO_wide_data"
.LASF111:
	.string	"width_deviation"
.LASF75:
	.string	"selected_glyphs"
.LASF8:
	.string	"__uint8_t"
.LASF119:
	.string	"bf_copy_bbx_and_update_shift"
.LASF127:
	.string	"rle_0"
.LASF128:
	.string	"rle_1"
.LASF82:
	.string	"dx_max"
.LASF38:
	.string	"_wide_data"
.LASF159:
	.string	"bd_max_len"
.LASF116:
	.string	"bf_ClearTargetData"
.LASF35:
	.string	"_lock"
.LASF2:
	.string	"long unsigned int"
.LASF31:
	.string	"_old_offset"
.LASF54:
	.string	"_IO_FILE"
.LASF76:
	.string	"bbx_mode"
.LASF120:
	.string	"bg_FlushTargetBits"
.LASF144:
	.string	"unicode_lookup_table_len"
.LASF121:
	.string	"__assert_fail"
.LASF115:
	.string	"bf_Error"
.LASF78:
	.string	"enc_h"
.LASF4:
	.string	"unsigned char"
.LASF79:
	.string	"enc_x"
.LASF80:
	.string	"enc_y"
.LASF10:
	.string	"__uint32_t"
.LASF102:
	.string	"bitmap_width"
.LASF165:
	.string	"GNU C17 11.3.0 -mtune=generic -march=x86-64 -g -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF167:
	.string	"bf_RLECompressAllGlyphs"
.LASF155:
	.string	"local_bbx"
.LASF37:
	.string	"_codecvt"
.LASF88:
	.string	"bbx_h_max_bit_size"
.LASF12:
	.string	"__off_t"
.LASF122:
	.string	"bg_GetBBXPixel"
.LASF6:
	.string	"signed char"
.LASF53:
	.string	"bf_t"
.LASF142:
	.string	"ascii_glyphs"
.LASF5:
	.string	"short unsigned int"
.LASF135:
	.string	"idx_1"
.LASF162:
	.string	"__PRETTY_FUNCTION__"
.LASF28:
	.string	"_chain"
.LASF44:
	.string	"FILE"
.LASF30:
	.string	"_flags2"
.LASF103:
	.string	"bitmap_height"
.LASF32:
	.string	"_cur_column"
.LASF131:
	.string	"total_bits"
.LASF137:
	.string	"idx_g"
.LASF13:
	.string	"__off64_t"
.LASF125:
	.string	"bg_ClearTargetData"
.LASF43:
	.string	"_unused2"
.LASF22:
	.string	"_IO_buf_base"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"bdf_rle.c"
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
