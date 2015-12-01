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
char* convertNumberToString(int numero);


%}

%union {
  int numero;
  char* string;
  char  simbolo;
  char variable[255];
  char tipoDato;
  ptrNodoArbol arbol;
  Dato tipoDeDato;
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

programa:         INICIO cuerpo FIN                                   {{$<arbol>$ = $<arbol>2;printf("%s\n", "LOG: Recorriendo Arbol Post Order"); postOrden($<arbol>$); }}
                ;

cuerpo:           sentencia PC cuerpo                                 {{printf("%s\n", "LOG: Regla sentencia;cuerpo "); $<arbol>$ = insertarNodo("s",&$<arbol>1,&$<arbol>3);}}
		            | sentencia PC                                        {{printf("%s\n", "LOG: Regla sentencia; "); $<arbol>$ = $<arbol>1;}}
		            ;


sentencia:      asignacion                                             {{printf("%s\n", "LOG: Regla sentencia asignacion"); $<arbol>$ = $<arbol>1;}}
		          | condicional                                            {{printf("%s\n", "LOG: Regla sentencia condicional"); $<arbol>$ = $<arbol>1;}}
              | ciclo                                                  {{printf("%s\n", "LOG: Regla sentencia ciclo"); $<arbol>$ = $<arbol>1;}}
		          ;

asignacion:     expresion ASIG VAR                                     {{printf("%s\n", "LOG: Regla asignacion"); insertar($<variable>3,$<tipoDato>1); $<arbol>$ = insertarNodo("=",&$<arbol>1,&$<arbol>3 );}} // aca arbol 3 no esta declarado como un tipo arbol en la linea %type <tipoDato,arbol>
              ;

ciclo:          MQ PI expresion PD LI cuerpo LD                           {{printf("%s\n", "LOG: Regla ciclo"); if ($<tipoDato>3 != 'b') {yyerror("Error: Operacion no permitida");};$<arbol>$ = insertarNodo("w",&$<arbol>3,&$<arbol>6);}}

condicional:    SI PI expresion PD LI cuerpo LD                           {{printf("%s\n", "LOG: Regla condicional"); if ($<tipoDato>3 != 'b') {yyerror("Error: Operacion no permitida");};$<arbol>$ = insertarNodo("i",&$<arbol>3,&$<arbol>6); }}
              | SI PI expresion PD LI cuerpo LD SINO LI cuerpo LD         {{printf("%s\n", "LOG: Regla condicional 2"); if ($<tipoDato>3 != 'b') {yyerror("Error: Operacion no permitida");}; }}
              ;


/* $3 es la variable, $1 es el tipo */
expresion:      expresion OPS expresion {{ printf("%s\n", "LOG: Regla expresion"); $<arbol>$ = insertarNodo($<tipoDeDato.texto>2,&$<arbol>1,&$<arbol>3); printf("%s %c \n","Valor Simbolo: ",$<tipoDeDato.simbolo>2);$<tipoDato>$ = validarTipo($<tipoDeDato.simbolo>1,$<tipoDeDato.simbolo>2,$<tipoDato>3); }} /* deben concordar los tipos y la operacion y devolver el tipo resultante*/
              | NUMBER  {{printf("%s\n", "LOG: Regla numero"); $<tipoDeDato.arbol>$ = insertarHoja(convertNumberToString($1)); $<tipoDeDato.simbolo>$ = 'n'; printf("%s" "%c\n", "LOG: Tipo Dato: ",$<tipoDeDato.simbolo>$); }}
		          | STRING {{printf("%s\n", "LOG: Regla string"); $<tipoDeDato.arbol>$  = insertarHoja($<string>1); $<tipoDeDato.simbolo>$ = 's';}}
		          | BOOL {{printf("%s\n", "LOG: Regla boolean"); $<tipoDeDato.arbol>$  = insertarHoja($<string>1); $<tipoDeDato.simbolo>$ = 'b';printf("%s" "%c\n", "LOG: Tipo Dato: ",$<tipoDeDato.simbolo>$);}}
		          | VAR	{{printf("%s\n", "LOG: Regla variable"); $<tipoDeDato.simbolo>$ = getTipo($<variable>1); printf("%s" "%c\n", "LOG: Tipo Dato Variable: ",$<tipoDeDato.simbolo>$); $<tipoDeDato.arbol>$ = insertarHoja($<variable>1); }} /*hacer funcion para buscar en tabla de sim. y si no la encuentra tira error*/
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
  printf("%s" "%c\n", "LOG: tipo1: ",tipo1);
  printf("%s" "%c\n", "LOG: tipo2: ",tipo2);
  printf("%s" "%c\n", "LOG: operacion: ",operacion);

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

char* convertNumberToString(int numero){
  char* stringNum = (char*)malloc(sizeof(char)*(255));
  sprintf(stringNum,"%d",numero);
  printf("%s" "%d" "\n", "LOG: Numero Ingresado: ", numero);
  printf("%s" "%s" "\n", "LOG: Numero Modificado: ", stringNum);
  return stringNum;
};

/*
Notas:
Los terminales van en mayusculas y son los tokens devueltos por el analizador lexico.
los auxiliares van en minusculas
*/
