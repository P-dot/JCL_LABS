//CRTPDS   JOB (ACCT),'LAB07 PDS',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//CREATE   EXEC PGM=IEFBR14
//PDSFILE  DD DSN=IBMUSER.JCLLAB07.PDS,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(2,1,10)),
//             DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=0)
