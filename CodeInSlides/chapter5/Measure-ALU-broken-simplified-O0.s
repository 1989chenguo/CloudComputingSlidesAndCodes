
Measure-ALU-broken-simplified:     file format elf64-x86-64


Disassembly of section .init:

00000000000004b8 <_init>:
 4b8:	48 83 ec 08          	sub    $0x8,%rsp
 4bc:	48 8b 05 25 0b 20 00 	mov    0x200b25(%rip),%rax        # 200fe8 <__gmon_start__>
 4c3:	48 85 c0             	test   %rax,%rax
 4c6:	74 02                	je     4ca <_init+0x12>
 4c8:	ff d0                	callq  *%rax
 4ca:	48 83 c4 08          	add    $0x8,%rsp
 4ce:	c3                   	retq   

Disassembly of section .plt:

00000000000004d0 <.plt>:
 4d0:	ff 35 f2 0a 20 00    	pushq  0x200af2(%rip)        # 200fc8 <_GLOBAL_OFFSET_TABLE_+0x8>
 4d6:	ff 25 f4 0a 20 00    	jmpq   *0x200af4(%rip)        # 200fd0 <_GLOBAL_OFFSET_TABLE_+0x10>
 4dc:	0f 1f 40 00          	nopl   0x0(%rax)

Disassembly of section .plt.got:

00000000000004e0 <__cxa_finalize@plt>:
 4e0:	ff 25 12 0b 20 00    	jmpq   *0x200b12(%rip)        # 200ff8 <__cxa_finalize@GLIBC_2.2.5>
 4e6:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

00000000000004f0 <_start>:
 4f0:	31 ed                	xor    %ebp,%ebp
 4f2:	49 89 d1             	mov    %rdx,%r9
 4f5:	5e                   	pop    %rsi
 4f6:	48 89 e2             	mov    %rsp,%rdx
 4f9:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
 4fd:	50                   	push   %rax
 4fe:	54                   	push   %rsp
 4ff:	4c 8d 05 aa 02 00 00 	lea    0x2aa(%rip),%r8        # 7b0 <__libc_csu_fini>
 506:	48 8d 0d 33 02 00 00 	lea    0x233(%rip),%rcx        # 740 <__libc_csu_init>
 50d:	48 8d 3d e6 00 00 00 	lea    0xe6(%rip),%rdi        # 5fa <main>
 514:	ff 15 c6 0a 20 00    	callq  *0x200ac6(%rip)        # 200fe0 <__libc_start_main@GLIBC_2.2.5>
 51a:	f4                   	hlt    
 51b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000520 <deregister_tm_clones>:
 520:	48 8d 3d e9 0a 20 00 	lea    0x200ae9(%rip),%rdi        # 201010 <__TMC_END__>
 527:	55                   	push   %rbp
 528:	48 8d 05 e1 0a 20 00 	lea    0x200ae1(%rip),%rax        # 201010 <__TMC_END__>
 52f:	48 39 f8             	cmp    %rdi,%rax
 532:	48 89 e5             	mov    %rsp,%rbp
 535:	74 19                	je     550 <deregister_tm_clones+0x30>
 537:	48 8b 05 9a 0a 20 00 	mov    0x200a9a(%rip),%rax        # 200fd8 <_ITM_deregisterTMCloneTable>
 53e:	48 85 c0             	test   %rax,%rax
 541:	74 0d                	je     550 <deregister_tm_clones+0x30>
 543:	5d                   	pop    %rbp
 544:	ff e0                	jmpq   *%rax
 546:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 54d:	00 00 00 
 550:	5d                   	pop    %rbp
 551:	c3                   	retq   
 552:	0f 1f 40 00          	nopl   0x0(%rax)
 556:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 55d:	00 00 00 

0000000000000560 <register_tm_clones>:
 560:	48 8d 3d a9 0a 20 00 	lea    0x200aa9(%rip),%rdi        # 201010 <__TMC_END__>
 567:	48 8d 35 a2 0a 20 00 	lea    0x200aa2(%rip),%rsi        # 201010 <__TMC_END__>
 56e:	55                   	push   %rbp
 56f:	48 29 fe             	sub    %rdi,%rsi
 572:	48 89 e5             	mov    %rsp,%rbp
 575:	48 c1 fe 03          	sar    $0x3,%rsi
 579:	48 89 f0             	mov    %rsi,%rax
 57c:	48 c1 e8 3f          	shr    $0x3f,%rax
 580:	48 01 c6             	add    %rax,%rsi
 583:	48 d1 fe             	sar    %rsi
 586:	74 18                	je     5a0 <register_tm_clones+0x40>
 588:	48 8b 05 61 0a 20 00 	mov    0x200a61(%rip),%rax        # 200ff0 <_ITM_registerTMCloneTable>
 58f:	48 85 c0             	test   %rax,%rax
 592:	74 0c                	je     5a0 <register_tm_clones+0x40>
 594:	5d                   	pop    %rbp
 595:	ff e0                	jmpq   *%rax
 597:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 59e:	00 00 
 5a0:	5d                   	pop    %rbp
 5a1:	c3                   	retq   
 5a2:	0f 1f 40 00          	nopl   0x0(%rax)
 5a6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 5ad:	00 00 00 

00000000000005b0 <__do_global_dtors_aux>:
 5b0:	80 3d 59 0a 20 00 00 	cmpb   $0x0,0x200a59(%rip)        # 201010 <__TMC_END__>
 5b7:	75 2f                	jne    5e8 <__do_global_dtors_aux+0x38>
 5b9:	48 83 3d 37 0a 20 00 	cmpq   $0x0,0x200a37(%rip)        # 200ff8 <__cxa_finalize@GLIBC_2.2.5>
 5c0:	00 
 5c1:	55                   	push   %rbp
 5c2:	48 89 e5             	mov    %rsp,%rbp
 5c5:	74 0c                	je     5d3 <__do_global_dtors_aux+0x23>
 5c7:	48 8b 3d 3a 0a 20 00 	mov    0x200a3a(%rip),%rdi        # 201008 <__dso_handle>
 5ce:	e8 0d ff ff ff       	callq  4e0 <__cxa_finalize@plt>
 5d3:	e8 48 ff ff ff       	callq  520 <deregister_tm_clones>
 5d8:	c6 05 31 0a 20 00 01 	movb   $0x1,0x200a31(%rip)        # 201010 <__TMC_END__>
 5df:	5d                   	pop    %rbp
 5e0:	c3                   	retq   
 5e1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 5e8:	f3 c3                	repz retq 
 5ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000005f0 <frame_dummy>:
 5f0:	55                   	push   %rbp
 5f1:	48 89 e5             	mov    %rsp,%rbp
 5f4:	5d                   	pop    %rbp
 5f5:	e9 66 ff ff ff       	jmpq   560 <register_tm_clones>

00000000000005fa <main>:
 5fa:	55                   	push   %rbp
 5fb:	48 89 e5             	mov    %rsp,%rbp
 5fe:	48 83 ec 08          	sub    $0x8,%rsp
 602:	89 7d 8c             	mov    %edi,-0x74(%rbp)
 605:	48 89 75 80          	mov    %rsi,-0x80(%rbp)
 609:	c7 45 ac 11 00 00 00 	movl   $0x11,-0x54(%rbp)
 610:	c7 45 b0 0d 00 00 00 	movl   $0xd,-0x50(%rbp)
 617:	c7 45 b4 00 00 00 00 	movl   $0x0,-0x4c(%rbp)
 61e:	c7 45 98 00 00 00 00 	movl   $0x0,-0x68(%rbp)
 625:	eb 04                	jmp    62b <main+0x31>
 627:	83 45 98 01          	addl   $0x1,-0x68(%rbp)
 62b:	81 7d 98 ff c9 9a 3b 	cmpl   $0x3b9ac9ff,-0x68(%rbp)
 632:	7e f3                	jle    627 <main+0x2d>
 634:	c7 45 b8 11 00 00 00 	movl   $0x11,-0x48(%rbp)
 63b:	c7 45 bc 0d 00 00 00 	movl   $0xd,-0x44(%rbp)
 642:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%rbp)
 649:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
 650:	eb 0e                	jmp    660 <main+0x66>
 652:	8b 45 b8             	mov    -0x48(%rbp),%eax
 655:	0f af 45 bc          	imul   -0x44(%rbp),%eax
 659:	89 45 c0             	mov    %eax,-0x40(%rbp)
 65c:	83 45 9c 01          	addl   $0x1,-0x64(%rbp)
 660:	81 7d 9c ff c9 9a 3b 	cmpl   $0x3b9ac9ff,-0x64(%rbp)
 667:	7e e9                	jle    652 <main+0x58>
 669:	c7 45 c4 11 00 00 00 	movl   $0x11,-0x3c(%rbp)
 670:	c7 45 c8 0d 00 00 00 	movl   $0xd,-0x38(%rbp)
 677:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%rbp)
 67e:	c7 45 a0 00 00 00 00 	movl   $0x0,-0x60(%rbp)
 685:	eb 0e                	jmp    695 <main+0x9b>
 687:	8b 45 c4             	mov    -0x3c(%rbp),%eax
 68a:	99                   	cltd   
 68b:	f7 7d c8             	idivl  -0x38(%rbp)
 68e:	89 45 cc             	mov    %eax,-0x34(%rbp)
 691:	83 45 a0 01          	addl   $0x1,-0x60(%rbp)
 695:	81 7d a0 ff c9 9a 3b 	cmpl   $0x3b9ac9ff,-0x60(%rbp)
 69c:	7e e9                	jle    687 <main+0x8d>
 69e:	f2 0f 10 05 22 01 00 	movsd  0x122(%rip),%xmm0        # 7c8 <_IO_stdin_used+0x8>
 6a5:	00 
 6a6:	f2 0f 11 45 d0       	movsd  %xmm0,-0x30(%rbp)
 6ab:	f2 0f 10 05 1d 01 00 	movsd  0x11d(%rip),%xmm0        # 7d0 <_IO_stdin_used+0x10>
 6b2:	00 
 6b3:	f2 0f 11 45 d8       	movsd  %xmm0,-0x28(%rbp)
 6b8:	66 0f ef c0          	pxor   %xmm0,%xmm0
 6bc:	f2 0f 11 45 e0       	movsd  %xmm0,-0x20(%rbp)
 6c1:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%rbp)
 6c8:	eb 13                	jmp    6dd <main+0xe3>
 6ca:	f2 0f 10 45 d0       	movsd  -0x30(%rbp),%xmm0
 6cf:	f2 0f 59 45 d8       	mulsd  -0x28(%rbp),%xmm0
 6d4:	f2 0f 11 45 e0       	movsd  %xmm0,-0x20(%rbp)
 6d9:	83 45 a4 01          	addl   $0x1,-0x5c(%rbp)
 6dd:	81 7d a4 ff c9 9a 3b 	cmpl   $0x3b9ac9ff,-0x5c(%rbp)
 6e4:	7e e4                	jle    6ca <main+0xd0>
 6e6:	f2 0f 10 05 da 00 00 	movsd  0xda(%rip),%xmm0        # 7c8 <_IO_stdin_used+0x8>
 6ed:	00 
 6ee:	f2 0f 11 45 e8       	movsd  %xmm0,-0x18(%rbp)
 6f3:	f2 0f 10 05 d5 00 00 	movsd  0xd5(%rip),%xmm0        # 7d0 <_IO_stdin_used+0x10>
 6fa:	00 
 6fb:	f2 0f 11 45 f0       	movsd  %xmm0,-0x10(%rbp)
 700:	66 0f ef c0          	pxor   %xmm0,%xmm0
 704:	f2 0f 11 45 f8       	movsd  %xmm0,-0x8(%rbp)
 709:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
 710:	eb 13                	jmp    725 <main+0x12b>
 712:	f2 0f 10 45 e8       	movsd  -0x18(%rbp),%xmm0
 717:	f2 0f 5e 45 f0       	divsd  -0x10(%rbp),%xmm0
 71c:	f2 0f 11 45 f8       	movsd  %xmm0,-0x8(%rbp)
 721:	83 45 a8 01          	addl   $0x1,-0x58(%rbp)
 725:	81 7d a8 ff c9 9a 3b 	cmpl   $0x3b9ac9ff,-0x58(%rbp)
 72c:	7e e4                	jle    712 <main+0x118>
 72e:	b8 00 00 00 00       	mov    $0x0,%eax
 733:	c9                   	leaveq 
 734:	c3                   	retq   
 735:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 73c:	00 00 00 
 73f:	90                   	nop

0000000000000740 <__libc_csu_init>:
 740:	41 57                	push   %r15
 742:	41 56                	push   %r14
 744:	49 89 d7             	mov    %rdx,%r15
 747:	41 55                	push   %r13
 749:	41 54                	push   %r12
 74b:	4c 8d 25 9e 06 20 00 	lea    0x20069e(%rip),%r12        # 200df0 <__frame_dummy_init_array_entry>
 752:	55                   	push   %rbp
 753:	48 8d 2d 9e 06 20 00 	lea    0x20069e(%rip),%rbp        # 200df8 <__init_array_end>
 75a:	53                   	push   %rbx
 75b:	41 89 fd             	mov    %edi,%r13d
 75e:	49 89 f6             	mov    %rsi,%r14
 761:	4c 29 e5             	sub    %r12,%rbp
 764:	48 83 ec 08          	sub    $0x8,%rsp
 768:	48 c1 fd 03          	sar    $0x3,%rbp
 76c:	e8 47 fd ff ff       	callq  4b8 <_init>
 771:	48 85 ed             	test   %rbp,%rbp
 774:	74 20                	je     796 <__libc_csu_init+0x56>
 776:	31 db                	xor    %ebx,%ebx
 778:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 77f:	00 
 780:	4c 89 fa             	mov    %r15,%rdx
 783:	4c 89 f6             	mov    %r14,%rsi
 786:	44 89 ef             	mov    %r13d,%edi
 789:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 78d:	48 83 c3 01          	add    $0x1,%rbx
 791:	48 39 dd             	cmp    %rbx,%rbp
 794:	75 ea                	jne    780 <__libc_csu_init+0x40>
 796:	48 83 c4 08          	add    $0x8,%rsp
 79a:	5b                   	pop    %rbx
 79b:	5d                   	pop    %rbp
 79c:	41 5c                	pop    %r12
 79e:	41 5d                	pop    %r13
 7a0:	41 5e                	pop    %r14
 7a2:	41 5f                	pop    %r15
 7a4:	c3                   	retq   
 7a5:	90                   	nop
 7a6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 7ad:	00 00 00 

00000000000007b0 <__libc_csu_fini>:
 7b0:	f3 c3                	repz retq 

Disassembly of section .fini:

00000000000007b4 <_fini>:
 7b4:	48 83 ec 08          	sub    $0x8,%rsp
 7b8:	48 83 c4 08          	add    $0x8,%rsp
 7bc:	c3                   	retq   
