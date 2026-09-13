# Troubleshooting — Missing SYSUT1 DD

## Symptom

The initial `L14INPUT` execution ended with `CC=0012`.

Messages included:

```text
IEC130I SYSUT1 DD STATEMENT MISSING
IEB316I DDNAME SYSUT1 CANNOT BE OPENED
```

## Root Cause

The instream input DD was coded as:

```jcl
//SYSUT DD *
```

IEBGENER expects the input DDNAME `SYSUT1`.

## Correction

The DD statement was changed to:

```jcl
//SYSUT1 DD *
```

Because the failed attempt had already left `IBMUSER.JCLLAB14.INPUT` cataloged, that data set was deleted before rerunning a JCL definition that requested `DISP=(NEW,CATLG,DELETE)`.

## Validation

The corrected job completed with `CC=0000`, cataloged the input PS, and ISPF Browse showed all six expected records.

This failure is intentionally retained because it demonstrates the repository methodology:

`Observe -> Diagnose -> Correct -> Validate`
