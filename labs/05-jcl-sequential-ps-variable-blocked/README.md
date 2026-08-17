# Lab 05 — Sequential PS Data Set with Variable Blocked Records

**Estado:** COMPLETADO — PASS  
**Plataforma:** IBM z/OS ADCD 1.11 sobre Hercules  
**Job:** `CRTVB`  
**Step:** `CREATE`  
**Programa:** `IEFBR14`  
**Data set:** `IBMUSER.JCLLAB05.VB`

## Objetivo

Crear mediante JCL un **Physical Sequential Data Set (PS)** con formato de registro **Variable Blocked (VB)**, dejar que z/OS seleccione el tamaño de bloque mediante `BLKSIZE=0`, catalogar el data set al finalizar correctamente y validar el resultado real desde JES2/SDSF e ISPF.

Este laboratorio continúa directamente el Lab 04 de `RECFM=FB`. La diferencia fundamental es que ahora cada registro lógico puede tener una longitud distinta.

## JCL ejecutado

```jcl
//CRTVB    JOB (ACCT),'CREATE VB PS',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//***************************************************************
//* LAB 05 - CREATE SEQUENTIAL PS DATA SET
//* RECORD FORMAT : VB
//* MAX LRECL    : 80
//***************************************************************
//*
//CREATE   EXEC PGM=IEFBR14
//VBFILE   DD DSN=IBMUSER.JCLLAB05.VB,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=VB,LRECL=80,BLKSIZE=0)
```

## Qué hace realmente el JCL

```text
JOB CRTVB
   |
   +-- JES2 recibe y planifica el trabajo
   |
   +-- CREATE EXEC PGM=IEFBR14
   |      |
   |      `-- programa mínimo; la operación importante es la allocation
   |
   `-- VBFILE DD
          |
          +-- DSN=IBMUSER.JCLLAB05.VB
          +-- DISP=(NEW,CATLG,DELETE)
          +-- SPACE=(TRK,(1,1))
          `-- DCB=(DSORG=PS,RECFM=VB,LRECL=80,BLKSIZE=0)
```

`IEFBR14` no escribe los registros del fichero. El efecto principal se produce cuando z/OS procesa la sentencia DD, asigna el data set y aplica su disposición.

## Explicación de los parámetros

### `DSORG=PS`

El data set es **Physical Sequential**. No contiene miembros como un PDS/PDSE; sus registros forman una secuencia.

### `RECFM=VB`

`VB` significa **Variable Blocked**:

- `V`: los registros lógicos pueden tener longitudes distintas.
- `B`: varios registros pueden agruparse dentro de un bloque físico de E/S.

### `LRECL=80`

En un data set VB, `LRECL` no significa que todos los registros midan 80 bytes. Significa que **80 es la longitud lógica máxima del registro**, incluyendo el RDW.

Un registro VB tiene un **Record Descriptor Word (RDW) de 4 bytes** delante de los datos:

```text
Registro VB
+----------------+--------------------------------------+
| RDW (4 bytes)  | datos de longitud variable          |
+----------------+--------------------------------------+
  posiciones 1-4   datos desde la posición 5
```

Por tanto, con `LRECL=80`, la parte de datos puede ocupar como máximo **76 bytes**.

### RDW y BDW

No deben confundirse:

- **RDW (Record Descriptor Word):** describe la longitud de un registro variable.
- **BDW (Block Descriptor Word):** describe el bloque que agrupa registros variables.

Conceptualmente:

```text
BLOQUE VB
|
+-- BDW
|
+-- RDW + registro 1
+-- RDW + registro 2
+-- RDW + registro 3
`-- ...
```

### `BLKSIZE=0`

No significa un bloque de cero bytes. Indica que el sistema puede seleccionar un tamaño de bloque apropiado.

En esta ejecución, ISPF mostró:

```text
BLKSIZE = 27998
```

### `DISP=(NEW,CATLG,DELETE)`

```text
NEW
 |
 v
allocation
 /      \
normal  abnormal
 |         |
CATLG     DELETE
```

- `NEW`: el data set debe crearse.
- `CATLG`: si la ejecución termina normalmente, queda catalogado.
- `DELETE`: si la creación falla, se elimina la asignación nueva.

### `SPACE=(TRK,(1,1))`

Solicita una asignación primaria de 1 track y secundaria de 1 track.

## Evidencia real

### 1. Source JCL

`evidence/01_createvb_jcl_source.png`

Demuestra el miembro `CREATEVB` con `RECFM=VB`, `LRECL=80` y `BLKSIZE=0`.

### 2. JES2 / SDSF Job Log

`evidence/02_sdsf_joblog_allocation.png`

Demuestra que el job `CRTVB` fue ejecutado por JES2 y que `VBFILE` fue asignado.

### 3. Condition Code y catalogación

`evidence/03_sdsf_rc0000_cataloged.png`

Mensajes determinantes:

```text
IEF142I CRTVB CREATE - STEP WAS EXECUTED - COND CODE 0000
IEF285I IBMUSER.JCLLAB05.VB CATALOGED
```

Esto demuestra tanto la finalización normal como la catalogación del data set.

### 4. Estado persistente del data set

`evidence/04_dataset_info_ps_vb_lrecl80_blksize27998.png`

ISPF Data Set Information confirma:

| Atributo | Valor observado |
|---|---:|
| Data Set Name | `IBMUSER.JCLLAB05.VB` |
| Organization | `PS` |
| Record format | `VB` |
| Record length | `80` |
| Block size | `27998` |
| Allocated tracks | `1` |
| Used tracks | `0` |

`Used tracks = 0` es coherente: el laboratorio crea y cataloga el data set, pero no carga registros de aplicación.

## Comparación directa con Lab 04

| Concepto | Lab 04 | Lab 05 |
|---|---|---|
| DSORG | PS | PS |
| RECFM | FB | VB |
| LRECL=80 | cada registro mide 80 | máximo 80 incluyendo RDW |
| Longitud de datos | fija | variable |
| RDW | no | sí, 4 bytes |
| Bloqueo | sí | sí |

## Criterio profesional de cierre

No se considera suficiente observar solo `RC=0000`. El laboratorio valida dos capas:

```text
EJECUCIÓN
   |
   `-- COND CODE 0000

ESTADO PERSISTENTE
   |
   `-- IBMUSER.JCLLAB05.VB
       PS / VB / LRECL 80 / BLKSIZE 27998
```

## Resultado

- [x] JCL creado y conservado
- [x] Job aceptado y ejecutado por JES2
- [x] Step `CREATE` finalizado con CC 0000
- [x] Data set creado
- [x] Data set catalogado
- [x] `DSORG=PS` validado
- [x] `RECFM=VB` validado
- [x] `LRECL=80` validado
- [x] `BLKSIZE=0` solicitado
- [x] `BLKSIZE=27998` observado
- [x] Evidencias originales conservadas
- [x] Documentación técnica y runbook incluidos

**LAB 05 — CERRADO CORRECTAMENTE.**
