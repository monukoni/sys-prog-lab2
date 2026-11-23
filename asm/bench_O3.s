	.file	"bench.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	fill
	.type	fill, @function
fill:
	endbr64
	test	esi, esi
	jle	.L5
	movsx	rsi, esi
	mov	eax, DWORD PTR seed[rip]
	vmovss	xmm1, DWORD PTR .LC0[rip]
	vxorps	xmm2, xmm2, xmm2
	lea	rcx, [rdi+rsi*4]
	.p2align 4,,10
	.p2align 3
.L3:
	imul	eax, eax, 1103515245
	add	rdi, 4
	add	eax, 12345
	mov	edx, eax
	shr	edx, 8
	movzx	edx, dx
	vcvtsi2ss	xmm0, xmm2, edx
	vmulss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR -4[rdi], xmm0
	cmp	rcx, rdi
	jne	.L3
	mov	DWORD PTR seed[rip], eax
.L5:
	ret
	.size	fill, .-fill
	.p2align 4
	.globl	matmul
	.type	matmul, @function
matmul:
	endbr64
	push	rbp
	mov	eax, ecx
	mov	r10, rdx
	imul	eax, ecx
	mov	rbp, rsp
	push	r15
	push	r14
	mov	r14, rdi
	push	r13
	push	r12
	mov	r12, rsi
	push	rbx
	mov	ebx, ecx
	and	rsp, -32
	sub	rsp, 64
	test	eax, eax
	je	.L8
	mov	rdi, r10
	lea	rdx, 0[0+rax*4]
	xor	esi, esi
	call	memset@PLT
	mov	r10, rax
.L8:
	test	ebx, ebx
	jle	.L35
	lea	edx, -1[rbx]
	movsx	rax, ebx
	mov	r13d, ebx
	xor	edi, edi
	mov	DWORD PTR 60[rsp], edx
	mov	edx, ebx
	shr	r13d, 3
	lea	r15, 0[0+rax*4]
	and	edx, -8
	mov	QWORD PTR 40[rsp], rax
	lea	rax, [r14+r15]
	lea	rsi, [r15+r10]
	mov	DWORD PTR 24[rsp], edx
	mov	edx, ebx
	sal	r13, 5
	and	edx, 7
	mov	DWORD PTR 56[rsp], 0
	mov	DWORD PTR 20[rsp], edx
	sub	edx, 1
	mov	QWORD PTR 32[rsp], 0
	mov	DWORD PTR 16[rsp], edx
	mov	QWORD PTR 48[rsp], rax
	mov	rax, r10
	.p2align 4,,10
	.p2align 3
.L10:
	mov	rdx, QWORD PTR 32[rsp]
	mov	DWORD PTR 12[rsp], edi
	xor	r11d, r11d
	xor	r9d, r9d
	mov	QWORD PTR [rsp], r14
	lea	r8, [r14+rdx*4]
	mov	rdx, r12
	.p2align 4,,10
	.p2align 3
.L19:
	cmp	DWORD PTR 60[rsp], 2
	vmovss	xmm1, DWORD PTR [r8]
	jbe	.L20
	lea	rcx, 4[rdx]
	mov	r14, rax
	mov	rdi, rdx
	sub	r14, rcx
	mov	rcx, rax
	cmp	r14, 24
	ja	.L37
	.p2align 4,,10
	.p2align 3
.L17:
	vmovss	xmm0, DWORD PTR [rdi]
	vfmadd213ss	xmm0, xmm1, DWORD PTR [rcx]
	add	rcx, 4
	add	rdi, 4
	vmovss	DWORD PTR -4[rcx], xmm0
	cmp	rcx, rsi
	jne	.L17
.L18:
	mov	rdi, QWORD PTR 40[rsp]
	add	r8, 4
	add	rdx, r15
	add	r9d, ebx
	add	r11, rdi
	cmp	QWORD PTR 48[rsp], r8
	jne	.L19
	mov	rcx, rdi
	mov	edi, DWORD PTR 12[rsp]
	add	QWORD PTR 48[rsp], r15
	add	rax, r15
	add	DWORD PTR 56[rsp], ebx
	mov	r14, QWORD PTR [rsp]
	add	rsi, r15
	add	edi, 1
	add	QWORD PTR 32[rsp], rcx
	cmp	ebx, edi
	jne	.L10
	vzeroupper
.L35:
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.p2align 4,,10
	.p2align 3
.L37:
	cmp	DWORD PTR 60[rsp], 6
	jbe	.L22
	vbroadcastss	ymm2, xmm1
	xor	ecx, ecx
	.p2align 4,,10
	.p2align 3
.L13:
	vmovups	ymm0, YMMWORD PTR [rdx+rcx]
	vfmadd213ps	ymm0, ymm2, YMMWORD PTR [rax+rcx]
	vmovups	YMMWORD PTR [rax+rcx], ymm0
	add	rcx, 32
	cmp	rcx, r13
	jne	.L13
	mov	edi, DWORD PTR 24[rsp]
	cmp	edi, ebx
	je	.L18
	cmp	DWORD PTR 16[rsp], 2
	mov	ecx, DWORD PTR 20[rsp]
	jbe	.L23
	mov	DWORD PTR 28[rsp], edi
.L12:
	mov	r14, QWORD PTR 32[rsp]
	vshufps	xmm0, xmm1, xmm1, 0
	add	r14, rdi
	add	rdi, r11
	lea	r14, [r10+r14*4]
	vmovups	xmm3, XMMWORD PTR [r14]
	vfmadd132ps	xmm0, xmm3, XMMWORD PTR [r12+rdi*4]
	vmovups	XMMWORD PTR [r14], xmm0
	test	cl, 3
	je	.L18
	mov	edi, DWORD PTR 28[rsp]
	and	ecx, -4
	add	ecx, edi
.L15:
	mov	edi, DWORD PTR 56[rsp]
	add	edi, ecx
	movsx	rdi, edi
	lea	r14, [r10+rdi*4]
	lea	edi, [r9+rcx]
	movsx	rdi, edi
	vmovss	xmm0, DWORD PTR [r12+rdi*4]
	vfmadd213ss	xmm0, xmm1, DWORD PTR [r14]
	lea	edi, 1[rcx]
	vmovss	DWORD PTR [r14], xmm0
	cmp	ebx, edi
	jle	.L18
	mov	r14d, DWORD PTR 56[rsp]
	add	ecx, 2
	add	r14d, edi
	add	edi, r9d
	movsx	r14, r14d
	movsx	rdi, edi
	lea	r14, [r10+r14*4]
	vmovss	xmm0, DWORD PTR [r12+rdi*4]
	vfmadd213ss	xmm0, xmm1, DWORD PTR [r14]
	vmovss	DWORD PTR [r14], xmm0
	cmp	ebx, ecx
	jle	.L18
	mov	r14d, DWORD PTR 56[rsp]
	lea	edi, [r14+rcx]
	add	ecx, r9d
	movsx	rdi, edi
	movsx	rcx, ecx
	lea	rdi, [r10+rdi*4]
	vmovss	xmm4, DWORD PTR [rdi]
	vfmadd132ss	xmm1, xmm4, DWORD PTR [r12+rcx*4]
	vmovss	DWORD PTR [rdi], xmm1
	jmp	.L18
	.p2align 4,,10
	.p2align 3
.L20:
	mov	rdi, rdx
	mov	rcx, rax
	jmp	.L17
.L22:
	mov	DWORD PTR 28[rsp], 0
	mov	ecx, ebx
	xor	edi, edi
	jmp	.L12
.L23:
	mov	ecx, edi
	jmp	.L15
	.size	matmul, .-matmul
	.p2align 4
	.globl	axpy
	.type	axpy, @function
axpy:
	endbr64
	movsx	rax, edx
	mov	rcx, rsi
	test	eax, eax
	jle	.L56
	lea	edx, -1[rax]
	mov	r8d, eax
	cmp	edx, 2
	jbe	.L40
	lea	r9, 4[rdi]
	sub	rsi, r9
	cmp	rsi, 24
	ja	.L57
.L40:
	lea	rdx, 0[0+rax*4]
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L46:
	vmovss	xmm1, DWORD PTR [rdi+rax]
	vfmadd213ss	xmm1, xmm0, DWORD PTR [rcx+rax]
	vmovss	DWORD PTR [rcx+rax], xmm1
	add	rax, 4
	cmp	rax, rdx
	jne	.L46
	ret
.L54:
	vzeroupper
.L56:
	ret
	.p2align 4,,10
	.p2align 3
.L57:
	cmp	edx, 6
	jbe	.L48
	mov	esi, eax
	vbroadcastss	ymm2, xmm0
	xor	edx, edx
	shr	esi, 3
	sal	rsi, 5
	.p2align 4,,10
	.p2align 3
.L42:
	vmovups	ymm1, YMMWORD PTR [rdi+rdx]
	vfmadd213ps	ymm1, ymm2, YMMWORD PTR [rcx+rdx]
	vmovups	YMMWORD PTR [rcx+rdx], ymm1
	add	rdx, 32
	cmp	rsi, rdx
	jne	.L42
	mov	edx, eax
	and	edx, -8
	mov	esi, edx
	cmp	eax, edx
	je	.L54
	mov	r8d, eax
	sub	r8d, edx
	lea	r9d, -1[r8]
	cmp	r9d, 2
	jbe	.L58
	vzeroupper
.L41:
	lea	r9, [rcx+rsi*4]
	vshufps	xmm1, xmm0, xmm0, 0
	vmovups	xmm3, XMMWORD PTR [r9]
	vfmadd132ps	xmm1, xmm3, XMMWORD PTR [rdi+rsi*4]
	mov	esi, r8d
	and	esi, -4
	add	edx, esi
	and	r8d, 3
	vmovups	XMMWORD PTR [r9], xmm1
	je	.L56
.L44:
	movsx	r9, edx
	lea	rsi, 0[0+r9*4]
	vmovss	xmm1, DWORD PTR [rdi+r9*4]
	lea	r8, [rcx+rsi]
	vfmadd213ss	xmm1, xmm0, DWORD PTR [r8]
	vmovss	DWORD PTR [r8], xmm1
	lea	r8d, 1[rdx]
	cmp	eax, r8d
	jle	.L56
	lea	r8, 4[rcx+rsi]
	vmovss	xmm1, DWORD PTR 4[rdi+rsi]
	add	edx, 2
	vfmadd213ss	xmm1, xmm0, DWORD PTR [r8]
	vmovss	DWORD PTR [r8], xmm1
	cmp	eax, edx
	jle	.L56
	lea	rax, 8[rcx+rsi]
	vmovss	xmm4, DWORD PTR [rax]
	vfmadd132ss	xmm0, xmm4, DWORD PTR 8[rdi+rsi]
	vmovss	DWORD PTR [rax], xmm0
	ret
.L48:
	xor	esi, esi
	xor	edx, edx
	jmp	.L41
.L58:
	vzeroupper
	jmp	.L44
	.size	axpy, .-axpy
	.p2align 4
	.globl	dot
	.type	dot, @function
dot:
	endbr64
	mov	rcx, rsi
	test	edx, edx
	jle	.L67
	lea	eax, -1[rdx]
	cmp	eax, 6
	jbe	.L68
	mov	esi, edx
	xor	eax, eax
	vxorps	xmm0, xmm0, xmm0
	shr	esi, 3
	sal	rsi, 5
	.p2align 4,,10
	.p2align 3
.L62:
	vmovups	ymm4, YMMWORD PTR [rdi+rax]
	vmulps	ymm1, ymm4, YMMWORD PTR [rcx+rax]
	add	rax, 32
	vaddss	xmm0, xmm0, xmm1
	vshufps	xmm3, xmm1, xmm1, 85
	vshufps	xmm2, xmm1, xmm1, 255
	vaddss	xmm0, xmm0, xmm3
	vunpckhps	xmm3, xmm1, xmm1
	vextractf128	xmm1, ymm1, 0x1
	vaddss	xmm0, xmm0, xmm3
	vaddss	xmm0, xmm0, xmm2
	vshufps	xmm2, xmm1, xmm1, 85
	vaddss	xmm0, xmm0, xmm1
	vaddss	xmm0, xmm0, xmm2
	vunpckhps	xmm2, xmm1, xmm1
	vshufps	xmm1, xmm1, xmm1, 255
	vaddss	xmm0, xmm0, xmm2
	vaddss	xmm0, xmm0, xmm1
	cmp	rsi, rax
	jne	.L62
	mov	eax, edx
	and	eax, -8
	mov	esi, eax
	cmp	edx, eax
	je	.L74
	vzeroupper
.L61:
	mov	r8d, edx
	sub	r8d, esi
	lea	r9d, -1[r8]
	cmp	r9d, 2
	jbe	.L65
	vmovups	xmm5, XMMWORD PTR [rdi+rsi*4]
	vmulps	xmm1, xmm5, XMMWORD PTR [rcx+rsi*4]
	mov	esi, r8d
	and	esi, -4
	add	eax, esi
	and	r8d, 3
	vaddss	xmm0, xmm0, xmm1
	vshufps	xmm2, xmm1, xmm1, 85
	vaddss	xmm0, xmm0, xmm2
	vunpckhps	xmm2, xmm1, xmm1
	vshufps	xmm1, xmm1, xmm1, 255
	vaddss	xmm0, xmm0, xmm2
	vaddss	xmm0, xmm0, xmm1
	je	.L59
.L65:
	movsx	r8, eax
	vmovss	xmm6, DWORD PTR [rdi+r8*4]
	lea	rsi, 0[0+r8*4]
	vfmadd231ss	xmm0, xmm6, DWORD PTR [rcx+r8*4]
	lea	r8d, 1[rax]
	cmp	edx, r8d
	jle	.L59
	add	eax, 2
	vmovss	xmm7, DWORD PTR 4[rdi+rsi]
	vfmadd231ss	xmm0, xmm7, DWORD PTR 4[rcx+rsi]
	cmp	edx, eax
	jle	.L59
	vmovss	xmm7, DWORD PTR 8[rdi+rsi]
	vfmadd231ss	xmm0, xmm7, DWORD PTR 8[rcx+rsi]
	ret
	.p2align 4,,10
	.p2align 3
.L67:
	vxorps	xmm0, xmm0, xmm0
.L59:
	ret
	.p2align 4,,10
	.p2align 3
.L74:
	vzeroupper
	ret
.L68:
	xor	esi, esi
	xor	eax, eax
	vxorps	xmm0, xmm0, xmm0
	jmp	.L61
	.size	dot, .-dot
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"not enough memory\n"
.LC7:
	.string	"fill   %.3f s\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC8:
	.string	"matmul %.3f s  c[0]=%.4f c[last]=%.4f\n"
	.align 8
.LC9:
	.string	"axpy   %.3f s  y[0]=%.4f y[last]=%.4f\n"
	.section	.rodata.str1.1
.LC10:
	.string	"dot    %.3f s  dot=%.2f\n"
.LC11:
	.string	"total  %.3f s\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	endbr64
	lea	r10, 8[rsp]
	and	rsp, -32
	push	QWORD PTR -8[r10]
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	r10
	push	rbx
	add	rsp, -128
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -56[rbp], rax
	xor	eax, eax
	cmp	edi, 1
	jg	.L155
	mov	r14d, 16777216
	mov	r15d, 1024
	mov	r9d, 50
.L76:
	movsx	r13, r15d
	mov	DWORD PTR -88[rbp], r9d
	imul	r13, r13
	sal	r13, 2
	mov	rdi, r13
	call	malloc@PLT
	mov	rdi, r13
	mov	QWORD PTR -96[rbp], rax
	call	malloc@PLT
	mov	rdi, r13
	mov	QWORD PTR -104[rbp], rax
	call	malloc@PLT
	mov	QWORD PTR -112[rbp], rax
	movsx	rax, r14d
	lea	rbx, 0[0+rax*4]
	mov	rdi, rbx
	mov	QWORD PTR -120[rbp], rbx
	call	malloc@PLT
	mov	rdi, rbx
	mov	r12, rax
	call	malloc@PLT
	cmp	QWORD PTR -96[rbp], 0
	mov	rbx, rax
	je	.L77
	cmp	QWORD PTR -104[rbp], 0
	je	.L77
	cmp	QWORD PTR -112[rbp], 0
	sete	al
	test	r12, r12
	sete	dl
	or	al, dl
	jne	.L77
	test	rbx, rbx
	mov	r9d, DWORD PTR -88[rbp]
	je	.L77
	lea	rax, -80[rbp]
	mov	edi, 1
	mov	DWORD PTR -128[rbp], r9d
	mov	rsi, rax
	mov	QWORD PTR -88[rbp], rax
	call	clock_gettime@PLT
	vxorps	xmm4, xmm4, xmm4
	mov	eax, r15d
	mov	r9d, DWORD PTR -128[rbp]
	vcvtsi2sd	xmm1, xmm4, QWORD PTR -72[rbp]
	vcvtsi2sd	xmm0, xmm4, QWORD PTR -80[rbp]
	vfmadd132sd	xmm1, xmm0, QWORD PTR .LC3[rip]
	imul	eax, r15d
	test	eax, eax
	vmovsd	QWORD PTR -144[rbp], xmm1
	je	.L81
	mov	rdi, QWORD PTR -96[rbp]
	mov	eax, DWORD PTR seed[rip]
	vmovss	xmm1, DWORD PTR .LC0[rip]
	mov	rdx, rdi
	lea	rsi, 0[r13+rdi]
	.p2align 4,,10
	.p2align 3
.L82:
	imul	eax, eax, 1103515245
	add	rdx, 4
	add	eax, 12345
	mov	ecx, eax
	shr	ecx, 8
	movzx	ecx, cx
	vcvtsi2ss	xmm0, xmm4, ecx
	vmulss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR -4[rdx], xmm0
	cmp	rsi, rdx
	jne	.L82
	mov	rdi, QWORD PTR -104[rbp]
	mov	rdx, rdi
	lea	rsi, 0[r13+rdi]
	.p2align 4,,10
	.p2align 3
.L83:
	imul	eax, eax, 1103515245
	add	rdx, 4
	add	eax, 12345
	mov	ecx, eax
	shr	ecx, 8
	movzx	ecx, cx
	vcvtsi2ss	xmm0, xmm4, ecx
	vmulss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR -4[rdx], xmm0
	cmp	rsi, rdx
	jne	.L83
	mov	DWORD PTR seed[rip], eax
.L81:
	test	r14d, r14d
	jle	.L84
	mov	rdi, QWORD PTR -120[rbp]
	mov	eax, DWORD PTR seed[rip]
	mov	rdx, r12
	vmovss	xmm1, DWORD PTR .LC0[rip]
	lea	rsi, [rdi+r12]
	.p2align 4,,10
	.p2align 3
.L85:
	imul	eax, eax, 1103515245
	add	rdx, 4
	add	eax, 12345
	mov	ecx, eax
	shr	ecx, 8
	movzx	ecx, cx
	vcvtsi2ss	xmm0, xmm4, ecx
	vmulss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR -4[rdx], xmm0
	cmp	rsi, rdx
	jne	.L85
	mov	rdi, QWORD PTR -120[rbp]
	mov	rdx, rbx
	lea	rsi, [rdi+rbx]
	.p2align 4,,10
	.p2align 3
.L86:
	imul	eax, eax, 1103515245
	add	rdx, 4
	add	eax, 12345
	mov	ecx, eax
	shr	ecx, 8
	movzx	ecx, cx
	vcvtsi2ss	xmm0, xmm4, ecx
	vmulss	xmm0, xmm0, xmm1
	vmovss	DWORD PTR -4[rdx], xmm0
	cmp	rsi, rdx
	jne	.L86
	mov	DWORD PTR seed[rip], eax
.L84:
	mov	rsi, QWORD PTR -88[rbp]
	mov	edi, 1
	mov	DWORD PTR -152[rbp], r9d
	call	clock_gettime@PLT
	vxorps	xmm4, xmm4, xmm4
	mov	rdx, QWORD PTR -112[rbp]
	mov	ecx, r15d
	vcvtsi2sd	xmm0, xmm4, QWORD PTR -80[rbp]
	mov	rsi, QWORD PTR -104[rbp]
	mov	rdi, QWORD PTR -96[rbp]
	vcvtsi2sd	xmm1, xmm4, QWORD PTR -72[rbp]
	vfmadd132sd	xmm1, xmm0, QWORD PTR .LC3[rip]
	vmovsd	QWORD PTR -136[rbp], xmm1
	call	matmul
	mov	rsi, QWORD PTR -88[rbp]
	mov	edi, 1
	call	clock_gettime@PLT
	vxorps	xmm4, xmm4, xmm4
	mov	r9d, DWORD PTR -152[rbp]
	vcvtsi2sd	xmm1, xmm4, QWORD PTR -72[rbp]
	vcvtsi2sd	xmm0, xmm4, QWORD PTR -80[rbp]
	vfmadd132sd	xmm1, xmm0, QWORD PTR .LC3[rip]
	vmovsd	QWORD PTR -128[rbp], xmm1
	test	r9d, r9d
	jle	.L154
	test	r14d, r14d
	jle	.L154
	xor	edi, edi
	lea	r15d, -1[r14]
	cmp	r9d, 2
	jle	.L89
	lea	edi, -3[r9]
	lea	r15d, -1[r14]
	xor	esi, esi
	vbroadcastss	xmm2, DWORD PTR .LC5[rip]
	and	edi, -2
	add	edi, 2
.L96:
	cmp	r15d, 6
	jbe	.L118
	vbroadcastss	ymm1, DWORD PTR .LC5[rip]
	mov	edx, r14d
	shr	edx, 3
	sal	rdx, 5
.L92:
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L90:
	vmovups	ymm0, YMMWORD PTR [r12+rax]
	vfmadd213ps	ymm0, ymm1, YMMWORD PTR [rbx+rax]
	vfmadd231ps	ymm0, ymm1, YMMWORD PTR [r12+rax]
	vmovups	YMMWORD PTR [rbx+rax], ymm0
	add	rax, 32
	cmp	rdx, rax
	jne	.L90
	mov	eax, r14d
	and	eax, -8
	mov	ecx, eax
	cmp	r14d, eax
	je	.L156
.L91:
	mov	r8d, r14d
	sub	r8d, ecx
	lea	edx, -1[r8]
	cmp	edx, 2
	jbe	.L94
	mov	edx, ecx
	vmovups	xmm0, XMMWORD PTR [r12+rdx*4]
	lea	rcx, [rbx+rdx*4]
	mov	edx, r8d
	and	edx, -4
	vmovaps	xmm1, xmm0
	vfmadd213ps	xmm1, xmm2, XMMWORD PTR [rcx]
	add	eax, edx
	and	r8d, 3
	vfmadd132ps	xmm0, xmm1, xmm2
	vmovups	XMMWORD PTR [rcx], xmm0
	je	.L95
.L94:
	movsx	rcx, eax
	vmovss	xmm0, DWORD PTR .LC5[rip]
	vmovss	xmm1, DWORD PTR [r12+rcx*4]
	lea	rdx, 0[0+rcx*4]
	lea	rcx, [rbx+rdx]
	vmovaps	xmm3, xmm1
	vfmadd213ss	xmm3, xmm0, DWORD PTR [rcx]
	vfmadd132ss	xmm1, xmm3, xmm0
	vmovss	DWORD PTR [rcx], xmm1
	lea	ecx, 1[rax]
	cmp	r14d, ecx
	jle	.L95
	vmovss	xmm1, DWORD PTR 4[r12+rdx]
	lea	rcx, 4[rbx+rdx]
	add	eax, 2
	vmovaps	xmm3, xmm1
	vfmadd213ss	xmm3, xmm0, DWORD PTR [rcx]
	vfmadd132ss	xmm1, xmm3, xmm0
	vmovss	DWORD PTR [rcx], xmm1
	cmp	r14d, eax
	jle	.L95
	vmovss	xmm1, DWORD PTR 8[r12+rdx]
	lea	rax, 8[rbx+rdx]
	vmovaps	xmm3, xmm1
	vfmadd213ss	xmm3, xmm0, DWORD PTR [rax]
	vfmadd132ss	xmm0, xmm3, xmm1
	vmovss	DWORD PTR [rax], xmm0
.L95:
	add	esi, 2
	cmp	esi, edi
	jne	.L96
.L89:
	mov	ecx, r14d
	mov	r10d, r14d
	vmovss	xmm2, DWORD PTR .LC5[rip]
	vbroadcastss	ymm1, DWORD PTR .LC5[rip]
	shr	ecx, 3
	and	r10d, -8
	sal	rcx, 5
	vshufps	xmm3, xmm2, xmm2, 0
	.p2align 4,,10
	.p2align 3
.L102:
	cmp	r15d, 6
	jbe	.L116
.L99:
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L98:
	vmovups	ymm0, YMMWORD PTR [r12+rax]
	vfmadd213ps	ymm0, ymm1, YMMWORD PTR [rbx+rax]
	vmovups	YMMWORD PTR [rbx+rax], ymm0
	add	rax, 32
	cmp	rcx, rax
	jne	.L98
	cmp	r10d, r14d
	je	.L157
	mov	eax, r10d
	mov	edx, r10d
.L97:
	mov	esi, r14d
	sub	esi, eax
	lea	r8d, -1[rsi]
	cmp	r8d, 2
	jbe	.L100
	lea	r8, [rbx+rax*4]
	vmovups	xmm0, XMMWORD PTR [r12+rax*4]
	mov	eax, esi
	vfmadd213ps	xmm0, xmm3, XMMWORD PTR [r8]
	and	eax, -4
	add	edx, eax
	and	esi, 3
	vmovups	XMMWORD PTR [r8], xmm0
	je	.L101
.L100:
	movsx	r8, edx
	lea	rax, 0[0+r8*4]
	vmovss	xmm0, DWORD PTR [r12+r8*4]
	lea	rsi, [rbx+rax]
	vfmadd213ss	xmm0, xmm2, DWORD PTR [rsi]
	vmovss	DWORD PTR [rsi], xmm0
	lea	esi, 1[rdx]
	cmp	r14d, esi
	jle	.L101
	lea	rsi, 4[rbx+rax]
	vmovss	xmm0, DWORD PTR 4[r12+rax]
	add	edx, 2
	vfmadd213ss	xmm0, xmm2, DWORD PTR [rsi]
	vmovss	DWORD PTR [rsi], xmm0
	cmp	r14d, edx
	jle	.L101
	lea	rdx, 8[rbx+rax]
	vmovss	xmm0, DWORD PTR 8[r12+rax]
	vfmadd213ss	xmm0, xmm2, DWORD PTR [rdx]
	vmovss	DWORD PTR [rdx], xmm0
.L101:
	add	edi, 1
	cmp	r9d, edi
	jg	.L102
.L153:
	vzeroupper
	jmp	.L87
.L155:
	mov	ebx, edi
	mov	rdi, QWORD PTR 8[rsi]
	mov	r12, rsi
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	r15d, eax
	cmp	ebx, 2
	je	.L114
	mov	rdi, QWORD PTR 16[r12]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	r14d, eax
	cmp	ebx, 3
	je	.L115
	mov	rdi, QWORD PTR 24[r12]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	r9d, eax
	jmp	.L76
.L114:
	mov	r14d, 16777216
	mov	r9d, 50
	jmp	.L76
.L154:
	lea	r15d, -1[r14]
.L87:
	mov	rsi, QWORD PTR -88[rbp]
	mov	edi, 1
	call	clock_gettime@PLT
	vxorps	xmm4, xmm4, xmm4
	mov	ecx, r14d
	mov	r9d, r14d
	vcvtsi2sd	xmm1, xmm4, QWORD PTR -72[rbp]
	shr	ecx, 3
	and	r9d, -8
	mov	edi, 10
	vcvtsi2sd	xmm0, xmm4, QWORD PTR -80[rbp]
	sal	rcx, 5
	vfmadd132sd	xmm1, xmm0, QWORD PTR .LC3[rip]
	vmovsd	QWORD PTR -152[rbp], xmm1
.L103:
	test	r14d, r14d
	jle	.L158
	vxorps	xmm5, xmm5, xmm5
	.p2align 4,,10
	.p2align 3
.L109:
	xor	eax, eax
	vxorps	xmm0, xmm0, xmm0
	cmp	r15d, 6
	jbe	.L119
	.p2align 4,,10
	.p2align 3
.L105:
	vmovups	ymm6, YMMWORD PTR [rbx+rax]
	vmulps	ymm2, ymm6, YMMWORD PTR [r12+rax]
	add	rax, 32
	vaddss	xmm0, xmm0, xmm2
	vshufps	xmm1, xmm2, xmm2, 85
	vshufps	xmm3, xmm2, xmm2, 255
	vaddss	xmm1, xmm1, xmm0
	vunpckhps	xmm0, xmm2, xmm2
	vaddss	xmm0, xmm0, xmm1
	vextractf128	xmm1, ymm2, 0x1
	vshufps	xmm2, xmm1, xmm1, 85
	vaddss	xmm3, xmm3, xmm0
	vaddss	xmm0, xmm1, xmm3
	vaddss	xmm2, xmm2, xmm0
	vunpckhps	xmm0, xmm1, xmm1
	vshufps	xmm1, xmm1, xmm1, 255
	vaddss	xmm0, xmm0, xmm2
	vaddss	xmm0, xmm0, xmm1
	cmp	rcx, rax
	jne	.L105
	cmp	r9d, r14d
	je	.L106
	mov	eax, r9d
	mov	edx, r9d
.L104:
	mov	esi, r14d
	sub	esi, eax
	lea	r8d, -1[rsi]
	cmp	r8d, 2
	jbe	.L107
	vmovups	xmm7, XMMWORD PTR [rbx+rax*4]
	vmulps	xmm1, xmm7, XMMWORD PTR [r12+rax*4]
	mov	eax, esi
	and	eax, -4
	add	edx, eax
	and	esi, 3
	vaddss	xmm0, xmm1, xmm0
	vshufps	xmm2, xmm1, xmm1, 85
	vaddss	xmm2, xmm2, xmm0
	vunpckhps	xmm0, xmm1, xmm1
	vshufps	xmm1, xmm1, xmm1, 255
	vaddss	xmm0, xmm0, xmm2
	vaddss	xmm0, xmm0, xmm1
	je	.L106
.L107:
	movsx	rsi, edx
	vmovss	xmm7, DWORD PTR [r12+rsi*4]
	lea	rax, 0[0+rsi*4]
	vfmadd231ss	xmm0, xmm7, DWORD PTR [rbx+rsi*4]
	lea	esi, 1[rdx]
	cmp	r14d, esi
	jle	.L106
	add	edx, 2
	vmovss	xmm7, DWORD PTR 4[rbx+rax]
	vfmadd231ss	xmm0, xmm7, DWORD PTR 4[r12+rax]
	cmp	r14d, edx
	jle	.L106
	vmovss	xmm7, DWORD PTR 8[rbx+rax]
	vfmadd231ss	xmm0, xmm7, DWORD PTR 8[r12+rax]
.L106:
	vaddss	xmm5, xmm5, xmm0
	sub	edi, 1
	jne	.L109
	vzeroupper
.L110:
	mov	rsi, QWORD PTR -88[rbp]
	mov	edi, 1
	vmovss	DWORD PTR -156[rbp], xmm5
	call	clock_gettime@PLT
	vxorps	xmm4, xmm4, xmm4
	mov	edi, 2
	vmovsd	xmm5, QWORD PTR -136[rbp]
	vcvtsi2sd	xmm0, xmm4, QWORD PTR -80[rbp]
	lea	rsi, .LC7[rip]
	mov	eax, 1
	vcvtsi2sd	xmm1, xmm4, QWORD PTR -72[rbp]
	vfmadd132sd	xmm1, xmm0, QWORD PTR .LC3[rip]
	vsubsd	xmm0, xmm5, QWORD PTR -144[rbp]
	vmovq	r15, xmm1
	call	__printf_chk@PLT
	vmovsd	xmm4, QWORD PTR -128[rbp]
	mov	r14, QWORD PTR -112[rbp]
	lea	rsi, .LC8[rip]
	vsubsd	xmm0, xmm4, QWORD PTR -136[rbp]
	mov	edi, 2
	vxorps	xmm4, xmm4, xmm4
	mov	eax, 3
	vcvtss2sd	xmm2, xmm4, DWORD PTR -4[r14+r13]
	vcvtss2sd	xmm1, xmm4, DWORD PTR [r14]
	call	__printf_chk@PLT
	mov	rax, QWORD PTR -120[rbp]
	vxorps	xmm4, xmm4, xmm4
	vmovsd	xmm5, QWORD PTR -152[rbp]
	vsubsd	xmm0, xmm5, QWORD PTR -128[rbp]
	lea	rsi, .LC9[rip]
	mov	edi, 2
	vcvtss2sd	xmm1, xmm4, DWORD PTR [rbx]
	vcvtss2sd	xmm2, xmm4, DWORD PTR -4[rbx+rax]
	mov	eax, 3
	call	__printf_chk@PLT
	vmovq	xmm4, r15
	mov	edi, 2
	vsubsd	xmm0, xmm4, QWORD PTR -152[rbp]
	vmovss	xmm5, DWORD PTR -156[rbp]
	lea	rsi, .LC10[rip]
	mov	eax, 2
	vcvtss2sd	xmm1, xmm5, xmm5
	call	__printf_chk@PLT
	vmovq	xmm5, r15
	vsubsd	xmm0, xmm5, QWORD PTR -144[rbp]
	lea	rsi, .LC11[rip]
	mov	edi, 2
	mov	eax, 1
	call	__printf_chk@PLT
	mov	rdi, QWORD PTR -96[rbp]
	call	free@PLT
	mov	rdi, QWORD PTR -104[rbp]
	call	free@PLT
	mov	rdi, r14
	call	free@PLT
	mov	rdi, r12
	call	free@PLT
	mov	rdi, rbx
	call	free@PLT
	xor	eax, eax
.L75:
	mov	rdx, QWORD PTR -56[rbp]
	sub	rdx, QWORD PTR fs:40
	jne	.L159
	sub	rsp, -128
	pop	rbx
	pop	r10
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	lea	rsp, -8[r10]
	ret
.L158:
	sub	edi, 1
	jne	.L103
	vxorps	xmm5, xmm5, xmm5
	jmp	.L110
.L119:
	xor	edx, edx
	jmp	.L104
.L116:
	xor	eax, eax
	xor	edx, edx
	jmp	.L97
.L115:
	mov	r9d, 50
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L157:
	add	edi, 1
	cmp	r9d, edi
	jg	.L99
	jmp	.L153
.L156:
	add	esi, 2
	cmp	esi, edi
	jne	.L92
	jmp	.L89
.L118:
	xor	ecx, ecx
	xor	eax, eax
	jmp	.L91
.L159:
	call	__stack_chk_fail@PLT
.L77:
	mov	rcx, QWORD PTR stderr[rip]
	mov	edx, 18
	mov	esi, 1
	lea	rdi, .LC2[rip]
	call	fwrite@PLT
	mov	eax, 1
	jmp	.L75
	.size	main, .-main
	.data
	.align 4
	.type	seed, @object
	.size	seed, 4
seed:
	.long	12345
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	931135488
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
	.long	-400107883
	.long	1041313291
	.section	.rodata.cst4
	.align 4
.LC5:
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
