#include <stdio.h>
#include <string.h>

typedef enum symbol_type {
  T_NUMBER,
  T_BOOLEAN,
  T_STRING
} SymbolType;

typedef struct variable {
  char nombre[255];
  SymbolType tipo;
} Variable;

typedef struct tabla {
  Variable variables[50];
} Tabla;

/*https://en.wikipedia.org/wiki/C_dynamic_memory_allocation*/

/*Variables Globales*/
Tabla *tablaDeSimbolos;

/*Definicion de funciones*/
Tabla crear();
void insertar(char nombre[255],char tipo);
void remover(char nombre[255]);
char getTipo(char nombre[255]);
int existe(char nombre[255]);


/*Implementacion de funciones*/

/* Crea una tabla de signos y reserva espacio en memoria*/
Tabla crear(){
     
     tablaDeSimbolos = malloc(sizeof (Tabla));
     return *tablaDeSimbolos;
     
}
     
void insertar(char nombre[255],char tipo){

     if (existe(nombre)==0){
      
         int i = 0;
         Variable *variable = malloc(sizeof (Variable));
      // strcpy(*variable.nombre,nombre);
      //   variable.tipo = tipo;
         
         for (i; i<50; i++){
         
         /*
             if (tablaDeSimbolos.variables[i].nombre==NULL){
                                                     
             tablaDeSimbolos.variables[i] = *variable;
             
             }
         */    
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
      
      //Recorrer vector y devolver tipo                                    
                                                 
     }
     
}

int existe(char nombre[255]){
        
       int i=0; 
        
       for (i; i<50; i++){
           
         /*  if (strncmp(tablaDeSimbolos.variables[i].nombre, nombre, 255)==0){
                                                 
           return 1;
           
           }
          */ 
       }
       
       return 0;
        
}

main(){
       
       
}
