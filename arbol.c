#include <stdio.h>
#include <stdlib.h>

typedef struct nodoArbol {
  char valor[255];
  struct nodoArbol *ptrIzq;
  struct nodoArbol *prtDer;
} NodoArbol;

typedef NodoArbol *ptrNodoArbol; /* Puntero a NodoArbol* */

/* prototipos */
ptrNodoArbol insertarNodo(char valor[255], ptrNodoArbol *ptrArbolIzq, ptrNodoArbol *ptrArbolDer);
ptrNodoArbol insertarHoja(char valor[255]);
void inicializarArbol();

/*Variables*/
ptrNodoArbol ptrRaiz;

/* inserta un nodo dentro del Arbol */
ptrNodoArbol insertarNodo( char valor[255], ptrNodoArbol *ptrArbolIzq, ptrNodoArbol *ptrArbolDer ) {

    /*Crea el nodo que va a devolver*/
    ptrNodoArbol ptrNodo;
    ptrNodo = malloc(sizeof(NodoArbol));
    
    /*Asigno los parametros*/
    strcpy((ptrNodo)->valor,valor);
    (ptrNodo)->ptrIzq = *ptrArbolIzq;
    (ptrNodo)->prtDer = *ptrArbolDer;
    
    return ptrNodo;

}

ptrNodoArbol insertarHoja(char valor[255]){
  /*Crea el nodo que va a devolver*/
  ptrNodoArbol ptrNodo;
  ptrNodo = malloc(sizeof(NodoArbol));

  /*Asigno los parametros*/
  strcpy((ptrNodo)->valor,valor);
  (ptrNodo)->ptrIzq = NULL;
  (ptrNodo)->prtDer = NULL;

  return ptrNodo;
}
void inicializarArbol(){
  ptrRaiz = NULL; /* árbol inicialemnte vacío */
}
