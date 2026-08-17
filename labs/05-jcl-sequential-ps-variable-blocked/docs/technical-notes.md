# Technical Notes — Variable Blocked Records

## Record vs block

En z/OS conviene separar siempre dos conceptos:

- **record:** entidad lógica que consume una aplicación.
- **block:** unidad física utilizada para operaciones de E/S.

Para `RECFM=VB`, el bloque puede contener varios registros variables.

## DCB del laboratorio

```text
DSORG  = PS
RECFM  = VB
LRECL  = 80
BLKSIZE= 0  -> z/OS seleccionó 27998
```

## RDW

Cada registro variable contiene un RDW de cuatro bytes. Los primeros dos bytes almacenan la longitud del registro en binario. Los datos comienzan después del RDW.

Con `LRECL=80`:

```text
80 bytes máximo total
-4 bytes RDW
-----------------
76 bytes máximo de datos
```

## BDW

En formatos bloqueados variables existe además un BDW de cuatro bytes a nivel de bloque. No debe confundirse con el RDW del registro.

## Relación con aplicaciones

VB resulta útil cuando la longitud de los registros varía. Al procesar este formato con COBOL, DFSORT u otras utilidades, hay que respetar la estructura variable y recordar que el layout físico/lógico no es el mismo que en FB.

## Por qué `RC=0000` no basta

El condition code demuestra que el step terminó correctamente. La validación completa exige verificar el recurso persistente creado. En este laboratorio se comprobó el catálogo y los atributos reales en ISPF.
