# Lab 04 — Sequential PS Data Set with Fixed Block Records

## Estado

**Completado correctamente — MAXCC 0000.**

## Objetivo

Crear mediante JCL un data set secuencial físico (`DSORG=PS`) con registros `Fixed Blocked` (`RECFM=FB`) utilizando `IEFBR14`, y validar tanto la ejecución del job como los atributos reales asignados al data set por z/OS.

## Entorno

- IBM z/OS ADCD 1.11 sobre Hercules
- TSO/E + ISPF
- JES2 + SDSF
- Usuario: `IBMUSER`
- JCL library: `IBMUSER.JCL.LAB`
- Miembro: `CREATEFB`
- Data set: `IBMUSER.JCLLAB04.FB`

## JCL ejecutado

```jcl
//CRTFB    JOB (ACCT),'CREATE FB PS',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//***************************************************************
//* LAB 04 - CREATE SEQUENTIAL PS DATA SET
//* RECORD FORMAT : FB
//* RECORD LENGTH : 80
//***************************************************************
//*
//CREATE   EXEC PGM=IEFBR14
//FBFILE   DD DSN=IBMUSER.JCLLAB04.FB,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=0)
```

## Qué hace cada parte

### `EXEC PGM=IEFBR14`

`IEFBR14` no escribe registros en el data set. Se utiliza aquí para que z/OS procese la asignación y disposición definidas en la DD.

### `DSN=IBMUSER.JCLLAB04.FB`

Nombre del data set creado.

### `DISP=(NEW,CATLG,DELETE)`

- `NEW`: crea un data set nuevo.
- `CATLG`: si el step termina correctamente, se cataloga.
- `DELETE`: si falla la creación, se elimina.

### `SPACE=(TRK,(1,1))`

Reserva 1 track primario y 1 track secundario.

### `DSORG=PS`

Physical Sequential Data Set.

### `RECFM=FB`

- `F`: registros de longitud fija.
- `B`: varios registros lógicos pueden agruparse en un bloque físico de E/S.

### `LRECL=80`

Cada registro lógico tiene 80 bytes.

### `BLKSIZE=0`

z/OS determina un tamaño de bloque apropiado. En la ejecución documentada el valor observado fue `27920`.

## Resultado observado

- Job: `CRTFB`
- Step: `CREATE`
- Programa: `IEFBR14`
- Resultado: `MAXCC=0`
- Data set creado: `IBMUSER.JCLLAB04.FB`

## Validación de atributos

| Atributo | Valor observado |
|---|---:|
| Data Set Organization | `PS` |
| Record Format | `FB` |
| Record Length | `80` |
| Block Size | `27920` |
| Allocated Tracks | `1` |

## Evidencias incluidas

- `evidence/01-jcl-source.png`
- `evidence/02-runtime-and-dataset-info.png`
- `evidence/lab04-evidence.docx`
- `evidence/README.md`

## Flujo del laboratorio

```text
ISPF EDIT
   |
   v
CREATEFB
   |
   v
SUBMIT
   |
   v
JES2
   |
   v
CREATE EXEC PGM=IEFBR14
   |
   v
FBFILE DD allocation
   |
   +-- DISP=(NEW,CATLG,DELETE)
   +-- SPACE=(TRK,(1,1))
   +-- DSORG=PS
   +-- RECFM=FB
   +-- LRECL=80
   `-- BLKSIZE=0
   |
   v
MAXCC=0000
   |
   v
CATLG
   |
   v
IBMUSER.JCLLAB04.FB
   |
   v
ISPF Data Set Information
   |
   +-- PS
   +-- FB
   +-- LRECL 80
   `-- BLKSIZE 27920
```

## Conclusión

El laboratorio demuestra de extremo a extremo la creación, catalogación y validación de un data set secuencial `PS` con registros `FB`, incluyendo evidencia de ejecución y comprobación del estado persistente en z/OS.

**LAB 04 — PASS**
