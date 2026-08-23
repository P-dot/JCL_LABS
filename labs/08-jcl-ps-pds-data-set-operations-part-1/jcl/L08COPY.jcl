//L08COPY  JOB (ACCT),'LAB08 COPY',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//***************************************************************
//* LAB 08 - PS/PDS DATA SET OPERATIONS
//* PART 1 / PHASE 03 - COPY PS TO PS WITH IEBGENER
//***************************************************************
//*
//COPYPS   EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD DSN=IBMUSER.JCLLAB08.INPUT,
//             DISP=SHR
//SYSUT2   DD DSN=IBMUSER.JCLLAB08.OUTPUT,
//             DISP=(NEW,CATLG,DELETE),
//             UNIT=SYSDA,
//             SPACE=(TRK,(1,1)),
//             DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=0)
//SYSIN    DD DUMMY
