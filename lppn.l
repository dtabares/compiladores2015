%option noyywrap
%option yylineno


%{
#include "analizador_sintactico.tab.h"
%}

Ops_Suma "+"|"-"
Ops_Mult "*"|"/"
Ops_Logicas "no"|"y"|"o"|"mayor_a"|"menor_a"|"igual_a"|"menor_igual_a"|"mayor_igual_a"
NUMBER [0-9]+
STRING ["]{1}.{2,255}["]{1}
BOOLEAN "verdadero"|"falso"
VAR_NAME [a-zA-Z][a-zA-Z0-9]*


%%
"Inicio"            { printf("INICIO \n"); return INICIO; }
"Fin"			          { printf("FIN \n"); return FIN;}
"leer"              { printf("LEER \n"); return LEER;}
"mostrar"           { printf("MOSTRAR \n"); return MOSTRAR;}
"("                 { printf("PI \n"); return PI;}
")"                 { printf("PD \n"); return PD;}
"guardar_en"	      { printf("GE \n"); return GE;}
"{"                 { printf("LI \n"); return LI;}
"}"                 { printf("LD \n"); return LD;}
"mientras_que"	    { printf("MQ \n"); return MQ;}
"hacer"			        { printf("HACER \n"); return HACER;}
"fin"			          { printf("FIN \n"); return OTROFIN;} /* que era este fin?*/
"si"			          { printf("SI \n"); return SI;}
"entonces"		      { printf("ENTONCES \n"); return ENTONCES;}
"sino"			        { printf("SINO \n"); return SINO;}
"sumar_uno"		      { printf("SU \n"); return SU;}
"restar_uno"	      { printf("RU \n"); return RU;}
"es"			          { printf("ES \n"); return ES;}
{Ops_Suma}          { printf("Ingresaste una op suma \n"); yylval.simbolo = yytext[0]; return OPS;}
{Ops_Mult}          { printf("Ingresaste una op mult \n"); yylval.simbolo = yytext[0]; return OPM;}
{BOOLEAN}           { printf("Ingresaste un booleano \n"); return BOOL;}
{STRING}		        { printf("Ingresaste un string \n"); yylval.string ; return STRING;}
{NUMBER}            { printf("Ingresaste un numero \n"); yylval.numero = atoi(yytext); return NUMBER;}
{Ops_Logicas}       { printf("Ingresaste una op logica \n"); return OPSL;}
{VAR_NAME}          { printf("Ingresaste una variable \n"); yylval.variable; return VAR;}

[ \t\n]+            { } /* ignorar enters y tabs*/
.                   {printf("error lexico \n"),yylineno; exit(1);}

%%
