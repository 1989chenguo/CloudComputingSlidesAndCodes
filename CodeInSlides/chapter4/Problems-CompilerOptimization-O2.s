
Problems-OoO:     file format elf64-x86-64


Disassembly of section .init:

0000000000000630 <_init>:
 630:	48 83 ec 08          	sub    $0x8,%rsp
 634:	48 8b 05 ad 09 20 00 	mov    0x2009ad(%rip),%rax        # 200fe8 <__gmon_start__>
 63b:	48 85 c0             	test   %rax,%rax
 63e:	74 02                	je     642 <_init+0x12>
 640:	ff d0                	callq  *%rax
 642:	48 83 c4 08          	add    $0x8,%rsp
 646:	c3                   	retq   

Disassembly of section .plt:

0000000000000650 <.plt>:
 650:	ff 35 4a 09 20 00    	pushq  0x20094a(%rip)        # 200fa0 <_GLOBAL_OFFSET_TABLE_+0x8>
 656:	ff 25 4c 09 20 00    	jmpq   *0x20094c(%rip)        # 200fa8 <_GLOBAL_OFFSET_TABLE_+0x10>
 65c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000660 <pthread_create@plt>:
 660:	ff 25 4a 09 20 00    	jmpq   *0x20094a(%rip)        # 200fb0 <pthread_create@GLIBC_2.2.5>
 666:	68 00 00 00 00       	pushq  $0x0
 66b:	e9 e0 ff ff ff       	jmpq   650 <.plt>

0000000000000670 <__printf_chk@plt>:
 670:	ff 25 42 09 20 00    	jmpq   *0x200942(%rip)        # 200fb8 <__printf_chk@GLIBC_2.3.4>
 676:	68 01 00 00 00       	pushq  $0x1
 67b:	e9 d0 ff ff ff       	jmpq   650 <.plt>

0000000000000680 <perror@plt>:
 680:	ff 25 3a 09 20 00    	jmpq   *0x20093a(%rip)        # 200fc0 <perror@GLIBC_2.2.5>
 686:	68 02 00 00 00       	pushq  $0x2
 68b:	e9 c0 ff ff ff       	jmpq   650 <.plt>

0000000000000690 <pthread_join@plt>:
 690:	ff 25 32 09 20 00    	jmpq   *0x200932(%rip)        # 200fc8 <pthread_join@GLIBC_2.2.5>
 696:	68 03 00 00 00       	pushq  $0x3
 69b:	e9 b0 ff ff ff       	jmpq   650 <.plt>

00000000000006a0 <exit@plt>:
 6a0:	ff 25 2a 09 20 00    	jmpq   *0x20092a(%rip)        # 200fd0 <exit@GLIBC_2.2.5>
 6a6:	68 04 00 00 00       	pushq  $0x4
 6ab:	e9 a0 ff ff ff       	jmpq   650 <.plt>

Disassembly of section .plt.got:

00000000000006b0 <__cxa_finalize@plt>:
 6b0:	ff 25 42 09 20 00    	jmpq   *0x200942(%rip)        # 200ff8 <__cxa_finalize@GLIBC_2.2.5>
 6b6:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

00000000000006c0 <main>:
 6c0:	53                   	push   %rbx
 6c1:	48 8d 15 a8 01 00 00 	lea    0x1a8(%rip),%rdx        # 870 <do_sum>
 6c8:	31 c9                	xor    %ecx,%ecx
 6ca:	31 f6                	xor    %esi,%esi
 6cc:	48 83 ec 20          	sub    $0x20,%rsp
 6d0:	48 89 e3             	mov    %rsp,%rbx
 6d3:	48 89 df             	mov    %rbx,%rdi
 6d6:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
 6dd:	00 00 
 6df:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
 6e4:	31 c0                	xor    %eax,%eax
 6e6:	e8 75 ff ff ff       	callq  660 <pthread_create@plt>
 6eb:	85 c0                	test   %eax,%eax
 6ed:	75 50                	jne    73f <main+0x7f>
 6ef:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
 6f3:	48 8d 15 76 01 00 00 	lea    0x176(%rip),%rdx        # 870 <do_sum>
 6fa:	31 c9                	xor    %ecx,%ecx
 6fc:	31 f6                	xor    %esi,%esi
 6fe:	e8 5d ff ff ff       	callq  660 <pthread_create@plt>
 703:	85 c0                	test   %eax,%eax
 705:	75 38                	jne    73f <main+0x7f>
 707:	48 8b 3c 24          	mov    (%rsp),%rdi
 70b:	31 f6                	xor    %esi,%esi
 70d:	e8 7e ff ff ff       	callq  690 <pthread_join@plt>
 712:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
 717:	31 f6                	xor    %esi,%esi
 719:	e8 72 ff ff ff       	callq  690 <pthread_join@plt>
 71e:	48 8b 15 f3 08 20 00 	mov    0x2008f3(%rip),%rdx        # 201018 <sum>
 725:	48 8d 35 d8 01 00 00 	lea    0x1d8(%rip),%rsi        # 904 <_IO_stdin_used+0x4>
 72c:	bf 01 00 00 00       	mov    $0x1,%edi
 731:	31 c0                	xor    %eax,%eax
 733:	e8 38 ff ff ff       	callq  670 <__printf_chk@plt>
 738:	31 ff                	xor    %edi,%edi
 73a:	e8 61 ff ff ff       	callq  6a0 <exit@plt>
 73f:	48 8d 3d c9 01 00 00 	lea    0x1c9(%rip),%rdi        # 90f <_IO_stdin_used+0xf>
 746:	e8 35 ff ff ff       	callq  680 <perror@plt>
 74b:	bf 01 00 00 00       	mov    $0x1,%edi
 750:	e8 4b ff ff ff       	callq  6a0 <exit@plt>
 755:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 75c:	00 00 00 
 75f:	90                   	nop

0000000000000760 <_start>:
 760:	31 ed                	xor    %ebp,%ebp
 762:	49 89 d1             	mov    %rdx,%r9
 765:	5e                   	pop    %rsi
 766:	48 89 e2             	mov    %rsp,%rdx
 769:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
 76d:	50                   	push   %rax
 76e:	54                   	push   %rsp
 76f:	4c 8d 05 7a 01 00 00 	lea    0x17a(%rip),%r8        # 8f0 <__libc_csu_fini>
 776:	48 8d 0d 03 01 00 00 	lea    0x103(%rip),%rcx        # 880 <__libc_csu_init>
 77d:	48 8d 3d 3c ff ff ff 	lea    -0xc4(%rip),%rdi        # 6c0 <main>
 784:	ff 15 56 08 20 00    	callq  *0x200856(%rip)        # 200fe0 <__libc_start_main@GLIBC_2.2.5>
 78a:	f4                   	hlt    
 78b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000790 <deregister_tm_clones>:
 790:	48 8d 3d 79 08 20 00 	lea    0x200879(%rip),%rdi        # 201010 <__TMC_END__>
 797:	55                   	push   %rbp
 798:	48 8d 05 71 08 20 00 	lea    0x200871(%rip),%rax        # 201010 <__TMC_END__>
 79f:	48 39 f8             	cmp    %rdi,%rax
 7a2:	48 89 e5             	mov    %rsp,%rbp
 7a5:	74 19                	je     7c0 <deregister_tm_clones+0x30>
 7a7:	48 8b 05 2a 08 20 00 	mov    0x20082a(%rip),%rax        # 200fd8 <_ITM_deregisterTMCloneTable>
 7ae:	48 85 c0             	test   %rax,%rax
 7b1:	74 0d                	je     7c0 <deregister_tm_clones+0x30>
 7b3:	5d                   	pop    %rbp
 7b4:	ff e0                	jmpq   *%rax
 7b6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 7bd:	00 00 00 
 7c0:	5d                   	pop    %rbp
 7c1:	c3                   	retq   
 7c2:	0f 1f 40 00          	nopl   0x0(%rax)
 7c6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 7cd:	00 00 00 

00000000000007d0 <register_tm_clones>:
 7d0:	48 8d 3d 39 08 20 00 	lea    0x200839(%rip),%rdi        # 201010 <__TMC_END__>
 7d7:	48 8d 35 32 08 20 00 	lea    0x200832(%rip),%rsi        # 201010 <__TMC_END__>
 7de:	55                   	push   %rbp
 7df:	48 29 fe             	sub    %rdi,%rsi
 7e2:	48 89 e5             	mov    %rsp,%rbp
 7e5:	48 c1 fe 03          	sar    $0x3,%rsi
 7e9:	48 89 f0             	mov    %rsi,%rax
 7ec:	48 c1 e8 3f          	shr    $0x3f,%rax
 7f0:	48 01 c6             	add    %rax,%rsi
 7f3:	48 d1 fe             	sar    %rsi
 7f6:	74 18                	je     810 <register_tm_clones+0x40>
 7f8:	48 8b 05 f1 07 20 00 	mov    0x2007f1(%rip),%rax        # 200ff0 <_ITM_registerTMCloneTable>
 7ff:	48 85 c0             	test   %rax,%rax
 802:	74 0c                	je     810 <register_tm_clones+0x40>
 804:	5d                   	pop    %rbp
 805:	ff e0                	jmpq   *%rax
 807:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 80e:	00 00 
 810:	5d                   	pop    %rbp
 811:	c3                   	retq   
 812:	0f 1f 40 00          	nopl   0x0(%rax)
 816:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 81d:	00 00 00 

0000000000000820 <__do_global_dtors_aux>:
 820:	80 3d e9 07 20 00 00 	cmpb   $0x0,0x2007e9(%rip)        # 201010 <__TMC_END__>
 827:	75 2f                	jne    858 <__do_global_dtors_aux+0x38>
 829:	48 83 3d c7 07 20 00 	cmpq   $0x0,0x2007c7(%rip)        # 200ff8 <__cxa_finalize@GLIBC_2.2.5>
 830:	00 
 831:	55                   	push   %rbp
 832:	48 89 e5             	mov    %rsp,%rbp
 835:	74 0c                	je     843 <__do_global_dtors_aux+0x23>
 837:	48 8b 3d ca 07 20 00 	mov    0x2007ca(%rip),%rdi        # 201008 <__dso_handle>
 83e:	e8 6d fe ff ff       	callq  6b0 <__cxa_finalize@plt>
 843:	e8 48 ff ff ff       	callq  790 <deregister_tm_clones>
 848:	c6 05 c1 07 20 00 01 	movb   $0x1,0x2007c1(%rip)        # 201010 <__TMC_END__>
 84f:	5d                   	pop    %rbp
 850:	c3                   	retq   
 851:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 858:	f3 c3                	repz retq 
 85a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000860 <frame_dummy>:
 860:	55                   	push   %rbp
 861:	48 89 e5             	mov    %rsp,%rbp
 864:	5d                   	pop    %rbp
 865:	e9 66 ff ff ff       	jmpq   7d0 <register_tm_clones>
 86a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000870 <do_sum>:
 870:	48 81 05 9d 07 20 00 	addq   $0x5f5e100,0x20079d(%rip)        # 201018 <sum>
 877:	00 e1 f5 05 
 87b:	c3                   	retq   
 87c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000880 <__libc_csu_init>:
 880:	41 57                	push   %r15
 882:	41 56                	push   %r14
 884:	49 89 d7             	mov    %rdx,%r15
 887:	41 55                	push   %r13
 889:	41 54                	push   %r12
 88b:	4c 8d 25 f6 04 20 00 	lea    0x2004f6(%rip),%r12        # 200d88 <__frame_dummy_init_array_entry>
 892:	55                   	push   %rbp
 893:	48 8d 2d f6 04 20 00 	lea    0x2004f6(%rip),%rbp        # 200d90 <__init_array_end>
 89a:	53                   	push   %rbx
 89b:	41 89 fd             	mov    %edi,%r13d
 89e:	49 89 f6             	mov    %rsi,%r14
 8a1:	4c 29 e5             	sub    %r12,%rbp
 8a4:	48 83 ec 08          	sub    $0x8,%rsp
 8a8:	48 c1 fd 03          	sar    $0x3,%rbp
 8ac:	e8 7f fd ff ff       	callq  630 <_init>
 8b1:	48 85 ed             	test   %rbp,%rbp
 8b4:	74 20                	je     8d6 <__libc_csu_init+0x56>
 8b6:	31 db                	xor    %ebx,%ebx
 8b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 8bf:	00 
 8c0:	4c 89 fa             	mov    %r15,%rdx
 8c3:	4c 89 f6             	mov    %r14,%rsi
 8c6:	44 89 ef             	mov    %r13d,%edi
 8c9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 8cd:	48 83 c3 01          	add    $0x1,%rbx
 8d1:	48 39 dd             	cmp    %rbx,%rbp
 8d4:	75 ea                	jne    8c0 <__libc_csu_init+0x40>
 8d6:	48 83 c4 08          	add    $0x8,%rsp
 8da:	5b                   	pop    %rbx
 8db:	5d                   	pop    %rbp
 8dc:	41 5c                	pop    %r12
 8de:	41 5d                	pop    %r13
 8e0:	41 5e                	pop    %r14
 8e2:	41 5f                	pop    %r15
 8e4:	c3                   	retq   
 8e5:	90                   	nop
 8e6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 8ed:	00 00 00 

00000000000008f0 <__libc_csu_fini>:
 8f0:	f3 c3                	repz retq 

Disassembly of section .fini:

00000000000008f4 <_fini>:
 8f4:	48 83 ec 08          	sub    $0x8,%rsp
 8f8:	48 83 c4 08          	add    $0x8,%rsp
 8fc:	c3                   	retq   
