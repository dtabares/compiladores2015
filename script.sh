bison -d analizador_sintactico.y
flex lppn.l
gcc analizador_sintactico.tab.c lex.yy.c
