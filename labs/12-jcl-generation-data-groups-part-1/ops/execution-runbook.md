# Execution Runbook — Part 1

1. Confirm no `IBMUSER.JCLLAB12.*` objects exist in ISPF 3.4.
2. Attempt the initial GDG definition and retain the IDCAMS CC 12 evidence.
3. Correct the `DEFINE GDG` command.
4. Run `L12GDG`; verify IDCAMS MAXCC 0.
5. Confirm the GDG base in ISPF 3.4.
6. Run `L12LIST`; inspect `LISTCAT ... ALL`.
7. Verify `LIMIT(3)`, `NOEMPTY`, and `SCRATCH`.
8. Run `L12GEN1`; verify `G0001V00`.
9. Run `L12GEN2`; verify success.
10. Run `L12GEN3`; verify success.
11. Confirm the GDG base plus three GDSs.
12. Stop. Rollover begins in Part 2.
