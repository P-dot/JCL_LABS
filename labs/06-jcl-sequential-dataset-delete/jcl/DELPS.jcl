//DELPS    JOB (ACCT),'LAB06 DELETE',
//             CLASS=A,
//             MSGCLASS=X,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//***************************************************************
//* LAB 06 - DELETE EXISTING SEQUENTIAL DATA SET
//* TARGET: IBMUSER.JCLLAB06.DELETE
//***************************************************************
//DELETE   EXEC PGM=IEFBR14
//DELFILE  DD DSN=IBMUSER.JCLLAB06.DELETE,
//             DISP=(OLD,DELETE,DELETE)
