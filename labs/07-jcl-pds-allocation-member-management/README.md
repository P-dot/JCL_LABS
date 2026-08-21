# Lab 07 - PDS Allocation and Member Management with JCL

## Status
**COMPLETED - execution and persistent-state evidence captured.**

## Objective
Allocate `IBMUSER.JCLLAB07.PDS` as a classic PDS, validate its attributes, create `MEMBER1`, save content and verify the member list.

## JCL
```jcl
//CREATE   EXEC PGM=IEFBR14
//PDSFILE  DD DSN=IBMUSER.JCLLAB07.PDS,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(2,1,10)),
//             DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=0)
```

`DSORG=PO` selects partitioned organization. `RECFM=FB,LRECL=80` describes member records. `SPACE=(TRK,(2,1,10))` requests primary/secondary tracks and PDS directory space. `BLKSIZE=0` lets the system select the block size.

## Evidence-backed results
- SDSF: `CRTPDS CREATE - STEP WAS EXECUTED - COND CODE 0000`.
- `IBMUSER.JCLLAB07.PDS` is shown as `CATALOGED`.
- ISPF Data Set Information: `Organization PO`, `Record format FB`, `Record length 80`, `Block size 27920`, allocated tracks 2, maximum directory blocks 10.
- `IBMUSER.JCLLAB07.PDS(MEMBER1)` is saved.
- `MEMBER1` appears in the member list.
- Saved content identifies the lab, PDS and `DSORG=PO RECFM=FB LRECL=80`.

## Result
```text
CRTPDS -> COND CODE 0000 -> PDS CATALOGED
       -> PO / FB / 80 / BLKSIZE 27920
       -> MEMBER1 created -> listed -> content verified
```

**LAB 07 CLOSED.**
