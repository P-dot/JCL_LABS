//CRTFB    JOB (ACCT),'CREATE FB PS',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//***************************************************************
//* LAB 04 - CREATE SEQUENTIAL PS DATA SET
//* RECORD FORMAT : FB
//* RECORD LENGTH : 80
//***************************************************************
//*
//CREATE   EXEC PGM=IEFBR14
//FBFILE   DD DSN=IBMUSER.JCLLAB04.FB,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=0)
