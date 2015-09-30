%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}

%union {
  int numero
  char* string
  char  simbolo
  char[255] variable
}

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
%left OPS
%left OPM

/* Fin Declaraciones */

%%

/* Reglas Gramaticales */
/*
Ej:
expresion : expresion Ops_Suma expresion
          | CTE
;
*/

%%

/* Código de Usuario */




/*
Notas:
Los terminales van en mayusculas y son los tokens devueltos por el analizador lexico.
los auxiliares van en minusculas
*/
