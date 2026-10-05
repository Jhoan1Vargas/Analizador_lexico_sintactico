# Analizador Léxico y Sintáctico

Compilador completo con interfaz gráfica GTK3 implementado en C con FLEX.

## Características

- **Análisis Léxico**: Reconoce 50+ tipos de tokens
- **Análisis Sintáctico**: Parser recursivo descendente
- **AST**: Construcción de Árbol de Sintaxis Abstracta
- **Interfaz Gráfica**: 3 paneles (Editor, Tokens, AST)
- **Detección de Errores**: Errores léxicos y sintácticos

## Tokens Soportados

### Palabras Reservadas
`if`, `else`, `while`, `for`, `do`, `break`, `continue`, `return`

### Tipos de Datos
`int`, `float`, `double`, `char`, `void`, `bool`

### Operadores
- Aritméticos: `+`, `-`, `*`, `/`, `%`
- Relacionales: `==`, `!=`, `<`, `>`, `<=`, `>=`
- Lógicos: `&&`, `||`, `!`
- Asignación: `=`, `+=`, `-=`, `*=`, `/=`
- Incremento: `++`, `--`

### Otros
- Números enteros y decimales
- Identificadores
- Comentarios (`//` y `/* */`)
- Delimitadores: `( ) { } [ ] ; , .`

## Compilación

```bash
make clean
make
```

## Ejecución

```bash
./analizador.exe
```

## Uso

1. Escribe código en el panel izquierdo
2. Presiona ">> Analizar"
3. Observa los tokens reconocidos (panel central)
4. Observa el AST generado (panel derecho)

## Ejemplos

Ver archivo `ejemplos_codigo.txt` para ejemplos de código.

## Archivos

- `lexer.l` - Especificación FLEX del lexer
- `parser.h/c` - Analizador sintáctico
- `main.c` - Interfaz gráfica GTK3
- `Makefile` - Compilación
- `analizador.exe` - Ejecutable

---

**Tecnologías**: FLEX 2.6, GCC, GTK3, C99
