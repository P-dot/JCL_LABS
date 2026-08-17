# Execution Runbook - Lab 06

## Crear recurso de prueba

1. Abrir `IBMUSER.JCL.LAB(CRTDEL)`.
2. Revisar el DSN `IBMUSER.JCLLAB06.DELETE`.
3. Enviar con `SUB`.
4. Verificar desde ISPF 3.4 que el data set existe.

## Eliminar en batch

1. Abrir `IBMUSER.JCL.LAB(DELPS)`.
2. Confirmar que el target es exactamente `IBMUSER.JCLLAB06.DELETE`.
3. Revisar `DISP=(OLD,DELETE,DELETE)`.
4. Enviar el job.
5. Volver a ISPF 3.4.
6. Buscar `IBMUSER.JCLLAB06.DELETE`.
7. Validar que ya no aparece.

## Precaucion

No reutilizar este JCL contra un DSN de produccion sin control de cambios,
validacion del target y estrategia de recovery.
