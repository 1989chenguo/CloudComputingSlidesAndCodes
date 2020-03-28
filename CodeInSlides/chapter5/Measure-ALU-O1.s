
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

0000000000000610 <_start>:
 610:	31 ed                	xor    %ebp,%ebp
 612:	49 89 d1             	mov    %rdx,%r9
 615:	5e                   	pop    %rsi
 616:	48 89 e2             	mov    %rsp,%rdx
 619:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
 61d:	50                   	push   %rax
 61e:	54                   	push   %rsp
 61f:	4c 8d 05 9a 04 00 00 	lea    0x49a(%rip),%r8        # ac0 <__libc_csu_fini>
 626:	48 8d 0d 23 04 00 00 	lea    0x423(%rip),%rcx        # a50 <__libc_csu_init>
 62d:	48 8d 3d 27 01 00 00 	lea    0x127(%rip),%rdi        # 75b <main>
 634:	ff 15 a6 19 20 00    	callq  *0x2019a6(%rip)        # 201fe0 <__libc_start_main@GLIBC_2.2.5>
 63a:	f4                   	hlt    
 63b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000640 <deregister_tm_clones>:
 640:	48 8d 3d c9 19 20 00 	lea    0x2019c9(%rip),%rdi        # 202010 <__TMC_END__>
 647:	55                   	push   %rbp
 648:	48 8d 05 c1 19 20 00 	lea    0x2019c1(%rip),%rax        # 202010 <__TMC_END__>
 64f:	48 39 f8             	cmp    %rdi,%rax
 652:	48 89 e5             	mov    %rsp,%rbp
 655:	74 19                	je     670 <deregister_tm_clones+0x30>
 657:	48 8b 05 7a 19 20 00 	mov    0x20197a(%rip),%rax        # 201fd8 <_ITM_deregisterTMCloneTable>
 65e:	48 85 c0             	test   %rax,%rax
 661:	74 0d                	je     670 <deregister_tm_clones+0x30>
 663:	5d                   	pop    %rbp
 664:	ff e0                	jmpq   *%rax
 666:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 66d:	00 00 00 
 670:	5d                   	pop    %rbp
 671:	c3                   	retq   
 672:	0f 1f 40 00          	nopl   0x0(%rax)
 676:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 67d:	00 00 00 

0000000000000680 <register_tm_clones>:
 680:	48 8d 3d 89 19 20 00 	lea    0x201989(%rip),%rdi        # 202010 <__TMC_END__>
 687:	48 8d 35 82 19 20 00 	lea    0x201982(%rip),%rsi        # 202010 <__TMC_END__>
 68e:	55                   	push   %rbp
 68f:	48 29 fe             	sub    %rdi,%rsi
 692:	48 89 e5             	mov    %rsp,%rbp
 695:	48 c1 fe 03          	sar    $0x3,%rsi
 699:	48 89 f0             	mov    %rsi,%rax
 69c:	48 c1 e8 3f          	shr    $0x3f,%rax
 6a0:	48 01 c6             	add    %rax,%rsi
 6a3:	48 d1 fe             	sar    %rsi
 6a6:	74 18                	je     6c0 <register_tm_clones+0x40>
 6a8:	48 8b 05 41 19 20 00 	mov    0x201941(%rip),%rax        # 201ff0 <_ITM_registerTMCloneTable>
 6af:	48 85 c0             	test   %rax,%rax
 6b2:	74 0c                	je     6c0 <register_tm_clones+0x40>
 6b4:	5d                   	pop    %rbp
 6b5:	ff e0                	jmpq   *%rax
 6b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 6be:	00 00 
 6c0:	5d                   	pop    %rbp
 6c1:	c3                   	retq   
 6c2:	0f 1f 40 00          	nopl   0x0(%rax)
 6c6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 6cd:	00 00 00 

00000000000006d0 <__do_global_dtors_aux>:
 6d0:	80 3d 39 19 20 00 00 	cmpb   $0x0,0x201939(%rip)        # 202010 <__TMC_END__>
 6d7:	75 2f                	jne    708 <__do_global_dtors_aux+0x38>
 6d9:	48 83 3d 17 19 20 00 	cmpq   $0x0,0x201917(%rip)        # 201ff8 <__cxa_finalize@GLIBC_2.2.5>
 6e0:	00 
 6e1:	55                   	push   %rbp
 6e2:	48 89 e5             	mov    %rsp,%rbp
 6e5:	74 0c                	je     6f3 <__do_global_dtors_aux+0x23>
 6e7:	48 8b 3d 1a 19 20 00 	mov    0x20191a(%rip),%rdi        # 202008 <__dso_handle>
 6ee:	e8 0d ff ff ff       	callq  600 <__cxa_finalize@plt>
 6f3:	e8 48 ff ff ff       	callq  640 <deregister_tm_clones>
 6f8:	c6 05 11 19 20 00 01 	movb   $0x1,0x201911(%rip)        # 202010 <__TMC_END__>
 6ff:	5d                   	pop    %rbp
 700:	c3                   	retq   
 701:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 708:	f3 c3                	repz retq 
 70a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000710 <frame_dummy>:
 710:	55                   	push   %rbp
 711:	48 89 e5             	mov    %rsp,%rbp
 714:	5d                   	pop    %rbp
 715:	e9 66 ff ff ff       	jmpq   680 <register_tm_clones>

000000000000071a <time_diff>:
 71a:	66 0f ef c0          	pxor   %xmm0,%xmm0
 71e:	f2 48 0f 2a c2       	cvtsi2sd %rdx,%xmm0
 723:	f2 0f 10 1d 15 05 00 	movsd  0x515(%rip),%xmm3        # c40 <_IO_stdin_used+0x170>
 72a:	00 
 72b:	f2 0f 59 c3          	mulsd  %xmm3,%xmm0
 72f:	66 0f ef d2          	pxor   %xmm2,%xmm2
 733:	f2 48 0f 2a d1       	cvtsi2sd %rcx,%xmm2
 738:	f2 0f 58 c2          	addsd  %xmm2,%xmm0
 73c:	66 0f ef c9          	pxor   %xmm1,%xmm1
 740:	f2 48 0f 2a cf       	cvtsi2sd %rdi,%xmm1
 745:	f2 0f 59 cb          	mulsd  %xmm3,%xmm1
 749:	66 0f ef d2          	pxor   %xmm2,%xmm2
 74d:	f2 48 0f 2a d6       	cvtsi2sd %rsi,%xmm2
 752:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
 756:	f2 0f 5c c1          	subsd  %xmm1,%xmm0
 75a:	c3                   	retq   

000000000000075b <main>:
 75b:	53                   	push   %rbx
 75c:	48 83 ec 40          	sub    $0x40,%rsp
 760:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
 767:	00 00 
 769:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
 76e:	31 c0                	xor    %eax,%eax
 770:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
 775:	be 00 00 00 00       	mov    $0x0,%esi
 77a:	e8 61 fe ff ff       	callq  5e0 <gettimeofday@plt>
 77f:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 784:	83 e8 01             	sub    $0x1,%eax
 787:	75 fb                	jne    784 <main+0x29>
 789:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
 78e:	be 00 00 00 00       	mov    $0x0,%esi
 793:	e8 48 fe ff ff       	callq  5e0 <gettimeofday@plt>
 798:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
 79d:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
 7a2:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
 7a7:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
 7ac:	e8 69 ff ff ff       	callq  71a <time_diff>
 7b1:	66 0f 28 c8          	movapd %xmm0,%xmm1
 7b5:	f2 0f 5e 05 83 04 00 	divsd  0x483(%rip),%xmm0        # c40 <_IO_stdin_used+0x170>
 7bc:	00 
 7bd:	f2 0f 5e 0d 8b 04 00 	divsd  0x48b(%rip),%xmm1        # c50 <_IO_stdin_used+0x180>
 7c4:	00 
 7c5:	b9 11 00 00 00       	mov    $0x11,%ecx
 7ca:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 7cf:	48 8d 35 02 03 00 00 	lea    0x302(%rip),%rsi        # ad8 <_IO_stdin_used+0x8>
 7d6:	bf 01 00 00 00       	mov    $0x1,%edi
 7db:	b8 02 00 00 00       	mov    $0x2,%eax
 7e0:	e8 0b fe ff ff       	callq  5f0 <__printf_chk@plt>
 7e5:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
 7ea:	be 00 00 00 00       	mov    $0x0,%esi
 7ef:	e8 ec fd ff ff       	callq  5e0 <gettimeofday@plt>
 7f4:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 7f9:	bb 11 00 00 00       	mov    $0x11,%ebx
 7fe:	8d 14 5b             	lea    (%rbx,%rbx,2),%edx
 801:	8d 1c 93             	lea    (%rbx,%rdx,4),%ebx
 804:	83 e8 01             	sub    $0x1,%eax
 807:	75 f5                	jne    7fe <main+0xa3>
 809:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
 80e:	be 00 00 00 00       	mov    $0x0,%esi
 813:	e8 c8 fd ff ff       	callq  5e0 <gettimeofday@plt>
 818:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
 81d:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
 822:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
 827:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
 82c:	e8 e9 fe ff ff       	callq  71a <time_diff>
 831:	66 0f 28 c8          	movapd %xmm0,%xmm1
 835:	f2 0f 5e 05 03 04 00 	divsd  0x403(%rip),%xmm0        # c40 <_IO_stdin_used+0x170>
 83c:	00 
 83d:	f2 0f 5e 0d 0b 04 00 	divsd  0x40b(%rip),%xmm1        # c50 <_IO_stdin_used+0x180>
 844:	00 
 845:	89 d9                	mov    %ebx,%ecx
 847:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 84c:	48 8d 35 cd 02 00 00 	lea    0x2cd(%rip),%rsi        # b20 <_IO_stdin_used+0x50>
 853:	bf 01 00 00 00       	mov    $0x1,%edi
 858:	b8 02 00 00 00       	mov    $0x2,%eax
 85d:	e8 8e fd ff ff       	callq  5f0 <__printf_chk@plt>
 862:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
 867:	be 00 00 00 00       	mov    $0x0,%esi
 86c:	e8 6f fd ff ff       	callq  5e0 <gettimeofday@plt>
 871:	b9 00 ca 9a 3b       	mov    $0x3b9aca00,%ecx
 876:	bb 11 00 00 00       	mov    $0x11,%ebx
 87b:	be 4f ec c4 4e       	mov    $0x4ec4ec4f,%esi
 880:	89 d8                	mov    %ebx,%eax
 882:	f7 ee                	imul   %esi
 884:	c1 fa 02             	sar    $0x2,%edx
 887:	c1 fb 1f             	sar    $0x1f,%ebx
 88a:	29 da                	sub    %ebx,%edx
 88c:	89 d3                	mov    %edx,%ebx
 88e:	83 e9 01             	sub    $0x1,%ecx
 891:	75 ed                	jne    880 <main+0x125>
 893:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
 898:	be 00 00 00 00       	mov    $0x0,%esi
 89d:	e8 3e fd ff ff       	callq  5e0 <gettimeofday@plt>
 8a2:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
 8a7:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
 8ac:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
 8b1:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
 8b6:	e8 5f fe ff ff       	callq  71a <time_diff>
 8bb:	66 0f 28 c8          	movapd %xmm0,%xmm1
 8bf:	f2 0f 5e 05 79 03 00 	divsd  0x379(%rip),%xmm0        # c40 <_IO_stdin_used+0x170>
 8c6:	00 
 8c7:	f2 0f 5e 0d 81 03 00 	divsd  0x381(%rip),%xmm1        # c50 <_IO_stdin_used+0x180>
 8ce:	00 
 8cf:	89 d9                	mov    %ebx,%ecx
 8d1:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 8d6:	48 8d 35 8b 02 00 00 	lea    0x28b(%rip),%rsi        # b68 <_IO_stdin_used+0x98>
 8dd:	bf 01 00 00 00       	mov    $0x1,%edi
 8e2:	b8 02 00 00 00       	mov    $0x2,%eax
 8e7:	e8 04 fd ff ff       	callq  5f0 <__printf_chk@plt>
 8ec:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
 8f1:	be 00 00 00 00       	mov    $0x0,%esi
 8f6:	e8 e5 fc ff ff       	callq  5e0 <gettimeofday@plt>
 8fb:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 900:	f2 0f 10 2d 40 03 00 	movsd  0x340(%rip),%xmm5        # c48 <_IO_stdin_used+0x178>
 907:	00 
 908:	f2 0f 11 6c 24 08    	movsd  %xmm5,0x8(%rsp)
 90e:	f2 0f 10 05 42 03 00 	movsd  0x342(%rip),%xmm0        # c58 <_IO_stdin_used+0x188>
 915:	00 
 916:	f2 0f 10 5c 24 08    	movsd  0x8(%rsp),%xmm3
 91c:	f2 0f 59 d8          	mulsd  %xmm0,%xmm3
 920:	f2 0f 11 5c 24 08    	movsd  %xmm3,0x8(%rsp)
 926:	83 e8 01             	sub    $0x1,%eax
 929:	75 eb                	jne    916 <main+0x1bb>
 92b:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
 930:	be 00 00 00 00       	mov    $0x0,%esi
 935:	e8 a6 fc ff ff       	callq  5e0 <gettimeofday@plt>
 93a:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
 93f:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
 944:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
 949:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
 94e:	e8 c7 fd ff ff       	callq  71a <time_diff>
 953:	66 0f 28 d0          	movapd %xmm0,%xmm2
 957:	f2 0f 5e 15 f1 02 00 	divsd  0x2f1(%rip),%xmm2        # c50 <_IO_stdin_used+0x180>
 95e:	00 
 95f:	66 0f 28 c8          	movapd %xmm0,%xmm1
 963:	f2 0f 5e 0d d5 02 00 	divsd  0x2d5(%rip),%xmm1        # c40 <_IO_stdin_used+0x170>
 96a:	00 
 96b:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
 971:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 976:	48 8d 35 33 02 00 00 	lea    0x233(%rip),%rsi        # bb0 <_IO_stdin_used+0xe0>
 97d:	bf 01 00 00 00       	mov    $0x1,%edi
 982:	b8 03 00 00 00       	mov    $0x3,%eax
 987:	e8 64 fc ff ff       	callq  5f0 <__printf_chk@plt>
 98c:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
 991:	be 00 00 00 00       	mov    $0x0,%esi
 996:	e8 45 fc ff ff       	callq  5e0 <gettimeofday@plt>
 99b:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 9a0:	f2 0f 10 35 a0 02 00 	movsd  0x2a0(%rip),%xmm6        # c48 <_IO_stdin_used+0x178>
 9a7:	00 
 9a8:	f2 0f 11 74 24 08    	movsd  %xmm6,0x8(%rsp)
 9ae:	f2 0f 10 05 a2 02 00 	movsd  0x2a2(%rip),%xmm0        # c58 <_IO_stdin_used+0x188>
 9b5:	00 
 9b6:	f2 0f 10 64 24 08    	movsd  0x8(%rsp),%xmm4
 9bc:	f2 0f 5e e0          	divsd  %xmm0,%xmm4
 9c0:	f2 0f 11 64 24 08    	movsd  %xmm4,0x8(%rsp)
 9c6:	83 e8 01             	sub    $0x1,%eax
 9c9:	75 eb                	jne    9b6 <main+0x25b>
 9cb:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
 9d0:	be 00 00 00 00       	mov    $0x0,%esi
 9d5:	e8 06 fc ff ff       	callq  5e0 <gettimeofday@plt>
 9da:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
 9df:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
 9e4:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
 9e9:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
 9ee:	e8 27 fd ff ff       	callq  71a <time_diff>
 9f3:	66 0f 28 d0          	movapd %xmm0,%xmm2
 9f7:	f2 0f 5e 15 51 02 00 	divsd  0x251(%rip),%xmm2        # c50 <_IO_stdin_used+0x180>
 9fe:	00 
 9ff:	66 0f 28 c8          	movapd %xmm0,%xmm1
 a03:	f2 0f 5e 0d 35 02 00 	divsd  0x235(%rip),%xmm1        # c40 <_IO_stdin_used+0x170>
 a0a:	00 
 a0b:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
 a11:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 a16:	48 8d 35 db 01 00 00 	lea    0x1db(%rip),%rsi        # bf8 <_IO_stdin_used+0x128>
 a1d:	bf 01 00 00 00       	mov    $0x1,%edi
 a22:	b8 03 00 00 00       	mov    $0x3,%eax
 a27:	e8 c4 fb ff ff       	callq  5f0 <__printf_chk@plt>
 a2c:	b8 00 00 00 00       	mov    $0x0,%eax
 a31:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
 a36:	64 48 33 3c 25 28 00 	xor    %fs:0x28,%rdi
 a3d:	00 00 
 a3f:	75 06                	jne    a47 <main+0x2ec>
 a41:	48 83 c4 40          	add    $0x40,%rsp
 a45:	5b                   	pop    %rbx
 a46:	c3                   	retq   
 a47:	e8 84 fb ff ff       	callq  5d0 <__stack_chk_fail@plt>
 a4c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000a50 <__libc_csu_init>:
 a50:	41 57                	push   %r15
 a52:	41 56                	push   %r14
 a54:	49 89 d7             	mov    %rdx,%r15
 a57:	41 55                	push   %r13
 a59:	41 54                	push   %r12
 a5b:	4c 8d 25 46 13 20 00 	lea    0x201346(%rip),%r12        # 201da8 <__frame_dummy_init_array_entry>
 a62:	55                   	push   %rbp
 a63:	48 8d 2d 46 13 20 00 	lea    0x201346(%rip),%rbp        # 201db0 <__init_array_end>
 a6a:	53                   	push   %rbx
 a6b:	41 89 fd             	mov    %edi,%r13d
 a6e:	49 89 f6             	mov    %rsi,%r14
 a71:	4c 29 e5             	sub    %r12,%rbp
 a74:	48 83 ec 08          	sub    $0x8,%rsp
 a78:	48 c1 fd 03          	sar    $0x3,%rbp
 a7c:	e8 27 fb ff ff       	callq  5a8 <_init>
 a81:	48 85 ed             	test   %rbp,%rbp
 a84:	74 20                	je     aa6 <__libc_csu_init+0x56>
 a86:	31 db                	xor    %ebx,%ebx
 a88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 a8f:	00 
 a90:	4c 89 fa             	mov    %r15,%rdx
 a93:	4c 89 f6             	mov    %r14,%rsi
 a96:	44 89 ef             	mov    %r13d,%edi
 a99:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 a9d:	48 83 c3 01          	add    $0x1,%rbx
 aa1:	48 39 dd             	cmp    %rbx,%rbp
 aa4:	75 ea                	jne    a90 <__libc_csu_init+0x40>
 aa6:	48 83 c4 08          	add    $0x8,%rsp
 aaa:	5b                   	pop    %rbx
 aab:	5d                   	pop    %rbp
 aac:	41 5c                	pop    %r12
 aae:	41 5d                	pop    %r13
 ab0:	41 5e                	pop    %r14
 ab2:	41 5f                	pop    %r15
 ab4:	c3                   	retq   
 ab5:	90                   	nop
 ab6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 abd:	00 00 00 

0000000000000ac0 <__libc_csu_fini>:
 ac0:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000000ac4 <_fini>:
 ac4:	48 83 ec 08          	sub    $0x8,%rsp
 ac8:	48 83 c4 08          	add    $0x8,%rsp
 acc:	c3                   	retq   
