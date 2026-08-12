# Comandos y miembros ejecutados

## Librerías usadas

```text
IBMUSER.JCL.LAB
IBMUSER.JCL.PROCLIB
```

## Miembros

```text
IBMUSER.JCL.PROCLIB(COPYPROC)
IBMUSER.JCL.LAB(MKINPUT)
IBMUSER.JCL.LAB(CALLPROC)
IBMUSER.JCL.LAB(CALLPRC2)
```

## Flujo de validación

1. Crear `COPYPROC`.
2. Ejecutar `MKINPUT`.
3. Validar `CC 0000` en SDSF.
4. Ejecutar `CALLPROC`.
5. Revisar JESJCL y confirmar expansión de la PROC.
6. Confirmar `IBMUSER.PROC.OUTPUT` en ISPF 3.4.
7. Ejecutar `CALLPRC2` con override de `OUTDSN`.
8. Revisar JESJCL.
9. Confirmar `IBMUSER.PROC.OUTPUT2`.

## Datasets creados

```text
IBMUSER.PROC.INPUT
IBMUSER.PROC.OUTPUT
IBMUSER.PROC.OUTPUT2
```
