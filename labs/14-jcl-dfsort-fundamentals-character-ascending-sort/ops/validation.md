# Operational Validation

## Input

Browse:

```text
IBMUSER.JCLLAB14.INPUT
```

Expected records: 6.

## DFSORT Execution

In SDSF verify:

```text
L14SORT SORTSTEP ... COND CODE 0000
IBMUSER.JCLLAB14.INPUT  KEPT
IBMUSER.JCLLAB14.OUTPUT CATALOGED
```

In DFSORT SYSOUT verify:

```text
SORT FIELDS=(1,5,CH,A)
RECORDS SORTED - PROCESSED: 6
NUMBER OF BYTES SORTED: 480
END OF DFSORT
```

## Output

Browse:

```text
IBMUSER.JCLLAB14.OUTPUT
```

Expected key sequence:

```text
A0005
A0010
B0020
C0010
C0050
D0040
```

The number of records must remain six.
