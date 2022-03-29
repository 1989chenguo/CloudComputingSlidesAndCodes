
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

00000000000006c0 <_start>:
 6c0:	31 ed                	xor    %ebp,%ebp
 6c2:	49 89 d1             	mov    %rdx,%r9
 6c5:	5e                   	pop    %rsi
 6c6:	48 89 e2             	mov    %rsp,%rdx
 6c9:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
 6cd:	50                   	push   %rax
 6ce:	54                   	push   %rsp
 6cf:	4c 8d 05 3a 02 00 00 	lea    0x23a(%rip),%r8        # 910 <__libc_csu_fini>
 6d6:	48 8d 0d c3 01 00 00 	lea    0x1c3(%rip),%rcx        # 8a0 <__libc_csu_init>
 6dd:	48 8d 3d 06 01 00 00 	lea    0x106(%rip),%rdi        # 7ea <main>
 6e4:	ff 15 f6 08 20 00    	callq  *0x2008f6(%rip)        # 200fe0 <__libc_start_main@GLIBC_2.2.5>
 6ea:	f4                   	hlt    
 6eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000006f0 <deregister_tm_clones>:
 6f0:	48 8d 3d 19 09 20 00 	lea    0x200919(%rip),%rdi        # 201010 <__TMC_END__>
 6f7:	55                   	push   %rbp
 6f8:	48 8d 05 11 09 20 00 	lea    0x200911(%rip),%rax        # 201010 <__TMC_END__>
 6ff:	48 39 f8             	cmp    %rdi,%rax
 702:	48 89 e5             	mov    %rsp,%rbp
 705:	74 19                	je     720 <deregister_tm_clones+0x30>
 707:	48 8b 05 ca 08 20 00 	mov    0x2008ca(%rip),%rax        # 200fd8 <_ITM_deregisterTMCloneTable>
 70e:	48 85 c0             	test   %rax,%rax
 711:	74 0d                	je     720 <deregister_tm_clones+0x30>
 713:	5d                   	pop    %rbp
 714:	ff e0                	jmpq   *%rax
 716:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 71d:	00 00 00 
 720:	5d                   	pop    %rbp
 721:	c3                   	retq   
 722:	0f 1f 40 00          	nopl   0x0(%rax)
 726:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 72d:	00 00 00 

0000000000000730 <register_tm_clones>:
 730:	48 8d 3d d9 08 20 00 	lea    0x2008d9(%rip),%rdi        # 201010 <__TMC_END__>
 737:	48 8d 35 d2 08 20 00 	lea    0x2008d2(%rip),%rsi        # 201010 <__TMC_END__>
 73e:	55                   	push   %rbp
 73f:	48 29 fe             	sub    %rdi,%rsi
 742:	48 89 e5             	mov    %rsp,%rbp
 745:	48 c1 fe 03          	sar    $0x3,%rsi
 749:	48 89 f0             	mov    %rsi,%rax
 74c:	48 c1 e8 3f          	shr    $0x3f,%rax
 750:	48 01 c6             	add    %rax,%rsi
 753:	48 d1 fe             	sar    %rsi
 756:	74 18                	je     770 <register_tm_clones+0x40>
 758:	48 8b 05 91 08 20 00 	mov    0x200891(%rip),%rax        # 200ff0 <_ITM_registerTMCloneTable>
 75f:	48 85 c0             	test   %rax,%rax
 762:	74 0c                	je     770 <register_tm_clones+0x40>
 764:	5d                   	pop    %rbp
 765:	ff e0                	jmpq   *%rax
 767:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 76e:	00 00 
 770:	5d                   	pop    %rbp
 771:	c3                   	retq   
 772:	0f 1f 40 00          	nopl   0x0(%rax)
 776:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 77d:	00 00 00 

0000000000000780 <__do_global_dtors_aux>:
 780:	80 3d 89 08 20 00 00 	cmpb   $0x0,0x200889(%rip)        # 201010 <__TMC_END__>
 787:	75 2f                	jne    7b8 <__do_global_dtors_aux+0x38>
 789:	48 83 3d 67 08 20 00 	cmpq   $0x0,0x200867(%rip)        # 200ff8 <__cxa_finalize@GLIBC_2.2.5>
 790:	00 
 791:	55                   	push   %rbp
 792:	48 89 e5             	mov    %rsp,%rbp
 795:	74 0c                	je     7a3 <__do_global_dtors_aux+0x23>
 797:	48 8b 3d 6a 08 20 00 	mov    0x20086a(%rip),%rdi        # 201008 <__dso_handle>
 79e:	e8 0d ff ff ff       	callq  6b0 <__cxa_finalize@plt>
 7a3:	e8 48 ff ff ff       	callq  6f0 <deregister_tm_clones>
 7a8:	c6 05 61 08 20 00 01 	movb   $0x1,0x200861(%rip)        # 201010 <__TMC_END__>
 7af:	5d                   	pop    %rbp
 7b0:	c3                   	retq   
 7b1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 7b8:	f3 c3                	repz retq 
 7ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000007c0 <frame_dummy>:
 7c0:	55                   	push   %rbp
 7c1:	48 89 e5             	mov    %rsp,%rbp
 7c4:	5d                   	pop    %rbp
 7c5:	e9 66 ff ff ff       	jmpq   730 <register_tm_clones>

00000000000007ca <do_sum>:
 7ca:	48 8b 15 47 08 20 00 	mov    0x200847(%rip),%rdx        # 201018 <sum>
 7d1:	b8 00 e1 f5 05       	mov    $0x5f5e100,%eax
 7d6:	83 e8 01             	sub    $0x1,%eax
 7d9:	75 fb                	jne    7d6 <do_sum+0xc>
 7db:	48 8d 82 00 e1 f5 05 	lea    0x5f5e100(%rdx),%rax
 7e2:	48 89 05 2f 08 20 00 	mov    %rax,0x20082f(%rip)        # 201018 <sum>
 7e9:	c3                   	retq   

00000000000007ea <main>:
 7ea:	48 83 ec 28          	sub    $0x28,%rsp
 7ee:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
 7f5:	00 00 
 7f7:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
 7fc:	31 c0                	xor    %eax,%eax
 7fe:	48 89 e7             	mov    %rsp,%rdi
 801:	b9 00 00 00 00       	mov    $0x0,%ecx
 806:	48 8d 15 bd ff ff ff 	lea    -0x43(%rip),%rdx        # 7ca <do_sum>
 80d:	be 00 00 00 00       	mov    $0x0,%esi
 812:	e8 49 fe ff ff       	callq  660 <pthread_create@plt>
 817:	85 c0                	test   %eax,%eax
 819:	75 63                	jne    87e <main+0x94>
 81b:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
 820:	b9 00 00 00 00       	mov    $0x0,%ecx
 825:	48 8d 15 9e ff ff ff 	lea    -0x62(%rip),%rdx        # 7ca <do_sum>
 82c:	be 00 00 00 00       	mov    $0x0,%esi
 831:	e8 2a fe ff ff       	callq  660 <pthread_create@plt>
 836:	85 c0                	test   %eax,%eax
 838:	75 44                	jne    87e <main+0x94>
 83a:	be 00 00 00 00       	mov    $0x0,%esi
 83f:	48 8b 3c 24          	mov    (%rsp),%rdi
 843:	e8 48 fe ff ff       	callq  690 <pthread_join@plt>
 848:	be 00 00 00 00       	mov    $0x0,%esi
 84d:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
 852:	e8 39 fe ff ff       	callq  690 <pthread_join@plt>
 857:	48 8b 15 ba 07 20 00 	mov    0x2007ba(%rip),%rdx        # 201018 <sum>
 85e:	48 8d 35 d5 00 00 00 	lea    0xd5(%rip),%rsi        # 93a <_IO_stdin_used+0x1a>
 865:	bf 01 00 00 00       	mov    $0x1,%edi
 86a:	b8 00 00 00 00       	mov    $0x0,%eax
 86f:	e8 fc fd ff ff       	callq  670 <__printf_chk@plt>
 874:	bf 00 00 00 00       	mov    $0x0,%edi
 879:	e8 22 fe ff ff       	callq  6a0 <exit@plt>
 87e:	48 8d 3d 9f 00 00 00 	lea    0x9f(%rip),%rdi        # 924 <_IO_stdin_used+0x4>
 885:	e8 f6 fd ff ff       	callq  680 <perror@plt>
 88a:	bf 01 00 00 00       	mov    $0x1,%edi
 88f:	e8 0c fe ff ff       	callq  6a0 <exit@plt>
 894:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 89b:	00 00 00 
 89e:	66 90                	xchg   %ax,%ax

00000000000008a0 <__libc_csu_init>:
 8a0:	41 57                	push   %r15
 8a2:	41 56                	push   %r14
 8a4:	49 89 d7             	mov    %rdx,%r15
 8a7:	41 55                	push   %r13
 8a9:	41 54                	push   %r12
 8ab:	4c 8d 25 d6 04 20 00 	lea    0x2004d6(%rip),%r12        # 200d88 <__frame_dummy_init_array_entry>
 8b2:	55                   	push   %rbp
 8b3:	48 8d 2d d6 04 20 00 	lea    0x2004d6(%rip),%rbp        # 200d90 <__init_array_end>
 8ba:	53                   	push   %rbx
 8bb:	41 89 fd             	mov    %edi,%r13d
 8be:	49 89 f6             	mov    %rsi,%r14
 8c1:	4c 29 e5             	sub    %r12,%rbp
 8c4:	48 83 ec 08          	sub    $0x8,%rsp
 8c8:	48 c1 fd 03          	sar    $0x3,%rbp
 8cc:	e8 5f fd ff ff       	callq  630 <_init>
 8d1:	48 85 ed             	test   %rbp,%rbp
 8d4:	74 20                	je     8f6 <__libc_csu_init+0x56>
 8d6:	31 db                	xor    %ebx,%ebx
 8d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 8df:	00 
 8e0:	4c 89 fa             	mov    %r15,%rdx
 8e3:	4c 89 f6             	mov    %r14,%rsi
 8e6:	44 89 ef             	mov    %r13d,%edi
 8e9:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 8ed:	48 83 c3 01          	add    $0x1,%rbx
 8f1:	48 39 dd             	cmp    %rbx,%rbp
 8f4:	75 ea                	jne    8e0 <__libc_csu_init+0x40>
 8f6:	48 83 c4 08          	add    $0x8,%rsp
 8fa:	5b                   	pop    %rbx
 8fb:	5d                   	pop    %rbp
 8fc:	41 5c                	pop    %r12
 8fe:	41 5d                	pop    %r13
 900:	41 5e                	pop    %r14
 902:	41 5f                	pop    %r15
 904:	c3                   	retq   
 905:	90                   	nop
 906:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 90d:	00 00 00 

0000000000000910 <__libc_csu_fini>:
 910:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000000914 <_fini>:
 914:	48 83 ec 08          	sub    $0x8,%rsp
 918:	48 83 c4 08          	add    $0x8,%rsp
 91c:	c3                   	retq   
