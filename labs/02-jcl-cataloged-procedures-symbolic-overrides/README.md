# Lab 02 — JCL Cataloged Procedures, JCLLIB and Symbolic Overrides

> **Academy level:** Foundation · **Evidence:** VALIDATED · **Primary subsystem:** JES2 / JCL
>
> [← JCL course](../../README.md) · [Guided evidence →](evidence/README.md) · [Academy](https://github.com/P-dot/P-dot/blob/main/docs/ACADEMY.md)

## Status

**Validated successfully.**

This lab reproduces en z/OS ADCD 1.11 el uso de una **cataloged procedure** JCL, a private procedure library through `JCLLIB`, symbolic parameters defined in `PROC` and an override from the calling JCL.

## Environment

- Platform: z/OS ADCD 1.11 sobre Hercules
- User: `IBMUSER`
- Job PDS: `IBMUSER.JCL.LAB`
- Procedure PDS: `IBMUSER.JCL.PROCLIB`
- Procedure created: `IBMUSER.JCL.PROCLIB(COPYPROC)`
- Utility executed: `IEBGENER`
- Validation: SDSF / JESJCL / step output / ISPF 3.4

## Objective

Demonstrate the flow:

```text
JOB -> JCLLIB -> EXEC PROC= -> cataloged PROC -> EXEC PGM=IEBGENER
```

and verify how JES expands the PROC and substitutes symbolic parameters.

## Desarrollo

### 1. Creación de la procedure

Se creó `IBMUSER.JCL.PROCLIB(COPYPROC)` con dos parámetros simbólicos:

```text
INDSN
OUTDSN
```

Defaults:

```text
INDSN=IBMUSER.PROC.INPUT
OUTDSN=IBMUSER.PROC.OUTPUT
```

La procedure ejecuta `IEBGENER` y conecta:

```text
SYSUT1 -> &INDSN
SYSUT2 -> &OUTDSN
```

### 2. Preparación del dataset de entrada

Se creó `IBMUSER.JCL.LAB(MKINPUT)` para generar:

```text
IBMUSER.PROC.INPUT
```

Resultado observado:

```text
CC 0000
```

### 3. Llamada usando valores por defecto

Se creó `IBMUSER.JCL.LAB(CALLPROC)`:

```jcl
//MYLIB   JCLLIB ORDER=IBMUSER.JCL.PROCLIB
//RUNPROC EXEC PROC=COPYPROC
```

Al no especificarse parámetros, se usaron los defaults de `COPYPROC`.

Resultado:

```text
IBMUSER.PROC.INPUT
        |
        v
    IEBGENER
        |
        v
IBMUSER.PROC.OUTPUT
```

El step terminó con `COND CODE 0000` y `IBMUSER.PROC.OUTPUT` quedó catalogado.

### 4. Validación de expansión en JESJCL

La salida JESJCL mostró la expansión de `COPYPROC`, permitiendo observar el JCL efectivo generado a partir de la procedure.

### 5. Override de parámetro simbólico

Se creó `IBMUSER.JCL.LAB(CALLPRC2)` y se sustituyó únicamente `OUTDSN`:

```jcl
//RUNPROC EXEC PROC=COPYPROC,
//            OUTDSN=IBMUSER.PROC.OUTPUT2
```

`INDSN` mantuvo el valor por defecto y `OUTDSN` tomó el valor suministrado por el caller.

Resultado:

```text
IBMUSER.PROC.INPUT
        |
        v
    IEBGENER
        |
        v
IBMUSER.PROC.OUTPUT2
```

El step terminó con `COND CODE 0000` y el segundo dataset quedó catalogado.

## Conceptos JCL consolidados

- `JOB`
- `EXEC PGM=`
- `EXEC PROC=`
- `DD`
- ddname frente a DSNAME
- `SYSUT1`, `SYSUT2`, `SYSIN`, `SYSPRINT`
- `SYSOUT=*`
- datos in-stream con `DD *`
- `DISP=(NEW,CATLG,DELETE)`
- `DISP=SHR`
- `JCLLIB ORDER=`
- cataloged procedures
- parámetros simbólicos en `PROC`
- valores por defecto
- symbolic parameter override
- expansión de procedure en JESJCL

## Resultado técnico

| Validación | Resultado |
|---|---|
| `COPYPROC` creada en `IBMUSER.JCL.PROCLIB` | Correcto |
| `MKINPUT` genera dataset de entrada | CC 0000 |
| `CALLPROC` usa defaults de la PROC | CC 0000 |
| `IBMUSER.PROC.OUTPUT` catalogado | Correcto |
| JESJCL muestra expansión de la PROC | Correcto |
| `CALLPRC2` sobrescribe `OUTDSN` | Correcto |
| `IBMUSER.PROC.OUTPUT2` catalogado | Correcto |

## Conclusión

El laboratorio demuestra cómo desacoplar JCL repetitivo mediante una cataloged procedure y cómo parametrizarla para reutilizar el mismo procedimiento con diferentes datasets sin modificar la definición central.

**LAB CERRADO — ÉXITO.**
