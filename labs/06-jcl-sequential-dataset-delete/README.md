# Lab 06 - Delete a Sequential Data Set with JCL

## Estado

**COMPLETADO - evidencia funcional de estado antes/despues.**

## Objetivo

Demostrar el ciclo de vida de un data set secuencial de prueba:

```text
CREATE -> VERIFY EXISTS -> DELETE IN BATCH -> VERIFY ABSENT
```

El objetivo no es procesar registros. El laboratorio practica la gestion del recurso
mediante JCL y, en particular, el parametro `DISP`.

## Entorno observado

- z/OS ADCD sobre Hercules
- Usuario / HLQ: `IBMUSER`
- JCL library: `IBMUSER.JCL.LAB`
- Data set de prueba: `IBMUSER.JCLLAB06.DELETE`
- Programa utilizado: `IEFBR14`
- Validacion interactiva: ISPF Data Set List Utility

## 1. Creacion controlada

El miembro `CRTDEL` define un PS de prueba:

```jcl
//CREATE   EXEC PGM=IEFBR14
//TESTFILE DD DSN=IBMUSER.JCLLAB06.DELETE,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=0)
```

La evidencia conserva el JCL de creacion y, posteriormente, la lista ISPF donde
`IBMUSER.JCLLAB06.DELETE` aparece existente.

## 2. Eliminacion batch

El miembro `DELPS` contiene:

```jcl
//DELETE   EXEC PGM=IEFBR14
//DELFILE  DD DSN=IBMUSER.JCLLAB06.DELETE,
//             DISP=(OLD,DELETE,DELETE)
```

### Significado de DISP

```text
DISP=(OLD,DELETE,DELETE)
      |     |      |
      |     |      +-- disposicion en terminacion anormal
      |     +--------- disposicion en terminacion normal
      +--------------- estado inicial: data set existente
```

`OLD` indica que el data set ya existe y solicita uso exclusivo para el step.

`DELETE` como disposicion normal solicita eliminarlo al terminar el step.

El tercer `DELETE` solicita tambien su eliminacion ante terminacion anormal.

## 3. Por que no aparecen SPACE, RECFM o LRECL en DELPS

En `CRTDEL` esos atributos son necesarios porque se esta creando el data set.

En `DELPS` el recurso ya existe. Para este objetivo solo necesitamos identificarlo
(`DSN`) y establecer su disposicion (`DISP`).

## 4. IEFBR14

`IEFBR14` no lee ni transforma los registros del fichero. En este patron sirve como
programa minimo para que z/OS procese las DD y sus reglas de allocation/disposition.

Por ello el mismo principio de eliminacion no depende de que el PS sea FB o VB.

## 5. Foreground frente a batch

Una eliminacion interactiva puede realizarse desde ISPF 3.4 con la accion `D` y su
confirmacion. Este laboratorio documenta la alternativa batch mediante JCL.

La ventaja operativa del batch es que la limpieza puede integrarse en una cadena de
procesamiento sin intervencion manual.

## 6. Evidencia

| Evidencia | Que demuestra |
|---|---|
| `01_create_test_dataset_jcl.png` | JCL de creacion controlada |
| `02_dataset_exists_before_delete.png` | El data set existe antes de eliminarlo |
| `03_delete_dataset_jcl.png` | JCL batch de eliminacion |
| `04_disp_old_delete_delete_detail.png` | `DISP=(OLD,DELETE,DELETE)` usado |
| `05_dataset_not_found_after_delete.png` | El data set ya no aparece despues |

El DOCX original se conserva sin modificar en `evidence/Lab06_original_evidence.docx`.

## 7. Alcance de la evidencia

Las capturas aportadas demuestran el **estado persistente antes y despues**:
el data set aparece antes de la operacion y posteriormente ISPF muestra
`No data set names found`.

El documento aportado **no incluye una captura de SDSF/JES con MAXCC o condition
code del job DELPS**, por lo que este repositorio no afirma un RC concreto que no
este demostrado por la evidencia.

## Resultado

```text
ANTES
IBMUSER.JCLLAB06.DELETE -> EXISTS

OPERACION
DELPS -> DISP=(OLD,DELETE,DELETE)

DESPUES
IBMUSER.JCLLAB06.DELETE -> NOT FOUND
```

**LAB 06 CERRADO - eliminacion batch del data set demostrada mediante evidencia de
estado antes/despues.**
