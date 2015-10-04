%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int evaluarExpresion(int exp1, char operador, int exp2);

//-- Lexer prototype required by bison, aka getNextToken()
int yylex();
int yyerror(const char *p) { printf("error");}
%}

%union {
  int numero;
  char* string;
  char  simbolo;
  char variable[255];
};

/* Inicio Declaraciones */
/* Son de la forma:
                    %token <nombre_del_terminal> */

%token INICIO
%token FIN
%token LEER
%token MOSTRAR
%token PI
%token PD
%token GE
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
/*
%token OPS
%token OPM
*/
%token BOOL
%token STRING
%token <numero> NUMBER
%token OPSL
%token VAR
%left <simbolo> OPS
%left <simbolo> OPM
%type <numero> expresion

/* Fin Declaraciones */

%%

/* Reglas Gramaticales */
/*
Ej:
expresion : expresion Ops_Suma expresion
          | CTE
;
*/

expresion: expresion OPS expresion {{ int resultado = evaluarExpresion($1,$2,$3); $$ = resultado;}}
          | NUMBER  {{$$ = $1;}};

%%

/* Código de Usuario */


int main() {
  yyparse();
  return 0;
}

int evaluarExpresion(int exp1, char operador, int exp2){
  int resultado;

  if (operador == '+') {
    resultado = exp1 + exp2;
  }
  else {
    if (operador == '-') {
      resultado = exp1 - exp2;
    }
    else {
      if (operador == '*') {
        resultado = exp1 * exp2;
      }
      else {
        if (operador == '/') {
          resultado = exp1 / exp2;
        }
      }
    }
  }

  return resultado;
}

/*
Notas:
Los terminales van en mayusculas y son los tokens devueltos por el analizador lexico.
los auxiliares van en minusculas
*/
