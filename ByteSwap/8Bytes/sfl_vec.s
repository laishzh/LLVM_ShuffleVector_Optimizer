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
	subq	$176, %rsp
	movl	$0, -12(%rbp)
	movaps	.Lmain.a+48(%rip), %xmm0
	movaps	%xmm0, -32(%rbp)
	movaps	.Lmain.a+32(%rip), %xmm0
	movaps	%xmm0, -48(%rbp)
	movaps	.Lmain.a+16(%rip), %xmm0
	movaps	%xmm0, -64(%rbp)
	movaps	.Lmain.a(%rip), %xmm0
	movaps	%xmm0, -80(%rbp)
	movq	$0, -8(%rbp)
	movq	$1, -8(%rbp)
	movq	$2, -8(%rbp)
	movq	$3, -8(%rbp)
	movq	$4, -8(%rbp)
	movq	$5, -8(%rbp)
	movq	$6, -8(%rbp)
	movq	$7, -8(%rbp)
	leaq	-80(%rbp), %rax
	movaps	-80(%rbp), %xmm0
	movaps	-64(%rbp), %xmm1
	movaps	-48(%rbp), %xmm2
	movaps	-32(%rbp), %xmm3
	movl	$0, -84(%rbp)
	movl	$0, -84(%rbp)
	movq	%rax, -96(%rbp)         # 8-byte Spill
	movaps	%xmm0, -112(%rbp)       # 16-byte Spill
	movaps	%xmm1, -128(%rbp)       # 16-byte Spill
	movaps	%xmm2, -144(%rbp)       # 16-byte Spill
	movaps	%xmm3, -160(%rbp)       # 16-byte Spill
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	cmpl	$100000, -84(%rbp)      # imm = 0x186A0
	jae	.LBB0_4
# BB#2:                                 #   in Loop: Header=BB0_1 Depth=1
# BB#3:                                 #   in Loop: Header=BB0_1 Depth=1
	movl	-84(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -84(%rbp)
	jmp	.LBB0_1
.LBB0_4:
	movl	$0, -84(%rbp)
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
	cmpl	$8, -84(%rbp)
	jae	.LBB0_8
# BB#6:                                 #   in Loop: Header=BB0_5 Depth=1
	leaq	.L.str, %rdi
	movq	-96(%rbp), %rax         # 8-byte Reload
	movaps	-112(%rbp), %xmm0       # 16-byte Reload
	movaps	%xmm0, (%rax)
	movaps	-128(%rbp), %xmm1       # 16-byte Reload
	movaps	%xmm1, 16(%rax)
	movaps	-144(%rbp), %xmm2       # 16-byte Reload
	movaps	%xmm2, 32(%rax)
	movaps	-160(%rbp), %xmm3       # 16-byte Reload
	movaps	%xmm3, 48(%rax)
	movl	-84(%rbp), %ecx
	movl	%ecx, %edx
	movq	-80(%rbp,%rdx,8), %rdx
	movabsq	$4278190080, %rsi       # imm = 0xFF000000
	andq	%rsi, %rdx
	shrq	$24, %rdx
	movl	-84(%rbp), %ecx
	movl	%ecx, %esi
	movq	-80(%rbp,%rsi,8), %rsi
	andq	$16711680, %rsi         # imm = 0xFF0000
	shrq	$16, %rsi
	movl	-84(%rbp), %ecx
	movl	%ecx, %r8d
	movq	-80(%rbp,%r8,8), %r8
	andq	$65280, %r8             # imm = 0xFF00
	shrq	$8, %r8
	movl	-84(%rbp), %ecx
	movl	%ecx, %r9d
	movq	-80(%rbp,%r9,8), %r9
	andq	$255, %r9
	movq	%rsi, -168(%rbp)        # 8-byte Spill
	movq	%rdx, %rsi
	movq	-168(%rbp), %rdx        # 8-byte Reload
	movq	%r8, %rcx
	movq	%r9, %r8
	movb	$0, %al
	callq	printf
	movl	%eax, -172(%rbp)        # 4-byte Spill
# BB#7:                                 #   in Loop: Header=BB0_5 Depth=1
	movl	-84(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -84(%rbp)
	jmp	.LBB0_5
.LBB0_8:
	movl	$0, %eax
	addq	$176, %rsp
	popq	%rbp
	ret
.Ltmp5:
	.size	main, .Ltmp5-main
	.cfi_endproc

	.type	.Lmain.a,@object        # @main.a
	.section	.rodata,"a",@progbits
	.align	16
.Lmain.a:
	.quad	286397464               # 0x11121418
	.quad	555885608               # 0x21222428
	.quad	825373752               # 0x31323438
	.quad	1094861896              # 0x41424448
	.quad	1364350040              # 0x51525458
	.quad	1633838184              # 0x61626468
	.quad	1903326328              # 0x71727478
	.quad	2172814472              # 0x81828488
	.size	.Lmain.a, 64

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	 "%02lX %02lX %02lX %02lX\n"
	.size	.L.str, 25


	.section	".note.GNU-stack","",@progbits
