# Validation — Lab 05

## Identificación

- Job: `CRTVB`
- Job ID observado: `JOB04450`
- Step: `CREATE`
- Program: `IEFBR14`
- Data set: `IBMUSER.JCLLAB05.VB`

## Resultado JES2/SDSF

```text
IEF142I CRTVB CREATE - STEP WAS EXECUTED - COND CODE 0000
IEF285I IBMUSER.JCLLAB05.VB CATALOGED
```

Resultado: **PASS**

## Data Set Information

```text
Organization  : PS
Record format : VB
Record length : 80
Block size    : 27998
Allocated tracks : 1
Used tracks      : 0
```

Resultado: **PASS**

## Acceptance criteria

- [x] JOB ejecutado
- [x] CC 0000
- [x] Data set catalogado
- [x] PS confirmado
- [x] VB confirmado
- [x] LRECL 80 confirmado
- [x] BLKSIZE real observado
- [x] Evidencia conservada

**Final status: PASS**
