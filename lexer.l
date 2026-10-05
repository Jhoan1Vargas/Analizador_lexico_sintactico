/* ==========================================================================
 * lexer.l  —  Especificacion FLEX para el Analizador Lexico (EXTENDIDO)
 *
 * Tokens reconocidos:
 *   PALABRAS RESERVADAS:
 *     - Control de flujo: if, else, while, for, do, break, continue, return
 *     - Tipos de datos: int, float, double, char, void, bool
 *   
 *   IDENTIFICADORES: [a-zA-Z_][a-zA-Z0-9_]*
 *   
 *   NUMEROS:
 *     - Enteros: [0-9]+
 *     - Decimales: [0-9]+\.[0-9]+
 *   
 *   OPERADORES:
 *     - Aritmeticos: +, -, *, /, %
 *     - Relacionales: ==, !=, <, >, <=, >=
 *     - Logicos: &&, ||, !
 *     - Asignacion: =, +=, -=, *=, /=
 *     - Incremento/Decremento: ++, --
 *   
 *   DELIMITADORES: ( ) { } [ ] ; , .
 *   
 *   COMENTARIOS: Linea (//) y bloque (slash-asterisco)
 *   
 *   Espacios/tabs/saltos: ignorados
 *   Otro caracter: ERROR_LEXICO
 * ========================================================================== */

%{
#include <stdio.h>
#include <string.h>

/* Tipo de funcion callback que recibe cada token */
typedef void (*TokenCallback)(const char* tipo,
                               const char* lexema,
                               void* user_data);

/* Variables internas para el callback */
static TokenCallback g_callback  = NULL;
static void*         g_user_data = NULL;

/* Funcion auxiliar para emitir un token */
static void emitir(const char* tipo) {
    if (g_callback)
        g_callback(tipo, yytext, g_user_data);
}
%}

/* noyywrap: no necesitamos la funcion yywrap() */
%option noyywrap

%%

    /* ═══════════════════════════════════════════════════════════════════
     *  COMENTARIOS (deben ir PRIMERO para que se ignoren antes de todo)
     * ═══════════════════════════════════════════════════════════════════ */
"//".*                  { /* Comentario de linea: ignorar */ }
"/*"([^*]|\*+[^*/])*"*"+"/"  { /* Comentario multilinea: ignorar */ }

    /* ═══════════════════════════════════════════════════════════════════
     *  PALABRAS RESERVADAS (ANTES del patron de identificadores)
     * ═══════════════════════════════════════════════════════════════════ */
    
    /* — Control de flujo — */
"if"            { emitir("PALABRA_RESERVADA"); }
"else"          { emitir("PALABRA_RESERVADA"); }
"while"         { emitir("PALABRA_RESERVADA"); }
"for"           { emitir("PALABRA_RESERVADA"); }
"do"            { emitir("PALABRA_RESERVADA"); }
"break"         { emitir("PALABRA_RESERVADA"); }
"continue"      { emitir("PALABRA_RESERVADA"); }
"return"        { emitir("PALABRA_RESERVADA"); }

    /* — Tipos de datos — */
"int"           { emitir("TIPO_DATO"); }
"float"         { emitir("TIPO_DATO"); }
"double"        { emitir("TIPO_DATO"); }
"char"          { emitir("TIPO_DATO"); }
"void"          { emitir("TIPO_DATO"); }
"bool"          { emitir("TIPO_DATO"); }

    /* — Constantes booleanas — */
"true"          { emitir("CONSTANTE_BOOLEANA"); }
"false"         { emitir("CONSTANTE_BOOLEANA"); }

    /* ═══════════════════════════════════════════════════════════════════
     *  IDENTIFICADORES Y NUMEROS
     * ═══════════════════════════════════════════════════════════════════ */
    
    /* — Identificadores: letra/_ seguido de letras/digitos/_ — */
[a-zA-Z_][a-zA-Z0-9_]*  { emitir("IDENTIFICADOR"); }

    /* — Numeros decimales (ANTES que enteros, mas especifico) — */
[0-9]+\.[0-9]+          { emitir("NUMERO_DECIMAL"); }

    /* — Numeros enteros: secuencia de digitos (0-9) — */
[0-9]+                  { emitir("NUMERO_ENTERO"); }

    /* ═══════════════════════════════════════════════════════════════════
     *  OPERADORES (los mas largos PRIMERO)
     * ═══════════════════════════════════════════════════════════════════ */
    
    /* — Operadores de Asignacion Compuesta — */
"+="            { emitir("OP_ASIG_SUMA"); }
"-="            { emitir("OP_ASIG_RESTA"); }
"*="            { emitir("OP_ASIG_MULT"); }
"/="            { emitir("OP_ASIG_DIV"); }

    /* — Operadores de Incremento/Decremento — */
"++"            { emitir("OP_INCREMENTO"); }
"--"            { emitir("OP_DECREMENTO"); }

    /* — Operadores Logicos — */
"&&"            { emitir("OP_AND"); }
"||"            { emitir("OP_OR"); }
"!"             { emitir("OP_NOT"); }

    /* — Operadores Relacionales — */
"=="            { emitir("OP_IGUALDAD"); }
"!="            { emitir("OP_DIFERENTE"); }
"<="            { emitir("OP_MENOR_IGUAL"); }
">="            { emitir("OP_MAYOR_IGUAL"); }
"<"             { emitir("OP_MENOR"); }
">"             { emitir("OP_MAYOR"); }

    /* — Operadores Aritmeticos — */
"="             { emitir("OP_ASIGNACION"); }
"+"             { emitir("OP_SUMA"); }
"-"             { emitir("OP_RESTA"); }
"*"             { emitir("OP_MULT"); }
"/"             { emitir("OP_DIV"); }
"%"             { emitir("OP_MODULO"); }

    /* ═══════════════════════════════════════════════════════════════════
     *  DELIMITADORES
     * ═══════════════════════════════════════════════════════════════════ */
"("             { emitir("PAREN_IZQ"); }
")"             { emitir("PAREN_DER"); }
"{"             { emitir("LLAVE_IZQ"); }
"}"             { emitir("LLAVE_DER"); }
"["             { emitir("CORCHETE_IZQ"); }
"]"             { emitir("CORCHETE_DER"); }
";"             { emitir("PUNTO_Y_COMA"); }
","             { emitir("COMA"); }
"."             { emitir("PUNTO"); }

    /* ═══════════════════════════════════════════════════════════════════
     *  ESPACIOS EN BLANCO Y ERRORES
     * ═══════════════════════════════════════════════════════════════════ */
    
    /* — Espacios en blanco, tabulaciones y saltos de linea: ignorados — */
[ \t\n\r]+      { /* ignorar */ }

    /* — Cualquier otro caracter: error lexico — */
.               { emitir("ERROR_LEXICO"); }

%%

/*
 * analizar_cadena()
 *
 * Funcion publica llamada desde main.c.
 * Recibe el texto del editor y lo analiza lexicamente,
 * invocando 'callback' por cada token encontrado.
 */
void analizar_cadena(const char*   entrada,
                     TokenCallback callback,
                     void*         user_data)
{
    g_callback  = callback;
    g_user_data = user_data;

    /* yy_scan_string crea un buffer temporal con la cadena */
    YY_BUFFER_STATE buf = yy_scan_string(entrada);
    yylex();              /* ejecutar el analizador */
    yy_delete_buffer(buf); /* liberar el buffer */
}
