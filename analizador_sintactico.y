%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
/*#include <tablaDeSimbolos>*/
//-- Lexer prototype required by bison, aka getNextToken()
int yylex();
int yyerror(const char *p) { printf("error");}
char validarTipo(char tipo1, char operacion, char tipo2);

/* Declara tabla de simbolos */
Tabla tablaDeSimbolos;
%}

%union {
  int numero;
  char* string;
  char  simbolo;
  char variable[255];
  char tipoDato;
};

/* Inicio Declaraciones */
/* Son de la forma:
                    %token <nombre_del_terminal> */

%token INICIO FIN LEER MOSTRAR ASIG MQ HACER SI ENTONCES SINO SU RU ES BOOL STRING
%token <simbolo> PI PD LI LD OPSL PC
%token <numero> NUMBER
%token <variable> VAR
%left <simbolo> OPS
%left <simbolo> OPM
%type <tipoDato> expresion programa cuerpo sentencia

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

programa: INICIO cuerpo FIN;

cuerpo: sentencia PC cuerpo
		| sentencia PC
		;
sentencia: expresion ASIG VAR {{InsertarEnTablaDeSimbolos($3,$1)}}
		| condicional
    |
		;

condicional:    SI PI expresion PD LI cuerpo LD                         {{if ($3 != 'b'){yyerror("Error: Operacion no permitida");} }}
              | SI PI expresion PD LI cuerpo LD SINO LI cuerpo LD       {{if ($3 != 'b'){yyerror("Error: Operacion no permitida");} }}
              | SI PI expresion PD LI cuerpo LD SINO LI condicional LD       {{if ($3 != 'b'){yyerror("Error: Operacion no permitida");} }}
/* $3 es la variable, $1 es el tipo */

expresion: expresion OPS expresion {{ $$ = validarTipo($1,$2,$3); }} /* deben concordar los tipos y la operacion y devolver el tipo resultante*/
          | NUMBER  {{$$ = 'n';}}
		  | STRING {{$$ = 's';}}
		  | BOOL {{$$ = 'b';}}
		  | VAR	{{$$ = getTipo($1);}} /*hacer funcion para buscar en tabla de sim. y si no la encuentra tira error*/
		  ;
%%

/* Código de Usuario */

int main() {
  yyparse();
  return 0;
  /* Inicializar tablaDeSimbolos*/
}

void InsertarEnTablaDeSimbolos(char nombre[255],char tipo){
 /*buscar si existe, sino insertar */
};

char validarTipo(char tipo1, char operacion, char tipo2){
  if (tipo1 == tipo2) {

    if (operacion == 'n' || operacion == 'y' || operacion == 'o') {
      if (tipo1 == 'b') {
        return 'b';
      }
      else{
        yyerror("Error: Operacion no permitida");
      }
    }
    else {
      if (operacion == '+' || operacion == '-' || operacion == '/' || operacion == '*' || operacion == 'w' || operacion == 's' || operacion == 'i' || operacion == 'a' || operacion == 'd') {
        if (tipo1 == 'n') {
          return 'n';
        }
        else{
          yyerror("Error: Operacion no permitida");
        }
      }
      else{
        yyerror("Error:Tipo de operador desconocido");
      }
    }
  }
  else{
    yyerror("Error: tipos de variable incompatibles");
  }

};

char getTipo(char nombre[255]){

/* busca nombre de variable en tabla de simbolos y devuelve el tipo asociado */

};


/*
Notas:
Los terminales van en mayusculas y son los tokens devueltos por el analizador lexico.
los auxiliares van en minusculas
*/
