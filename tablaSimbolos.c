typedef enum symbol_type {
  T_NUMBER,
  T_BOOLEAN,
  T_STRING
} SymbolType;

typedef struct variable {
  char name[50];
  SymbolType type;
} Variable;

typedef struct tabla {
  char name[50];
  variable variables[50];
} Tabla;
