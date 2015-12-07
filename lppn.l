%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "estructuraArbol.h"
#include "analizador_sintactico.tab.h"
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
"Inicio"            { return INICIO; }
"Fin"			          { return FIN;}
"leer"              { return LEER;}
"mostrar"           { return MOSTRAR;}
"("                 { return PI;}
")"                 { return PD;}
"guardar_en"	      { return ASIG;}
"{"                 { return LI;}
"}"                 { return LD;}
"mientras_que"	    { return MQ;}
"hacer"			        { return HACER;}
"si"			          { return SI;}
"entonces"		      { return ENTONCES;}
"sino"			        { return SINO;}
"sumar_uno"		      { return SU;}
"restar_uno"	      { return RU;}
"es"			          { return ES;}
{Ops_Logicas}       { yylval.tipoDeDato.simbolo = 'b'; yylval.tipoDeDato.texto = strdup(yytext); return OPS;}
{Ops_Suma}          { yylval.tipoDeDato.simbolo = strdup(yytext)[0]; yylval.tipoDeDato.texto = strdup(yytext); return OPS;}
{Ops_Mult}          { yylval.tipoDeDato.texto = strdup(yytext); yylval.tipoDeDato.simbolo = yytext[0] ;return OPS;}
{BOOLEAN}           { yylval.string = strdup(yytext);return BOOL;}
{STRING}		        { yylval.string = strdup(yytext);return STRING;}
";"					        { return PC;}
                    /* Si encuentra un número lo convierte a int y devuelve el token NUMBER */
{NUMBER}            { yylval.numero = atoi(yytext); return NUMBER;}
{VAR_NAME}          { strcpy(yylval.variable,yytext); return VAR;}

[ \t]+            { } /* ignorar tabs*/
.                   {printf("error lexico \n"),yylineno; exit(1);}

%%
