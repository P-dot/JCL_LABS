# Lab 10 — Advanced PDS Maintenance with IEBCOPY
## Part 1 — Replacement history and COMPRESS

**Status: PART 1 COMPLETED — PASS**

This checkpoint closes only phases 1 and 2. Phases 3 and 4 remain pending.

### Phase 1 — controlled PDS preparation
`IBMUSER.JCLLAB10.PDS` was created as a classic PDS. MEMBERA was retained as a
control member; MEMBERB and MEMBERC were written as VERSION 1 and subsequently
replaced by VERSION 2.

PRE-COMPRESS baseline captured in ISPF:
- DSORG PO; RECFM FB; LRECL 80; BLKSIZE 27920
- 3 allocated tracks; 1 used track
- 10 maximum directory blocks; 1 used directory block
- 3 members

### Phase 2 — IEBCOPY COMPRESS
`L10COMP` executed successfully with condition code 0000.

IEBCOPY SYSPRINT provides the functional evidence: it identifies the operation
as PDS compression, reports MEMBERA already in place, moves MEMBERB and MEMBERC,
reports 2 of 3 members moved, 2 unused tracks, 9 unused directory blocks, and
highest severity code 0.

### Result
Part 1 demonstrates controlled replacement history followed by an in-place
IEBCOPY reorganization of a classic PDS.

### Pending
- Phase 3 — merge multiple PDS libraries.
- Phase 4 — member management / rename.
