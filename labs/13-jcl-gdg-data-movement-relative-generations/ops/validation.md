# Operational Validation

## Validate a new generation

In SDSF/JESYSMSG confirm:

```text
IEF142I ... COND CODE 0000
IEF285I ... GxxxxV00 CATALOGED
```

## Validate a relative read

For `L13CURR` and `L13PREV`, inspect JESYSMSG. The `IEF285I` message exposes the absolute GDS that z/OS resolved from `(0)` or `(-1)`.

Then inspect SYSOUT and compare the records with the expected generation.

## Validate retention

Use ISPF 3.4:

```text
IBMUSER.JCLLAB12.GDG*
```

The final expected active generations for this execution are:

```text
G0004V00
G0005V00
G0006V00
G0007V00
G0008V00
```
