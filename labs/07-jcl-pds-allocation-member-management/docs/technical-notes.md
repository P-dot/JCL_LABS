# Technical Notes - Lab 07

A classic PDS uses `DSORG=PO` and contains directory information plus named members. Members are addressed as `IBMUSER.JCLLAB07.PDS(MEMBER1)`.

The third quantity in `SPACE=(TRK,(2,1,10))` supplies directory space. The captured ISPF panel reports `Maximum dir. blocks: 10`.

The JCL requested `BLKSIZE=0`; the resulting allocation shown by ISPF is `27920`. `DSORG` describes data-set organization, while `RECFM` and `LRECL` describe record characteristics.
