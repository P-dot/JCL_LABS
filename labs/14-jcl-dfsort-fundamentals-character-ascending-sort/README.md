# Lab 14 — DFSORT Fundamentals: Character Key Ascending Sort

## Objective

Introduce DFSORT through a controlled fixed-record batch scenario and demonstrate an ascending character sort using a positional key.

The lab validates:

- creation of a controlled FB input data set
- diagnosis and correction of a DDNAME error
- execution of DFSORT with `PGM=SORT`
- use of `SORTIN`, `SORTOUT`, `SYSIN`, and `SYSOUT`
- interpretation of `SORT FIELDS=(1,5,CH,A)`
- DFSORT/JES return-code and message validation
- data-level verification of the sorted output

## Environment

- IBM z/OS ADCD 1.11 on Hercules
- TSO/E and ISPF
- JES2 and SDSF
- IEBGENER
- DFSORT
- User namespace: `IBMUSER`
- JCL library: `IBMUSER.JCL.LAB`

## Engineering Methodology

`Build -> Execute -> Observe -> Diagnose -> Correct -> Validate -> Document`

## Input Record Layout

The input is an `FB 80` sequential data set.

The sort key occupies the first five bytes:

```text
Position  Length  Field
1         5       KEY
6+        ...     Payload
```

Controlled input:

```text
C0050OPERATIONS         OPS
A0010SECURITY           SEC
D0040DATABASE           DB2
B0020NETWORKING         NET
A0005BATCH              JCL
C0010STORAGE            DASD
```

## Phase 1 — Create the Controlled Input

`L14INPUT` uses IEBGENER to create:

```text
IBMUSER.JCLLAB14.INPUT
```

### Troubleshooting Event

The first execution contained:

```jcl
//SYSUT DD *
```

instead of the required IEBGENER input DDNAME:

```jcl
//SYSUT1 DD *
```

The execution produced:

```text
IEC130I SYSUT1 DD STATEMENT MISSING
IEB316I DDNAME SYSUT1 CANNOT BE OPENED
```

and the step ended with:

```text
COND CODE 0012
```

The failed output data set had nevertheless been cataloged, so it was deleted before rerunning the corrected JCL with `DISP=(NEW,CATLG,DELETE)`.

After correcting the DDNAME, `L14INPUT` completed with:

```text
COND CODE 0000
IBMUSER.JCLLAB14.INPUT CATALOGED
```

ISPF Browse verified all six deliberately unordered records.

## Phase 2 — DFSORT Ascending Character Sort

`L14SORT` executes:

```jcl
//SORTSTEP EXEC PGM=SORT
```

with:

```text
SORTIN  -> IBMUSER.JCLLAB14.INPUT
SORTOUT -> IBMUSER.JCLLAB14.OUTPUT
SYSIN   -> DFSORT control statements
SYSOUT  -> DFSORT messages
```

The control statement is:

```text
SORT FIELDS=(1,5,CH,A)
```

Meaning:

```text
1  = key starts at byte 1
5  = key length is 5 bytes
CH = character comparison
A  = ascending order
```

## Predicted Result

Before execution, the expected key order was established as:

```text
A0005
A0010
B0020
C0010
C0050
D0040
```

This made the validation deterministic rather than visual or subjective.

## Execution Validation

JES confirmed:

```text
L14SORT SORTSTEP - STEP WAS EXECUTED - COND CODE 0000
IBMUSER.JCLLAB14.INPUT  KEPT
IBMUSER.JCLLAB14.OUTPUT CATALOGED
```

DFSORT reported the submitted sort control statement and processed six fixed-length records.

The evidence also shows:

```text
NUMBER OF BYTES SORTED: 480
RECORDS SORTED - PROCESSED: 6
END OF DFSORT
```

The 480-byte total is consistent with:

```text
6 records x 80 bytes = 480 bytes
```

## Data-Level Validation

ISPF Browse of:

```text
IBMUSER.JCLLAB14.OUTPUT
```

showed:

```text
A0005BATCH              JCL
A0010SECURITY           SEC
B0020NETWORKING         NET
C0010STORAGE            DASD
C0050OPERATIONS         OPS
D0040DATABASE           DB2
```

Therefore:

- input record count: 6
- output record count: 6
- key order: ascending
- input preserved
- output cataloged
- DFSORT completion: successful

## Operational Interpretation

DFSORT did not sort by the visible meaning of each line. It compared the five-byte field beginning at byte 1 using character semantics.

The payload following the key remained attached to its original record while DFSORT changed the physical record sequence.

This distinction is fundamental when operating positional fixed-record batch data.

## Final Result

**LAB 14 COMPLETED AND VALIDATED**

The lab demonstrates the complete first DFSORT workflow:

```text
Controlled input
      |
      v
SORTIN
      |
      v
SORT FIELDS=(1,5,CH,A)
      |
      v
SORTOUT
      |
      +-- CC=0000
      +-- 6 records processed
      +-- 480 bytes sorted
      +-- ascending key order verified
```

The initial `CC=0012` is retained as troubleshooting evidence and documents the diagnose/correct/validate cycle.


---
### Continue learning

**Previous:** [13-jcl-gdg-data-movement-relative-generations](../13-jcl-gdg-data-movement-relative-generations/)  
**Course:** [Course home](../../README.md)  
**Next:** [Choose the next Academy course](https://github.com/P-dot/P-dot/blob/main/docs/COURSES.md)  
**Academy:** [z/OS Engineering Academy](https://github.com/P-dot/P-dot/blob/main/docs/ACADEMY.md) · [Curriculum](https://github.com/P-dot/P-dot/blob/main/docs/CURRICULUM.md)
