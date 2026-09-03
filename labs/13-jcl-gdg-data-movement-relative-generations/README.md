# Lab 13 — GDG Data Movement and Relative Generations

## Objective

Use an existing z/OS Generation Data Group in a real batch data flow and demonstrate that relative GDG references are resolved dynamically by z/OS.

This laboratory continues after Lab 12, which established the GDG base and its retention policy.

## Environment

- IBM z/OS ADCD 1.11 on Hercules
- TSO/E and ISPF
- JES2 and SDSF
- IEBGENER
- User: `IBMUSER`
- JCL library: `IBMUSER.JCL.LAB`
- GDG base: `IBMUSER.JCLLAB12.GDG`
- GDG policy inherited from Lab 12: `LIMIT(5) NOEMPTY SCRATCH`

## Engineering Method

`Build -> Execute -> Observe -> Diagnose -> Correct -> Validate -> Document`

## Phase 1 — Create a Controlled Source PS

`L13INPUT` used IEBGENER with instream data to create:

```text
IBMUSER.JCLLAB13.INPUT
```

The source contained three known records:

```text
LAB13 RECORD 01 - GDG INPUT DATA
LAB13 RECORD 02 - BATCH GENERATION TEST
LAB13 RECORD 03 - RELATIVE REFERENCE BASELINE
```

The job completed with `CC=0000`, the PS was cataloged, and its contents were verified in ISPF Browse.

## Phase 2 — Copy PS Data to GDG(+1)

`L13COPY` used the PS as `SYSUT1` and:

```text
IBMUSER.JCLLAB12.GDG(+1)
```

as `SYSUT2`.

z/OS created:

```text
IBMUSER.JCLLAB12.GDG.G0007V00
```

with `CC=0000`.

Because the GDG already contained five active generations, `LIMIT(5)` caused the oldest generation to leave the group. The resulting active range was `G0003V00` through `G0007V00`.

The new `G0007V00` was browsed and the three source records were verified.

## Phase 3 — Read the Current Generation with GDG(0)

`L13CURR` used:

```text
DSN=IBMUSER.JCLLAB12.GDG(0)
```

JES showed that z/OS resolved the relative reference to:

```text
IBMUSER.JCLLAB12.GDG.G0007V00
```

IEBGENER copied its three records to SYSOUT.

This proved that the consumer did not need the absolute generation name.

## Phase 4 — Read the Previous Generation with GDG(-1)

`L13PREV` used:

```text
DSN=IBMUSER.JCLLAB12.GDG(-1)
```

At that point z/OS resolved `(-1)` to:

```text
IBMUSER.JCLLAB12.GDG.G0006V00
```

That generation had been created previously as an empty generation, so the job completed successfully at end-of-data with no application records in SYSOUT.

## Phase 5 — Create a New Current Generation

`L13NEXT` created another `GDG(+1)` containing:

```text
LAB13 GENERATION 02 - NEW CURRENT GENERATION
LAB13 GENERATION 02 - RELATIVE REFERENCE SHIFT
```

z/OS cataloged:

```text
IBMUSER.JCLLAB12.GDG.G0008V00
```

with `CC=0000`.

The GDG again respected `LIMIT(5)`, leaving the active generations:

```text
G0004V00
G0005V00
G0006V00
G0007V00
G0008V00
```

## Phase 6 — Prove Dynamic Relative Resolution

The original `L13CURR` was submitted again **without changing the `GDG(0)` reference**.

This time JES resolved:

```text
GDG(0) -> G0008V00
```

and SYSOUT contained the two new Generation 02 records.

The original `L13PREV` was then submitted again **without changing `GDG(-1)`**.

This time JES resolved:

```text
GDG(-1) -> G0007V00
```

and SYSOUT contained the three records written earlier.

## Key Demonstration

```text
Before G0008 creation            After G0008 creation

GDG(0)  -> G0007V00              GDG(0)  -> G0008V00
GDG(-1) -> G0006V00              GDG(-1) -> G0007V00
```

The JCL consumer remained unchanged while z/OS dynamically resolved the logical relative position to a different physical generation.

## Operational Value

This is the core reason GDGs are useful in recurring batch workloads. A production job can request the current or previous generation without embedding generation numbers such as `G0007V00` or `G0008V00`.

The physical generation changes over time; the logical contract used by the batch job remains stable.

## Final State

```text
IBMUSER.JCLLAB12.GDG
├── G0004V00
├── G0005V00
├── G0006V00
├── G0007V00
└── G0008V00
```

`LIMIT(5)` remained active throughout the experiment.

## Scope Boundary

Completed here:

- controlled PS creation
- PS -> `GDG(+1)` data movement
- content validation
- rollover while writing real data
- `GDG(0)` consumption
- `GDG(-1)` consumption
- creation of a second data-bearing generation
- dynamic shift of `(0)` and `(-1)`
- validation in JES/SDSF, SYSOUT and ISPF

Deferred to a later lab:

- selective GDS deletion
- GDG base deletion
- additional lifecycle/cleanup operations

## Result

**LAB 13 COMPLETED AND VALIDATED**

All executed batch steps used for the final demonstrations completed with condition code 0.
