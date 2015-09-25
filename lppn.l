%option noyywrap
%option yylineno
Ops_Aritmeticas "+"|"-"|"*"|"/"
Ops_Logicas "no"|"y"|"o"|"mayor_a"|"menor_a"|"igual_a"|"menor_igual_a"|"mayor_igual_a"
/* NUMBER "0"|(-)?[1-9][0-9]*(\.[0-9]+)? */
NUMBER [0-9]+
STRING \"[^\"]*["]
BOOLEAN "verdadero"|"falso"
VAR_NAME [a-zA-Z][a-zA-Z0-9]*
%%
"Inicio"		{ return INICIO; }
"Fin"			{ return FIN; }
"leer"			{ return LEER; }
"mostrar"		{ return MOSTRAR; }
"("			{ return PD; }
")"			{ return PI; }
"guardar_en"		{ return GE; }
"{"			{ return LI; }
"}"			{ return LD; }
"mientras_que"		{ return MQ; }
"hacer"			{ return HACER; }
"fin"			{ return FIN; }
"si"			{ return SI; }
"entonces"		{ return ENTONCES; }
"sino"			{ return SINO; }
"sumar_uno"		{ return SU; }
"restar_uno"		{ return RU; }
"es"			{ return ES; }
%%
void main() {
 yylex();
}
