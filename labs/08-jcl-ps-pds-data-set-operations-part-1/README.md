# Lab 08 — PS/PDS Data Set Operations — Part 1

## Status

**COMPLETED — PART 1**

This first part establishes the sequential-data-set side of the PS/PDS operations lab.
The continuation will extend the same Lab 08 into PDS/member operations.

## Objective

Build and validate a repeatable batch workflow that:

1. creates a physical sequential (PS) input data set;
2. loads controlled in-stream records with IEBGENER;
3. uses that existing PS as `SYSUT1`;
4. creates a second PS as `SYSUT2`;
5. proves that the copy completed successfully and that the records are identical.

## Environment

- z/OS ADCD / Hercules laboratory
- TSO/ISPF
- JES2 / SDSF
- JCL
- IEBGENER
- DASD allocation through `UNIT=SYSDA`

## Data sets used

| Data set | Purpose | Organization |
|---|---|---|
| `IBMUSER.JCLLAB08.INPUT` | Source data | PS, FB, LRECL 80 |
| `IBMUSER.JCLLAB08.OUTPUT` | Copy target | PS, FB, LRECL 80 |
| `IBMUSER.JCL.LAB(L08DATA)` | Executed creation/load JCL | JCL library member |
| `IBMUSER.JCL.LAB(L08COPY)` | Executed PS-to-PS copy JCL | JCL library member |

## Phase 1 — Build the input PS

`L08DATA` runs IEBGENER with in-stream data on `SYSUT1`.

Flow:

    in-stream records
           |
         SYSUT1
           |
       IEBGENER
           |
         SYSUT2
           |
    IBMUSER.JCLLAB08.INPUT

The output DD requests:

- `DISP=(NEW,CATLG,DELETE)` — create a new data set, catalog it after normal
  completion, and delete it after abnormal completion.
- `UNIT=SYSDA` — request a DASD device from the installation's SYSDA pool.
- `SPACE=(TRK,(1,1))` — primary allocation of one track and secondary
  allocations of one track when additional extents are required.
- `DSORG=PS` — physical sequential organization.
- `RECFM=FB` — fixed-length blocked records.
- `LRECL=80` — each logical record is 80 bytes.
- `BLKSIZE=0` — let the system select an appropriate block size.

Five controlled records were written and verified.

## Phase 2 — Library organization context

The associated video sequence also introduces PDS libraries as containers for
JCL, COBOL source, procedures and application-related members. This part is
documented conceptually only; no artificial TEST/QA/UAT/PROD libraries were
created merely for appearance. Existing project naming is retained.

The PDS/member operations are intentionally deferred to **Lab 08 Part 2**.

## Phase 3 — Copy PS to PS

`L08COPY` uses the existing input data set as:

    SYSUT1 DD DSN=IBMUSER.JCLLAB08.INPUT,DISP=SHR

and creates:

    IBMUSER.JCLLAB08.OUTPUT

as `SYSUT2`.

`DISP=SHR` is appropriate for the existing source because this job reads it and
does not need to create it. The output uses `DISP=(NEW,CATLG,DELETE)` because
it is a new persistent data set.

## Validation

Observed evidence confirms:

- `L08DATA` completed with condition code `0000`.
- `IBMUSER.JCLLAB08.INPUT` contains all five expected records.
- `L08COPY` completed with condition code `0000`.
- the input data set was kept;
- `IBMUSER.JCLLAB08.OUTPUT` was cataloged;
- the output contains the same five records as the input.

This validates both execution status and resulting data, rather than relying on
condition code alone.

## Evidence

See `evidence/screenshots/` and the original evidence document in `evidence/`.

## What Part 1 demonstrates

- JCL JOB / EXEC / DD structure
- IEBGENER simple sequential processing
- in-stream input with `DD *`
- `SYSUT1`, `SYSUT2`, `SYSPRINT`, and `SYSIN`
- `SYSIN DD DUMMY`
- PS allocation on DASD
- primary and secondary SPACE quantities
- FB / LRECL / system-selected BLKSIZE
- DISP lifecycle for new and existing data sets
- batch PS-to-PS copy
- validation through SDSF and ISPF

## Continuation

**Lab 08 Part 2** will continue from this baseline with PDS/member operations and
the appropriate distinction between sequential copying and partitioned-library
management.

No Part 2 implementation is included in this package.
