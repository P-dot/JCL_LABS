# References

## IBM material used

- IBM Redbooks — *Introduction to the New Mainframe: z/OS Basics*, chapter on data sets and basic record formats.
  - Difference between logical records and physical blocks.
  - DCB characteristics `RECFM`, `LRECL`, `BLKSIZE`.
  - `RECFM=VB` and 4-byte RDW.
  - First data byte at position 5 for VB records.
  - RDW and BDW are each 4 bytes.
- IBM Redbooks — JCL/SDSF examples using `IEFBR14` for new data set allocation and cataloging.
- IBM MVS JCL Reference — DD/DCB/DISP/DSNAME/BLKSIZE parameter definitions.

## Laboratory evidence

The runtime screenshots in `evidence/` are the primary source for the actual values observed in this ADCD/Hercules execution.
