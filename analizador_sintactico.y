%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
/*#include <tablaDeSimbolos>*/
//-- Lexer prototype required by bison, aka getNextToken()
int yylex();
int yyerror(const char *p) { printf("error");}
char validarTipo(char tipo1, char operacion, char tipo2);
%}

%union {
  int numero;
  char* string;
  char  simbolo; /*hacer conversion de operacion logica a char (en el lex!!!!) */
  char variable[255];
  char tipoDato;
};

/* Declara tabla de simbolos */
Tabla tablaDeSimbolos;


/* Inicio Declaraciones */
/* Son de la forma:
                    %token <nombre_del_terminal> */

%token INICIO
%token FIN
%token LEER
%token MOSTRAR
%token PI
%token PD
%token ASIG
%token LI
%token LD
%token MQ
%token HACER
%token OTROFIN
%token SI
%token ENTONCES
%token SINO
%token SU
%token RU
%token ES
%token PC
/*
%token OPS
%token OPM
*/
%token BOOL
%token STRING
%token <numero> NUMBER
%token OPSL
%token <variable> VAR
%left <simbolo> OPS
%left <simbolo> OPM
%type <tipoDato> expresion

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
		| SI expresion ENTONCES sentencia
		;
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
