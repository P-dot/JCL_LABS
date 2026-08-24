# Execution Runbook
1. Submit `IBMUSER.JCL.LAB(L08M2PS)`; verify COPYMPS CC 0000 and browse MEMOUT.
2. Submit `IBMUSER.JCL.LAB(L08PS2M)`; verify COPYPSM CC 0000 and browse FROMPS.
3. For a fresh final run, ensure PDSCOPY does not already exist.
4. Submit `IBMUSER.JCL.LAB(L08PDSCP)`.
5. Verify ALLOC CC 0000 and COPYLIB CC 0000.
6. Inspect IEBCOPY SYSPRINT and compare source/destination member lists.
