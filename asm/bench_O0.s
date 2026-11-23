	.file	"bench.c"
	.intel_syntax noprefix
	.text
	.data
	.align 4
	.type	seed, @object
	.size	seed, 4
seed:
	.long	12345
	.text
	.type	next_random, @function
next_random:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	eax, DWORD PTR seed[rip]
	imul	eax, eax, 1103515245
	add	eax, 12345
	mov	DWORD PTR seed[rip], eax
	mov	eax, DWORD PTR seed[rip]
	shr	eax, 8
	movzx	eax, ax
	mov	eax, eax
	test	rax, rax
	js	.L2
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, rax
	jmp	.L3
.L2:
	mov	rdx, rax
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, rdx
	addss	xmm0, xmm0
.L3:
	movss	xmm1, DWORD PTR .LC0[rip]
	divss	xmm0, xmm1
	pop	rbp
	ret
	.size	next_random, .-next_random
	.globl	fill
	.type	fill, @function
fill:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 32
	mov	QWORD PTR -32[rbp], rdi
	mov	DWORD PTR -36[rbp], esi
	mov	DWORD PTR -12[rbp], 0
	jmp	.L6
.L7:
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	lea	rbx, [rdx+rax]
	call	next_random
	movd	eax, xmm0
	mov	DWORD PTR [rbx], eax
	add	DWORD PTR -12[rbp], 1
.L6:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -36[rbp]
	jl	.L7
	nop
	nop
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
	.size	fill, .-fill
	.globl	matmul
	.type	matmul, @function
matmul:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -40[rbp], rdi
	mov	QWORD PTR -48[rbp], rsi
	mov	QWORD PTR -56[rbp], rdx
	mov	DWORD PTR -60[rbp], ecx
	mov	DWORD PTR -20[rbp], 0
	jmp	.L9
.L10:
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -56[rbp]
	add	rax, rdx
	pxor	xmm0, xmm0
	movss	DWORD PTR [rax], xmm0
	add	DWORD PTR -20[rbp], 1
.L9:
	mov	eax, DWORD PTR -60[rbp]
	imul	eax, eax
	cmp	DWORD PTR -20[rbp], eax
	jl	.L10
	mov	DWORD PTR -16[rbp], 0
	jmp	.L11
.L16:
	mov	DWORD PTR -12[rbp], 0
	jmp	.L12
.L15:
	mov	eax, DWORD PTR -16[rbp]
	imul	eax, DWORD PTR -60[rbp]
	mov	edx, eax
	mov	eax, DWORD PTR -12[rbp]
	add	eax, edx
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	movss	DWORD PTR -4[rbp], xmm0
	mov	DWORD PTR -8[rbp], 0
	jmp	.L13
.L14:
	mov	eax, DWORD PTR -16[rbp]
	imul	eax, DWORD PTR -60[rbp]
	mov	edx, eax
	mov	eax, DWORD PTR -8[rbp]
	add	eax, edx
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -56[rbp]
	add	rax, rdx
	movss	xmm1, DWORD PTR [rax]
	mov	eax, DWORD PTR -12[rbp]
	imul	eax, DWORD PTR -60[rbp]
	mov	edx, eax
	mov	eax, DWORD PTR -8[rbp]
	add	eax, edx
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, DWORD PTR -4[rbp]
	mov	eax, DWORD PTR -16[rbp]
	imul	eax, DWORD PTR -60[rbp]
	mov	edx, eax
	mov	eax, DWORD PTR -8[rbp]
	add	eax, edx
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -56[rbp]
	add	rax, rdx
	addss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	add	DWORD PTR -8[rbp], 1
.L13:
	mov	eax, DWORD PTR -8[rbp]
	cmp	eax, DWORD PTR -60[rbp]
	jl	.L14
	add	DWORD PTR -12[rbp], 1
.L12:
	mov	eax, DWORD PTR -12[rbp]
	cmp	eax, DWORD PTR -60[rbp]
	jl	.L15
	add	DWORD PTR -16[rbp], 1
.L11:
	mov	eax, DWORD PTR -16[rbp]
	cmp	eax, DWORD PTR -60[rbp]
	jl	.L16
	nop
	nop
	pop	rbp
	ret
	.size	matmul, .-matmul
	.globl	axpy
	.type	axpy, @function
axpy:
	endbr64
	push	rbp
	mov	rbp, rsp
	movss	DWORD PTR -20[rbp], xmm0
	mov	QWORD PTR -32[rbp], rdi
	mov	QWORD PTR -40[rbp], rsi
	mov	DWORD PTR -24[rbp], edx
	mov	DWORD PTR -4[rbp], 0
	jmp	.L18
.L19:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	movaps	xmm1, xmm0
	mulss	xmm1, DWORD PTR -20[rbp]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	addss	xmm0, xmm1
	movss	DWORD PTR [rax], xmm0
	add	DWORD PTR -4[rbp], 1
.L18:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -24[rbp]
	jl	.L19
	nop
	nop
	pop	rbp
	ret
	.size	axpy, .-axpy
	.globl	dot
	.type	dot, @function
dot:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	DWORD PTR -36[rbp], edx
	pxor	xmm0, xmm0
	movss	DWORD PTR -8[rbp], xmm0
	mov	DWORD PTR -4[rbp], 0
	jmp	.L21
.L22:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movss	xmm1, DWORD PTR [rax]
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	mulss	xmm0, xmm1
	movss	xmm1, DWORD PTR -8[rbp]
	addss	xmm0, xmm1
	movss	DWORD PTR -8[rbp], xmm0
	add	DWORD PTR -4[rbp], 1
.L21:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -36[rbp]
	jl	.L22
	movss	xmm0, DWORD PTR -8[rbp]
	pop	rbp
	ret
	.size	dot, .-dot
	.type	now, @function
now:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rax, -32[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -32[rbp]
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, rax
	mov	rax, QWORD PTR -24[rbp]
	pxor	xmm2, xmm2
	cvtsi2sd	xmm2, rax
	movsd	xmm0, QWORD PTR .LC2[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR fs:40
	je	.L26
	call	__stack_chk_fail@PLT
.L26:
	leave
	ret
	.size	now, .-now
	.section	.rodata
.LC3:
	.string	"not enough memory\n"
.LC5:
	.string	"fill   %.3f s\n"
	.align 8
.LC6:
	.string	"matmul %.3f s  c[0]=%.4f c[last]=%.4f\n"
	.align 8
.LC7:
	.string	"axpy   %.3f s  y[0]=%.4f y[last]=%.4f\n"
.LC8:
	.string	"dot    %.3f s  dot=%.2f\n"
.LC9:
	.string	"total  %.3f s\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	add	rsp, -128
	mov	DWORD PTR -116[rbp], edi
	mov	QWORD PTR -128[rbp], rsi
	cmp	DWORD PTR -116[rbp], 1
	jle	.L28
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	jmp	.L29
.L28:
	mov	eax, 1024
.L29:
	mov	DWORD PTR -92[rbp], eax
	cmp	DWORD PTR -116[rbp], 2
	jle	.L30
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	jmp	.L31
.L30:
	mov	eax, 16777216
.L31:
	mov	DWORD PTR -88[rbp], eax
	cmp	DWORD PTR -116[rbp], 3
	jle	.L32
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	jmp	.L33
.L32:
	mov	eax, 50
.L33:
	mov	DWORD PTR -84[rbp], eax
	mov	eax, DWORD PTR -92[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -92[rbp]
	cdqe
	imul	rax, rdx
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -80[rbp], rax
	mov	eax, DWORD PTR -92[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -92[rbp]
	cdqe
	imul	rax, rdx
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -72[rbp], rax
	mov	eax, DWORD PTR -92[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -92[rbp]
	cdqe
	imul	rax, rdx
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -64[rbp], rax
	mov	eax, DWORD PTR -88[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -56[rbp], rax
	mov	eax, DWORD PTR -88[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -48[rbp], rax
	cmp	QWORD PTR -80[rbp], 0
	je	.L34
	cmp	QWORD PTR -72[rbp], 0
	je	.L34
	cmp	QWORD PTR -64[rbp], 0
	je	.L34
	cmp	QWORD PTR -56[rbp], 0
	je	.L34
	cmp	QWORD PTR -48[rbp], 0
	jne	.L35
.L34:
	mov	rax, QWORD PTR stderr[rip]
	mov	rcx, rax
	mov	edx, 18
	mov	esi, 1
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 1
	jmp	.L36
.L35:
	call	now
	movq	rax, xmm0
	mov	QWORD PTR -40[rbp], rax
	mov	eax, DWORD PTR -92[rbp]
	imul	eax, eax
	mov	edx, eax
	mov	rax, QWORD PTR -80[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	fill
	mov	eax, DWORD PTR -92[rbp]
	imul	eax, eax
	mov	edx, eax
	mov	rax, QWORD PTR -72[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	fill
	mov	edx, DWORD PTR -88[rbp]
	mov	rax, QWORD PTR -56[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	fill
	mov	edx, DWORD PTR -88[rbp]
	mov	rax, QWORD PTR -48[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	fill
	call	now
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	mov	ecx, DWORD PTR -92[rbp]
	mov	rdx, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -72[rbp]
	mov	rax, QWORD PTR -80[rbp]
	mov	rdi, rax
	call	matmul
	call	now
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	mov	DWORD PTR -104[rbp], 0
	jmp	.L37
.L38:
	mov	edx, DWORD PTR -88[rbp]
	mov	rcx, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -56[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, DWORD PTR .LC4[rip]
	movd	xmm0, eax
	call	axpy
	add	DWORD PTR -104[rbp], 1
.L37:
	mov	eax, DWORD PTR -104[rbp]
	cmp	eax, DWORD PTR -84[rbp]
	jl	.L38
	call	now
	movq	rax, xmm0
	mov	QWORD PTR -16[rbp], rax
	pxor	xmm0, xmm0
	movss	DWORD PTR -100[rbp], xmm0
	mov	DWORD PTR -96[rbp], 0
	jmp	.L39
.L40:
	mov	edx, DWORD PTR -88[rbp]
	mov	rcx, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -56[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	dot
	movss	xmm1, DWORD PTR -100[rbp]
	addss	xmm0, xmm1
	movss	DWORD PTR -100[rbp], xmm0
	add	DWORD PTR -96[rbp], 1
.L39:
	cmp	DWORD PTR -96[rbp], 9
	jle	.L40
	call	now
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	movsd	xmm0, QWORD PTR -32[rbp]
	subsd	xmm0, QWORD PTR -40[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, DWORD PTR -92[rbp]
	imul	eax, eax
	cdqe
	sal	rax, 2
	lea	rdx, -4[rax]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	pxor	xmm2, xmm2
	cvtss2sd	xmm2, xmm0
	mov	rax, QWORD PTR -64[rbp]
	movss	xmm0, DWORD PTR [rax]
	pxor	xmm1, xmm1
	cvtss2sd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -24[rbp]
	subsd	xmm0, QWORD PTR -32[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 3
	call	printf@PLT
	mov	eax, DWORD PTR -88[rbp]
	cdqe
	sal	rax, 2
	lea	rdx, -4[rax]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	movss	xmm0, DWORD PTR [rax]
	pxor	xmm2, xmm2
	cvtss2sd	xmm2, xmm0
	mov	rax, QWORD PTR -48[rbp]
	movss	xmm0, DWORD PTR [rax]
	pxor	xmm1, xmm1
	cvtss2sd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -16[rbp]
	subsd	xmm0, QWORD PTR -24[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 3
	call	printf@PLT
	pxor	xmm1, xmm1
	cvtss2sd	xmm1, DWORD PTR -100[rbp]
	movsd	xmm0, QWORD PTR -8[rbp]
	subsd	xmm0, QWORD PTR -16[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT
	movsd	xmm0, QWORD PTR -8[rbp]
	subsd	xmm0, QWORD PTR -40[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -80[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -72[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -48[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
.L36:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 4
.LC0:
	.long	1199570944
	.align 8
.LC2:
	.long	-400107883
	.long	1041313291
	.align 4
.LC4:
	.long	1056964608
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
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
