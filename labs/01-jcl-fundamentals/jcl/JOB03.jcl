//IBMJ03   JOB (ACCT),'DD LAB',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//CREATE   EXEC PGM=IEFBR14
//MYDATA   DD  DSN=IBMUSER.JCL.TESTDATA,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(1,1)),
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=0)
//*
