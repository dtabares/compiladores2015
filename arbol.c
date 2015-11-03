#include <stdio.h>
#include <stdlib.h>


struct nodoArbol {
  char valor[255];
  struct nodoArbol *ptrIzq;
  struct nodoArbol *prtDer;
};
typedef struct nodoArbol NodoArbol; /* sinónimo de la estructura nodoArbol */
typedef NodoArbol *ptrNodoArbol; /* sinónimo de NodoArbol* */


/* prototipos */
void insertaNodo(ptrNodoArbol *ptrArbol, char valor[255]);

void inicializarArbol();

/* inserta un nodo dentro del árbol */
void insertaNodo( ptrNodoArbol *ptrArbol, char valor[255] ) {
 /* si el árbol está vacío */
 if (*ptrArbol == NULL) {
 *ptrArbol = malloc(sizeof(NodoArbol));

 /* si la memoria está asignada, entonces asigna el dato */
 if (*ptrArbol != NULL) {

 strcpy((*ptrArbol)->valor,valor);
 (*ptrArbol)->ptrIzq = NULL;
 (*ptrArbol)->prtDer = NULL;
 } else {
 printf("no se inserto %s. No hay memoria disponible.n", valor);
 }
 } else {
 /* el dato a insertar es menor que el dato en el nodo actual */
 if (valor < (*ptrArbol)->valor) {
 insertaNodo(&((*ptrArbol)->ptrIzq), valor);
 } else if (valor > (*ptrArbol)->valor) {
 insertaNodo(&((*ptrArbol)->prtDer), valor);
 } else {
 printf("dup");
 }
 }
}

void inicializarArbol(){
  ptrNodoArbol ptrRaiz = NULL; /* árbol inicialemnte vacío */
}
