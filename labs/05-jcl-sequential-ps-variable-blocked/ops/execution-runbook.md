# Execution Runbook — Lab 05

## Ejecutar desde ISPF

1. Abrir `IBMUSER.JCL.LAB(CREATEVB)`.
2. Verificar que `IBMUSER.JCLLAB05.VB` no exista si se va a repetir una ejecución con `DISP=NEW`.
3. Ejecutar `SUB` o `SUBMIT`.
4. Entrar en SDSF y localizar `CRTVB`.
5. Confirmar `COND CODE 0000`.
6. Confirmar `IBMUSER.JCLLAB05.VB CATALOGED`.
7. En ISPF 3.4 localizar `IBMUSER.JCLLAB05.VB`.
8. Mostrar Data Set Information y validar `PS`, `VB`, `LRECL=80` y el BLKSIZE asignado.

## Rerun

El JCL usa `DISP=(NEW,CATLG,DELETE)`. Una repetición directa fallará si el data set ya existe. Para repetir el ejercicio, eliminar deliberadamente el data set de laboratorio o utilizar otro DSNAME.
