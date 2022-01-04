CC=gcc
CFLAGS=-O -g
LEX=flex -Cf
YACC=yacc
OBJS=parse.o scan.o alloc.o ident.o main.o par.o item.o value.o exp.o print.o type.o same.o check.o domain.o excerpt.o compile.o
INSTALLDIR=/local/bin

aut: ${OBJS}
	${CC} ${CFLAGS} -o aut ${OBJS}

.c.o:
	${CC} ${CFLAGS} -c $<

scan.o: flex.h aut.h parse.h
parse.o: aut.h parse.h
alloc.o: aut.h
ident.o: aut.h
main.o: aut.h
par.o: aut.h
item.o: aut.h
value.o: aut.h
exp.o: aut.h
print.o: aut.h
type.o: aut.h
same.o: aut.h
check.o: aut.h
domain.o: aut.h
excerpt.o: aut.h
compile.o: aut.h

scan.c: scan.l
	${LEX} scan.l
	mv lex.yy.c scan.c

parse.c parse.h: parse.y
	${YACC} -d parse.y
	mv y.tab.c parse.c
	mv y.tab.h parse.h

test: aut grundlagen.aut
	./aut -QZ grundlagen

install: aut
	install -c -s aut ${INSTALLDIR}

small:
	rm -f lex.yy.c y.tab.c y.tab.h y.output *.o core

clean: small
	rm -f scan.c parse.c parse.h aut
