%option noyywrap
%option yylineno

Ops_Aritmeticas "+"|"-"|"*"|"/"
Ops_Logicas "no"|"y"|"o"|"mayor_a"|"menor_a"|"igual_a"|"menor_igual_a"|"mayor_igual_a"
NUMBER [0-9]+
STRING ["]{1}.{2,255}["]{1}
BOOLEAN "verdadero"|"falso"
VAR_NAME [a-zA-Z][a-zA-Z0-9]*


%%
"Inicio"            { printf("INICIO \n"); }
"Fin"			          { printf("FIN \n"); }
"leer"              { printf("LEER \n"); }
"mostrar"           { printf("MOSTRAR \n"); }
"("                 { printf("PI \n"); }
")"                 { printf("PD \n"); }
"guardar_en"	      { printf("GE \n"); }
"{"                 { printf("LI \n"); }
"}"                 { printf("LD \n"); }
"mientras_que"	    { printf("MQ \n"); }
"hacer"			        { printf("HACER \n"); }
"fin"			          { printf("FIN \n"); }
"si"			          { printf("SI \n"); }
"entonces"		      { printf("ENTONCES \n"); }
"sino"			        { printf("SINO \n"); }
"sumar_uno"		      { printf("SU \n"); }
"restar_uno"	      { printf("RU \n"); }
"es"			          { printf("ES \n"); }
{Ops_Aritmeticas}   { printf("Ingresaste una op aritmetica \n"); }
{BOOLEAN}           { printf("Ingresaste un booleano \n"); }
{STRING}		        { printf("Ingresaste un string \n"); }
{NUMBER}            { printf("Ingresaste un numero \n"); }
{Ops_Logicas}       { printf("Ingresaste una op logica \n"); }
{VAR_NAME}          { printf("Ingresaste una variable \n"); }

[ \t\n]+            { } /* ignorar enters y tabs*/
.                   {printf("error lexico \n");}


%%
void main() {
 yylex();
}
