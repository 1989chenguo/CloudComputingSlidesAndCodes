
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

00000000000004f0 <main>:
 4f0:	31 c0                	xor    %eax,%eax
 4f2:	c3                   	retq   
 4f3:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 4fa:	00 00 00 
 4fd:	0f 1f 00             	nopl   (%rax)

0000000000000500 <_start>:
 500:	31 ed                	xor    %ebp,%ebp
 502:	49 89 d1             	mov    %rdx,%r9
 505:	5e                   	pop    %rsi
 506:	48 89 e2             	mov    %rsp,%rdx
 509:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
 50d:	50                   	push   %rax
 50e:	54                   	push   %rsp
 50f:	4c 8d 05 6a 01 00 00 	lea    0x16a(%rip),%r8        # 680 <__libc_csu_fini>
 516:	48 8d 0d f3 00 00 00 	lea    0xf3(%rip),%rcx        # 610 <__libc_csu_init>
 51d:	48 8d 3d cc ff ff ff 	lea    -0x34(%rip),%rdi        # 4f0 <main>
 524:	ff 15 b6 0a 20 00    	callq  *0x200ab6(%rip)        # 200fe0 <__libc_start_main@GLIBC_2.2.5>
 52a:	f4                   	hlt    
 52b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000000530 <deregister_tm_clones>:
 530:	48 8d 3d d9 0a 20 00 	lea    0x200ad9(%rip),%rdi        # 201010 <__TMC_END__>
 537:	55                   	push   %rbp
 538:	48 8d 05 d1 0a 20 00 	lea    0x200ad1(%rip),%rax        # 201010 <__TMC_END__>
 53f:	48 39 f8             	cmp    %rdi,%rax
 542:	48 89 e5             	mov    %rsp,%rbp
 545:	74 19                	je     560 <deregister_tm_clones+0x30>
 547:	48 8b 05 8a 0a 20 00 	mov    0x200a8a(%rip),%rax        # 200fd8 <_ITM_deregisterTMCloneTable>
 54e:	48 85 c0             	test   %rax,%rax
 551:	74 0d                	je     560 <deregister_tm_clones+0x30>
 553:	5d                   	pop    %rbp
 554:	ff e0                	jmpq   *%rax
 556:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 55d:	00 00 00 
 560:	5d                   	pop    %rbp
 561:	c3                   	retq   
 562:	0f 1f 40 00          	nopl   0x0(%rax)
 566:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 56d:	00 00 00 

0000000000000570 <register_tm_clones>:
 570:	48 8d 3d 99 0a 20 00 	lea    0x200a99(%rip),%rdi        # 201010 <__TMC_END__>
 577:	48 8d 35 92 0a 20 00 	lea    0x200a92(%rip),%rsi        # 201010 <__TMC_END__>
 57e:	55                   	push   %rbp
 57f:	48 29 fe             	sub    %rdi,%rsi
 582:	48 89 e5             	mov    %rsp,%rbp
 585:	48 c1 fe 03          	sar    $0x3,%rsi
 589:	48 89 f0             	mov    %rsi,%rax
 58c:	48 c1 e8 3f          	shr    $0x3f,%rax
 590:	48 01 c6             	add    %rax,%rsi
 593:	48 d1 fe             	sar    %rsi
 596:	74 18                	je     5b0 <register_tm_clones+0x40>
 598:	48 8b 05 51 0a 20 00 	mov    0x200a51(%rip),%rax        # 200ff0 <_ITM_registerTMCloneTable>
 59f:	48 85 c0             	test   %rax,%rax
 5a2:	74 0c                	je     5b0 <register_tm_clones+0x40>
 5a4:	5d                   	pop    %rbp
 5a5:	ff e0                	jmpq   *%rax
 5a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
 5ae:	00 00 
 5b0:	5d                   	pop    %rbp
 5b1:	c3                   	retq   
 5b2:	0f 1f 40 00          	nopl   0x0(%rax)
 5b6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 5bd:	00 00 00 

00000000000005c0 <__do_global_dtors_aux>:
 5c0:	80 3d 49 0a 20 00 00 	cmpb   $0x0,0x200a49(%rip)        # 201010 <__TMC_END__>
 5c7:	75 2f                	jne    5f8 <__do_global_dtors_aux+0x38>
 5c9:	48 83 3d 27 0a 20 00 	cmpq   $0x0,0x200a27(%rip)        # 200ff8 <__cxa_finalize@GLIBC_2.2.5>
 5d0:	00 
 5d1:	55                   	push   %rbp
 5d2:	48 89 e5             	mov    %rsp,%rbp
 5d5:	74 0c                	je     5e3 <__do_global_dtors_aux+0x23>
 5d7:	48 8b 3d 2a 0a 20 00 	mov    0x200a2a(%rip),%rdi        # 201008 <__dso_handle>
 5de:	e8 fd fe ff ff       	callq  4e0 <__cxa_finalize@plt>
 5e3:	e8 48 ff ff ff       	callq  530 <deregister_tm_clones>
 5e8:	c6 05 21 0a 20 00 01 	movb   $0x1,0x200a21(%rip)        # 201010 <__TMC_END__>
 5ef:	5d                   	pop    %rbp
 5f0:	c3                   	retq   
 5f1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 5f8:	f3 c3                	repz retq 
 5fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000600 <frame_dummy>:
 600:	55                   	push   %rbp
 601:	48 89 e5             	mov    %rsp,%rbp
 604:	5d                   	pop    %rbp
 605:	e9 66 ff ff ff       	jmpq   570 <register_tm_clones>
 60a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000000610 <__libc_csu_init>:
 610:	41 57                	push   %r15
 612:	41 56                	push   %r14
 614:	49 89 d7             	mov    %rdx,%r15
 617:	41 55                	push   %r13
 619:	41 54                	push   %r12
 61b:	4c 8d 25 ce 07 20 00 	lea    0x2007ce(%rip),%r12        # 200df0 <__frame_dummy_init_array_entry>
 622:	55                   	push   %rbp
 623:	48 8d 2d ce 07 20 00 	lea    0x2007ce(%rip),%rbp        # 200df8 <__init_array_end>
 62a:	53                   	push   %rbx
 62b:	41 89 fd             	mov    %edi,%r13d
 62e:	49 89 f6             	mov    %rsi,%r14
 631:	4c 29 e5             	sub    %r12,%rbp
 634:	48 83 ec 08          	sub    $0x8,%rsp
 638:	48 c1 fd 03          	sar    $0x3,%rbp
 63c:	e8 77 fe ff ff       	callq  4b8 <_init>
 641:	48 85 ed             	test   %rbp,%rbp
 644:	74 20                	je     666 <__libc_csu_init+0x56>
 646:	31 db                	xor    %ebx,%ebx
 648:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
 64f:	00 
 650:	4c 89 fa             	mov    %r15,%rdx
 653:	4c 89 f6             	mov    %r14,%rsi
 656:	44 89 ef             	mov    %r13d,%edi
 659:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
 65d:	48 83 c3 01          	add    $0x1,%rbx
 661:	48 39 dd             	cmp    %rbx,%rbp
 664:	75 ea                	jne    650 <__libc_csu_init+0x40>
 666:	48 83 c4 08          	add    $0x8,%rsp
 66a:	5b                   	pop    %rbx
 66b:	5d                   	pop    %rbp
 66c:	41 5c                	pop    %r12
 66e:	41 5d                	pop    %r13
 670:	41 5e                	pop    %r14
 672:	41 5f                	pop    %r15
 674:	c3                   	retq   
 675:	90                   	nop
 676:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 67d:	00 00 00 

0000000000000680 <__libc_csu_fini>:
 680:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000000684 <_fini>:
 684:	48 83 ec 08          	sub    $0x8,%rsp
 688:	48 83 c4 08          	add    $0x8,%rsp
 68c:	c3                   	retq   
