# Lab 09 — Selective PDS Member Operations with IEBCOPY

## Estado
**COMPLETED — PASS**

## Objetivo
Aprender a controlar qué miembros de un PDS participan en una copia con IEBCOPY,
continuando el trabajo PDS→PDS realizado en el Lab 08.

## Entorno de trabajo
PDS origen:

`IBMUSER.JCLLAB07.PDS`

Miembros usados en la práctica:

- EXCLTEST
- FROMPS
- MEMBER1
- SELONE
- SELTWO

## Fase 1 — Preparación
Se añadieron SELONE, SELTWO y EXCLTEST mediante IEBGENER para disponer de un
origen suficientemente amplio para comparar operaciones selectivas.

## Fase 2 — SELECT
Destino:

`IBMUSER.JCLLAB09.SELECT`

Control IEBCOPY:

    COPY OUTDD=SYSUT2,INDD=SYSUT1
    SELECT MEMBER=(SELONE,SELTWO)

Resultado validado: el destino contiene únicamente SELONE y SELTWO. SYSPRINT
confirma que los miembros seleccionados fueron copiados satisfactoriamente y que
2 de 2 miembros fueron copiados.

## Fase 3 — EXCLUDE
Destino:

`IBMUSER.JCLLAB09.EXCLUDE`

Control IEBCOPY:

    COPY OUTDD=SYSUT2,INDD=SYSUT1
    EXCLUDE MEMBER=(EXCLTEST,MEMBER1)

Resultado validado: EXCLTEST y MEMBER1 quedan fuera; el destino contiene FROMPS,
SELONE y SELTWO.

## COPY vs SELECT vs EXCLUDE
- COPY: copia el conjunto indicado.
- SELECT: limita la operación a los miembros nombrados.
- EXCLUDE: procesa el conjunto excepto los miembros nombrados.

## Validación
No se utiliza CC 0000 como única prueba. El laboratorio conserva:
- JCL ejecutado.
- SDSF con condition codes.
- SYSPRINT de IEBCOPY.
- Listas de miembros de origen y destino.

## Resultado final
**LAB 09 COMPLETED — PASS**
