# Teoría y sintaxis

## Sentencia JCL
Forma básica: `//nombre operación parámetros`.

Ejemplo: `//STEP1 EXEC PGM=IEBGENER`
- `STEP1`: nombre del step.
- `EXEC`: operación.
- `PGM=IEBGENER`: programa que se ejecutará.

## PROC / PEND
`PROC` inicia una procedure. `PEND` termina una in-stream procedure.

## EXEC PGM / EXEC PROC
`EXEC PGM=` ejecuta un programa.
`EXEC PROC=` invoca una procedure.

## Símbolos
`OUTDSN=IBMUSER.PROC.INSTREAM` define un valor.
`&OUTDSN` referencia ese valor dentro de la PROC.

## DD cualificado
`STEP1.SYSUT1` identifica el DD `SYSUT1` del step interno `STEP1`.

## Datos in-stream
`DD *` indica que los registros siguientes son datos de entrada. `/*` marca su final.

## Continuación
Varias líneas físicas pueden formar una única sentencia JCL cuando continúa su lista de parámetros.
