%option noyywrap
%option yylineno


%{
#include "analizador_sintactico.tab.h"
}%

Ops_Suma "+"|"-"
Ops_Mult "*"|"/"
Ops_Logicas "no"|"y"|"o"|"mayor_a"|"menor_a"|"igual_a"|"menor_igual_a"|"mayor_igual_a"
NUMBER [0-9]+
STRING ["]{1}.{2,255}["]{1}
BOOLEAN "verdadero"|"falso"
VAR_NAME [a-zA-Z][a-zA-Z0-9]*


%%
"Inicio"            { printf("INICIO \n"); return INICIO }
"Fin"			          { printf("FIN \n"); return FIN}
"leer"              { printf("LEER \n"); return LEER}
"mostrar"           { printf("MOSTRAR \n"); return MOSTRAR}
"("                 { printf("PI \n"); return PI}
")"                 { printf("PD \n"); return PD}
"guardar_en"	      { printf("GE \n"); return GE}
"{"                 { printf("LI \n"); return LI}
"}"                 { printf("LD \n"); return LD}
"mientras_que"	    { printf("MQ \n"); return MQ}
"hacer"			        { printf("HACER \n"); return HACER}
"fin"			          { printf("FIN \n"); return OTROFIN} /* que era este fin?*/
"si"			          { printf("SI \n"); return SI}
"entonces"		      { printf("ENTONCES \n"); return ENTONCES}
"sino"			        { printf("SINO \n"); return SINO}
"sumar_uno"		      { printf("SU \n"); return SU}
"restar_uno"	      { printf("RU \n"); return SU}
"es"			          { printf("ES \n"); return ES}
{Ops_Suma}          { printf("Ingresaste una op suma \n"); yylval.sym = yytext[0]; return OPS}
{Ops_Mult}          { printf("Ingresaste una op mult \n"); yylval.sym = yytext[0]; return OPM}
{BOOLEAN}           { printf("Ingresaste un booleano \n"); }
{STRING}		        { printf("Ingresaste un string \n"); }
{NUMBER}            { printf("Ingresaste un numero \n"); yyval.numero = atoi(yytext); return(NUMBER);}
{Ops_Logicas}       { printf("Ingresaste una op logica \n"); }
{VAR_NAME}          { printf("Ingresaste una variable \n"); }

[ \t\n]+            { } /* ignorar enters y tabs*/
.                   {printf("error lexico \n"),yylineno; exit(1);}


%%
