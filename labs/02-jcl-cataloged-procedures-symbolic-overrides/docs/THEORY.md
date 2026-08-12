# Teoría resumida

## JOB

Define el trabajo batch completo y sus atributos para JES.

## EXEC

`EXEC PGM=` ejecuta directamente un programa.

`EXEC PROC=` invoca una procedure JCL.

## DD

Una DD conecta un **ddname** usado por el programa con un dataset o recurso concreto para esa ejecución.

## Cataloged procedure

Es JCL reutilizable almacenado como miembro de una procedure library. En este lab:

```text
IBMUSER.JCL.PROCLIB(COPYPROC)
```

## JCLLIB

`JCLLIB ORDER=` incluye una librería privada en el orden de búsqueda de procedures para el job.

## Parámetros simbólicos

Los símbolos `&INDSN` y `&OUTDSN` permiten sustituir valores en la PROC. Los valores declarados en `PROC` actúan como defaults.

## Override

El caller puede sustituir un default al ejecutar la PROC sin editar la procedure central.

## JESJCL

Permite observar el JCL procesado/expandido por JES, incluyendo el contenido de la PROC y la sustitución efectiva de símbolos.
