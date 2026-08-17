//CRTVB    JOB (ACCT),'CREATE VB PS',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//***************************************************************
//* LAB 05 - CREATE SEQUENTIAL PS DATA SET
//* RECORD FORMAT : VB
//* MAX LRECL    : 80
//***************************************************************
//*
//CREATE   EXEC PGM=IEFBR14
//VBFILE   DD DSN=IBMUSER.JCLLAB05.VB,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=VB,LRECL=80,BLKSIZE=0)
