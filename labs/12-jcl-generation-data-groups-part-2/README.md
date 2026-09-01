# Lab 12 — Generation Data Groups — Part 2

## Objective

Continue the GDG work started in **Part 1** and validate the retention behavior of an existing Generation Data Group under real catalog operations.

This second part demonstrates:

- creation of a generation beyond `LIMIT(3)`
- automatic GDG rollover
- practical behavior of `NOEMPTY` and `SCRATCH`
- modification of the GDG retention limit with IDCAMS `ALTER`
- catalog validation with `LISTCAT ALL`
- operational validation of the new `LIMIT(5)`

Part 1 remains separate and unchanged.

## Starting State

The GDG base already existed from Part 1:

```text
IBMUSER.JCLLAB12.GDG
```

Initial attributes:

```text
LIMIT(3)
NOEMPTY
SCRATCH
```

Initial active generations at the beginning of Part 2:

```text
G0001V00
G0002V00
G0003V00
```

## Environment

- IBM z/OS ADCD 1.11 on Hercules
- TSO/E and ISPF
- JES2 and SDSF
- IDCAMS
- User namespace: `IBMUSER`
- JCL library: `IBMUSER.JCL.LAB`
- GDG base: `IBMUSER.JCLLAB12.GDG`

## Engineering Methodology

`Build -> Execute -> Observe -> Diagnose -> Correct -> Validate -> Document`

## Phase 1 — Test GDG Rollover

A fourth generation was requested with:

```text
IBMUSER.JCLLAB12.GDG(+1)
```

The JCL completed successfully:

```text
IEF142I ... COND CODE 0000
IEF285I IBMUSER.JCLLAB12.GDG.G0004V00 CATALOGED
```

Because the base was still defined with `LIMIT(3)`, the new generation forced the group to exceed its retention limit.

ISPF 3.4 then showed:

```text
IBMUSER.JCLLAB12.GDG
IBMUSER.JCLLAB12.GDG.G0002V00
IBMUSER.JCLLAB12.GDG.G0003V00
IBMUSER.JCLLAB12.GDG.G0004V00
```

`G0001V00` was no longer present.

### Result

This demonstrated automatic rollover with:

```text
LIMIT(3)
NOEMPTY
SCRATCH
```

The oldest generation was removed while the remaining generations stayed in the group.

## Phase 2 — ALTER the GDG LIMIT

IDCAMS was used to change the retention limit:

```text
ALTER IBMUSER.JCLLAB12.GDG -
      LIMIT(5)
```

IDCAMS confirmed:

```text
IDC0531I ENTRY IBMUSER.JCLLAB12.GDG ALTERED
IDC0001I FUNCTION COMPLETED, HIGHEST CONDITION CODE WAS 0
IDC0002I IDCAMS PROCESSING COMPLETE. MAXIMUM CONDITION CODE WAS 0
```

## Phase 3 — Validate the Catalog Change

`LISTCAT ENT(IBMUSER.JCLLAB12.GDG) ALL` confirmed:

```text
LIMIT----------------5
SCRATCH
NOEMPTY
```

The existing generations remained associated with the GDG base.

## Phase 4 — Validate LIMIT(5) Operationally

Two additional generations were allocated using `(+1)`:

```text
G0005V00
G0006V00
```

Both jobs completed with `CC=0000`.

Final ISPF 3.4 state:

```text
IBMUSER.JCLLAB12.GDG
IBMUSER.JCLLAB12.GDG.G0002V00
IBMUSER.JCLLAB12.GDG.G0003V00
IBMUSER.JCLLAB12.GDG.G0004V00
IBMUSER.JCLLAB12.GDG.G0005V00
IBMUSER.JCLLAB12.GDG.G0006V00
```

The GDG therefore retained five generations after the `ALTER`, proving that the new catalog policy was active.

## Operational Interpretation

This lab shows that generation retention is controlled by the GDG base rather than by hard-coded generation names in each job.

From an operations perspective:

- `(+1)` requests the next generation.
- `LIMIT` controls how many generations stay active.
- `NOEMPTY` avoids emptying the complete GDG when the limit is exceeded.
- `SCRATCH` removes the generation leaving the group.
- `ALTER` can modify the retention policy without deleting and recreating the GDG base.

## Final State

```text
IBMUSER.JCLLAB12.GDG
├── G0002V00
├── G0003V00
├── G0004V00
├── G0005V00
└── G0006V00
```

Final attributes:

```text
LIMIT(5)
NOEMPTY
SCRATCH
```

## Scope Boundary

This Part 2 ends here.

The following topics are intentionally **not** included and will be implemented in a separate laboratory:

- copying a PS into `GDG(+1)`
- writing real batch data into a generation
- consuming `GDG(0)`
- consuming `GDG(-1)`
- relative-generation batch processing
- selective generation deletion
- deletion of the GDG base

## Result

**PART 2 COMPLETED AND VALIDATED**

All final execution and IDCAMS validation steps completed with condition code 0.
