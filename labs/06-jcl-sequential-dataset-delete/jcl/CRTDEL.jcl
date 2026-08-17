//CRTDEL   JOB (ACCT),'LAB06 CREATE',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//***************************************************************
//* LAB 06 - CREATE DATA SET FOR DELETE TEST
//***************************************************************
//CREATE   EXEC PGM=IEFBR14
//TESTFILE DD DSN=IBMUSER.JCLLAB06.DELETE,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=0)
