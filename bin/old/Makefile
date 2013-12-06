all:		src exec

src:		idcheck.l defcon.l modstr.l
		flex -ft idcheck.l > idcheck.yy.c
		flex -ft defcon.l > defcon.yy.c
		flex -f+t modstr.l > modstr.yy.cc

idcheck:	idcheck.l
		flex -f $<
		gcc lex.yy.c -lfl -o idcheck

defcon:  	defcon.l
		flex -f $<
		gcc lex.yy.c -lfl -o defcon

modstr:		modstr.l
		flex -f+ $<
		g++ lex.yy.cc -lfl -o modstr
 
exec:		idcheck.yy.c defcon.yy.c modstr.yy.cc
		gcc idcheck.yy.c -lfl -o idcheck
		gcc defcon.yy.c -lfl -o defcon
		g++ modstr.yy.cc -lfl -o modstr

clean:		
		rm -f *.yy.c *.yy.cc *~

distclean:	clean
