# Execution Runbook — Lab 04

## 1. Abrir el miembro

Biblioteca: `IBMUSER.JCL.LAB`

Miembro: `CREATEFB`

## 2. Comprobar que el target no existe

Target: `IBMUSER.JCLLAB04.FB`

Como el JCL usa `DISP=NEW`, un rerun limpio requiere que el data set no exista previamente.

## 3. Enviar el job

Desde ISPF Edit: `SUB` o `SUBMIT`.

## 4. Revisar ejecución

Esperado: `MAXCC=0000`.

## 5. Revisar SDSF

Ruta típica: `ISPF -> SDSF -> ST -> CRTFB`.

## 6. Validar el data set

En ISPF 3.4 localizar `IBMUSER.JCLLAB04.FB` y comprobar:

- `DSORG=PS`
- `RECFM=FB`
- `LRECL=80`
- `BLKSIZE=27920` en la ejecución documentada

## 7. Cierre

El laboratorio se considera cerrado cuando coinciden la ejecución correcta y el estado persistente esperado.
