# DFSORT Fundamentals Demonstrated

## PGM=SORT

`PGM=SORT` invokes the installation's sort product. In this environment the resulting `ICE...` messages identify DFSORT processing.

## SORTIN

Input data set. `DISP=SHR` allows the job to read the existing PS and preserves it.

## SORTOUT

Output data set receiving the sorted records.

## SYSIN

Contains DFSORT control statements:

```text
SORT FIELDS=(1,5,CH,A)
```

## SYSOUT

Receives DFSORT diagnostic and processing messages. These messages are part of operational validation and must be reviewed together with the step condition code.

## Positional Key

`(1,5,CH,A)` selects five bytes starting at byte 1, compares them as character data, and orders them ascending.

The remaining bytes are not independent fields being sorted; they remain part of their complete input record.
