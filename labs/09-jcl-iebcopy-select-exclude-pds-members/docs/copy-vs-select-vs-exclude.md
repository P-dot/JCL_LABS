# COPY vs SELECT vs EXCLUDE

## COPY
Establece la copia entre las DD de entrada y salida.

    COPY OUTDD=SYSUT2,INDD=SYSUT1

## SELECT
Es apropiado cuando solo interesa una parte concreta de la biblioteca.

    SELECT MEMBER=(SELONE,SELTWO)

En la ejecución del lab, el PDS SELECT terminó únicamente con esos dos miembros.

## EXCLUDE
Es apropiado cuando interesa copiar el conjunto salvo excepciones concretas.

    EXCLUDE MEMBER=(EXCLTEST,MEMBER1)

En la ejecución del lab, el destino terminó con FROMPS, SELONE y SELTWO.

## Diferencia con PDS(MEMBER)
`DSN=PDS(MEMBER)` selecciona un miembro en la propia definición DD. En este lab
se entrega el PDS a IEBCOPY y la selección se expresa mediante sus control
statements en SYSIN.
