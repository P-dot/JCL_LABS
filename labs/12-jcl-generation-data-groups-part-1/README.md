# Lab 12 — Generation Data Groups (GDG) — Part 1

**Status: COMPLETED — PASS (PART 1)**

This lab belongs to `JCL_LABS`, a specialized component of the wider z/OS Engineering Laboratory. It follows the repository methodology:

```text
Build -> Execute -> Observe -> Diagnose -> Correct -> Validate -> Document
```

## Objective

Introduce Generation Data Groups from three complementary perspectives:

- **z/OS administration:** catalog-managed retention and GDG attributes;
- **z/OS operations:** repeatable batch use of relative generations such as `(+1)`, `(0)`, and `(-1)`;
- **z/OS engineering:** separating stable JCL logic from changing absolute generation names.

Part 1 validates the GDG base, catalog inspection, generation allocation, and the controlled arrival at `LIMIT(3)`.

## Namespace

```text
IBMUSER.JCLLAB12.GDG
```

## What was validated

The lab started by confirming that no `IBMUSER.JCLLAB12.*` objects existed. A GDG base was then defined with IDCAMS.

The first `DEFINE GDG` execution failed with IDCAMS condition code 12 because the command structure did not place the opening parenthesis where IDCAMS expected it. The failure was retained as engineering evidence, diagnosed, corrected, and resubmitted successfully.

The corrected definition used:

```text
DEFINE GDG ( -
       NAME(IBMUSER.JCLLAB12.GDG) -
       LIMIT(3) -
       NOEMPTY -
       SCRATCH )
```

IDCAMS completed with maximum condition code 0. ISPF 3.4 then showed the GDG base, and `LISTCAT ENT(... ) ALL` verified the catalog definition and its attributes.

## GDG base vs Generation Data Set

The GDG base is the catalog-managed group definition. It is not the sequential data set containing application data.

Individual generations are Generation Data Sets (GDSs):

```text
IBMUSER.JCLLAB12.GDG.G0001V00
IBMUSER.JCLLAB12.GDG.G0002V00
IBMUSER.JCLLAB12.GDG.G0003V00
```

The jobs requested new generations by using:

```text
IBMUSER.JCLLAB12.GDG(+1)
```

z/OS resolved the relative request and cataloged the corresponding absolute generation name.

## Relative generation model at the end of Part 1

```text
G0001V00 -> (-2)
G0002V00 -> (-1)
G0003V00 -> (0)
```

The absolute GDS names remain stable. Their relative positions change as newer generations are cataloged.

## Final validated state

```text
IBMUSER.JCLLAB12.GDG
IBMUSER.JCLLAB12.GDG.G0001V00
IBMUSER.JCLLAB12.GDG.G0002V00
IBMUSER.JCLLAB12.GDG.G0003V00
```

This reaches the configured `LIMIT(3)`.

## Part 1 scope boundary

Part 1 intentionally stops **before** creating the fourth generation. The following belong to Part 2 because they have not yet been validated in the captured evidence:

- rollover beyond `LIMIT(3)`;
- practical confirmation of `NOEMPTY + SCRATCH` during rollover;
- `ALTER` of the GDG limit;
- writing/copying data across relative generations;
- selective generation deletion;
- deletion of the GDG base.

## Evidence

The evidence set preserves the original supplied montage and extracted/upscaled screenshots. The screenshots document both the error path and the corrected successful path.

## Result

**PART 1 PASS**

The GDG base was created and inspected, the initial IDCAMS syntax problem was diagnosed and corrected, three generations were cataloged successfully, and the lab reached the configured limit in a controlled state ready for Part 2.
