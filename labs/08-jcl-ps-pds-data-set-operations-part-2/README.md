# Lab 08 — PS/PDS Data Set Operations — Part 2

## Status
**COMPLETED — PASS**

## Objective
Continue Part 1 by moving data between sequential and partitioned data sets and
finish with a PDS-to-PDS library copy.

## Executed progression
1. `IBMUSER.JCLLAB07.PDS(MEMBER1)` → `IBMUSER.JCLLAB08.MEMOUT` with IEBGENER.
2. `IBMUSER.JCLLAB08.MEMOUT` → `IBMUSER.JCLLAB07.PDS(FROMPS)` with IEBGENER.
3. Allocate `IBMUSER.JCLLAB08.PDSCOPY` as a PDS.
4. Copy `IBMUSER.JCLLAB07.PDS` → `IBMUSER.JCLLAB08.PDSCOPY` with IEBCOPY.

## What was demonstrated
- `DSN=PDS(MEMBER)` addresses one member of a partitioned data set.
- IEBGENER is used here for sequential record movement to/from a selected member.
- A member does not receive an independent SPACE allocation when its PDS already exists.
- A new PDS uses `DSORG=PO` and requires directory space.
- `SPACE=(TRK,(2,1,10))` means track allocation, primary quantity 2,
  secondary quantity 1, and directory quantity 10.
- IEBCOPY operates on the source and destination partitioned libraries using
  `COPY OUTDD=SYSUT2,INDD=SYSUT1`.
- `DISP=OLD` is used for the already-created destination PDS when COPYLIB modifies it.

## Validation
The supplied evidence shows condition code `0000` for the executed IEBGENER
operations and for both `ALLOC` and `COPYLIB`. It also shows the resulting data
and the final source/destination member lists. The destination PDS contains the
demonstrated members `FROMPS` and `MEMBER1`.

## Files
- `jcl/` — three executed JCL jobs.
- `docs/` — theory, utility comparison and validation.
- `evidence/` — original evidence DOCX plus extracted screenshots.
- `ops/` — execution and Git closure runbooks.
- `references/` — IBM reference families used during the lab.

## Result
**Lab 08 Part 2 complete.** Together with Part 1, the lab now covers:

    PS -> PS
    PDS(member) -> PS
    PS -> PDS(member)
    PDS -> PDS
