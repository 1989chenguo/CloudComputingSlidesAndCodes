
Measure-ALU:     file format elf64-x86-64


Disassembly of section .init:

00000000000005a8 <_init>:
 5a8:	48 83 ec 08          	sub    $0x8,%rsp
 5ac:	48 8b 05 35 1a 20 00 	mov    0x201a35(%rip),%rax        # 201fe8 <__gmon_start__>
 5b3:	48 85 c0             	test   %rax,%rax
 5b6:	74 02                	je     5ba <_init+0x12>
 5b8:	ff d0                	callq  *%rax
 5ba:	48 83 c4 08          	add    $0x8,%rsp
 5be:	c3                   	retq   

Disassembly of section .plt:

00000000000005c0 <.plt>:
 5c0:	ff 35 ea 19 20 00    	pushq  0x2019ea(%rip)        # 201fb0 <_GLOBAL_OFFSET_TABLE_+0x8>
 5c6:	ff 25 ec 19 20 00    	jmpq   *0x2019ec(%rip)        # 201fb8 <_GLOBAL_OFFSET_TABLE_+0x10>
 5cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000005d0 <__stack_chk_fail@plt>:
 5d0:	ff 25 ea 19 20 00    	jmpq   *0x2019ea(%rip)        # 201fc0 <__stack_chk_fail@GLIBC_2.4>
 5d6:	68 00 00 00 00       	pushq  $0x0
 5db:	e9 e0 ff ff ff       	jmpq   5c0 <.plt>

00000000000005e0 <gettimeofday@plt>:
 5e0:	ff 25 e2 19 20 00    	jmpq   *0x2019e2(%rip)        # 201fc8 <gettimeofday@GLIBC_2.2.5>
 5e6:	68 01 00 00 00       	pushq  $0x1
 5eb:	e9 d0 ff ff ff       	jmpq   5c0 <.plt>

00000000000005f0 <__printf_chk@plt>:
 5f0:	ff 25 da 19 20 00    	jmpq   *0x2019da(%rip)        # 201fd0 <__printf_chk@GLIBC_2.3.4>
 5f6:	68 02 00 00 00       	pushq  $0x2
 5fb:	e9 c0 ff ff ff       	jmpq   5c0 <.plt>

Disassembly of section .plt.got:

0000000000000600 <__cxa_finalize@plt>:
 600:	ff 25 f2 19 20 00    	jmpq   *0x2019f2(%rip)        # 201ff8 <__cxa_finalize@GLIBC_2.2.5>
 606:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000000610 <main>:
 610:	41 54                	push   %r12
 612:	55                   	push   %rbp
 613:	31 f6                	xor    %esi,%esi
 615:	53                   	push   %rbx
 616:	bb 11 00 00 00       	mov    $0x11,%ebx
 61b:	48 83 ec 40          	sub    $0x40,%rsp
 61f:	4c 8d 64 24 10       	lea    0x10(%rsp),%r12
 624:	48 8d 6c 24 20       	lea    0x20(%rsp),%rbp
 629:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
 630:	00 00 
 632:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
 637:	31 c0                	xor    %eax,%eax
 639:	4c 89 e7             	mov    %r12,%rdi
 63c:	e8 9f ff ff ff       	callq  5e0 <gettimeofday@plt>
 641:	31 f6                	xor    %esi,%esi
 643:	48 89 ef             	mov    %rbp,%rdi
 646:	e8 95 ff ff ff       	callq  5e0 <gettimeofday@plt>
 64b:	66 0f ef c9          	pxor   %xmm1,%xmm1
 64f:	48 8d 35 52 05 00 00 	lea    0x552(%rip),%rsi        # ba8 <_IO_stdin_used+0x8>
 656:	66 0f ef c0          	pxor   %xmm0,%xmm0
 65a:	b9 11 00 00 00       	mov    $0x11,%ecx
 65f:	66 0f ef d2          	pxor   %xmm2,%xmm2
 663:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 668:	f2 48 0f 2a 4c 24 20 	cvtsi2sdq 0x20(%rsp),%xmm1
 66f:	f2 0f 59 0d 99 06 00 	mulsd  0x699(%rip),%xmm1        # d10 <_IO_stdin_used+0x170>
 676:	00 
 677:	bf 01 00 00 00       	mov    $0x1,%edi
 67c:	f2 48 0f 2a 44 24 28 	cvtsi2sdq 0x28(%rsp),%xmm0
 683:	b8 02 00 00 00       	mov    $0x2,%eax
 688:	f2 48 0f 2a 54 24 18 	cvtsi2sdq 0x18(%rsp),%xmm2
 68f:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
 693:	66 0f ef c0          	pxor   %xmm0,%xmm0
 697:	f2 48 0f 2a 44 24 10 	cvtsi2sdq 0x10(%rsp),%xmm0
 69e:	f2 0f 59 05 6a 06 00 	mulsd  0x66a(%rip),%xmm0        # d10 <_IO_stdin_used+0x170>
 6a5:	00 
 6a6:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
 6aa:	f2 0f 5c c8          	subsd  %xmm0,%xmm1
 6ae:	66 0f 28 c1          	movapd %xmm1,%xmm0
 6b2:	f2 0f 5e 0d 66 06 00 	divsd  0x666(%rip),%xmm1        # d20 <_IO_stdin_used+0x180>
 6b9:	00 
 6ba:	f2 0f 5e 05 4e 06 00 	divsd  0x64e(%rip),%xmm0        # d10 <_IO_stdin_used+0x170>
 6c1:	00 
 6c2:	e8 29 ff ff ff       	callq  5f0 <__printf_chk@plt>
 6c7:	31 f6                	xor    %esi,%esi
 6c9:	4c 89 e7             	mov    %r12,%rdi
 6cc:	e8 0f ff ff ff       	callq  5e0 <gettimeofday@plt>
 6d1:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 6d6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 6dd:	00 00 00 
 6e0:	8d 14 5b             	lea    (%rbx,%rbx,2),%edx
 6e3:	83 e8 01             	sub    $0x1,%eax
 6e6:	8d 1c 93             	lea    (%rbx,%rdx,4),%ebx
 6e9:	75 f5                	jne    6e0 <main+0xd0>
 6eb:	31 f6                	xor    %esi,%esi
 6ed:	48 89 ef             	mov    %rbp,%rdi
 6f0:	e8 eb fe ff ff       	callq  5e0 <gettimeofday@plt>
 6f5:	66 0f ef c9          	pxor   %xmm1,%xmm1
 6f9:	48 8d 35 f0 04 00 00 	lea    0x4f0(%rip),%rsi        # bf0 <_IO_stdin_used+0x50>
 700:	66 0f ef c0          	pxor   %xmm0,%xmm0
 704:	89 d9                	mov    %ebx,%ecx
 706:	66 0f ef d2          	pxor   %xmm2,%xmm2
 70a:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 70f:	f2 48 0f 2a 4c 24 20 	cvtsi2sdq 0x20(%rsp),%xmm1
 716:	f2 0f 59 0d f2 05 00 	mulsd  0x5f2(%rip),%xmm1        # d10 <_IO_stdin_used+0x170>
 71d:	00 
 71e:	bf 01 00 00 00       	mov    $0x1,%edi
 723:	f2 48 0f 2a 44 24 28 	cvtsi2sdq 0x28(%rsp),%xmm0
 72a:	b8 02 00 00 00       	mov    $0x2,%eax
 72f:	bb 11 00 00 00       	mov    $0x11,%ebx
 734:	f2 48 0f 2a 54 24 18 	cvtsi2sdq 0x18(%rsp),%xmm2
 73b:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
 73f:	66 0f ef c0          	pxor   %xmm0,%xmm0
 743:	f2 48 0f 2a 44 24 10 	cvtsi2sdq 0x10(%rsp),%xmm0
 74a:	f2 0f 59 05 be 05 00 	mulsd  0x5be(%rip),%xmm0        # d10 <_IO_stdin_used+0x170>
 751:	00 
 752:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
 756:	f2 0f 5c c8          	subsd  %xmm0,%xmm1
 75a:	66 0f 28 c1          	movapd %xmm1,%xmm0
 75e:	f2 0f 5e 0d ba 05 00 	divsd  0x5ba(%rip),%xmm1        # d20 <_IO_stdin_used+0x180>
 765:	00 
 766:	f2 0f 5e 05 a2 05 00 	divsd  0x5a2(%rip),%xmm0        # d10 <_IO_stdin_used+0x170>
 76d:	00 
 76e:	e8 7d fe ff ff       	callq  5f0 <__printf_chk@plt>
 773:	31 f6                	xor    %esi,%esi
 775:	4c 89 e7             	mov    %r12,%rdi
 778:	e8 63 fe ff ff       	callq  5e0 <gettimeofday@plt>
 77d:	b9 00 ca 9a 3b       	mov    $0x3b9aca00,%ecx
 782:	be 4f ec c4 4e       	mov    $0x4ec4ec4f,%esi
 787:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 78e:	00 00 
 790:	89 d8                	mov    %ebx,%eax
 792:	c1 fb 1f             	sar    $0x1f,%ebx
 795:	f7 ee                	imul   %esi
 797:	c1 fa 02             	sar    $0x2,%edx
 79a:	29 da                	sub    %ebx,%edx
 79c:	83 e9 01             	sub    $0x1,%ecx
 79f:	89 d3                	mov    %edx,%ebx
 7a1:	75 ed                	jne    790 <main+0x180>
 7a3:	31 f6                	xor    %esi,%esi
 7a5:	48 89 ef             	mov    %rbp,%rdi
 7a8:	e8 33 fe ff ff       	callq  5e0 <gettimeofday@plt>
 7ad:	66 0f ef c9          	pxor   %xmm1,%xmm1
 7b1:	48 8d 35 80 04 00 00 	lea    0x480(%rip),%rsi        # c38 <_IO_stdin_used+0x98>
 7b8:	66 0f ef c0          	pxor   %xmm0,%xmm0
 7bc:	89 d9                	mov    %ebx,%ecx
 7be:	66 0f ef d2          	pxor   %xmm2,%xmm2
 7c2:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 7c7:	f2 48 0f 2a 4c 24 20 	cvtsi2sdq 0x20(%rsp),%xmm1
 7ce:	f2 0f 59 0d 3a 05 00 	mulsd  0x53a(%rip),%xmm1        # d10 <_IO_stdin_used+0x170>
 7d5:	00 
 7d6:	bf 01 00 00 00       	mov    $0x1,%edi
 7db:	f2 48 0f 2a 44 24 28 	cvtsi2sdq 0x28(%rsp),%xmm0
 7e2:	b8 02 00 00 00       	mov    $0x2,%eax
 7e7:	f2 48 0f 2a 54 24 18 	cvtsi2sdq 0x18(%rsp),%xmm2
 7ee:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
 7f2:	66 0f ef c0          	pxor   %xmm0,%xmm0
 7f6:	f2 48 0f 2a 44 24 10 	cvtsi2sdq 0x10(%rsp),%xmm0
 7fd:	f2 0f 59 05 0b 05 00 	mulsd  0x50b(%rip),%xmm0        # d10 <_IO_stdin_used+0x170>
 804:	00 
 805:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
 809:	f2 0f 5c c8          	subsd  %xmm0,%xmm1
 80d:	66 0f 28 c1          	movapd %xmm1,%xmm0
 811:	f2 0f 5e 0d 07 05 00 	divsd  0x507(%rip),%xmm1        # d20 <_IO_stdin_used+0x180>
 818:	00 
 819:	f2 0f 5e 05 ef 04 00 	divsd  0x4ef(%rip),%xmm0        # d10 <_IO_stdin_used+0x170>
 820:	00 
 821:	e8 ca fd ff ff       	callq  5f0 <__printf_chk@plt>
 826:	31 f6                	xor    %esi,%esi
 828:	4c 89 e7             	mov    %r12,%rdi
 82b:	e8 b0 fd ff ff       	callq  5e0 <gettimeofday@plt>
 830:	f2 0f 10 05 e0 04 00 	movsd  0x4e0(%rip),%xmm0        # d18 <_IO_stdin_used+0x178>
 837:	00 
 838:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 83d:	f2 0f 10 1d e3 04 00 	movsd  0x4e3(%rip),%xmm3        # d28 <_IO_stdin_used+0x188>
 844:	00 
 845:	0f 1f 00             	nopl   (%rax)
 848:	83 e8 01             	sub    $0x1,%eax
 84b:	f2 0f 59 c3          	mulsd  %xmm3,%xmm0
 84f:	75 f7                	jne    848 <main+0x238>
 851:	31 f6                	xor    %esi,%esi
 853:	48 89 ef             	mov    %rbp,%rdi
 856:	f2 0f 11 5c 24 08    	movsd  %xmm3,0x8(%rsp)
 85c:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
 861:	e8 7a fd ff ff       	callq  5e0 <gettimeofday@plt>
 866:	66 0f ef c9          	pxor   %xmm1,%xmm1
 86a:	48 8d 35 0f 04 00 00 	lea    0x40f(%rip),%rsi        # c80 <_IO_stdin_used+0xe0>
 871:	66 0f ef d2          	pxor   %xmm2,%xmm2
 875:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 87a:	66 0f ef e4          	pxor   %xmm4,%xmm4
 87e:	bf 01 00 00 00       	mov    $0x1,%edi
 883:	f2 48 0f 2a 4c 24 20 	cvtsi2sdq 0x20(%rsp),%xmm1
 88a:	f2 0f 59 0d 7e 04 00 	mulsd  0x47e(%rip),%xmm1        # d10 <_IO_stdin_used+0x170>
 891:	00 
 892:	b8 03 00 00 00       	mov    $0x3,%eax
 897:	f2 48 0f 2a 54 24 28 	cvtsi2sdq 0x28(%rsp),%xmm2
 89e:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
 8a3:	f2 48 0f 2a 64 24 18 	cvtsi2sdq 0x18(%rsp),%xmm4
 8aa:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
 8ae:	66 0f ef d2          	pxor   %xmm2,%xmm2
 8b2:	f2 48 0f 2a 54 24 10 	cvtsi2sdq 0x10(%rsp),%xmm2
 8b9:	f2 0f 59 15 4f 04 00 	mulsd  0x44f(%rip),%xmm2        # d10 <_IO_stdin_used+0x170>
 8c0:	00 
 8c1:	f2 0f 58 d4          	addsd  %xmm4,%xmm2
 8c5:	f2 0f 5c ca          	subsd  %xmm2,%xmm1
 8c9:	66 0f 28 d1          	movapd %xmm1,%xmm2
 8cd:	f2 0f 5e 0d 3b 04 00 	divsd  0x43b(%rip),%xmm1        # d10 <_IO_stdin_used+0x170>
 8d4:	00 
 8d5:	f2 0f 5e 15 43 04 00 	divsd  0x443(%rip),%xmm2        # d20 <_IO_stdin_used+0x180>
 8dc:	00 
 8dd:	e8 0e fd ff ff       	callq  5f0 <__printf_chk@plt>
 8e2:	31 f6                	xor    %esi,%esi
 8e4:	4c 89 e7             	mov    %r12,%rdi
 8e7:	e8 f4 fc ff ff       	callq  5e0 <gettimeofday@plt>
 8ec:	f2 0f 10 05 24 04 00 	movsd  0x424(%rip),%xmm0        # d18 <_IO_stdin_used+0x178>
 8f3:	00 
 8f4:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 8f9:	f2 0f 10 5c 24 08    	movsd  0x8(%rsp),%xmm3
 8ff:	90                   	nop
 900:	83 e8 01             	sub    $0x1,%eax
 903:	f2 0f 5e c3          	divsd  %xmm3,%xmm0
 907:	75 f7                	jne    900 <main+0x2f0>
 909:	31 f6                	xor    %esi,%esi
 90b:	48 89 ef             	mov    %rbp,%rdi
 90e:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
 913:	e8 c8 fc ff ff       	callq  5e0 <gettimeofday@plt>
 918:	66 0f ef c9          	pxor   %xmm1,%xmm1
 91c:	48 8d 35 a5 03 00 00 	lea    0x3a5(%rip),%rsi        # cc8 <_IO_stdin_used+0x128>
 923:	66 0f ef d2          	pxor   %xmm2,%xmm2
 927:	bf 01 00 00 00       	mov    $0x1,%edi
 92c:	66 0f ef db          	pxor   %xmm3,%xmm3
 930:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 935:	f2 48 0f 2a 4c 24 20 	cvtsi2sdq 0x20(%rsp),%xmm1
 93c:	f2 0f 59 0d cc 03 00 	mulsd  0x3cc(%rip),%xmm1        # d10 <_IO_stdin_used+0x170>
 943:	00 
 944:	b8 03 00 00 00       	mov    $0x3,%eax
 949:	f2 48 0f 2a 54 24 28 	cvtsi2sdq 0x28(%rsp),%xmm2
 950:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
 955:	f2 48 0f 2a 5c 24 18 	cvtsi2sdq 0x18(%rsp),%xmm3
 95c:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
 960:	66 0f ef d2          	pxor   %xmm2,%xmm2
 964:	f2 48 0f 2a 54 24 10 	cvtsi2sdq 0x10(%rsp),%xmm2
 96b:	f2 0f 59 15 9d 03 00 	mulsd  0x39d(%rip),%xmm2        # d10 <_IO_stdin_used+0x170>
 972:	00 
 973:	f2 0f 58 d3          	addsd  %xmm3,%xmm2
 977:	f2 0f 5c ca          	subsd  %xmm2,%xmm1
 97b:	66 0f 28 d1          	movapd %xmm1,%xmm2
 97f:	f2 0f 5e 0d 89 03 00 	divsd  0x389(%rip),%xmm1        # d10 <_IO_stdin_used+0x170>
 986:	00 
 987:	f2 0f 5e 15 91 03 00 	divsd  0x391(%rip),%xmm2        # d20 <_IO_stdin_used+0x180>
 98e:	00 
 98f:	e8 5c fc ff ff       	callq  5f0 <__printf_chk@plt>
 994:	31 c0                	xor    %eax,%eax
 996:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
 99b:	64 48 33 3c 25 28 00 	xor    %fs:0x28,%rdi
 9a2:	00 00 
 9a4:	75 09                	jne    9af <main+0x39f>
 9a6:	48 83 c4 40          	add    $0x40,%rsp
 9aa:	5b                   	pop    %rbx
 9ab:	5d                   	pop    %rbp
 9ac:	41 5c                	pop    %r12
 9ae:	c3                   	retq   
 9af:	e8 1c fc ff ff       	callq  5d0 <__stack_chk_fail@plt>
 9b4:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 9bb:	00 00 00 
 9be:	66 90                	xchg   %ax,%ax

00000000000009c0 <_start>:
 9c0:	31 ed                	xor    %ebp,%ebp
 9c2:	49 89 d1             	mov    %rdx,%r9
 9c5:	5e                   	pop    %rsi
 9c6:	48 89 e2             	mov    %rsp,%rdx
 9c9:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
 9cd:	50                   	push   %rax
 9ce:	54                   	push   %rsp
 9cf:	4c 8d 05 ba 01 00 00 	lea    0x1ba(%rip),%r8        # b90 <__libc_csu_fini>
 9d6:	48 8d 0d 43 01 00 00 	lea    0x143(%rip),%rcx        # b20 <__libc_csu_init>
 9dd:	48 8d 3d 2c fc ff ff 	lea    -0x3d4(%rip),%rdi        # 610 <main>
 9e4:	ff 15 f6 15 20 00    	callq  *0x2015f6(%rip)        # 201fe0 <__libc_start_main@GLIBC_2.2.5>
 9ea:	f4                   	hlt    
 9eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000009f0 <deregister_tm_clones>:
 9f0:	48 8d 3d 19 16 20 00 	lea    0x201619(%rip),%rdi        # 202010 <__TMC_END__>
 9f7:	55                   	push   %rbp
 9f8:	48 8d 05 11 16 20 00 	lea    0x201611(%rip),%rax        # 202010 <__TMC_END__>
 9ff:	48 39 f8             	cmp    %rdi,%rax
 a02:	48 89 e5             	mov    %rsp,%rbp
 a05:	74 19                	je     a20 <deregister_tm_clones+0x30>
 a07:	48 8b 05 ca 15 20 00 	mov    0x2015ca(%rip),%rax        # 201fd8 <_ITM_deregisterTMCloneTable>
 a0e:	48 85 c0             	test   %rax,%rax
 a11:	74 0d                	je     a20 <deregister_tm_clones+0x30>
 a13:	5d                   	pop    %rbp
 a14:	ff e0                	jmpq   *%rax
 a16:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 a1d:	00 00 00 
 a20:	5d                   	pop    %rbp
 a21:	c3                   	retq   
 a22:	0f 1f 40 00          	nopl   0x0(%rax)
 a26:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 a2d:	00 00 00 

0000000000000a30 <register_tm_clones>:
 a30:	48 8d 3d d9 15 20 00 	lea    0x2015d9(%rip),%rdi        # 202010 <__TMC_END__>
 a37:	48 8d 35 d2 15 20 00 	lea    0x2015d2(%rip),%rsi        # 202010 <__TMC_END__>
 a3e:	55                   	push   %rbp
 a3f:	48 29 fe             	sub    %rdi,%rsi
 a42:	48 89 e5             	mov    %rsp,%rbp
 a45:	48 c1 fe 03          	sar    $0x3,%rsi
 a49:	48 89 f0             	mov    %rsi,%rax
 a4c:	48 c1 e8 3f          	shr    $0x3f,%rax
 a50:	48 01 c6             	add    %rax,%rsi
 a53:	48 d1 fe             	sar    %rsi
 a56:	74 18                	je     a70 <register_tm_clones+0x40>
 a58:	48 8b 05 91 15 20 00 	mov    0x201591(%rip),%rax        # 201ff0 <_ITM_registerTMCloneTable>
 a5f:	48 85 c0             	test   %rax,%rax
 a62:	74 0c                	je     a70 <register_tm_clones+0x40>
 a64:	5d                   	pop    %rbp
 a65:	ff e0                	jmpq   *%rax
 a67:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 a6e:	00 00 
 a70:	5d                   	pop    %rbp
 a71:	c3                   	retq   
 a72:	0f 1f 40 00          	nopl   0x0(%rax)
 a76:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 a7d:	00 00 00 

0000000000000a80 <__do_global_dtors_aux>:
 a80:	80 3d 89 15 20 00 00 	cmpb   $0x0,0x201589(%rip)        # 202010 <__TMC_END__>
 a87:	75 2f                	jne    ab8 <__do_global_dtors_aux+0x38>
 a89:	48 83 3d 67 15 20 00 	cmpq   $0x0,0x201567(%rip)        # 201ff8 <__cxa_finalize@GLIBC_2.2.5>
 a90:	00 
 a91:	55                   	push   %rbp
 a92:	48 89 e5             	mov    %rsp,%rbp
 a95:	74 0c                	je     aa3 <__do_global_dtors_aux+0x23>
 a97:	48 8b 3d 6a 15 20 00 	mov    0x20156a(%rip),%rdi        # 202008 <__dso_handle>
 a9e:	e8 5d fb ff ff       	callq  600 <__cxa_finalize@plt>
 aa3:	e8 48 ff ff ff       	callq  9f0 <deregister_tm_clones>
 aa8:	c6 05 61 15 20 00 01 	movb   $0x1,0x201561(%rip)        # 202010 <__TMC_END__>
 aaf:	5d                   	pop    %rbp
 ab0:	c3                   	retq   
 ab1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 ab8:	f3 c3                	repz retq 
 aba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000ac0 <frame_dummy>:
 ac0:	55                   	push   %rbp
 ac1:	48 89 e5             	mov    %rsp,%rbp
 ac4:	5d                   	pop    %rbp
 ac5:	e9 66 ff ff ff       	jmpq   a30 <register_tm_clones>
 aca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000ad0 <time_diff>:
 ad0:	66 0f ef c0          	pxor   %xmm0,%xmm0
 ad4:	66 0f ef d2          	pxor   %xmm2,%xmm2
 ad8:	f2 0f 10 1d 30 02 00 	movsd  0x230(%rip),%xmm3        # d10 <_IO_stdin_used+0x170>
 adf:	00 
 ae0:	f2 48 0f 2a c2       	cvtsi2sd %rdx,%xmm0
 ae5:	66 0f ef c9          	pxor   %xmm1,%xmm1
 ae9:	f2 48 0f 2a d1       	cvtsi2sd %rcx,%xmm2
 aee:	f2 48 0f 2a cf       	cvtsi2sd %rdi,%xmm1
 af3:	f2 0f 59 c3          	mulsd  %xmm3,%xmm0
 af7:	f2 0f 59 cb          	mulsd  %xmm3,%xmm1
 afb:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
 aff:	66 0f ef d2          	pxor   %xmm2,%xmm2
 b03:	f2 48 0f 2a d6       	cvtsi2sd %rsi,%xmm2
 b08:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
 b0c:	f2 0f 5c c1          	subsd  %xmm1,%xmm0
 b10:	c3                   	retq   
 b11:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 b18:	00 00 00 
 b1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000b20 <__libc_csu_init>:
 b20:	41 57                	push   %r15
 b22:	41 56                	push   %r14
 b24:	49 89 d7             	mov    %rdx,%r15
 b27:	41 55                	push   %r13
 b29:	41 54                	push   %r12
 b2b:	4c 8d 25 76 12 20 00 	lea    0x201276(%rip),%r12        # 201da8 <__frame_dummy_init_array_entry>
 b32:	55                   	push   %rbp
 b33:	48 8d 2d 76 12 20 00 	lea    0x201276(%rip),%rbp        # 201db0 <__init_array_end>
 b3a:	53                   	push   %rbx
 b3b:	41 89 fd             	mov    %edi,%r13d
 b3e:	49 89 f6             	mov    %rsi,%r14
 b41:	4c 29 e5             	sub    %r12,%rbp
 b44:	48 83 ec 08          	sub    $0x8,%rsp
 b48:	48 c1 fd 03          	sar    $0x3,%rbp
 b4c:	e8 57 fa ff ff       	callq  5a8 <_init>
 b51:	48 85 ed             	test   %rbp,%rbp
 b54:	74 20                	je     b76 <__libc_csu_init+0x56>
 b56:	31 db                	xor    %ebx,%ebx
 b58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 b5f:	00 
 b60:	4c 89 fa             	mov    %r15,%rdx
 b63:	4c 89 f6             	mov    %r14,%rsi
 b66:	44 89 ef             	mov    %r13d,%edi
 b69:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 b6d:	48 83 c3 01          	add    $0x1,%rbx
 b71:	48 39 dd             	cmp    %rbx,%rbp
 b74:	75 ea                	jne    b60 <__libc_csu_init+0x40>
 b76:	48 83 c4 08          	add    $0x8,%rsp
 b7a:	5b                   	pop    %rbx
 b7b:	5d                   	pop    %rbp
 b7c:	41 5c                	pop    %r12
 b7e:	41 5d                	pop    %r13
 b80:	41 5e                	pop    %r14
 b82:	41 5f                	pop    %r15
 b84:	c3                   	retq   
 b85:	90                   	nop
 b86:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 b8d:	00 00 00 

0000000000000b90 <__libc_csu_fini>:
 b90:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000000b94 <_fini>:
 b94:	48 83 ec 08          	sub    $0x8,%rsp
 b98:	48 83 c4 08          	add    $0x8,%rsp
 b9c:	c3                   	retq   
