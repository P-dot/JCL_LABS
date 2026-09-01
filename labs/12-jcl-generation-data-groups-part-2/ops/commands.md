# Operational Commands and Validation

## Inspect the GDG in ISPF

Use ISPF 3.4 with:

```text
IBMUSER.JCLLAB12.GDG*
```

Purpose:
- verify which physical generations are currently present
- confirm rollover behavior
- confirm the final five-generation state

## Validate the GDG Base

Submit `L12LIST` and inspect IDCAMS `SYSPRINT`.

Expected final attributes:

```text
LIMIT 5
SCRATCH
NOEMPTY
```

Expected successful IDCAMS completion:

```text
IDC0001I FUNCTION COMPLETED, HIGHEST CONDITION CODE WAS 0
IDC0002I IDCAMS PROCESSING COMPLETE. MAXIMUM CONDITION CODE WAS 0
```

## Validate Generation Allocation

For `L12GEN4`, `L12GEN5`, and `L12GEN6`, inspect SDSF/JESYSMSG.

Expected pattern:

```text
IEF142I ... STEP WAS EXECUTED - COND CODE 0000
IEF285I ... GxxxxV00 CATALOGED
```
