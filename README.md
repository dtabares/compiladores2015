# compiladores2015
Untref Compiladores 2015

Proyecto LPPN (Lenguaje de Programación Para Niños)

Integrantes:
Guillermo Arispe
Fernando Ares
Diego Tabares


## ¿ Cómo probar el ejemploLex.l ?
1) flex -o ejemploLex.yy.c ejemploLex.l  -> esto genera el ejemploLex.yy.c
2) gcc -o ejemplo ejemploLex.yy.c --> esto genera el ejecutable
3) ./ejemplo --> con eso se ejecuta


## ¿ Cómo compilar el código?
1) bison -d analizador_sintactico.y
2) flex lppn.l
3) gcc analizador_sintactico.tab.c lex.yy.c
4)



## Videos Interesantes
Incorporación de acciones en Flex : https://www.youtube.com/watch?v=BVYTRqi-Bsc
Desarrollo de un analizador léxico usando Flex (explica patrones): https://www.youtube.com/watch?v=_zbIOMp63mo
Incorporación de acciones semánticas en Bison (explica %token y %type): https://www.youtube.com/watch?v=HmVB-83k_BI

#Info:
Terminales vs No Terminales (explicacion simple):
https://ar.answers.yahoo.com/question/index?qid=20061119161115AAbTcX9

%token para terminales
%type para no-terminales
