

PL2014_check: y.tab.o lex.yy.o
	gcc -o PL2016_check y.tab.o lex.yy.o
y.tab.o: y.tab.c
	gcc -c y.tab.c
lex.yy.o: y.tab.h lex.yy.c 
	gcc -c lex.yy.c
y.tab.c y.tab.h: PL2016_check.y
	yacc -d PL2016_check.y
lex.yy.c: PL2016_check.l
	lex -l PL2016_check.l
clean:
	rm *.o
	rm *.c
	rm *.h
	rm PL2016_check
