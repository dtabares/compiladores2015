%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "analizador_sintactico.tab.h"
#include "tablaSimbolos.c"
%}

%option noyywrap
%option yylineno

Ops_Suma "+"|"-"
Ops_Mult "*"|"/"
Ops_Logicas "no"|"y"|"o"|"mayor_a"|"menor_a"|"igual_a"|"menor_igual_a"|"mayor_igual_a"
NUMBER [0-9]+
STRING ["]{1}.{2,255}["]{1}
BOOLEAN "verdadero"|"falso"
/* Las variables deben comenzar con letras ya sea mayus o minus */
VAR_NAME [a-zA-Z][a-zA-Z0-9]*


%%
"Inicio"            { printf("INICIO \n"); return INICIO; }
"Fin"			          { printf("FIN \n"); return FIN;}
"leer"              { printf("LEER \n"); return LEER;}
"mostrar"           { printf("MOSTRAR \n"); return MOSTRAR;}
"("                 { printf("PI \n"); return PI;}
")"                 { printf("PD \n"); return PD;}
"guardar_en"	      { printf("ASIGNACION \n"); return ASIG;}
"{"                 { printf("LI \n"); return LI;}
"}"                 { printf("LD \n"); return LD;}
"mientras_que"	    { printf("MQ \n"); return MQ;}
"hacer"			        { printf("HACER \n"); return HACER;}
"si"			          { printf("SI \n"); return SI;}
"entonces"		      { printf("ENTONCES \n"); return ENTONCES;}
"sino"			        { printf("SINO \n"); return SINO;}
"sumar_uno"		      { printf("SU \n"); return SU;}
"restar_uno"	      { printf("RU \n"); return RU;}
"es"			          { printf("ES \n"); return ES;}
{Ops_Logicas}       { printf("Op Logica \n"); return OPS;}
{Ops_Suma}          { printf("Ingresaste una op suma \n"); yylval.simbolo = yytext[0]; return OPS;}
{Ops_Mult}          { printf("Ingresaste una op mult \n"); yylval.simbolo = yytext[0]; return OPM;}
{BOOLEAN}           { printf("Ingresaste un booleano \n"); return BOOL;}
{STRING}		        { printf("Ingresaste un string \n"); yylval.string = yytext; return STRING;}
";"					        { printf("putoYcoma \n"); return PC;}
                    /* Si encuentra un número lo convierte a int y devuelve el token NUMBER */
{NUMBER}            { printf("Ingresaste un numero \n"); yylval.numero = atoi(yytext); return NUMBER;}
{VAR_NAME}          { printf("Ingresaste una variable \n"); strcpy(yylval.variable,yytext); return VAR;}

[ \t]+            { } /* ignorar tabs*/
.                   {printf("error lexico \n"),yylineno; exit(1);}

%%
