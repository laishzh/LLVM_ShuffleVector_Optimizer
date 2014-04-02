	.file	"sfl_vec.ll"
	.text
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp2:
	.cfi_def_cfa_offset 16
.Ltmp3:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp4:
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movl	$0, -4(%rbp)
	movl	$287454020, -8(%rbp)    # imm = 0x11223344
	movl	$1432778632, -12(%rbp)  # imm = 0x55667788
	movl	$0, -16(%rbp)
	movl	$0, -16(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, %ecx
	shlq	$32, %rcx
	movl	-12(%rbp), %eax
	movl	%eax, %edx
	orq	%rcx, %rdx
	movd	%rdx, %xmm0
                                        # implicit-def: XMM1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movaps	%xmm0, -48(%rbp)        # 16-byte Spill
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	cmpl	$1000000, -16(%rbp)     # imm = 0xF4240
	jge	.LBB0_4
# BB#2:                                 #   in Loop: Header=BB0_1 Depth=1
	movaps	-48(%rbp), %xmm0        # 16-byte Reload
	shufpd	$1, %xmm0, %xmm0        # xmm0 = xmm0[1,0]
	pshuflw	$27, %xmm0, %xmm0       # xmm0 = xmm0[3,2,1,0,4,5,6,7]
	pshufhw	$27, %xmm0, %xmm0       # xmm0 = xmm0[0,1,2,3,7,6,5,4]
	movaps	%xmm0, -64(%rbp)        # 16-byte Spill
# BB#3:                                 #   in Loop: Header=BB0_1 Depth=1
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB0_1
.LBB0_4:
	leaq	.L.str, %rdi
	movaps	-64(%rbp), %xmm0        # 16-byte Reload
	pextrw	$3, %xmm0, %eax
	shll	$8, %eax
	pextrw	$2, %xmm0, %ecx
	movb	%cl, %dl
	movzbl	%dl, %ecx
	orl	%ecx, %eax
	pextrw	$1, %xmm0, %ecx
	shll	$8, %ecx
	movd	%xmm0, %esi
	movb	%sil, %dl
	movzbl	%dl, %esi
	orl	%esi, %ecx
	pinsrw	$0, %ecx, %xmm0
	pinsrw	$1, %eax, %xmm0
	movaps	-64(%rbp), %xmm1        # 16-byte Reload
	pextrw	$5, %xmm1, %eax
	shll	$8, %eax
	pextrw	$4, %xmm1, %ecx
	movb	%cl, %dl
	movzbl	%dl, %ecx
	orl	%ecx, %eax
	pinsrw	$2, %eax, %xmm0
	pextrw	$7, %xmm1, %eax
	shll	$8, %eax
	pextrw	$6, %xmm1, %ecx
	movb	%cl, %dl
	movzbl	%dl, %ecx
	orl	%ecx, %eax
	pinsrw	$3, %eax, %xmm0
	movd	%xmm0, %r8
	movd	%r8, %xmm0
	pshufd	$1, %xmm0, %xmm2        # xmm2 = xmm0[1,0,0,0]
	movd	%xmm2, %eax
	movd	%xmm0, %ecx
	movl	%eax, -8(%rbp)
	movl	%ecx, -12(%rbp)
	movl	-8(%rbp), %eax
	andl	$4278190080, %eax       # imm = 0xFF000000
	shrl	$24, %eax
	movl	-8(%rbp), %ecx
	andl	$16711680, %ecx         # imm = 0xFF0000
	sarl	$16, %ecx
	movl	-8(%rbp), %esi
	andl	$65280, %esi            # imm = 0xFF00
	sarl	$8, %esi
	movl	-8(%rbp), %r9d
	andl	$255, %r9d
	movl	%esi, -68(%rbp)         # 4-byte Spill
	movl	%eax, %esi
	movl	%ecx, %edx
	movl	-68(%rbp), %ecx         # 4-byte Reload
	movl	%r9d, %r8d
	movb	$0, %al
	callq	printf
	leaq	.L.str1, %rdi
	movl	-12(%rbp), %ecx
	andl	$4278190080, %ecx       # imm = 0xFF000000
	shrl	$24, %ecx
	movl	-12(%rbp), %edx
	andl	$16711680, %edx         # imm = 0xFF0000
	sarl	$16, %edx
	movl	-12(%rbp), %esi
	andl	$65280, %esi            # imm = 0xFF00
	sarl	$8, %esi
	movl	-12(%rbp), %r8d
	andl	$255, %r8d
	movl	%esi, -72(%rbp)         # 4-byte Spill
	movl	%ecx, %esi
	movl	-72(%rbp), %ecx         # 4-byte Reload
	movl	%eax, -76(%rbp)         # 4-byte Spill
	movb	$0, %al
	callq	printf
	movl	$0, %ecx
	movl	%eax, -80(%rbp)         # 4-byte Spill
	movl	%ecx, %eax
	addq	$80, %rsp
	popq	%rbp
	ret
.Ltmp5:
	.size	main, .Ltmp5-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%02X %02X %02X %02X "
	.size	.L.str, 21

	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	"%02X %02X %02X %02X\n"
	.size	.L.str1, 21


	.ident	"Ubuntu clang version 3.4.1-1~exp1 (branches/release_34) (based on LLVM 3.4.1)"
	.section	".note.GNU-stack","",@progbits
