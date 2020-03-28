
Measure-ALU-broken:     file format elf64-x86-64


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
 610:	55                   	push   %rbp
 611:	53                   	push   %rbx
 612:	31 f6                	xor    %esi,%esi
 614:	48 83 ec 48          	sub    $0x48,%rsp
 618:	48 8d 6c 24 10       	lea    0x10(%rsp),%rbp
 61d:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
 622:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
 629:	00 00 
 62b:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
 630:	31 c0                	xor    %eax,%eax
 632:	48 89 ef             	mov    %rbp,%rdi
 635:	e8 a6 ff ff ff       	callq  5e0 <gettimeofday@plt>
 63a:	31 f6                	xor    %esi,%esi
 63c:	48 89 df             	mov    %rbx,%rdi
 63f:	e8 9c ff ff ff       	callq  5e0 <gettimeofday@plt>
 644:	66 0f ef c9          	pxor   %xmm1,%xmm1
 648:	48 8d 35 a9 04 00 00 	lea    0x4a9(%rip),%rsi        # af8 <_IO_stdin_used+0x8>
 64f:	f2 0f 10 1d 09 06 00 	movsd  0x609(%rip),%xmm3        # c60 <_IO_stdin_used+0x170>
 656:	00 
 657:	b9 11 00 00 00       	mov    $0x11,%ecx
 65c:	66 0f ef c0          	pxor   %xmm0,%xmm0
 660:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 665:	f2 48 0f 2a 4c 24 20 	cvtsi2sdq 0x20(%rsp),%xmm1
 66c:	f2 0f 59 cb          	mulsd  %xmm3,%xmm1
 670:	bf 01 00 00 00       	mov    $0x1,%edi
 675:	66 0f ef d2          	pxor   %xmm2,%xmm2
 679:	b8 02 00 00 00       	mov    $0x2,%eax
 67e:	f2 0f 11 5c 24 08    	movsd  %xmm3,0x8(%rsp)
 684:	f2 48 0f 2a 44 24 28 	cvtsi2sdq 0x28(%rsp),%xmm0
 68b:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
 68f:	66 0f ef c0          	pxor   %xmm0,%xmm0
 693:	f2 48 0f 2a 54 24 18 	cvtsi2sdq 0x18(%rsp),%xmm2
 69a:	f2 48 0f 2a 44 24 10 	cvtsi2sdq 0x10(%rsp),%xmm0
 6a1:	f2 0f 59 c3          	mulsd  %xmm3,%xmm0
 6a5:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
 6a9:	f2 0f 5c c8          	subsd  %xmm0,%xmm1
 6ad:	66 0f 28 c1          	movapd %xmm1,%xmm0
 6b1:	f2 0f 5e 0d af 05 00 	divsd  0x5af(%rip),%xmm1        # c68 <_IO_stdin_used+0x178>
 6b8:	00 
 6b9:	f2 0f 5e c3          	divsd  %xmm3,%xmm0
 6bd:	e8 2e ff ff ff       	callq  5f0 <__printf_chk@plt>
 6c2:	31 f6                	xor    %esi,%esi
 6c4:	48 89 ef             	mov    %rbp,%rdi
 6c7:	e8 14 ff ff ff       	callq  5e0 <gettimeofday@plt>
 6cc:	31 f6                	xor    %esi,%esi
 6ce:	48 89 df             	mov    %rbx,%rdi
 6d1:	e8 0a ff ff ff       	callq  5e0 <gettimeofday@plt>
 6d6:	66 0f ef c9          	pxor   %xmm1,%xmm1
 6da:	48 8d 35 5f 04 00 00 	lea    0x45f(%rip),%rsi        # b40 <_IO_stdin_used+0x50>
 6e1:	f2 0f 10 5c 24 08    	movsd  0x8(%rsp),%xmm3
 6e7:	b9 dd 00 00 00       	mov    $0xdd,%ecx
 6ec:	66 0f ef c0          	pxor   %xmm0,%xmm0
 6f0:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 6f5:	f2 48 0f 2a 4c 24 20 	cvtsi2sdq 0x20(%rsp),%xmm1
 6fc:	f2 0f 59 cb          	mulsd  %xmm3,%xmm1
 700:	bf 01 00 00 00       	mov    $0x1,%edi
 705:	66 0f ef d2          	pxor   %xmm2,%xmm2
 709:	b8 02 00 00 00       	mov    $0x2,%eax
 70e:	f2 48 0f 2a 44 24 28 	cvtsi2sdq 0x28(%rsp),%xmm0
 715:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
 719:	66 0f ef c0          	pxor   %xmm0,%xmm0
 71d:	f2 48 0f 2a 54 24 18 	cvtsi2sdq 0x18(%rsp),%xmm2
 724:	f2 48 0f 2a 44 24 10 	cvtsi2sdq 0x10(%rsp),%xmm0
 72b:	f2 0f 59 c3          	mulsd  %xmm3,%xmm0
 72f:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
 733:	f2 0f 5c c8          	subsd  %xmm0,%xmm1
 737:	66 0f 28 c1          	movapd %xmm1,%xmm0
 73b:	f2 0f 5e 0d 25 05 00 	divsd  0x525(%rip),%xmm1        # c68 <_IO_stdin_used+0x178>
 742:	00 
 743:	f2 0f 5e c3          	divsd  %xmm3,%xmm0
 747:	e8 a4 fe ff ff       	callq  5f0 <__printf_chk@plt>
 74c:	31 f6                	xor    %esi,%esi
 74e:	48 89 ef             	mov    %rbp,%rdi
 751:	e8 8a fe ff ff       	callq  5e0 <gettimeofday@plt>
 756:	31 f6                	xor    %esi,%esi
 758:	48 89 df             	mov    %rbx,%rdi
 75b:	e8 80 fe ff ff       	callq  5e0 <gettimeofday@plt>
 760:	66 0f ef c9          	pxor   %xmm1,%xmm1
 764:	48 8d 35 1d 04 00 00 	lea    0x41d(%rip),%rsi        # b88 <_IO_stdin_used+0x98>
 76b:	f2 0f 10 5c 24 08    	movsd  0x8(%rsp),%xmm3
 771:	b9 01 00 00 00       	mov    $0x1,%ecx
 776:	66 0f ef c0          	pxor   %xmm0,%xmm0
 77a:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 77f:	f2 48 0f 2a 4c 24 20 	cvtsi2sdq 0x20(%rsp),%xmm1
 786:	f2 0f 59 cb          	mulsd  %xmm3,%xmm1
 78a:	bf 01 00 00 00       	mov    $0x1,%edi
 78f:	66 0f ef d2          	pxor   %xmm2,%xmm2
 793:	b8 02 00 00 00       	mov    $0x2,%eax
 798:	f2 48 0f 2a 44 24 28 	cvtsi2sdq 0x28(%rsp),%xmm0
 79f:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
 7a3:	66 0f ef c0          	pxor   %xmm0,%xmm0
 7a7:	f2 48 0f 2a 54 24 18 	cvtsi2sdq 0x18(%rsp),%xmm2
 7ae:	f2 48 0f 2a 44 24 10 	cvtsi2sdq 0x10(%rsp),%xmm0
 7b5:	f2 0f 59 c3          	mulsd  %xmm3,%xmm0
 7b9:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
 7bd:	f2 0f 5c c8          	subsd  %xmm0,%xmm1
 7c1:	66 0f 28 c1          	movapd %xmm1,%xmm0
 7c5:	f2 0f 5e 0d 9b 04 00 	divsd  0x49b(%rip),%xmm1        # c68 <_IO_stdin_used+0x178>
 7cc:	00 
 7cd:	f2 0f 5e c3          	divsd  %xmm3,%xmm0
 7d1:	e8 1a fe ff ff       	callq  5f0 <__printf_chk@plt>
 7d6:	31 f6                	xor    %esi,%esi
 7d8:	48 89 ef             	mov    %rbp,%rdi
 7db:	e8 00 fe ff ff       	callq  5e0 <gettimeofday@plt>
 7e0:	31 f6                	xor    %esi,%esi
 7e2:	48 89 df             	mov    %rbx,%rdi
 7e5:	e8 f6 fd ff ff       	callq  5e0 <gettimeofday@plt>
 7ea:	66 0f ef c9          	pxor   %xmm1,%xmm1
 7ee:	48 8d 35 db 03 00 00 	lea    0x3db(%rip),%rsi        # bd0 <_IO_stdin_used+0xe0>
 7f5:	f2 0f 10 5c 24 08    	movsd  0x8(%rsp),%xmm3
 7fb:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 800:	66 0f ef c0          	pxor   %xmm0,%xmm0
 804:	bf 01 00 00 00       	mov    $0x1,%edi
 809:	f2 48 0f 2a 4c 24 20 	cvtsi2sdq 0x20(%rsp),%xmm1
 810:	f2 0f 59 cb          	mulsd  %xmm3,%xmm1
 814:	b8 03 00 00 00       	mov    $0x3,%eax
 819:	66 0f ef d2          	pxor   %xmm2,%xmm2
 81d:	f2 48 0f 2a 44 24 28 	cvtsi2sdq 0x28(%rsp),%xmm0
 824:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
 828:	66 0f ef c0          	pxor   %xmm0,%xmm0
 82c:	f2 48 0f 2a 54 24 18 	cvtsi2sdq 0x18(%rsp),%xmm2
 833:	f2 48 0f 2a 44 24 10 	cvtsi2sdq 0x10(%rsp),%xmm0
 83a:	f2 0f 59 c3          	mulsd  %xmm3,%xmm0
 83e:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
 842:	f2 0f 5c c8          	subsd  %xmm0,%xmm1
 846:	f2 0f 10 05 22 04 00 	movsd  0x422(%rip),%xmm0        # c70 <_IO_stdin_used+0x180>
 84d:	00 
 84e:	66 0f 28 d1          	movapd %xmm1,%xmm2
 852:	f2 0f 5e cb          	divsd  %xmm3,%xmm1
 856:	f2 0f 5e 15 0a 04 00 	divsd  0x40a(%rip),%xmm2        # c68 <_IO_stdin_used+0x178>
 85d:	00 
 85e:	e8 8d fd ff ff       	callq  5f0 <__printf_chk@plt>
 863:	31 f6                	xor    %esi,%esi
 865:	48 89 ef             	mov    %rbp,%rdi
 868:	e8 73 fd ff ff       	callq  5e0 <gettimeofday@plt>
 86d:	31 f6                	xor    %esi,%esi
 86f:	48 89 df             	mov    %rbx,%rdi
 872:	e8 69 fd ff ff       	callq  5e0 <gettimeofday@plt>
 877:	66 0f ef c9          	pxor   %xmm1,%xmm1
 87b:	48 8d 35 96 03 00 00 	lea    0x396(%rip),%rsi        # c18 <_IO_stdin_used+0x128>
 882:	f2 0f 10 5c 24 08    	movsd  0x8(%rsp),%xmm3
 888:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 88d:	66 0f ef c0          	pxor   %xmm0,%xmm0
 891:	bf 01 00 00 00       	mov    $0x1,%edi
 896:	f2 48 0f 2a 4c 24 20 	cvtsi2sdq 0x20(%rsp),%xmm1
 89d:	f2 0f 59 cb          	mulsd  %xmm3,%xmm1
 8a1:	b8 03 00 00 00       	mov    $0x3,%eax
 8a6:	66 0f ef d2          	pxor   %xmm2,%xmm2
 8aa:	f2 48 0f 2a 44 24 28 	cvtsi2sdq 0x28(%rsp),%xmm0
 8b1:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
 8b5:	66 0f ef c0          	pxor   %xmm0,%xmm0
 8b9:	f2 48 0f 2a 54 24 18 	cvtsi2sdq 0x18(%rsp),%xmm2
 8c0:	f2 48 0f 2a 44 24 10 	cvtsi2sdq 0x10(%rsp),%xmm0
 8c7:	f2 0f 59 c3          	mulsd  %xmm3,%xmm0
 8cb:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
 8cf:	f2 0f 5c c8          	subsd  %xmm0,%xmm1
 8d3:	f2 0f 10 05 9d 03 00 	movsd  0x39d(%rip),%xmm0        # c78 <_IO_stdin_used+0x188>
 8da:	00 
 8db:	66 0f 28 d1          	movapd %xmm1,%xmm2
 8df:	f2 0f 5e cb          	divsd  %xmm3,%xmm1
 8e3:	f2 0f 5e 15 7d 03 00 	divsd  0x37d(%rip),%xmm2        # c68 <_IO_stdin_used+0x178>
 8ea:	00 
 8eb:	e8 00 fd ff ff       	callq  5f0 <__printf_chk@plt>
 8f0:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
 8f5:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
 8fc:	00 00 
 8fe:	75 09                	jne    909 <main+0x2f9>
 900:	48 83 c4 48          	add    $0x48,%rsp
 904:	31 c0                	xor    %eax,%eax
 906:	5b                   	pop    %rbx
 907:	5d                   	pop    %rbp
 908:	c3                   	retq   
 909:	e8 c2 fc ff ff       	callq  5d0 <__stack_chk_fail@plt>
 90e:	66 90                	xchg   %ax,%ax

0000000000000910 <_start>:
 910:	31 ed                	xor    %ebp,%ebp
 912:	49 89 d1             	mov    %rdx,%r9
 915:	5e                   	pop    %rsi
 916:	48 89 e2             	mov    %rsp,%rdx
 919:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
 91d:	50                   	push   %rax
 91e:	54                   	push   %rsp
 91f:	4c 8d 05 ba 01 00 00 	lea    0x1ba(%rip),%r8        # ae0 <__libc_csu_fini>
 926:	48 8d 0d 43 01 00 00 	lea    0x143(%rip),%rcx        # a70 <__libc_csu_init>
 92d:	48 8d 3d dc fc ff ff 	lea    -0x324(%rip),%rdi        # 610 <main>
 934:	ff 15 a6 16 20 00    	callq  *0x2016a6(%rip)        # 201fe0 <__libc_start_main@GLIBC_2.2.5>
 93a:	f4                   	hlt    
 93b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000940 <deregister_tm_clones>:
 940:	48 8d 3d c9 16 20 00 	lea    0x2016c9(%rip),%rdi        # 202010 <__TMC_END__>
 947:	55                   	push   %rbp
 948:	48 8d 05 c1 16 20 00 	lea    0x2016c1(%rip),%rax        # 202010 <__TMC_END__>
 94f:	48 39 f8             	cmp    %rdi,%rax
 952:	48 89 e5             	mov    %rsp,%rbp
 955:	74 19                	je     970 <deregister_tm_clones+0x30>
 957:	48 8b 05 7a 16 20 00 	mov    0x20167a(%rip),%rax        # 201fd8 <_ITM_deregisterTMCloneTable>
 95e:	48 85 c0             	test   %rax,%rax
 961:	74 0d                	je     970 <deregister_tm_clones+0x30>
 963:	5d                   	pop    %rbp
 964:	ff e0                	jmpq   *%rax
 966:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 96d:	00 00 00 
 970:	5d                   	pop    %rbp
 971:	c3                   	retq   
 972:	0f 1f 40 00          	nopl   0x0(%rax)
 976:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 97d:	00 00 00 

0000000000000980 <register_tm_clones>:
 980:	48 8d 3d 89 16 20 00 	lea    0x201689(%rip),%rdi        # 202010 <__TMC_END__>
 987:	48 8d 35 82 16 20 00 	lea    0x201682(%rip),%rsi        # 202010 <__TMC_END__>
 98e:	55                   	push   %rbp
 98f:	48 29 fe             	sub    %rdi,%rsi
 992:	48 89 e5             	mov    %rsp,%rbp
 995:	48 c1 fe 03          	sar    $0x3,%rsi
 999:	48 89 f0             	mov    %rsi,%rax
 99c:	48 c1 e8 3f          	shr    $0x3f,%rax
 9a0:	48 01 c6             	add    %rax,%rsi
 9a3:	48 d1 fe             	sar    %rsi
 9a6:	74 18                	je     9c0 <register_tm_clones+0x40>
 9a8:	48 8b 05 41 16 20 00 	mov    0x201641(%rip),%rax        # 201ff0 <_ITM_registerTMCloneTable>
 9af:	48 85 c0             	test   %rax,%rax
 9b2:	74 0c                	je     9c0 <register_tm_clones+0x40>
 9b4:	5d                   	pop    %rbp
 9b5:	ff e0                	jmpq   *%rax
 9b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 9be:	00 00 
 9c0:	5d                   	pop    %rbp
 9c1:	c3                   	retq   
 9c2:	0f 1f 40 00          	nopl   0x0(%rax)
 9c6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 9cd:	00 00 00 

00000000000009d0 <__do_global_dtors_aux>:
 9d0:	80 3d 39 16 20 00 00 	cmpb   $0x0,0x201639(%rip)        # 202010 <__TMC_END__>
 9d7:	75 2f                	jne    a08 <__do_global_dtors_aux+0x38>
 9d9:	48 83 3d 17 16 20 00 	cmpq   $0x0,0x201617(%rip)        # 201ff8 <__cxa_finalize@GLIBC_2.2.5>
 9e0:	00 
 9e1:	55                   	push   %rbp
 9e2:	48 89 e5             	mov    %rsp,%rbp
 9e5:	74 0c                	je     9f3 <__do_global_dtors_aux+0x23>
 9e7:	48 8b 3d 1a 16 20 00 	mov    0x20161a(%rip),%rdi        # 202008 <__dso_handle>
 9ee:	e8 0d fc ff ff       	callq  600 <__cxa_finalize@plt>
 9f3:	e8 48 ff ff ff       	callq  940 <deregister_tm_clones>
 9f8:	c6 05 11 16 20 00 01 	movb   $0x1,0x201611(%rip)        # 202010 <__TMC_END__>
 9ff:	5d                   	pop    %rbp
 a00:	c3                   	retq   
 a01:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 a08:	f3 c3                	repz retq 
 a0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000a10 <frame_dummy>:
 a10:	55                   	push   %rbp
 a11:	48 89 e5             	mov    %rsp,%rbp
 a14:	5d                   	pop    %rbp
 a15:	e9 66 ff ff ff       	jmpq   980 <register_tm_clones>
 a1a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000a20 <time_diff>:
 a20:	66 0f ef c0          	pxor   %xmm0,%xmm0
 a24:	66 0f ef d2          	pxor   %xmm2,%xmm2
 a28:	f2 0f 10 1d 30 02 00 	movsd  0x230(%rip),%xmm3        # c60 <_IO_stdin_used+0x170>
 a2f:	00 
 a30:	f2 48 0f 2a c2       	cvtsi2sd %rdx,%xmm0
 a35:	66 0f ef c9          	pxor   %xmm1,%xmm1
 a39:	f2 48 0f 2a d1       	cvtsi2sd %rcx,%xmm2
 a3e:	f2 48 0f 2a cf       	cvtsi2sd %rdi,%xmm1
 a43:	f2 0f 59 c3          	mulsd  %xmm3,%xmm0
 a47:	f2 0f 59 cb          	mulsd  %xmm3,%xmm1
 a4b:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
 a4f:	66 0f ef d2          	pxor   %xmm2,%xmm2
 a53:	f2 48 0f 2a d6       	cvtsi2sd %rsi,%xmm2
 a58:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
 a5c:	f2 0f 5c c1          	subsd  %xmm1,%xmm0
 a60:	c3                   	retq   
 a61:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 a68:	00 00 00 
 a6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000a70 <__libc_csu_init>:
 a70:	41 57                	push   %r15
 a72:	41 56                	push   %r14
 a74:	49 89 d7             	mov    %rdx,%r15
 a77:	41 55                	push   %r13
 a79:	41 54                	push   %r12
 a7b:	4c 8d 25 26 13 20 00 	lea    0x201326(%rip),%r12        # 201da8 <__frame_dummy_init_array_entry>
 a82:	55                   	push   %rbp
 a83:	48 8d 2d 26 13 20 00 	lea    0x201326(%rip),%rbp        # 201db0 <__init_array_end>
 a8a:	53                   	push   %rbx
 a8b:	41 89 fd             	mov    %edi,%r13d
 a8e:	49 89 f6             	mov    %rsi,%r14
 a91:	4c 29 e5             	sub    %r12,%rbp
 a94:	48 83 ec 08          	sub    $0x8,%rsp
 a98:	48 c1 fd 03          	sar    $0x3,%rbp
 a9c:	e8 07 fb ff ff       	callq  5a8 <_init>
 aa1:	48 85 ed             	test   %rbp,%rbp
 aa4:	74 20                	je     ac6 <__libc_csu_init+0x56>
 aa6:	31 db                	xor    %ebx,%ebx
 aa8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 aaf:	00 
 ab0:	4c 89 fa             	mov    %r15,%rdx
 ab3:	4c 89 f6             	mov    %r14,%rsi
 ab6:	44 89 ef             	mov    %r13d,%edi
 ab9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 abd:	48 83 c3 01          	add    $0x1,%rbx
 ac1:	48 39 dd             	cmp    %rbx,%rbp
 ac4:	75 ea                	jne    ab0 <__libc_csu_init+0x40>
 ac6:	48 83 c4 08          	add    $0x8,%rsp
 aca:	5b                   	pop    %rbx
 acb:	5d                   	pop    %rbp
 acc:	41 5c                	pop    %r12
 ace:	41 5d                	pop    %r13
 ad0:	41 5e                	pop    %r14
 ad2:	41 5f                	pop    %r15
 ad4:	c3                   	retq   
 ad5:	90                   	nop
 ad6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 add:	00 00 00 

0000000000000ae0 <__libc_csu_fini>:
 ae0:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000000ae4 <_fini>:
 ae4:	48 83 ec 08          	sub    $0x8,%rsp
 ae8:	48 83 c4 08          	add    $0x8,%rsp
 aec:	c3                   	retq   
