%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "tablaSimbolos.c"
#include "arbol.c"
//-- Lexer prototype required by bison, aka getNextToken()
int yylex();
int yyerror(const char *p) { printf("%s \n", p);}
char validarTipo(char tipo1, char operacion, char tipo2);

%}

%union {
  int numero;
  char* string;
  char  simbolo;
  char variable[255];
  char tipoDato;
  ptrNodoArbol arbol;
};

/* Inicio Declaraciones */
	/* Son de la forma: %token <nombre_del_terminal> */

%token <tipoDato> INICIO FIN
%token LEER MOSTRAR ASIG MQ HACER SI ENTONCES SINO SU RU ES BOOL STRING
%token <simbolo> PI PD LI LD OPSL PC
%token <numero> NUMBER
%token <variable,arbol> VAR
%left <simbolo> OPS
%left <simbolo> OPM
%type <tipoDato,arbol> expresion cuerpo programa sentencia condicional ciclo asignacion

/* Fin Declaraciones */

%%

/* Reglas Gramaticales */
/*
Ej:
expresion : expresion Ops_Suma expresion
          | CTE
		;
*/

/*
Tipos de variables
b = boolean
n = numero
s = string
*/

//insertarNodo(&ptrRaiz,&$2)

programa:         INICIO cuerpo FIN                                   {{$<arbol>$ = $<arbol>2;}}
                ;

cuerpo:           sentencia PC cuerpo                                 {{$<arbol>$ = insertarNodo("s",&$<arbol>1,&$<arbol>3);}} //aca es como que le pasamos $1 y $3 al arbol, pero el arbol espera como parametro 2 punteros a arboles, y no parece que estos sean punteros a arboles
		            | sentencia PC                                        {{$<arbol>$ = $<arbol>1;}}
		            ;


sentencia:      asignacion                                             {{$<arbol>$ = $<arbol>1;}}
		          | condicional                                            {{$<arbol>$ = $<arbol>1;}}
              | ciclo                                                  {{$<arbol>$ = $<arbol>1;}}
		          ;

asignacion:     expresion ASIG VAR                                        {{ insertar($3,$1); $<arbol>$ = insertarNodo("=",&$<arbol>1,&$<arbol>3 );}} // aca arbol 3 no esta declarado como un tipo arbol en la linea %type <tipoDato,arbol>
              ;

ciclo:          MQ PI expresion PD LI cuerpo LD                           {{if ($3 != 'b') {yyerror("Error: Operacion no permitida");};$<arbol>$ = insertarNodo("w",&$<arbol>3,&$<arbol>6);}}

condicional:    SI PI expresion PD LI cuerpo LD                           {{if ($3 != 'b') {yyerror("Error: Operacion no permitida");};$<arbol>$ = insertarNodo("i",&$<arbol>3,&$<arbol>6); }}
              | SI PI expresion PD LI cuerpo LD SINO LI cuerpo LD         {{if ($3 != 'b') {yyerror("Error: Operacion no permitida");}; }}
              ;


/* $3 es la variable, $1 es el tipo */
expresion:      expresion OPS expresion {{ $$ = validarTipo($1,$2,$3); $<arbol>$ = insertarNodo($2,&$<arbol>1,&$<arbol>3);}} /* deben concordar los tipos y la operacion y devolver el tipo resultante*/
              | NUMBER  {{$$ = 'n'; $<arbol>$ = insertarHoja($1); }}
		          | STRING {{$$ = 's'; $<arbol>$  = insertarHoja($<string>1); }}
		          | BOOL {{$$ = 'b'; $<arbol>$  = insertarHoja($<string>1); }}
		          | VAR	{{$$ = getTipo($1); $<arbol>$ = insertarHoja($1); }} /*hacer funcion para buscar en tabla de sim. y si no la encuentra tira error*/
		          ;
%%

/* Código de Usuario */

int main() {
  crear();
  yyparse();
  imprimir();
  return 0;
  /* Inicializar tablaDeSimbolos*/
}

char validarTipo(char tipo1, char operacion, char tipo2){

  if (tipo1 == tipo2) {

	if(operacion == 'b'){

				return 'b';

    }

	else if (operacion == '+' || operacion == '-' || operacion == '/' || operacion == '*') {

				if (tipo1 == 'n') {

					return 'n';

				}

				else{

						yyerror("Error: Operacion no permitida");

				}

	}

	else {

		yyerror("Error:Tipo de operador desconocido");

	}

  }

  else{

		yyerror("Error: tipos de variable incompatibles");

  }

};

/*
Notas:
Los terminales van en mayusculas y son los tokens devueltos por el analizador lexico.
los auxiliares van en minusculas
*/
