# Lab 03 — JCL In-Stream Procedures

## Estado
**Completado correctamente — CC 0000.**

## Objetivo
Complementar el Lab 02 de cataloged procedures practicando una **in-stream procedure**, es decir, una PROC definida dentro del mismo job que la invoca.

## Entorno
- z/OS ADCD 1.11 sobre Hercules
- PDS: `IBMUSER.JCL.LAB`
- Miembro: `INPROC`
- Programa: `IEBGENER`
- Validación: SDSF / JESJCL

## Flujo
```text
INPROC JOB
 |
 +-- COPYONE PROC
 |    `-- STEP1 EXEC PGM=IEBGENER
 |         `-- SYSUT2 -> &OUTDSN
 |    PEND
 |
 `-- RUNPROC EXEC PROC=COPYONE
      `-- STEP1.SYSUT1 DD * -> entrada
```

## Conceptos practicados
- estructura `//nombre operación parámetros`
- `PROC` y `PEND`
- `EXEC PGM=` frente a `EXEC PROC=`
- parámetro simbólico `OUTDSN` y referencia `&OUTDSN`
- `DD *` y delimitador `/*`
- comentario `//*`
- continuación de sentencias
- DD cualificado `STEP1.SYSUT1`
- expansión de una PROC en JESJCL

## Resultado
SDSF confirmó que `COPYONE` fue expandida usando la definición in-stream. `STEP1` se ejecutó con **COND CODE 0000** y `IBMUSER.PROC.INSTREAM` quedó catalogado.

## Relación con Lab 02
| Lab 02 | Lab 03 |
|---|---|
| Cataloged PROC | In-stream PROC |
| PROC en `IBMUSER.JCL.PROCLIB` | PROC dentro del propio job |
| `JCLLIB` localiza la PROC | No necesita `JCLLIB` |
| Reutilización entre jobs | Definición local al job |
| Defaults y override | `PROC/PEND` y DD aportado por caller |

## Conclusión
Una PROC organiza JCL reutilizable; no es el programa ejecutable. En este laboratorio `COPYONE` contiene el JCL y `IEBGENER` es el programa que realiza el trabajo.

**LAB 03 CERRADO — ÉXITO.**
