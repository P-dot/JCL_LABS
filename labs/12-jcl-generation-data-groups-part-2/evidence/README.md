# Evidence — Lab 12 Part 2

This directory contains only the evidence for **Part 2**.

Evidence sequence:

1. `L12GEN4` JCL
2. `G0004V00` cataloged with `CC=0000`
3. ISPF verification of rollover at `LIMIT(3)`
4. `ALTER LIMIT(5)` JCL
5. successful IDCAMS `ALTER`
6. `LISTCAT ALL` showing `LIMIT 5`, `SCRATCH`, `NOEMPTY`
7. `LISTCAT` final `MAXCC=0`
8. `L12GEN5` JCL
9. `G0005V00` cataloged with `CC=0000`
10. `L12GEN6` JCL
11. `G0006V00` cataloged with `CC=0000`
12. final ISPF state with five active generations

Physical PNG files: 12

Part 1 evidence remains in its own repository directory and is not duplicated here.
