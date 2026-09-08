# JCL Ecosystem Integration

## Role

This repository provides the batch execution backbone of the broader z/OS Engineering Laboratory.

Its purpose is to establish reusable JCL, procedure, dataset and utility patterns that other application and operations repositories can consume without duplicating JCL fundamentals.

JCL is not the scheduler and it is not the application logic. It is the execution description used by JES2 to run batch work.

```text
MVS_TSO_ISPF
     |
     v
    JCL
     |
     v
   JES2
   / | \
  v  v  v
COBOL VSAM DB2
   \  |  /
    v v v
zos-batch-scheduler
```

## Upstream Dependencies

### MVS_TSO_ISPF

Provides the interactive environment used to create, edit, submit and inspect JCL members.

Relationship:

```text
MVS_TSO_ISPF -> JCL_LABS
```

Status: **Foundational dependency**

### z/OS Engineering Laboratory

Provides the common ADCD/Hercules environment, JES2 context, system-engineering methodology and ecosystem architecture.

Status: **Active architectural dependency**

## Downstream Consumers

### COBOL

COBOL programs require JCL for compile, link-edit and batch execution workflows.

Relationship:

```text
JCL_LABS -> COBOL
```

Status: **Validated foundation**

### VSAM

VSAM definition, loading, inspection and application access frequently depend on JCL and utilities such as IDCAMS.

Relationship:

```text
JCL_LABS -> VSAM
```

Status: **Validated foundation**

### DB2

Db2 batch utilities, application execution and later production-style workflows consume JCL/JES2 execution.

Relationship:

```text
JCL_LABS -> DB2
```

Status: **Foundational dependency**

### REXX

Batch REXX execution through `IRXJCL` consumes the JCL/JES2 model established here.

Relationship:

```text
JCL_LABS -> IRXJCL -> REXX
```

Status: **Validated in the REXX repository**

### PL/I and Assembler

Compilation, linkage and execution workflows for PL/I and HLASM consume the same batch foundation.

Status: **Foundational dependency**

### zos-batch-scheduler

The scheduler sits above JCL and JES2. It orders and tracks jobs, but JES2 remains the execution engine and JCL remains the workload description.

Relationship:

```text
zos-batch-scheduler
        |
        v
       JCL
        |
        v
      JES2
```

Status: **Planned cross-repository integration**

## Consumes

This repository consumes:

- TSO/E and ISPF for interactive editing and submission;
- JES2 for batch execution;
- z/OS datasets and catalog services;
- standard z/OS utilities used from JCL;
- system resources provided by the ADCD environment.

## Produces

The repository currently produces reusable patterns for:

- JOB, EXEC and DD statements;
- cataloged procedures;
- symbolic parameters and overrides;
- in-stream procedures;
- sequential datasets;
- partitioned datasets and member management;
- dataset copy and maintenance workflows;
- IDCAMS operations;
- generation data groups;
- utility-driven batch processing;
- repeatable JES2 execution and validation.

The repository therefore acts as a shared batch foundation for higher-level application and operational labs.

## Validated Capability Areas

The current lab tree demonstrates a mature progression that includes:

```text
JCL fundamentals
      |
      v
cataloged procedures
      |
      v
symbolic overrides
      |
      v
in-stream procedures
      |
      v
PS dataset operations
      |
      v
PDS/member operations
      |
      v
IEBCOPY / PDS maintenance
      |
      v
IDCAMS
      |
      v
GDG workflows
```

These capabilities are validated inside `JCL_LABS`.

## Validated Cross-Repository Paths

### Interactive-to-batch foundation

```text
MVS_TSO_ISPF
      |
      v
JCL member
      |
      v
   submit
      |
      v
    JES2
```

Status: **Validated operational pattern**

### JCL to application workloads

```text
JCL
 |
 +--> COBOL
 +--> VSAM utilities
 +--> Db2 workloads
 +--> PL/I
 +--> HLASM
```

Status: **Foundation validated; individual workload validation belongs to the target repository**

### Batch REXX

```text
JCL
 |
 v
IRXJCL
 |
 v
REXX EXEC
 |
 v
JES2 result
```

Status: **Validated in REXX Lab 02**

## Planned Cross-Repository Paths

The following are architectural targets and must not be interpreted as completed integrations.

### Scheduler submission path

```text
zos-batch-scheduler
        |
        v
      ORDER
        |
        v
      READY
        |
        v
       JCL
        |
        v
      JES2
        |
        v
RC / ABEND / JOBID
        |
        v
scheduler state/history
```

### Secure batch application track

```text
JCL / Scheduler
      |
      v
     RACF
      |
      v
     VSAM
      |
      v
    COBOL
      |
      v
     SMF
```

### Enterprise batch operations track

```text
Scheduler
   |
   v
JCL / JES2
   |
   +--> COBOL
   +--> DB2
   +--> VSAM
   |
   v
backup / monitoring / recovery
```

### Batch failure and recovery track

```text
Scheduler
   |
   v
  JCL
   |
   v
 JES2
   |
 failure
   |
   v
SDSF diagnosis
   |
 correction
   |
 restart / rerun
   |
 resume
```

## Integration Status

| Integration | Status | Evidence |
| --- | --- | --- |
| TSO/ISPF -> JCL editing/submission | Validated foundation | JCL labs and operator workflow |
| JCL -> JES2 | Validated | Core repository behavior |
| Procedures / overrides / in-stream PROCs | Validated | Labs 01-03 |
| PS/PDS operations | Validated | Labs 04 onward |
| IDCAMS / GDG patterns | Validated | Repository labs |
| JCL -> REXX through IRXJCL | Validated | REXX Lab 02 |
| JCL -> COBOL / VSAM / DB2 / PL/I / HLASM | Foundational | Target repositories own workload validation |
| Scheduler -> JCL -> JES2 | Planned integration | Scheduler roadmap |
| End-to-end production cycle | Planned | Ecosystem integration roadmap |

## Scope Boundaries

This repository owns JCL and general batch execution patterns.

It does **not** replace:

- `MVS_TSO_ISPF` for TSO/E and ISPF fundamentals;
- `zos-batch-scheduler` for ordering, dependencies, calendars, active-job state and orchestration;
- `COBOL` for application language logic;
- `vsam01` for VSAM-specific data organization and application behavior;
- `DB2-` for Db2 SQL, catalog and application topics;
- `Rexx` for REXX language and automation logic;
- `PL-I` for PL/I programming;
- `z_Assembly` for HLASM and low-level programming;
- `mainframe-racf-security-evidence` for RACF policy and authorization;
- the core z/OS Engineering Laboratory for JES2 and system-level engineering.

The integration rule is:

```text
Define and validate reusable batch mechanics here.
Consume those mechanics from specialized repositories.
Do not duplicate their application or subsystem domains inside JCL_LABS.
```

## Development Direction

The JCL track should evolve from isolated syntax and utility exercises toward reusable production-style batch patterns.

```text
JCL fundamentals
      |
      v
procedures and overrides
      |
      v
dataset lifecycle
      |
      v
utilities and GDGs
      |
      v
application execution patterns
      |
      v
scheduler-controlled execution
      |
      v
failure / restart / rerun
      |
      v
cross-repository production cycle
```

The next architectural priority is not to duplicate more application logic inside this repository, but to expose clean JCL patterns that can be consumed by scheduler and application integration labs.

## Engineering and Publication Rules

Cross-repository work should follow the common engineering cycle:

```text
Build -> Execute -> Observe -> Diagnose -> Correct -> Validate -> Document
```

Before publication:

- validate syntax and execution results;
- preserve RC, condition-code and failure evidence where relevant;
- distinguish reusable JCL mechanics from application-specific behavior;
- distinguish validated functionality from planned integration targets;
- do not publish credentials, IP addresses, MAC addresses, terminal/network identifiers or host-side network details;
- use short-lived integration branches and merge completed work into `main`.

## Master Architecture

The broader ecosystem architecture is maintained in:

https://github.com/P-dot/zos-adcd-hercules-engineering-lab
