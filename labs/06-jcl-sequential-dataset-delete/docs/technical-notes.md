# Technical Notes - Lab 06

## DISP como control del ciclo de vida

`DISP` expresa el estado del data set al inicio y la disposicion que z/OS debe
aplicar al finalizar el step.

En este lab:

```text
DISP=(OLD,DELETE,DELETE)
```

- `OLD`: data set existente; acceso exclusivo.
- primer `DELETE`: disposicion si el step termina normalmente.
- segundo `DELETE`: disposicion si el step termina anormalmente.

## DELETE y UNCATLG

No deben tratarse como sinonimos.

- `DELETE` solicita eliminar el data set.
- `UNCATLG` actua sobre su entrada de catalogo.

## Por que FB/VB no cambia el DELETE

La eliminacion gestiona el data set como recurso. El step no interpreta sus
registros, por lo que `RECFM=FB` o `RECFM=VB` no forma parte del JCL de borrado.

## Riesgo operacional

`DISP=(OLD,DELETE,DELETE)` es deliberadamente destructivo. En produccion debe
utilizarse solo cuando el ciclo de vida del recurso y las condiciones de recovery
estan definidos.
