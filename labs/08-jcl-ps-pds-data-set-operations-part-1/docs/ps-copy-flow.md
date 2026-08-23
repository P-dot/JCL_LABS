# PS Copy Flow

    IBMUSER.JCLLAB08.INPUT
              |
              | DISP=SHR
              v
           SYSUT1
              |
              v
          IEBGENER
              |
              v
           SYSUT2
              |
              | DISP=(NEW,CATLG,DELETE)
              v
    IBMUSER.JCLLAB08.OUTPUT

The source remains intact. The target is created and cataloged after successful
completion. The final ISPF browse confirms that all five records were copied.
