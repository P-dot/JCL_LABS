# Lab 10 — Advanced PDS Maintenance with IEBCOPY

**COMPLETED — PASS**

This lab demonstrates controlled maintenance of classic PDS libraries.

## Phases
1. Prepare `IBMUSER.JCLLAB10.PDS` and create replacement history for members.
2. Reorganize the PDS with IEBCOPY COMPRESS.
3. Merge two PDS sources into `IBMUSER.JCLLAB10.MERGED`.
4. Copy `MEMBERD` to another PDS under the new member name `RENAMED`.

## Results
Phase 2 completed with CC 0000 and IEBCOPY highest severity code 0; the Part 1
evidence recorded 2 of 3 members moved.

Phase 3 copied 3/3 members from the first PDS and 2/2 from PDS2. ISPF confirmed
MEMBERA, MEMBERB, MEMBERC, MEMBERD and MEMBERE in the merged destination.

Phase 4 copied MEMBERD under the new name RENAMED. IEBCOPY reported 1/1 member
copied and highest severity code 0. ISPF confirmed RENAMED and preserved the
original MEMBERD content.

All four phases are complete.
