	.text
	.file	"byte_swap.ll"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp0:
	.cfi_def_cfa_offset 16
.Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp2:
	.cfi_def_cfa_register %rbp
	movl	$123123123, %eax        # imm = 0x756B5B3
	movl	%eax, %ecx
	movd	%rcx, %xmm0
                                        # implicit-def: XMM1
	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
	movl	$0, -4(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -8(%rbp)
	movaps	%xmm0, -48(%rbp)        # 16-byte Spill
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	cmpl	$10000, -8(%rbp)        # imm = 0x2710
	jge	.LBB0_4
# BB#2:                                 #   in Loop: Header=BB0_1 Depth=1
# BB#3:                                 #   in Loop: Header=BB0_1 Depth=1
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	.LBB0_1
.LBB0_4:
	movl	$0, %eax
	popq	%rbp
	retq
.Ltmp3:
	.size	main, .Ltmp3-main
	.cfi_endproc


	.ident	"Ubuntu clang version 3.5.0-1~exp1 (trunk) (based on LLVM 3.5.0)"
	.section	".note.GNU-stack","",@progbits
