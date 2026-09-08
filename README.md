# JCL Engineering Labs

Hands-on **Job Control Language (JCL)** engineering labs for z/OS ADCD / Hercules.

This repository develops the batch execution foundations used across the wider z/OS Engineering Laboratory. The labs progress from core JCL syntax and procedure handling into sequential datasets, PDS management, IBM utilities, IDCAMS and Generation Data Groups.

---

## Repository role

`JCL_LABS` is the **batch execution backbone** of the ecosystem.

Its role is to define how work is described to JES2:

```text
JCL
 |
 v
JES2
 |
 +--> utilities
 +--> COBOL
 +--> VSAM
 +--> DB2
 +--> USS / BPXBATCH
 +--> future scheduler-controlled workloads
```

JCL does not replace application logic and it does not replace the scheduler.

The architectural boundary is:

```text
Scheduler decides when work runs
        |
        v
JCL describes what is executed
        |
        v
JES2 executes the batch workload
```

For the detailed cross-repository architecture, see:

[`docs/ECOSYSTEM-INTEGRATION.md`](docs/ECOSYSTEM-INTEGRATION.md)

---

## Environment

Current lab environment:

- z/OS 1.11 ADCD
- Hercules
- TSO/E
- ISPF
- SDSF
- JES2
- standard z/OS utilities used by the individual labs
- cataloged datasets and PDS members created inside the controlled lab environment

The repository documents behavior actually validated in this environment.

---

## Current lab progression

| Lab | Topic | Status |
|---|---|---|
| 01 | JCL Fundamentals | Completed |
| 02 | Cataloged Procedures and Symbolic Overrides | Completed |
| 03 | In-stream Procedures | Completed |
| 04 | Sequential PS — Fixed Block | Completed |
| 05 | Sequential PS — Variable Blocked | Completed |
| 06 | Sequential Dataset Delete | Completed |
| 07 | PDS Allocation and Member Management | Completed |
| 08 Part 1 | PS / PDS Data Set Operations | Completed |
| 08 Part 2 | PS / PDS Data Set Operations | Completed |
| 09 | IEBCOPY Select / Exclude PDS Members | Completed |
| 10 Part 1 | Advanced PDS Maintenance — Compress | Completed |
| 10 | Advanced PDS Maintenance | Completed |
| 11 | IDCAMS Delete — PS / PDS Member | Completed |
| 12 Part 1 | Generation Data Groups Fundamentals | Completed |
| 12 Part 2 | GDG Rollover and Limit Management | Completed |
| 13 | GDG Data Movement and Relative Generations | Completed |

The progression is deliberately cumulative:

```text
JCL syntax
   |
   v
procedures
   |
   v
sequential datasets
   |
   v
PDS management
   |
   v
utility-driven operations
   |
   v
IDCAMS
   |
   v
GDGs
```

---

# Lab 01 — JCL Fundamentals

## Objective

Introduce the structure of a z/OS batch job and validate the basic relationship between JCL statements, JES2 submission and step execution.

Typical concepts include:

- JOB statement;
- EXEC statement;
- DD statement;
- step naming;
- dataset references;
- return codes;
- JES2 job submission;
- SDSF inspection.

This lab is the base dependency for every later JCL lab.

---

# Lab 02 — Cataloged Procedures and Symbolic Overrides

## Objective

Demonstrate reusable cataloged procedures and parameter substitution.

The lab introduces:

- PROC members;
- symbolic parameters;
- procedure invocation;
- parameter overrides;
- reusable execution patterns.

Conceptually:

```text
caller JCL
   |
   +--> EXEC PROC=
          |
          v
      cataloged procedure
          |
          +--> symbolic defaults
          +--> caller overrides
```

This is an important step toward maintainable enterprise batch design.

---

# Lab 03 — In-stream Procedures

## Objective

Demonstrate procedure definitions embedded directly inside a job rather than stored in a cataloged procedure library.

This allows comparison between:

```text
cataloged PROC
      vs
in-stream PROC
```

The lab helps clarify where procedure reuse belongs and how job-local procedure logic behaves.

---

# Lab 04 — Sequential PS Fixed Block

## Objective

Create and use a sequential Physical Sequential dataset with fixed-block characteristics.

Key areas include:

- dataset allocation;
- `RECFM=FB`;
- logical record length;
- block size;
- space allocation;
- disposition handling.

This establishes the first practical data-allocation foundation used by later application labs.

---

# Lab 05 — Sequential PS Variable Blocked

## Objective

Extend sequential dataset handling to variable-blocked records.

The lab introduces:

- `RECFM=VB`;
- variable record structure;
- record-length considerations;
- differences from fixed-block datasets;
- JCL allocation parameters.

Together, Labs 04 and 05 form the sequential dataset baseline.

---

# Lab 06 — Sequential Dataset Delete

## Objective

Demonstrate controlled deletion of a sequential dataset.

This reinforces lifecycle handling:

```text
allocate
   |
   v
use
   |
   v
retain / catalog
   |
   v
delete
```

Deletion is treated as a controlled dataset operation rather than a cleanup afterthought.

---

# Lab 07 — PDS Allocation and Member Management

## Objective

Move from sequential datasets to Partitioned Data Sets.

The lab covers the practical structure:

```text
PDS
 |
 +--> directory
 |
 +--> MEMBER1
 +--> MEMBER2
 +--> ...
```

Key areas include:

- PDS allocation;
- directory blocks;
- member creation;
- member management;
- dataset organization.

This lab is especially important because PDS libraries are heavily used for:

- JCL;
- procedures;
- source code;
- control statements;
- configuration members.

---

# Lab 08 — PS / PDS Data Set Operations

Lab 08 is divided into two repository parts.

## Part 1

Introduces controlled operations between sequential and partitioned datasets.

## Part 2

Continues the same data movement / management track.

The two parts should be read together as one progression.

They extend the repository from simple allocation into practical dataset manipulation.

---

# Lab 09 — IEBCOPY Select / Exclude PDS Members

## Objective

Use `IEBCOPY` for controlled PDS member operations.

The lab demonstrates selective processing rather than treating a PDS as an indivisible object.

Conceptually:

```text
source PDS
   |
   +--> selected members
   |
   v
IEBCOPY
   |
   v
target PDS
```

It also introduces exclusion logic for member-level operations.

This is directly relevant to:

- library maintenance;
- controlled promotion;
- source/member movement;
- backup-like workflows.

---

# Lab 10 — Advanced PDS Maintenance

The repository contains two Lab 10 paths:

```text
10-jcl-advanced-pds-maintenance-part-1-compress
10-jcl-advanced-pds-maintenance
```

These should be understood as one advanced PDS maintenance progression.

## Part 1 — Compress

Focuses on PDS compression / directory-space recovery concepts.

## Advanced continuation

Extends maintenance beyond the initial compression operation.

The key architectural point is that JCL is being used to drive system utilities for dataset lifecycle management.

---

# Lab 11 — IDCAMS Delete PS / PDS Member

## Objective

Introduce IDCAMS-driven delete operations.

This brings the repository into utility-oriented dataset control.

Conceptually:

```text
JCL
 |
 v
IDCAMS
 |
 v
catalog / dataset operation
```

IDCAMS becomes increasingly important when moving toward VSAM and more advanced catalog work.

---

# Lab 12 — Generation Data Groups

Lab 12 is split into two parts.

## Part 1 — GDG fundamentals

Introduces:

- GDG base;
- generations;
- relative generation references;
- creation of successive generations.

Conceptually:

```text
GDG base
 |
 +--> G0001V00
 +--> G0002V00
 +--> G0003V00
```

Applications normally reference generations relatively rather than by absolute generation name.

Examples:

```text
(+1) -> new generation
(0)  -> current generation
(-1) -> previous generation
```

## Part 2 — rollover and limit management

Extends the GDG model into:

- generation limits;
- rollover;
- retention behavior;
- generation lifecycle.

This moves the repository closer to realistic recurring batch processing.

---

# Lab 13 — GDG Data Movement and Relative Generations

## Objective

Use GDGs as active batch data rather than only defining them.

The lab extends the previous GDG foundation into:

- relative generation references;
- data movement;
- current and previous generation usage;
- generational batch workflows.

This is an important bridge toward scheduler-controlled recurring jobs.

Target pattern:

```text
daily job
   |
   +--> read previous generation
   |
   +--> create new generation
   |
   v
next scheduled cycle
```

---

## Current capability matrix

| Capability | Status |
|---|---|
| Basic JOB / EXEC / DD structure | Validated |
| JES2 batch submission model | Validated |
| Cataloged procedures | Validated |
| Symbolic parameters / overrides | Validated |
| In-stream procedures | Validated |
| PS allocation | Validated |
| Fixed-block datasets | Validated |
| Variable-blocked datasets | Validated |
| Controlled sequential dataset deletion | Validated |
| PDS allocation | Validated |
| PDS member management | Validated |
| PS / PDS operations | Validated |
| IEBCOPY select / exclude | Validated |
| PDS maintenance / compression | Validated |
| IDCAMS delete operations | Validated |
| GDG fundamentals | Validated |
| GDG rollover / limits | Validated |
| Relative GDG generations | Validated |
| GDG data movement | Validated |
| Scheduler-controlled JCL execution | Planned integration |
| USS / BPXBATCH execution | Planned integration |
| end-to-end application batch chain | Planned integration |

---

## Relationship with JES2

JCL describes the batch workload.

JES2 manages the submitted job through the JES execution environment.

```text
JCL
 |
 v
JES2
 |
 +--> input processing
 +--> execution
 +--> spool
 +--> job output
```

The central system-engineering repository owns deeper JES2 system administration.

`JCL_LABS` owns the workload-description side.

---

## Relationship with the scheduler

The scheduler sits above JCL.

Correct architecture:

```text
Scheduler
   |
   | orders / releases work
   v
JCL
   |
   v
JES2
   |
   v
program / utility
```

Therefore:

- Scheduler decides **when** and under what dependencies a workload runs.
- JCL defines **what** JES2 executes.
- JES2 provides the batch execution environment.

This separation is fundamental to the wider ecosystem.

---

## Relationship with COBOL

COBOL depends directly on JCL for traditional batch workflows.

Typical chain:

```text
source
  |
  v
compile JCL
  |
  v
compiler
  |
  v
object
  |
  v
link-edit
  |
  v
load module
  |
  v
execution JCL
```

The COBOL repository owns program logic.

This repository owns reusable JCL concepts and batch execution patterns.

---

## Relationship with VSAM

VSAM workflows commonly require JCL and utilities for:

- DEFINE;
- DELETE;
- REPRO;
- LISTCAT;
- dataset preparation;
- batch program execution.

The dependency is:

```text
JCL_LABS
   |
   v
VSAM utilities
   |
   v
VSAM datasets
```

The dedicated VSAM repository owns VSAM semantics.

JCL provides the batch control layer.

---

## Relationship with Db2

Db2 batch work can involve:

- utility jobs;
- precompile / compile / link-edit flows;
- DSN command processor execution;
- application execution;
- report jobs.

The long-term architecture is:

```text
JCL
 |
 v
COBOL / utility
 |
 v
Db2
```

Db2-specific database behavior remains owned by the Db2 repository.

---

## Relationship with CICS

CICS itself is online transaction processing rather than standard batch execution.

However, JCL remains relevant around:

- compilation;
- link-edit;
- BMS map processing;
- deployment preparation;
- utility or maintenance jobs.

Therefore JCL supports CICS development workflows without replacing CICS runtime administration.

---

## Relationship with USS

A future important integration is:

```text
JCL
 |
 +--> EXEC PGM=BPXBATCH
          |
          v
       USS shell
          |
          +--> command
          +--> script
          +--> process
```

The dedicated USS repository owns UNIX runtime behavior.

`JCL_LABS` owns the job structure used to enter USS.

---

## Relationship with RACF

RACF can control access to:

- datasets;
- procedures;
- operator facilities;
- submitted workload resources.

This repository should not duplicate security administration.

Instead, future cross-repository labs can demonstrate:

```text
RACF authorization
       |
       v
JCL execution
       |
       v
dataset / utility / application access
```

---

## Data lifecycle progression

One of the strongest progressions in the current repository is the move from individual datasets to managed recurring generations.

```text
PS
 |
 v
PDS
 |
 v
utility-based maintenance
 |
 v
GDG
 |
 v
relative generations
 |
 v
recurring batch data
```

This is the right foundation for enterprise scheduler integration.

---

## JCL review methodology

Before submission, JCL should be reviewed for predictable failure points.

Typical checks include:

- JOB statement syntax;
- EXEC syntax;
- PROC names;
- symbolic parameters;
- procedure overrides;
- DD names;
- dataset names;
- DISP;
- UNIT;
- SPACE;
- DCB;
- record format;
- LRECL;
- continuation rules;
- utility control statements;
- existing datasets;
- required libraries;
- compatibility with the ADCD environment.

The goal is not only to correct failures after execution.

The goal is to identify likely failures before SUBMIT whenever possible.

---

## Evidence methodology

Each lab should make the execution chain reproducible.

Useful evidence includes:

- JCL source;
- JES2 job ID;
- SDSF job output;
- step return codes;
- utility messages;
- dataset allocation results;
- ISPF dataset/member views;
- LISTCAT output where relevant;
- final dataset/member state;
- failure diagnosis;
- corrected rerun.

Engineering workflow:

```text
Build
  ->
Review
  ->
Submit
  ->
Observe
  ->
Diagnose
  ->
Correct
  ->
Rerun
  ->
Validate
  ->
Document
```

---

## Return codes and failures

A successful lab should not merely state that it worked.

The documentation should show:

- which step executed;
- what RC was returned;
- what changed;
- how the result was verified.

When a job fails, useful evidence includes:

```text
JCL ERROR
RC > 0
ABEND
utility-specific message
allocation failure
catalog failure
record-format mismatch
```

Failures that contribute to understanding should remain documented.

---

## Publication security

Before publishing JCL evidence, review it for unnecessary exposure of:

- host IP addresses;
- MAC addresses;
- hostnames;
- Windows paths;
- user-specific host information;
- terminal/session identifiers;
- credentials;
- tokens;
- secrets;
- private keys;
- environment-specific network details.

Dataset names and z/OS identifiers should only be retained when they are relevant and suitable for public documentation.

---

## Repository structure

Current high-level structure:

```text
.
├── README.md
├── docs/
│   └── ECOSYSTEM-INTEGRATION.md
└── labs/
    ├── 01-jcl-fundamentals/
    ├── 02-jcl-cataloged-procedures-symbolic-overrides/
    ├── 03-jcl-instream-procedures/
    ├── 04-jcl-sequential-ps-fixed-block/
    ├── 05-jcl-sequential-ps-variable-blocked/
    ├── 06-jcl-sequential-dataset-delete/
    ├── 07-jcl-pds-allocation-member-management/
    ├── 08-jcl-ps-pds-data-set-operations-part-1/
    ├── 08-jcl-ps-pds-data-set-operations-part-2/
    ├── 09-jcl-iebcopy-select-exclude-pds-members/
    ├── 10-jcl-advanced-pds-maintenance-part-1-compress/
    ├── 10-jcl-advanced-pds-maintenance/
    ├── 11-jcl-idcams-delete-ps-pds-member/
    ├── 12-jcl-generation-data-groups-part-1/
    ├── 12-jcl-generation-data-groups-part-2/
    └── 13-jcl-gdg-data-movement-relative-generations/
```

---

## Ecosystem integration

Detailed architecture:

[`docs/ECOSYSTEM-INTEGRATION.md`](docs/ECOSYSTEM-INTEGRATION.md)

This document defines:

- upstream dependencies;
- downstream consumers;
- scheduler boundary;
- JES2 boundary;
- COBOL / VSAM / Db2 relationships;
- USS integration;
- cross-repository lab chains;
- validated vs planned capabilities.

---

## Wider z/OS Engineering Laboratory

Master repository:

[`P-dot/zos-adcd-hercules-engineering-lab`](https://github.com/P-dot/zos-adcd-hercules-engineering-lab)

The wider architecture includes:

- `MVS_TSO_ISPF`
- `JCL_LABS`
- `zos-batch-scheduler`
- `COBOL`
- `vsam01`
- `DB2-`
- `CICS`
- `UNIX_System_Services-`
- `Rexx`
- `PL-I`
- `z_Assembly`
- `mainframe-racf-security-evidence`
- `zos-communications-server-network-lab`

JCL sits near the center because many other tracks ultimately require batch execution.

---

## Cross-repository integration tracks

### Scheduler + JCL + JES2

```text
Scheduler
   |
   v
JCL
   |
   v
JES2
   |
   v
RC / ABEND
   |
   v
Scheduler decision
```

### JCL + COBOL + VSAM

```text
JCL
 |
 v
COBOL
 |
 v
VSAM
```

### JCL + COBOL + Db2

```text
JCL
 |
 v
COBOL
 |
 v
Db2
```

### JCL + USS

```text
JCL
 |
 v
BPXBATCH
 |
 v
USS
```

### JCL + Storage / Backup

```text
JCL
 |
 v
utility
 |
 v
dataset / volume operation
```

---

## Planned maturity path

Current foundation:

```text
syntax
 ->
procedures
 ->
PS
 ->
PDS
 ->
utilities
 ->
IDCAMS
 ->
GDG
```

Next integration stage:

```text
scheduler
 ->
JCL / JES2
 ->
application workload
 ->
RC / ABEND
 ->
restart / rerun
```

Long-term end-to-end target:

```text
Scheduler
   |
   v
JCL / JES2
   |
   +--> IDCAMS / dataset preparation
   |
   +--> COBOL
   |
   +--> VSAM / Db2
   |
   +--> reporting / housekeeping
   |
   v
RC / ABEND
   |
   v
scheduler history / recovery
```

---

## Branch strategy

Recommended development flow:

```text
main
 |
 +-- lab/<number>-<slug>
 |
 +-- docs/<topic>
 |
 +-- integration/<cross-repo-topic>
 |
 +-- fix/<slug>
```

Branches should be short-lived:

```text
branch
 -> implement
 -> validate
 -> security review
 -> document
 -> PR
 -> merge
 -> delete
```

---

## Status

The repository currently provides a validated JCL progression through **Lab 13**, including:

- fundamentals;
- procedures;
- sequential datasets;
- PDS handling;
- IBM utility use;
- IDCAMS;
- GDGs;
- relative generation references;
- recurring-data patterns.

Its next strategic role is not to duplicate application repositories, but to support the first real cross-repository batch integration chain:

```text
Scheduler
  ->
JCL
  ->
JES2
  ->
workload
  ->
return code
  ->
scheduler decision
```

That is the natural next maturity step for the wider z/OS Engineering Laboratory.
