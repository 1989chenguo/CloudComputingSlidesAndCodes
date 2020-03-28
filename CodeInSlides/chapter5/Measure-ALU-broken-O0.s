
Measure-ALU-broken:     file format elf64-x86-64


Disassembly of section .init:

0000000000000588 <_init>:
 588:	48 83 ec 08          	sub    $0x8,%rsp
 58c:	48 8b 05 55 1a 20 00 	mov    0x201a55(%rip),%rax        # 201fe8 <__gmon_start__>
 593:	48 85 c0             	test   %rax,%rax
 596:	74 02                	je     59a <_init+0x12>
 598:	ff d0                	callq  *%rax
 59a:	48 83 c4 08          	add    $0x8,%rsp
 59e:	c3                   	retq   

Disassembly of section .plt:

00000000000005a0 <.plt>:
 5a0:	ff 35 0a 1a 20 00    	pushq  0x201a0a(%rip)        # 201fb0 <_GLOBAL_OFFSET_TABLE_+0x8>
 5a6:	ff 25 0c 1a 20 00    	jmpq   *0x201a0c(%rip)        # 201fb8 <_GLOBAL_OFFSET_TABLE_+0x10>
 5ac:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000005b0 <__stack_chk_fail@plt>:
 5b0:	ff 25 0a 1a 20 00    	jmpq   *0x201a0a(%rip)        # 201fc0 <__stack_chk_fail@GLIBC_2.4>
 5b6:	68 00 00 00 00       	pushq  $0x0
 5bb:	e9 e0 ff ff ff       	jmpq   5a0 <.plt>

00000000000005c0 <printf@plt>:
 5c0:	ff 25 02 1a 20 00    	jmpq   *0x201a02(%rip)        # 201fc8 <printf@GLIBC_2.2.5>
 5c6:	68 01 00 00 00       	pushq  $0x1
 5cb:	e9 d0 ff ff ff       	jmpq   5a0 <.plt>

00000000000005d0 <gettimeofday@plt>:
 5d0:	ff 25 fa 19 20 00    	jmpq   *0x2019fa(%rip)        # 201fd0 <gettimeofday@GLIBC_2.2.5>
 5d6:	68 02 00 00 00       	pushq  $0x2
 5db:	e9 c0 ff ff ff       	jmpq   5a0 <.plt>

Disassembly of section .plt.got:

00000000000005e0 <__cxa_finalize@plt>:
 5e0:	ff 25 12 1a 20 00    	jmpq   *0x201a12(%rip)        # 201ff8 <__cxa_finalize@GLIBC_2.2.5>
 5e6:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

00000000000005f0 <_start>:
 5f0:	31 ed                	xor    %ebp,%ebp
 5f2:	49 89 d1             	mov    %rdx,%r9
 5f5:	5e                   	pop    %rsi
 5f6:	48 89 e2             	mov    %rsp,%rdx
 5f9:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
 5fd:	50                   	push   %rax
 5fe:	54                   	push   %rsp
 5ff:	4c 8d 05 ea 06 00 00 	lea    0x6ea(%rip),%r8        # cf0 <__libc_csu_fini>
 606:	48 8d 0d 73 06 00 00 	lea    0x673(%rip),%rcx        # c80 <__libc_csu_init>
 60d:	48 8d 3d 6d 01 00 00 	lea    0x16d(%rip),%rdi        # 781 <main>
 614:	ff 15 c6 19 20 00    	callq  *0x2019c6(%rip)        # 201fe0 <__libc_start_main@GLIBC_2.2.5>
 61a:	f4                   	hlt    
 61b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000620 <deregister_tm_clones>:
 620:	48 8d 3d e9 19 20 00 	lea    0x2019e9(%rip),%rdi        # 202010 <__TMC_END__>
 627:	55                   	push   %rbp
 628:	48 8d 05 e1 19 20 00 	lea    0x2019e1(%rip),%rax        # 202010 <__TMC_END__>
 62f:	48 39 f8             	cmp    %rdi,%rax
 632:	48 89 e5             	mov    %rsp,%rbp
 635:	74 19                	je     650 <deregister_tm_clones+0x30>
 637:	48 8b 05 9a 19 20 00 	mov    0x20199a(%rip),%rax        # 201fd8 <_ITM_deregisterTMCloneTable>
 63e:	48 85 c0             	test   %rax,%rax
 641:	74 0d                	je     650 <deregister_tm_clones+0x30>
 643:	5d                   	pop    %rbp
 644:	ff e0                	jmpq   *%rax
 646:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 64d:	00 00 00 
 650:	5d                   	pop    %rbp
 651:	c3                   	retq   
 652:	0f 1f 40 00          	nopl   0x0(%rax)
 656:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 65d:	00 00 00 

0000000000000660 <register_tm_clones>:
 660:	48 8d 3d a9 19 20 00 	lea    0x2019a9(%rip),%rdi        # 202010 <__TMC_END__>
 667:	48 8d 35 a2 19 20 00 	lea    0x2019a2(%rip),%rsi        # 202010 <__TMC_END__>
 66e:	55                   	push   %rbp
 66f:	48 29 fe             	sub    %rdi,%rsi
 672:	48 89 e5             	mov    %rsp,%rbp
 675:	48 c1 fe 03          	sar    $0x3,%rsi
 679:	48 89 f0             	mov    %rsi,%rax
 67c:	48 c1 e8 3f          	shr    $0x3f,%rax
 680:	48 01 c6             	add    %rax,%rsi
 683:	48 d1 fe             	sar    %rsi
 686:	74 18                	je     6a0 <register_tm_clones+0x40>
 688:	48 8b 05 61 19 20 00 	mov    0x201961(%rip),%rax        # 201ff0 <_ITM_registerTMCloneTable>
 68f:	48 85 c0             	test   %rax,%rax
 692:	74 0c                	je     6a0 <register_tm_clones+0x40>
 694:	5d                   	pop    %rbp
 695:	ff e0                	jmpq   *%rax
 697:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 69e:	00 00 
 6a0:	5d                   	pop    %rbp
 6a1:	c3                   	retq   
 6a2:	0f 1f 40 00          	nopl   0x0(%rax)
 6a6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 6ad:	00 00 00 

00000000000006b0 <__do_global_dtors_aux>:
 6b0:	80 3d 59 19 20 00 00 	cmpb   $0x0,0x201959(%rip)        # 202010 <__TMC_END__>
 6b7:	75 2f                	jne    6e8 <__do_global_dtors_aux+0x38>
 6b9:	48 83 3d 37 19 20 00 	cmpq   $0x0,0x201937(%rip)        # 201ff8 <__cxa_finalize@GLIBC_2.2.5>
 6c0:	00 
 6c1:	55                   	push   %rbp
 6c2:	48 89 e5             	mov    %rsp,%rbp
 6c5:	74 0c                	je     6d3 <__do_global_dtors_aux+0x23>
 6c7:	48 8b 3d 3a 19 20 00 	mov    0x20193a(%rip),%rdi        # 202008 <__dso_handle>
 6ce:	e8 0d ff ff ff       	callq  5e0 <__cxa_finalize@plt>
 6d3:	e8 48 ff ff ff       	callq  620 <deregister_tm_clones>
 6d8:	c6 05 31 19 20 00 01 	movb   $0x1,0x201931(%rip)        # 202010 <__TMC_END__>
 6df:	5d                   	pop    %rbp
 6e0:	c3                   	retq   
 6e1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 6e8:	f3 c3                	repz retq 
 6ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000006f0 <frame_dummy>:
 6f0:	55                   	push   %rbp
 6f1:	48 89 e5             	mov    %rsp,%rbp
 6f4:	5d                   	pop    %rbp
 6f5:	e9 66 ff ff ff       	jmpq   660 <register_tm_clones>

00000000000006fa <time_diff>:
 6fa:	55                   	push   %rbp
 6fb:	48 89 e5             	mov    %rsp,%rbp
 6fe:	48 89 f8             	mov    %rdi,%rax
 701:	49 89 f0             	mov    %rsi,%r8
 704:	48 89 c6             	mov    %rax,%rsi
 707:	48 89 d7             	mov    %rdx,%rdi
 70a:	4c 89 c7             	mov    %r8,%rdi
 70d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
 711:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
 715:	48 89 55 c0          	mov    %rdx,-0x40(%rbp)
 719:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
 71d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
 721:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
 726:	f2 0f 10 0d 42 07 00 	movsd  0x742(%rip),%xmm1        # e70 <_IO_stdin_used+0x170>
 72d:	00 
 72e:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
 732:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 736:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
 73b:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
 73f:	f2 0f 11 45 e8       	movsd  %xmm0,-0x18(%rbp)
 744:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
 748:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
 74d:	f2 0f 10 0d 1b 07 00 	movsd  0x71b(%rip),%xmm1        # e70 <_IO_stdin_used+0x170>
 754:	00 
 755:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
 759:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
 75d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
 762:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
 766:	f2 0f 11 45 f0       	movsd  %xmm0,-0x10(%rbp)
 76b:	f2 0f 10 45 f0       	movsd  -0x10(%rbp),%xmm0
 770:	f2 0f 5c 45 e8       	subsd  -0x18(%rbp),%xmm0
 775:	f2 0f 11 45 f8       	movsd  %xmm0,-0x8(%rbp)
 77a:	f2 0f 10 45 f8       	movsd  -0x8(%rbp),%xmm0
 77f:	5d                   	pop    %rbp
 780:	c3                   	retq   

0000000000000781 <main>:
 781:	55                   	push   %rbp
 782:	48 89 e5             	mov    %rsp,%rbp
 785:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
 78c:	89 bd 0c ff ff ff    	mov    %edi,-0xf4(%rbp)
 792:	48 89 b5 00 ff ff ff 	mov    %rsi,-0x100(%rbp)
 799:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
 7a0:	00 00 
 7a2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
 7a6:	31 c0                	xor    %eax,%eax
 7a8:	c7 85 34 ff ff ff 11 	movl   $0x11,-0xcc(%rbp)
 7af:	00 00 00 
 7b2:	c7 85 38 ff ff ff 0d 	movl   $0xd,-0xc8(%rbp)
 7b9:	00 00 00 
 7bc:	c7 85 3c ff ff ff 00 	movl   $0x0,-0xc4(%rbp)
 7c3:	00 00 00 
 7c6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
 7ca:	be 00 00 00 00       	mov    $0x0,%esi
 7cf:	48 89 c7             	mov    %rax,%rdi
 7d2:	e8 f9 fd ff ff       	callq  5d0 <gettimeofday@plt>
 7d7:	c7 85 18 ff ff ff 00 	movl   $0x0,-0xe8(%rbp)
 7de:	00 00 00 
 7e1:	eb 07                	jmp    7ea <main+0x69>
 7e3:	83 85 18 ff ff ff 01 	addl   $0x1,-0xe8(%rbp)
 7ea:	81 bd 18 ff ff ff ff 	cmpl   $0x3b9ac9ff,-0xe8(%rbp)
 7f1:	c9 9a 3b 
 7f4:	7e ed                	jle    7e3 <main+0x62>
 7f6:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
 7fa:	be 00 00 00 00       	mov    $0x0,%esi
 7ff:	48 89 c7             	mov    %rax,%rdi
 802:	e8 c9 fd ff ff       	callq  5d0 <gettimeofday@plt>
 807:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 80b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 80f:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
 813:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
 817:	48 89 d1             	mov    %rdx,%rcx
 81a:	48 89 c2             	mov    %rax,%rdx
 81d:	e8 d8 fe ff ff       	callq  6fa <time_diff>
 822:	66 48 0f 7e c0       	movq   %xmm0,%rax
 827:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
 82e:	f2 0f 10 85 60 ff ff 	movsd  -0xa0(%rbp),%xmm0
 835:	ff 
 836:	f2 0f 10 0d 3a 06 00 	movsd  0x63a(%rip),%xmm1        # e78 <_IO_stdin_used+0x178>
 83d:	00 
 83e:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
 842:	f2 0f 11 85 68 ff ff 	movsd  %xmm0,-0x98(%rbp)
 849:	ff 
 84a:	f2 0f 10 85 60 ff ff 	movsd  -0xa0(%rbp),%xmm0
 851:	ff 
 852:	f2 0f 10 0d 16 06 00 	movsd  0x616(%rip),%xmm1        # e70 <_IO_stdin_used+0x170>
 859:	00 
 85a:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
 85e:	f2 0f 10 8d 68 ff ff 	movsd  -0x98(%rbp),%xmm1
 865:	ff 
 866:	8b 95 34 ff ff ff    	mov    -0xcc(%rbp),%edx
 86c:	8b 85 18 ff ff ff    	mov    -0xe8(%rbp),%eax
 872:	89 c6                	mov    %eax,%esi
 874:	48 8d 3d 8d 04 00 00 	lea    0x48d(%rip),%rdi        # d08 <_IO_stdin_used+0x8>
 87b:	b8 02 00 00 00       	mov    $0x2,%eax
 880:	e8 3b fd ff ff       	callq  5c0 <printf@plt>
 885:	c7 85 40 ff ff ff 11 	movl   $0x11,-0xc0(%rbp)
 88c:	00 00 00 
 88f:	c7 85 44 ff ff ff 0d 	movl   $0xd,-0xbc(%rbp)
 896:	00 00 00 
 899:	c7 85 1c ff ff ff 00 	movl   $0x0,-0xe4(%rbp)
 8a0:	00 00 00 
 8a3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
 8a7:	be 00 00 00 00       	mov    $0x0,%esi
 8ac:	48 89 c7             	mov    %rax,%rdi
 8af:	e8 1c fd ff ff       	callq  5d0 <gettimeofday@plt>
 8b4:	c7 85 20 ff ff ff 00 	movl   $0x0,-0xe0(%rbp)
 8bb:	00 00 00 
 8be:	eb 1a                	jmp    8da <main+0x159>
 8c0:	8b 85 40 ff ff ff    	mov    -0xc0(%rbp),%eax
 8c6:	0f af 85 44 ff ff ff 	imul   -0xbc(%rbp),%eax
 8cd:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%rbp)
 8d3:	83 85 20 ff ff ff 01 	addl   $0x1,-0xe0(%rbp)
 8da:	81 bd 20 ff ff ff ff 	cmpl   $0x3b9ac9ff,-0xe0(%rbp)
 8e1:	c9 9a 3b 
 8e4:	7e da                	jle    8c0 <main+0x13f>
 8e6:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
 8ea:	be 00 00 00 00       	mov    $0x0,%esi
 8ef:	48 89 c7             	mov    %rax,%rdi
 8f2:	e8 d9 fc ff ff       	callq  5d0 <gettimeofday@plt>
 8f7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 8fb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 8ff:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
 903:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
 907:	48 89 d1             	mov    %rdx,%rcx
 90a:	48 89 c2             	mov    %rax,%rdx
 90d:	e8 e8 fd ff ff       	callq  6fa <time_diff>
 912:	66 48 0f 7e c0       	movq   %xmm0,%rax
 917:	48 89 85 70 ff ff ff 	mov    %rax,-0x90(%rbp)
 91e:	f2 0f 10 85 70 ff ff 	movsd  -0x90(%rbp),%xmm0
 925:	ff 
 926:	f2 0f 10 0d 4a 05 00 	movsd  0x54a(%rip),%xmm1        # e78 <_IO_stdin_used+0x178>
 92d:	00 
 92e:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
 932:	f2 0f 11 85 78 ff ff 	movsd  %xmm0,-0x88(%rbp)
 939:	ff 
 93a:	f2 0f 10 85 70 ff ff 	movsd  -0x90(%rbp),%xmm0
 941:	ff 
 942:	f2 0f 10 0d 26 05 00 	movsd  0x526(%rip),%xmm1        # e70 <_IO_stdin_used+0x170>
 949:	00 
 94a:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
 94e:	f2 0f 10 8d 78 ff ff 	movsd  -0x88(%rbp),%xmm1
 955:	ff 
 956:	8b 95 1c ff ff ff    	mov    -0xe4(%rbp),%edx
 95c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
 962:	89 c6                	mov    %eax,%esi
 964:	48 8d 3d e5 03 00 00 	lea    0x3e5(%rip),%rdi        # d50 <_IO_stdin_used+0x50>
 96b:	b8 02 00 00 00       	mov    $0x2,%eax
 970:	e8 4b fc ff ff       	callq  5c0 <printf@plt>
 975:	c7 85 48 ff ff ff 11 	movl   $0x11,-0xb8(%rbp)
 97c:	00 00 00 
 97f:	c7 85 4c ff ff ff 0d 	movl   $0xd,-0xb4(%rbp)
 986:	00 00 00 
 989:	c7 85 24 ff ff ff 00 	movl   $0x0,-0xdc(%rbp)
 990:	00 00 00 
 993:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
 997:	be 00 00 00 00       	mov    $0x0,%esi
 99c:	48 89 c7             	mov    %rax,%rdi
 99f:	e8 2c fc ff ff       	callq  5d0 <gettimeofday@plt>
 9a4:	c7 85 28 ff ff ff 00 	movl   $0x0,-0xd8(%rbp)
 9ab:	00 00 00 
 9ae:	eb 1a                	jmp    9ca <main+0x249>
 9b0:	8b 85 48 ff ff ff    	mov    -0xb8(%rbp),%eax
 9b6:	99                   	cltd   
 9b7:	f7 bd 4c ff ff ff    	idivl  -0xb4(%rbp)
 9bd:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%rbp)
 9c3:	83 85 28 ff ff ff 01 	addl   $0x1,-0xd8(%rbp)
 9ca:	81 bd 28 ff ff ff ff 	cmpl   $0x3b9ac9ff,-0xd8(%rbp)
 9d1:	c9 9a 3b 
 9d4:	7e da                	jle    9b0 <main+0x22f>
 9d6:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
 9da:	be 00 00 00 00       	mov    $0x0,%esi
 9df:	48 89 c7             	mov    %rax,%rdi
 9e2:	e8 e9 fb ff ff       	callq  5d0 <gettimeofday@plt>
 9e7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 9eb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 9ef:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
 9f3:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
 9f7:	48 89 d1             	mov    %rdx,%rcx
 9fa:	48 89 c2             	mov    %rax,%rdx
 9fd:	e8 f8 fc ff ff       	callq  6fa <time_diff>
 a02:	66 48 0f 7e c0       	movq   %xmm0,%rax
 a07:	48 89 45 80          	mov    %rax,-0x80(%rbp)
 a0b:	f2 0f 10 45 80       	movsd  -0x80(%rbp),%xmm0
 a10:	f2 0f 10 0d 60 04 00 	movsd  0x460(%rip),%xmm1        # e78 <_IO_stdin_used+0x178>
 a17:	00 
 a18:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
 a1c:	f2 0f 11 45 88       	movsd  %xmm0,-0x78(%rbp)
 a21:	f2 0f 10 45 80       	movsd  -0x80(%rbp),%xmm0
 a26:	f2 0f 10 0d 42 04 00 	movsd  0x442(%rip),%xmm1        # e70 <_IO_stdin_used+0x170>
 a2d:	00 
 a2e:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
 a32:	f2 0f 10 4d 88       	movsd  -0x78(%rbp),%xmm1
 a37:	8b 95 24 ff ff ff    	mov    -0xdc(%rbp),%edx
 a3d:	8b 85 28 ff ff ff    	mov    -0xd8(%rbp),%eax
 a43:	89 c6                	mov    %eax,%esi
 a45:	48 8d 3d 4c 03 00 00 	lea    0x34c(%rip),%rdi        # d98 <_IO_stdin_used+0x98>
 a4c:	b8 02 00 00 00       	mov    $0x2,%eax
 a51:	e8 6a fb ff ff       	callq  5c0 <printf@plt>
 a56:	f2 0f 10 05 22 04 00 	movsd  0x422(%rip),%xmm0        # e80 <_IO_stdin_used+0x180>
 a5d:	00 
 a5e:	f2 0f 11 45 90       	movsd  %xmm0,-0x70(%rbp)
 a63:	f2 0f 10 05 1d 04 00 	movsd  0x41d(%rip),%xmm0        # e88 <_IO_stdin_used+0x188>
 a6a:	00 
 a6b:	f2 0f 11 45 98       	movsd  %xmm0,-0x68(%rbp)
 a70:	66 0f ef c0          	pxor   %xmm0,%xmm0
 a74:	f2 0f 11 85 50 ff ff 	movsd  %xmm0,-0xb0(%rbp)
 a7b:	ff 
 a7c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
 a80:	be 00 00 00 00       	mov    $0x0,%esi
 a85:	48 89 c7             	mov    %rax,%rdi
 a88:	e8 43 fb ff ff       	callq  5d0 <gettimeofday@plt>
 a8d:	c7 85 2c ff ff ff 00 	movl   $0x0,-0xd4(%rbp)
 a94:	00 00 00 
 a97:	eb 19                	jmp    ab2 <main+0x331>
 a99:	f2 0f 10 45 90       	movsd  -0x70(%rbp),%xmm0
 a9e:	f2 0f 59 45 98       	mulsd  -0x68(%rbp),%xmm0
 aa3:	f2 0f 11 85 50 ff ff 	movsd  %xmm0,-0xb0(%rbp)
 aaa:	ff 
 aab:	83 85 2c ff ff ff 01 	addl   $0x1,-0xd4(%rbp)
 ab2:	81 bd 2c ff ff ff ff 	cmpl   $0x3b9ac9ff,-0xd4(%rbp)
 ab9:	c9 9a 3b 
 abc:	7e db                	jle    a99 <main+0x318>
 abe:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
 ac2:	be 00 00 00 00       	mov    $0x0,%esi
 ac7:	48 89 c7             	mov    %rax,%rdi
 aca:	e8 01 fb ff ff       	callq  5d0 <gettimeofday@plt>
 acf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 ad3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 ad7:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
 adb:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
 adf:	48 89 d1             	mov    %rdx,%rcx
 ae2:	48 89 c2             	mov    %rax,%rdx
 ae5:	e8 10 fc ff ff       	callq  6fa <time_diff>
 aea:	66 48 0f 7e c0       	movq   %xmm0,%rax
 aef:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
 af3:	f2 0f 10 45 a0       	movsd  -0x60(%rbp),%xmm0
 af8:	f2 0f 10 0d 78 03 00 	movsd  0x378(%rip),%xmm1        # e78 <_IO_stdin_used+0x178>
 aff:	00 
 b00:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
 b04:	f2 0f 11 45 a8       	movsd  %xmm0,-0x58(%rbp)
 b09:	f2 0f 10 45 a0       	movsd  -0x60(%rbp),%xmm0
 b0e:	f2 0f 10 0d 5a 03 00 	movsd  0x35a(%rip),%xmm1        # e70 <_IO_stdin_used+0x170>
 b15:	00 
 b16:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
 b1a:	f2 0f 10 4d a8       	movsd  -0x58(%rbp),%xmm1
 b1f:	48 8b 95 50 ff ff ff 	mov    -0xb0(%rbp),%rdx
 b26:	8b 85 2c ff ff ff    	mov    -0xd4(%rbp),%eax
 b2c:	66 0f 28 d1          	movapd %xmm1,%xmm2
 b30:	66 0f 28 c8          	movapd %xmm0,%xmm1
 b34:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
 b3b:	f2 0f 10 85 f8 fe ff 	movsd  -0x108(%rbp),%xmm0
 b42:	ff 
 b43:	89 c6                	mov    %eax,%esi
 b45:	48 8d 3d 94 02 00 00 	lea    0x294(%rip),%rdi        # de0 <_IO_stdin_used+0xe0>
 b4c:	b8 03 00 00 00       	mov    $0x3,%eax
 b51:	e8 6a fa ff ff       	callq  5c0 <printf@plt>
 b56:	f2 0f 10 05 22 03 00 	movsd  0x322(%rip),%xmm0        # e80 <_IO_stdin_used+0x180>
 b5d:	00 
 b5e:	f2 0f 11 45 b0       	movsd  %xmm0,-0x50(%rbp)
 b63:	f2 0f 10 05 1d 03 00 	movsd  0x31d(%rip),%xmm0        # e88 <_IO_stdin_used+0x188>
 b6a:	00 
 b6b:	f2 0f 11 45 b8       	movsd  %xmm0,-0x48(%rbp)
 b70:	66 0f ef c0          	pxor   %xmm0,%xmm0
 b74:	f2 0f 11 85 58 ff ff 	movsd  %xmm0,-0xa8(%rbp)
 b7b:	ff 
 b7c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
 b80:	be 00 00 00 00       	mov    $0x0,%esi
 b85:	48 89 c7             	mov    %rax,%rdi
 b88:	e8 43 fa ff ff       	callq  5d0 <gettimeofday@plt>
 b8d:	c7 85 30 ff ff ff 00 	movl   $0x0,-0xd0(%rbp)
 b94:	00 00 00 
 b97:	eb 19                	jmp    bb2 <main+0x431>
 b99:	f2 0f 10 45 b0       	movsd  -0x50(%rbp),%xmm0
 b9e:	f2 0f 5e 45 b8       	divsd  -0x48(%rbp),%xmm0
 ba3:	f2 0f 11 85 58 ff ff 	movsd  %xmm0,-0xa8(%rbp)
 baa:	ff 
 bab:	83 85 30 ff ff ff 01 	addl   $0x1,-0xd0(%rbp)
 bb2:	81 bd 30 ff ff ff ff 	cmpl   $0x3b9ac9ff,-0xd0(%rbp)
 bb9:	c9 9a 3b 
 bbc:	7e db                	jle    b99 <main+0x418>
 bbe:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
 bc2:	be 00 00 00 00       	mov    $0x0,%esi
 bc7:	48 89 c7             	mov    %rax,%rdi
 bca:	e8 01 fa ff ff       	callq  5d0 <gettimeofday@plt>
 bcf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 bd3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
 bd7:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
 bdb:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
 bdf:	48 89 d1             	mov    %rdx,%rcx
 be2:	48 89 c2             	mov    %rax,%rdx
 be5:	e8 10 fb ff ff       	callq  6fa <time_diff>
 bea:	66 48 0f 7e c0       	movq   %xmm0,%rax
 bef:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
 bf3:	f2 0f 10 45 c0       	movsd  -0x40(%rbp),%xmm0
 bf8:	f2 0f 10 0d 78 02 00 	movsd  0x278(%rip),%xmm1        # e78 <_IO_stdin_used+0x178>
 bff:	00 
 c00:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
 c04:	f2 0f 11 45 c8       	movsd  %xmm0,-0x38(%rbp)
 c09:	f2 0f 10 45 c0       	movsd  -0x40(%rbp),%xmm0
 c0e:	f2 0f 10 0d 5a 02 00 	movsd  0x25a(%rip),%xmm1        # e70 <_IO_stdin_used+0x170>
 c15:	00 
 c16:	f2 0f 5e c1          	divsd  %xmm1,%xmm0
 c1a:	f2 0f 10 4d c8       	movsd  -0x38(%rbp),%xmm1
 c1f:	48 8b 95 58 ff ff ff 	mov    -0xa8(%rbp),%rdx
 c26:	8b 85 30 ff ff ff    	mov    -0xd0(%rbp),%eax
 c2c:	66 0f 28 d1          	movapd %xmm1,%xmm2
 c30:	66 0f 28 c8          	movapd %xmm0,%xmm1
 c34:	48 89 95 f8 fe ff ff 	mov    %rdx,-0x108(%rbp)
 c3b:	f2 0f 10 85 f8 fe ff 	movsd  -0x108(%rbp),%xmm0
 c42:	ff 
 c43:	89 c6                	mov    %eax,%esi
 c45:	48 8d 3d dc 01 00 00 	lea    0x1dc(%rip),%rdi        # e28 <_IO_stdin_used+0x128>
 c4c:	b8 03 00 00 00       	mov    $0x3,%eax
 c51:	e8 6a f9 ff ff       	callq  5c0 <printf@plt>
 c56:	b8 00 00 00 00       	mov    $0x0,%eax
 c5b:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
 c5f:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
 c66:	00 00 
 c68:	74 05                	je     c6f <main+0x4ee>
 c6a:	e8 41 f9 ff ff       	callq  5b0 <__stack_chk_fail@plt>
 c6f:	c9                   	leaveq 
 c70:	c3                   	retq   
 c71:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 c78:	00 00 00 
 c7b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000c80 <__libc_csu_init>:
 c80:	41 57                	push   %r15
 c82:	41 56                	push   %r14
 c84:	49 89 d7             	mov    %rdx,%r15
 c87:	41 55                	push   %r13
 c89:	41 54                	push   %r12
 c8b:	4c 8d 25 16 11 20 00 	lea    0x201116(%rip),%r12        # 201da8 <__frame_dummy_init_array_entry>
 c92:	55                   	push   %rbp
 c93:	48 8d 2d 16 11 20 00 	lea    0x201116(%rip),%rbp        # 201db0 <__init_array_end>
 c9a:	53                   	push   %rbx
 c9b:	41 89 fd             	mov    %edi,%r13d
 c9e:	49 89 f6             	mov    %rsi,%r14
 ca1:	4c 29 e5             	sub    %r12,%rbp
 ca4:	48 83 ec 08          	sub    $0x8,%rsp
 ca8:	48 c1 fd 03          	sar    $0x3,%rbp
 cac:	e8 d7 f8 ff ff       	callq  588 <_init>
 cb1:	48 85 ed             	test   %rbp,%rbp
 cb4:	74 20                	je     cd6 <__libc_csu_init+0x56>
 cb6:	31 db                	xor    %ebx,%ebx
 cb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 cbf:	00 
 cc0:	4c 89 fa             	mov    %r15,%rdx
 cc3:	4c 89 f6             	mov    %r14,%rsi
 cc6:	44 89 ef             	mov    %r13d,%edi
 cc9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 ccd:	48 83 c3 01          	add    $0x1,%rbx
 cd1:	48 39 dd             	cmp    %rbx,%rbp
 cd4:	75 ea                	jne    cc0 <__libc_csu_init+0x40>
 cd6:	48 83 c4 08          	add    $0x8,%rsp
 cda:	5b                   	pop    %rbx
 cdb:	5d                   	pop    %rbp
 cdc:	41 5c                	pop    %r12
 cde:	41 5d                	pop    %r13
 ce0:	41 5e                	pop    %r14
 ce2:	41 5f                	pop    %r15
 ce4:	c3                   	retq   
 ce5:	90                   	nop
 ce6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 ced:	00 00 00 

0000000000000cf0 <__libc_csu_fini>:
 cf0:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000000cf4 <_fini>:
 cf4:	48 83 ec 08          	sub    $0x8,%rsp
 cf8:	48 83 c4 08          	add    $0x8,%rsp
 cfc:	c3                   	retq   
