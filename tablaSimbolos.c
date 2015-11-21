#include <stdio.h>
#include <string.h>

typedef struct variable {
  char nombre[255];
  char tipo;
} Variable;

typedef struct tabla {
  Variable * variables[50];
} Tabla;

/*https://en.wikipedia.org/wiki/C_dynamic_memory_allocation*/

Tabla tablaDeSimbolos;

/*Definicion de funciones*/
void crear();
void insertar(char nombre[255],char tipo);
void remover(char nombre[255]);
char getTipo(char nombre[255]);
int existe(char nombre[255]);
void imprimir();

/*Implementacion de funciones*/

/* Crea una tabla de signos y reserva espacio en memoria*/
void crear(){
      printf("%s\n", "LOG: creando Tabla de Simbolos");
      int i=0;
      for (i; i<50; i++){

        tablaDeSimbolos.variables[i] = NULL;

      }

    //  return tablaDeSimbolos;

}

void insertar(char nombre[255],char tipo){
      printf("%s\n", "LOG: insertando variable en Tabla de Simbolos");
     if (existe(nombre)==0){

             Variable * temp;
             temp = malloc(sizeof(Variable));
             strcpy(temp->nombre,nombre);
             temp->tipo = tipo;

             int i = 0;
             for (i; i<50; i++){

                 if (tablaDeSimbolos.variables[i] == NULL){

                     tablaDeSimbolos.variables[i] = temp;
             }
         }
     }
}

void remover(char nombre[255]){

     if (existe(nombre)==1){

      /*Remover*/

     }

}


char getTipo(char nombre[255]){

     if (existe(nombre)==1){

        int i=0;

        for (i; i<50; i++){

           if (tablaDeSimbolos.variables[i]!=NULL && strcmp(tablaDeSimbolos.variables[i]->nombre, nombre)==0){

             return tablaDeSimbolos.variables[i]->tipo;

            }


        }
     }

     return 'u';
}

int existe(char nombre[255]){

       int i=0;

       for (i; i<50; i++){

         if (tablaDeSimbolos.variables[i]!=NULL){

             if (strcmp(tablaDeSimbolos.variables[i]->nombre, nombre)==0){

               return 1;

               }

         }
       }

       return 0;

}

void imprimir(){

	 printf("LOG: Imprmiendo tabla de simbolos \n");
     int i=0;
     for (i;i<50;i++){

         if (tablaDeSimbolos.variables[i]!=NULL){
            printf("Tabla de simbolos en posicion %d | nombre: %s | tipo: %c \n",i,tablaDeSimbolos.variables[i]->nombre, getTipo(tablaDeSimbolos.variables[i]->nombre));
            }
     }

}
