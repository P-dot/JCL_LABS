# GDG Rollover and LIMIT Management

## Rollover

When the GDG was at `LIMIT(3)`, creating `(+1)` generated `G0004V00`.

The resulting group contained:

```text
G0002V00
G0003V00
G0004V00
```

This demonstrated that the oldest generation left the group.

## NOEMPTY

`NOEMPTY` preserves the remaining generations when the limit is exceeded. The group is not emptied as a whole.

## SCRATCH

With `SCRATCH`, the generation leaving the GDG is scratched rather than simply being uncataloged from the group.

## ALTER

The command:

```text
ALTER IBMUSER.JCLLAB12.GDG -
      LIMIT(5)
```

changed the catalog-managed retention policy without deleting the GDG base or its remaining generations.

## Validation

The change was validated twice:

1. Administratively with `LISTCAT ALL`.
2. Operationally by successfully growing the GDG to five active generations.
