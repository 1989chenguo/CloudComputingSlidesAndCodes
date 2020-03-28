
Measure-ALU-broken:     file format elf64-x86-64


Disassembly of section .init:

00000000000005a8 <_init>:
 5a8:	48 83 ec 08          	sub    $0x8,%rsp
 5ac:	48 8b 05 35 0a 20 00 	mov    0x200a35(%rip),%rax        # 200fe8 <__gmon_start__>
 5b3:	48 85 c0             	test   %rax,%rax
 5b6:	74 02                	je     5ba <_init+0x12>
 5b8:	ff d0                	callq  *%rax
 5ba:	48 83 c4 08          	add    $0x8,%rsp
 5be:	c3                   	retq   

Disassembly of section .plt:

00000000000005c0 <.plt>:
 5c0:	ff 35 ea 09 20 00    	pushq  0x2009ea(%rip)        # 200fb0 <_GLOBAL_OFFSET_TABLE_+0x8>
 5c6:	ff 25 ec 09 20 00    	jmpq   *0x2009ec(%rip)        # 200fb8 <_GLOBAL_OFFSET_TABLE_+0x10>
 5cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000005d0 <__stack_chk_fail@plt>:
 5d0:	ff 25 ea 09 20 00    	jmpq   *0x2009ea(%rip)        # 200fc0 <__stack_chk_fail@GLIBC_2.4>
 5d6:	68 00 00 00 00       	pushq  $0x0
 5db:	e9 e0 ff ff ff       	jmpq   5c0 <.plt>

00000000000005e0 <gettimeofday@plt>:
 5e0:	ff 25 e2 09 20 00    	jmpq   *0x2009e2(%rip)        # 200fc8 <gettimeofday@GLIBC_2.2.5>
 5e6:	68 01 00 00 00       	pushq  $0x1
 5eb:	e9 d0 ff ff ff       	jmpq   5c0 <.plt>

00000000000005f0 <__printf_chk@plt>:
 5f0:	ff 25 da 09 20 00    	jmpq   *0x2009da(%rip)        # 200fd0 <__printf_chk@GLIBC_2.3.4>
 5f6:	68 02 00 00 00       	pushq  $0x2
 5fb:	e9 c0 ff ff ff       	jmpq   5c0 <.plt>

Disassembly of section .plt.got:

0000000000000600 <__cxa_finalize@plt>:
 600:	ff 25 f2 09 20 00    	jmpq   *0x2009f2(%rip)        # 200ff8 <__cxa_finalize@GLIBC_2.2.5>
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
 61f:	4c 8d 05 2a 04 00 00 	lea    0x42a(%rip),%r8        # a50 <__libc_csu_fini>
 626:	48 8d 0d b3 03 00 00 	lea    0x3b3(%rip),%rcx        # 9e0 <__libc_csu_init>
 62d:	48 8d 3d 27 01 00 00 	lea    0x127(%rip),%rdi        # 75b <main>
 634:	ff 15 a6 09 20 00    	callq  *0x2009a6(%rip)        # 200fe0 <__libc_start_main@GLIBC_2.2.5>
 63a:	f4                   	hlt    
 63b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000640 <deregister_tm_clones>:
 640:	48 8d 3d c9 09 20 00 	lea    0x2009c9(%rip),%rdi        # 201010 <__TMC_END__>
 647:	55                   	push   %rbp
 648:	48 8d 05 c1 09 20 00 	lea    0x2009c1(%rip),%rax        # 201010 <__TMC_END__>
 64f:	48 39 f8             	cmp    %rdi,%rax
 652:	48 89 e5             	mov    %rsp,%rbp
 655:	74 19                	je     670 <deregister_tm_clones+0x30>
 657:	48 8b 05 7a 09 20 00 	mov    0x20097a(%rip),%rax        # 200fd8 <_ITM_deregisterTMCloneTable>
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
 680:	48 8d 3d 89 09 20 00 	lea    0x200989(%rip),%rdi        # 201010 <__TMC_END__>
 687:	48 8d 35 82 09 20 00 	lea    0x200982(%rip),%rsi        # 201010 <__TMC_END__>
 68e:	55                   	push   %rbp
 68f:	48 29 fe             	sub    %rdi,%rsi
 692:	48 89 e5             	mov    %rsp,%rbp
 695:	48 c1 fe 03          	sar    $0x3,%rsi
 699:	48 89 f0             	mov    %rsi,%rax
 69c:	48 c1 e8 3f          	shr    $0x3f,%rax
 6a0:	48 01 c6             	add    %rax,%rsi
 6a3:	48 d1 fe             	sar    %rsi
 6a6:	74 18                	je     6c0 <register_tm_clones+0x40>
 6a8:	48 8b 05 41 09 20 00 	mov    0x200941(%rip),%rax        # 200ff0 <_ITM_registerTMCloneTable>
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
 6d0:	80 3d 39 09 20 00 00 	cmpb   $0x0,0x200939(%rip)        # 201010 <__TMC_END__>
 6d7:	75 2f                	jne    708 <__do_global_dtors_aux+0x38>
 6d9:	48 83 3d 17 09 20 00 	cmpq   $0x0,0x200917(%rip)        # 200ff8 <__cxa_finalize@GLIBC_2.2.5>
 6e0:	00 
 6e1:	55                   	push   %rbp
 6e2:	48 89 e5             	mov    %rsp,%rbp
 6e5:	74 0c                	je     6f3 <__do_global_dtors_aux+0x23>
 6e7:	48 8b 3d 1a 09 20 00 	mov    0x20091a(%rip),%rdi        # 201008 <__dso_handle>
 6ee:	e8 0d ff ff ff       	callq  600 <__cxa_finalize@plt>
 6f3:	e8 48 ff ff ff       	callq  640 <deregister_tm_clones>
 6f8:	c6 05 11 09 20 00 01 	movb   $0x1,0x200911(%rip)        # 201010 <__TMC_END__>
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
 723:	f2 0f 10 1d a5 04 00 	movsd  0x4a5(%rip),%xmm3        # bd0 <_IO_stdin_used+0x170>
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
 75b:	48 83 ec 38          	sub    $0x38,%rsp
 75f:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
 766:	00 00 
 768:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
 76d:	31 c0                	xor    %eax,%eax
 76f:	48 89 e7             	mov    %rsp,%rdi
 772:	be 00 00 00 00       	mov    $0x0,%esi
 777:	e8 64 fe ff ff       	callq  5e0 <gettimeofday@plt>
 77c:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 781:	83 e8 01             	sub    $0x1,%eax
 784:	75 fb                	jne    781 <main+0x26>
 786:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
 78b:	be 00 00 00 00       	mov    $0x0,%esi
 790:	e8 4b fe ff ff       	callq  5e0 <gettimeofday@plt>
 795:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
 79a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
 79f:	48 8b 3c 24          	mov    (%rsp),%rdi
 7a3:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 7a8:	e8 6d ff ff ff       	callq  71a <time_diff>
 7ad:	66 0f 28 c8          	movapd %xmm0,%xmm1
 7b1:	f2 0f 5e 05 17 04 00 	divsd  0x417(%rip),%xmm0        # bd0 <_IO_stdin_used+0x170>
 7b8:	00 
 7b9:	f2 0f 5e 0d 17 04 00 	divsd  0x417(%rip),%xmm1        # bd8 <_IO_stdin_used+0x178>
 7c0:	00 
 7c1:	b9 11 00 00 00       	mov    $0x11,%ecx
 7c6:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 7cb:	48 8d 35 96 02 00 00 	lea    0x296(%rip),%rsi        # a68 <_IO_stdin_used+0x8>
 7d2:	bf 01 00 00 00       	mov    $0x1,%edi
 7d7:	b8 02 00 00 00       	mov    $0x2,%eax
 7dc:	e8 0f fe ff ff       	callq  5f0 <__printf_chk@plt>
 7e1:	48 89 e7             	mov    %rsp,%rdi
 7e4:	be 00 00 00 00       	mov    $0x0,%esi
 7e9:	e8 f2 fd ff ff       	callq  5e0 <gettimeofday@plt>
 7ee:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 7f3:	83 e8 01             	sub    $0x1,%eax
 7f6:	75 fb                	jne    7f3 <main+0x98>
 7f8:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
 7fd:	be 00 00 00 00       	mov    $0x0,%esi
 802:	e8 d9 fd ff ff       	callq  5e0 <gettimeofday@plt>
 807:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
 80c:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
 811:	48 8b 3c 24          	mov    (%rsp),%rdi
 815:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 81a:	e8 fb fe ff ff       	callq  71a <time_diff>
 81f:	66 0f 28 c8          	movapd %xmm0,%xmm1
 823:	f2 0f 5e 05 a5 03 00 	divsd  0x3a5(%rip),%xmm0        # bd0 <_IO_stdin_used+0x170>
 82a:	00 
 82b:	f2 0f 5e 0d a5 03 00 	divsd  0x3a5(%rip),%xmm1        # bd8 <_IO_stdin_used+0x178>
 832:	00 
 833:	b9 dd 00 00 00       	mov    $0xdd,%ecx
 838:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 83d:	48 8d 35 6c 02 00 00 	lea    0x26c(%rip),%rsi        # ab0 <_IO_stdin_used+0x50>
 844:	bf 01 00 00 00       	mov    $0x1,%edi
 849:	b8 02 00 00 00       	mov    $0x2,%eax
 84e:	e8 9d fd ff ff       	callq  5f0 <__printf_chk@plt>
 853:	48 89 e7             	mov    %rsp,%rdi
 856:	be 00 00 00 00       	mov    $0x0,%esi
 85b:	e8 80 fd ff ff       	callq  5e0 <gettimeofday@plt>
 860:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 865:	83 e8 01             	sub    $0x1,%eax
 868:	75 fb                	jne    865 <main+0x10a>
 86a:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
 86f:	be 00 00 00 00       	mov    $0x0,%esi
 874:	e8 67 fd ff ff       	callq  5e0 <gettimeofday@plt>
 879:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
 87e:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
 883:	48 8b 3c 24          	mov    (%rsp),%rdi
 887:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 88c:	e8 89 fe ff ff       	callq  71a <time_diff>
 891:	66 0f 28 c8          	movapd %xmm0,%xmm1
 895:	f2 0f 5e 05 33 03 00 	divsd  0x333(%rip),%xmm0        # bd0 <_IO_stdin_used+0x170>
 89c:	00 
 89d:	f2 0f 5e 0d 33 03 00 	divsd  0x333(%rip),%xmm1        # bd8 <_IO_stdin_used+0x178>
 8a4:	00 
 8a5:	b9 01 00 00 00       	mov    $0x1,%ecx
 8aa:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 8af:	48 8d 35 42 02 00 00 	lea    0x242(%rip),%rsi        # af8 <_IO_stdin_used+0x98>
 8b6:	bf 01 00 00 00       	mov    $0x1,%edi
 8bb:	b8 02 00 00 00       	mov    $0x2,%eax
 8c0:	e8 2b fd ff ff       	callq  5f0 <__printf_chk@plt>
 8c5:	48 89 e7             	mov    %rsp,%rdi
 8c8:	be 00 00 00 00       	mov    $0x0,%esi
 8cd:	e8 0e fd ff ff       	callq  5e0 <gettimeofday@plt>
 8d2:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 8d7:	83 e8 01             	sub    $0x1,%eax
 8da:	75 fb                	jne    8d7 <main+0x17c>
 8dc:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
 8e1:	be 00 00 00 00       	mov    $0x0,%esi
 8e6:	e8 f5 fc ff ff       	callq  5e0 <gettimeofday@plt>
 8eb:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
 8f0:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
 8f5:	48 8b 3c 24          	mov    (%rsp),%rdi
 8f9:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 8fe:	e8 17 fe ff ff       	callq  71a <time_diff>
 903:	66 0f 28 d0          	movapd %xmm0,%xmm2
 907:	f2 0f 5e 15 c9 02 00 	divsd  0x2c9(%rip),%xmm2        # bd8 <_IO_stdin_used+0x178>
 90e:	00 
 90f:	66 0f 28 c8          	movapd %xmm0,%xmm1
 913:	f2 0f 5e 0d b5 02 00 	divsd  0x2b5(%rip),%xmm1        # bd0 <_IO_stdin_used+0x170>
 91a:	00 
 91b:	f2 0f 10 05 bd 02 00 	movsd  0x2bd(%rip),%xmm0        # be0 <_IO_stdin_used+0x180>
 922:	00 
 923:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 928:	48 8d 35 11 02 00 00 	lea    0x211(%rip),%rsi        # b40 <_IO_stdin_used+0xe0>
 92f:	bf 01 00 00 00       	mov    $0x1,%edi
 934:	b8 03 00 00 00       	mov    $0x3,%eax
 939:	e8 b2 fc ff ff       	callq  5f0 <__printf_chk@plt>
 93e:	48 89 e7             	mov    %rsp,%rdi
 941:	be 00 00 00 00       	mov    $0x0,%esi
 946:	e8 95 fc ff ff       	callq  5e0 <gettimeofday@plt>
 94b:	b8 00 ca 9a 3b       	mov    $0x3b9aca00,%eax
 950:	83 e8 01             	sub    $0x1,%eax
 953:	75 fb                	jne    950 <main+0x1f5>
 955:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
 95a:	be 00 00 00 00       	mov    $0x0,%esi
 95f:	e8 7c fc ff ff       	callq  5e0 <gettimeofday@plt>
 964:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
 969:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
 96e:	48 8b 3c 24          	mov    (%rsp),%rdi
 972:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
 977:	e8 9e fd ff ff       	callq  71a <time_diff>
 97c:	66 0f 28 d0          	movapd %xmm0,%xmm2
 980:	f2 0f 5e 15 50 02 00 	divsd  0x250(%rip),%xmm2        # bd8 <_IO_stdin_used+0x178>
 987:	00 
 988:	66 0f 28 c8          	movapd %xmm0,%xmm1
 98c:	f2 0f 5e 0d 3c 02 00 	divsd  0x23c(%rip),%xmm1        # bd0 <_IO_stdin_used+0x170>
 993:	00 
 994:	f2 0f 10 05 4c 02 00 	movsd  0x24c(%rip),%xmm0        # be8 <_IO_stdin_used+0x188>
 99b:	00 
 99c:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
 9a1:	48 8d 35 e0 01 00 00 	lea    0x1e0(%rip),%rsi        # b88 <_IO_stdin_used+0x128>
 9a8:	bf 01 00 00 00       	mov    $0x1,%edi
 9ad:	b8 03 00 00 00       	mov    $0x3,%eax
 9b2:	e8 39 fc ff ff       	callq  5f0 <__printf_chk@plt>
 9b7:	b8 00 00 00 00       	mov    $0x0,%eax
 9bc:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
 9c1:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
 9c8:	00 00 
 9ca:	75 05                	jne    9d1 <main+0x276>
 9cc:	48 83 c4 38          	add    $0x38,%rsp
 9d0:	c3                   	retq   
 9d1:	e8 fa fb ff ff       	callq  5d0 <__stack_chk_fail@plt>
 9d6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 9dd:	00 00 00 

00000000000009e0 <__libc_csu_init>:
 9e0:	41 57                	push   %r15
 9e2:	41 56                	push   %r14
 9e4:	49 89 d7             	mov    %rdx,%r15
 9e7:	41 55                	push   %r13
 9e9:	41 54                	push   %r12
 9eb:	4c 8d 25 b6 03 20 00 	lea    0x2003b6(%rip),%r12        # 200da8 <__frame_dummy_init_array_entry>
 9f2:	55                   	push   %rbp
 9f3:	48 8d 2d b6 03 20 00 	lea    0x2003b6(%rip),%rbp        # 200db0 <__init_array_end>
 9fa:	53                   	push   %rbx
 9fb:	41 89 fd             	mov    %edi,%r13d
 9fe:	49 89 f6             	mov    %rsi,%r14
 a01:	4c 29 e5             	sub    %r12,%rbp
 a04:	48 83 ec 08          	sub    $0x8,%rsp
 a08:	48 c1 fd 03          	sar    $0x3,%rbp
 a0c:	e8 97 fb ff ff       	callq  5a8 <_init>
 a11:	48 85 ed             	test   %rbp,%rbp
 a14:	74 20                	je     a36 <__libc_csu_init+0x56>
 a16:	31 db                	xor    %ebx,%ebx
 a18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 a1f:	00 
 a20:	4c 89 fa             	mov    %r15,%rdx
 a23:	4c 89 f6             	mov    %r14,%rsi
 a26:	44 89 ef             	mov    %r13d,%edi
 a29:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 a2d:	48 83 c3 01          	add    $0x1,%rbx
 a31:	48 39 dd             	cmp    %rbx,%rbp
 a34:	75 ea                	jne    a20 <__libc_csu_init+0x40>
 a36:	48 83 c4 08          	add    $0x8,%rsp
 a3a:	5b                   	pop    %rbx
 a3b:	5d                   	pop    %rbp
 a3c:	41 5c                	pop    %r12
 a3e:	41 5d                	pop    %r13
 a40:	41 5e                	pop    %r14
 a42:	41 5f                	pop    %r15
 a44:	c3                   	retq   
 a45:	90                   	nop
 a46:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 a4d:	00 00 00 

0000000000000a50 <__libc_csu_fini>:
 a50:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000000a54 <_fini>:
 a54:	48 83 ec 08          	sub    $0x8,%rsp
 a58:	48 83 c4 08          	add    $0x8,%rsp
 a5c:	c3                   	retq   
