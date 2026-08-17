# FB vs VB — Comparación práctica

## FB

```text
RECFM=FB,LRECL=80

registro 1 -> 80 bytes
registro 2 -> 80 bytes
registro 3 -> 80 bytes
```

Todos los registros tienen la misma longitud.

## VB

```text
RECFM=VB,LRECL=80

[RDW] dato corto
[RDW] dato de longitud media
[RDW] dato más largo
```

Los registros pueden variar y el máximo total es 80 bytes, incluido el RDW de 4 bytes.

## Uso

FB favorece layouts rígidos y predecibles. VB resulta apropiado cuando los registros no necesitan tener todos el mismo tamaño.
