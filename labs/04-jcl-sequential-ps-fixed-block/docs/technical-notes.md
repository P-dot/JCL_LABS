# Technical Notes — Lab 04

## PS frente a PDS

`DSORG=PS` define un data set secuencial. No contiene miembros como un PDS/PDSE.

## Fixed Blocked

`RECFM=FB` combina registros de longitud fija con bloqueo físico de E/S.

## LRECL frente a BLKSIZE

- `LRECL=80`: longitud de cada registro lógico.
- `BLKSIZE=27920`: tamaño del bloque físico seleccionado por el sistema en esta ejecución.

## Por qué `BLKSIZE=0`

El cero no representa un bloque vacío. Solicita que el sistema seleccione un valor apropiado.

## DISP

```text
NEW -> allocation -> normal completion -> CATLG
                  -> abnormal completion -> DELETE
```

## IEFBR14

El punto importante es no afirmar que `IEFBR14` “escribe” el data set. La asignación se deriva del procesamiento de las DD y sus parámetros.
