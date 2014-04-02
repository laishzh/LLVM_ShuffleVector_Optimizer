	.file	"byte_swap.ll"
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
	subq	$64, %rsp
	movl	$0, -4(%rbp)
	movl	$287454020, -8(%rbp)    # imm = 0x11223344
	movl	$1432778632, -12(%rbp)  # imm = 0x55667788
	movl	$0, -16(%rbp)
	movl	$0, -16(%rbp)
	movl	-8(%rbp), %eax
	movl	-12(%rbp), %ecx
	movl	%eax, %eax
	movl	%eax, %edx
	shlq	$32, %rdx
	movl	%ecx, %eax
	movl	%eax, %esi
	addq	%rdx, %rsi
	movq	%rsi, -32(%rbp)         # 8-byte Spill
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	cmpl	$1000000, -16(%rbp)     # imm = 0xF4240
	jge	.LBB0_4
# BB#2:                                 #   in Loop: Header=BB0_1 Depth=1
	movq	-32(%rbp), %rax         # 8-byte Reload
	bswapq	%rax
	movq	%rax, -40(%rbp)         # 8-byte Spill
# BB#3:                                 #   in Loop: Header=BB0_1 Depth=1
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB0_1
.LBB0_4:
	leaq	.L.str, %rdi
	movq	-40(%rbp), %rax         # 8-byte Reload
	movd	%rax, %xmm0
	pshufd	$1, %xmm0, %xmm1        # xmm1 = xmm0[1,0,0,0]
	movd	%xmm1, %ecx
	movd	%xmm0, %edx
	movl	%ecx, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	-8(%rbp), %ecx
	andl	$4278190080, %ecx       # imm = 0xFF000000
	shrl	$24, %ecx
	movl	-8(%rbp), %edx
	andl	$16711680, %edx         # imm = 0xFF0000
	sarl	$16, %edx
	movl	-8(%rbp), %esi
	andl	$65280, %esi            # imm = 0xFF00
	sarl	$8, %esi
	movl	-8(%rbp), %r8d
	andl	$255, %r8d
	movl	%esi, -44(%rbp)         # 4-byte Spill
	movl	%ecx, %esi
	movl	-44(%rbp), %ecx         # 4-byte Reload
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
	movl	%esi, -48(%rbp)         # 4-byte Spill
	movl	%ecx, %esi
	movl	-48(%rbp), %ecx         # 4-byte Reload
	movl	%eax, -52(%rbp)         # 4-byte Spill
	movb	$0, %al
	callq	printf
	movl	$0, %ecx
	movl	%eax, -56(%rbp)         # 4-byte Spill
	movl	%ecx, %eax
	addq	$64, %rsp
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
