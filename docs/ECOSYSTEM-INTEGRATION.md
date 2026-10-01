# JCL Ecosystem Integration

## Purpose

This document defines how `JCL_LABS` participates in the wider IBM z/OS Engineering Portfolio without claiming capabilities that belong to other repositories.

The repository provides the reusable **batch workload-description and execution foundation** consumed by application, data, automation, and operations tracks.

```text
interactive operation
        |
        v
MVS_TSO_ISPF
        |
        v
    JCL_LABS
        |
        v
      JES2
        |
        v
 workload / utility
```

The repository validates JCL mechanics and their observable JES2 execution results. Specialized subsystem and application behavior remains owned by the corresponding domain repository.

## Ownership Boundary

### Owned here

`JCL_LABS` owns reusable evidence for:

- JOB, EXEC and DD statement patterns;
- JES2 submission from the workload side;
- cataloged procedures;
- symbolic parameters and overrides;
- in-stream procedures;
- sequential data-set allocation and lifecycle operations;
- PDS allocation and member-oriented operations;
- IEBCOPY-driven member processing;
- PDS maintenance;
- IDCAMS operations demonstrated by the labs;
- GDG creation, rollover, limits and relative generations;
- GDG data movement;
- DFSORT positional character-key ascending sort;
- return-code and utility-message observation;
- controlled failure, diagnosis, correction and rerun patterns.

### Not owned here

The repository does not replace:

- `MVS_TSO_ISPF` for TSO/E and ISPF fundamentals;
- the core engineering repository for JES2 system administration;
- `zos-batch-scheduler` for orchestration and workload scheduling;
- `COBOL`, `PL-I`, or `z_Assembly` for language semantics;
- `vsam01` for VSAM organization and behavior;
- `DB2-` for Db2 SQL, catalog and database behavior;
- `CICS` for online transaction runtime behavior;
- `Rexx` for REXX language and automation logic;
- `UNIX_System_Services-` for USS runtime behavior;
- `mainframe-racf-security-evidence` for RACF policy and authorization;
- `zos-communications-server-network-lab` for Communications Server networking;
- diagnostic/recovery repositories for system-wide problem determination and recovery.

The rule is:

```text
validate reusable batch mechanics here
             |
             v
consume them from specialized repositories
             |
             v
validate target-domain behavior there
```

## Validated Repository Progression

### Stage A — JCL and JES2 foundation

**Lab 01 — JCL Fundamentals**

Establishes the JOB / EXEC / DD structure and the basic relationship between JCL submission, JES2 execution, step completion, and output inspection.

Status: **VALIDATED LOCALLY**

### Stage B — Reusable procedure mechanics

**Labs 02–03**

The repository moves from direct job definitions to reusable execution structures:

```text
cataloged PROC
      |
      +--> symbolic defaults
      +--> caller overrides

in-stream PROC
      |
      +--> job-local procedure definition
```

Status: **VALIDATED LOCALLY**

### Stage C — Sequential data-set lifecycle

**Labs 04–06**

The sequence establishes:

```text
PS allocation
   |
   +--> FB
   +--> VB
   |
   v
controlled use / catalog state
   |
   v
controlled deletion
```

Status: **VALIDATED LOCALLY**

### Stage D — PDS and member operations

**Labs 07–10**

The repository expands into partitioned data sets and utility-driven member management:

```text
PDS allocation
     |
     v
member management
     |
     v
PS / PDS movement
     |
     v
IEBCOPY select / exclude
     |
     v
PDS compression / maintenance
```

Status: **VALIDATED LOCALLY**

### Stage E — IDCAMS lifecycle operations

**Lab 11**

IDCAMS is introduced as a batch utility for controlled data-set/member deletion within the scope demonstrated by the lab.

Status: **VALIDATED LOCALLY**

This does not transfer VSAM ownership to `JCL_LABS`; VSAM-specific semantics remain in `vsam01`.

### Stage F — Generation Data Groups

**Labs 12–13**

The progression moves from GDG definition and lifecycle behavior into active relative-generation data movement:

```text
GDG base
   |
   v
generation creation
   |
   v
limit / rollover behavior
   |
   v
relative references
   |
   v
data movement between generations
```

Status: **VALIDATED LOCALLY**

This is an important batch foundation for future recurring and scheduler-controlled workload patterns, but scheduler integration must be evidenced separately.

### Stage G — DFSORT

**Lab 14 — DFSORT Fundamentals: Character Key Ascending Sort**

Lab 14 validates a controlled `FB 80` record-processing scenario using:

```text
PGM=SORT
SORTIN
SORTOUT
SYSIN
SYSOUT
SORT FIELDS=(1,5,CH,A)
```

The expected key order was defined before execution:

```text
A0005
A0010
B0020
C0010
C0050
D0040
```

The first input-creation execution deliberately remains in the evidence chain:

```text
incorrect DDNAME
SYSUT
   |
   v
IEC130I / IEB316I
   |
   v
CC=0012
   |
   v
diagnose
   |
   v
correct to SYSUT1
   |
   v
CC=0000
```

The corrected sort then proved:

```text
6 records x 80 bytes = 480 bytes
            |
            v
       DFSORT processing
            |
            v
ascending five-byte CH key
            |
            v
data-level output verification
```

Status: **VALIDATED LOCALLY**

The claim is intentionally scoped to the demonstrated DFSORT capability; it is not a claim of comprehensive DFSORT coverage.

## Batch Execution Model

JCL and JES2 are related but not interchangeable.

```text
JCL
 |
 | describes job steps, programs and resources
 v
JES2
 |
 | receives and manages submitted batch work
 v
z/OS execution environment
 |
 v
program / utility
```

`JCL_LABS` owns the workload-description side and evidence from execution. System-level JES2 configuration and administration remain outside this repository.

## Interactive-to-Batch Boundary

`MVS_TSO_ISPF` is the upstream operational foundation.

```text
3270
 |
 v
TSO/E
 |
 v
ISPF
 |
 +--> edit JCL member
 |
 +--> submit
 |
 v
JES2
```

The TSO/ISPF repository owns the interactive environment. `JCL_LABS` owns the JCL and general batch mechanics.

The existence of this natural handoff does not mean every TSO/ISPF-to-JCL scenario is automatically a separately validated cross-repository production track.

## Scheduler Boundary

The scheduler sits above JCL and JES2:

```text
zos-batch-scheduler
        |
        | order / dependencies / calendar / operational state
        v
       JCL
        |
        | workload definition
        v
      JES2
        |
        | execution / spool / result
        v
  RC / ABEND / messages
        |
        v
 scheduler observation / decision
```

`JCL_LABS` does not own:

- calendars;
- cyclic scheduling;
- dependencies;
- scheduler resources;
- active-job state;
- scheduler history;
- orchestration policy.

Scheduler-controlled end-to-end execution remains a **cross-domain capability requiring its own evidence** unless a dedicated integration lab proves it.

## Application and Data Consumers

### COBOL

Traditional COBOL batch workflows consume JCL for compile, link-edit and execution.

```text
JCL
 |
 v
compiler / linkage / program
 |
 v
application result
```

`COBOL` owns program semantics. `JCL_LABS` owns the reusable batch mechanics.

### VSAM

JCL and IDCAMS can drive VSAM-oriented operations, but:

```text
JCL / IDCAMS mechanics -> JCL_LABS
VSAM semantics         -> vsam01
```

A JCL lab using IDCAMS does not by itself validate the VSAM domain.

### Db2

Db2 utilities and application jobs may consume JCL/JES2 execution.

Db2 SQL, catalog behavior, application database semantics, authorization behavior, and Db2-specific diagnostics remain owned by `DB2-`.

### CICS

CICS is an online transaction environment, but JCL can support surrounding build, deployment, BMS, utility, or maintenance workflows.

CICS runtime behavior remains owned by `CICS`.

### PL/I and HLASM

Compile, linkage and execution workflows consume the same general batch foundation. Language semantics remain in `PL-I` and `z_Assembly`.

## Automation Consumers

### REXX

A validated REXX repository path can consume JCL through `IRXJCL`:

```text
JCL
 |
 v
IRXJCL
 |
 v
REXX EXEC
```

Where that behavior is evidenced in the REXX repository, classify it as **VALIDATED IN TARGET REPOSITORY**, not as a locally implemented REXX capability in `JCL_LABS`.

### USS

A future integration pattern can use JCL to enter USS through `BPXBATCH`:

```text
JCL
 |
 v
BPXBATCH
 |
 v
USS shell / process
```

Until demonstrated by evidence, this remains **PLANNED / CROSS-DOMAIN**, not a validated local capability.

## Data Lifecycle Architecture

The local lab sequence creates a coherent data-lifecycle progression:

```text
PS
 |
 +--> FB
 +--> VB
 |
 v
PDS
 |
 v
member operations
 |
 v
IEBCOPY / maintenance
 |
 v
IDCAMS
 |
 v
GDG
 |
 v
relative generations
 |
 v
DFSORT processing
```

This is a batch-control progression. It must not be interpreted as ownership of every underlying storage or data subsystem.

## Evidence Model

The common evidence cycle is:

```text
BUILD
  |
  v
REVIEW
  |
  v
EXECUTE
  |
  v
OBSERVE
  |
  +--> RC / condition code
  +--> JES / utility messages
  +--> spool
  +--> catalog / allocation state
  +--> data state
  |
  v
DIAGNOSE
  |
  v
CORRECT
  |
  v
RERUN
  |
  v
VALIDATE
  |
  v
DOCUMENT
```

A claim should be tied to observable evidence appropriate to the operation.

For example:

```text
job submitted
    !=
capability validated
```

Validation requires the relevant execution result and resulting state.

## Failure and Recovery Evidence

Failure is useful when it explains system behavior.

The preferred documentation chain is:

```text
expected state
      |
      v
execution
      |
      v
observable failure
      |
      v
diagnostic message / RC / ABEND
      |
      v
root-cause analysis
      |
      v
controlled correction
      |
      v
rerun
      |
      v
final verification
```

Lab 14 provides a concrete example with the `SYSUT` versus `SYSUT1` DDNAME error and `CC=0012 -> CC=0000` recovery chain.

## Architecture V2 Lifecycle

The portfolio lifecycle is:

```text
Discover
   ->
Baseline
   ->
Configure
   ->
Operate
   ->
Observe
   ->
Diagnose
   ->
Recover
   ->
Improve
   ->
Automate
   ->
Integrate
```

Not every lab traverses every stage. The applicable stages depend on the capability being exercised.

## Maturity Model

```text
M0  Exploratory
M1  Foundational
M2  Operational
M3  Resilient
M4  Automated
M5  Integrated
```

Maturity is **capability-scoped**.

For example, a lab that demonstrates diagnosis and successful correction may show resilient behavior for that scenario without making the entire JCL repository `M3`.

## Integration Model

```text
I0  Standalone
I1  Cross-component
I2  Cross-repository
I3  Production-like
```

The same discipline applies to integration state. A diagram describing a future multi-repository path is architecture, not proof that the path is already I2 or I3.

## Validation Classification

Use four practical states in public documentation:

| State | Meaning |
| --- | --- |
| `VALIDATED LOCALLY` | Demonstrated by evidence inside `JCL_LABS` |
| `VALIDATED IN TARGET REPOSITORY` | Demonstrated by evidence owned by another repository |
| `CROSS-DOMAIN / REQUIRES EVIDENCE` | Architecture is defined but the complete path needs dedicated proof |
| `PLANNED` | Roadmap capability, not completed work |

This prevents architectural relationships from being mistaken for validated integrations.

## Current Integration Matrix

| Relationship | Classification | Ownership |
| --- | --- | --- |
| TSO/E / ISPF as interactive foundation | Foundational dependency | `MVS_TSO_ISPF` |
| JCL -> JES2 workload execution | VALIDATED LOCALLY | `JCL_LABS` workload side |
| Procedures / overrides / in-stream PROCs | VALIDATED LOCALLY | `JCL_LABS` |
| PS / PDS operations | VALIDATED LOCALLY | `JCL_LABS` |
| IEBCOPY / PDS maintenance | VALIDATED LOCALLY | `JCL_LABS` |
| IDCAMS operations demonstrated here | VALIDATED LOCALLY | `JCL_LABS` |
| GDG workflows | VALIDATED LOCALLY | `JCL_LABS` |
| DFSORT Lab 14 scenario | VALIDATED LOCALLY | `JCL_LABS` |
| JCL -> REXX through IRXJCL | VALIDATED IN TARGET REPOSITORY | `Rexx` |
| JCL -> specialized application/data behavior | TARGET-DOMAIN VALIDATION | target repository |
| Scheduler -> JCL -> JES2 | CROSS-DOMAIN / REQUIRES EVIDENCE | scheduler + JCL |
| JCL -> BPXBATCH -> USS | PLANNED / CROSS-DOMAIN | JCL + USS |
| End-to-end production cycle | PLANNED | portfolio integration track |

## Production-Track Relationships

### Enterprise Batch Operations

Target architecture:

```text
scheduler
   |
   v
JCL / JES2
   |
   +--> workload
   |
   v
RC / ABEND
   |
   v
diagnosis / restart / rerun
```

`JCL_LABS` supplies the batch mechanics. The full production track requires evidence from scheduler and diagnostic/recovery domains.

### Secure Batch Application

Target architecture can combine:

```text
scheduler / JCL
       |
       v
authorization
       |
       v
application / data
       |
       v
audit / observation
```

Security behavior must be evidenced by the RACF/security domain rather than inferred from successful JCL execution.

### Operations Automation

Automation can consume batch mechanics through REXX, scheduler workflows, or USS. Each integration must retain clear ownership and evidence boundaries.

## Repository-to-Repository Flow

The natural learning and operations sequence is:

```text
MVS_TSO_ISPF
      |
      v
JCL_LABS
      |
      v
zos-batch-scheduler
      |
      +--> application workloads
      +--> data workloads
      +--> automation
      +--> security controls
      +--> diagnostics / recovery
```

This sequence describes portfolio navigation. It does not assert that every downstream path has already been validated end to end.

## Current Validated Boundary

The current local evidence supports:

```text
JCL fundamentals ......................... VALIDATED LOCALLY
cataloged procedures / overrides ......... VALIDATED LOCALLY
in-stream procedures ..................... VALIDATED LOCALLY
PS allocation and lifecycle .............. VALIDATED LOCALLY
PDS/member operations .................... VALIDATED LOCALLY
IEBCOPY / PDS maintenance ................ VALIDATED LOCALLY
IDCAMS operations demonstrated by labs ... VALIDATED LOCALLY
GDG workflows ............................ VALIDATED LOCALLY
DFSORT Lab 14 scenario ................... VALIDATED LOCALLY
```

Cross-domain states:

```text
JCL -> REXX / IRXJCL ..................... VALIDATED IN TARGET REPOSITORY
Scheduler -> JCL -> JES2 ................. REQUIRES DEDICATED INTEGRATION EVIDENCE
JCL -> BPXBATCH -> USS ................... PLANNED / CROSS-DOMAIN
end-to-end production cycle .............. PLANNED
```

## Development Direction

Future work should extend the quality and reusability of batch patterns rather than duplicating application repositories.

Useful directions include deeper JCL/JES2 operational scenarios, richer DFSORT capabilities, reusable application execution patterns, scheduler-controlled workloads, and failure/restart/rerun integration.

Each new capability should move through the same evidence gate:

```text
IMPLEMENT
   ->
EXECUTE
   ->
OBSERVE
   ->
VALIDATE
   ->
CLASSIFY
   ->
PUBLISH
```

Only after validation should a roadmap item be promoted to a validated state.

## Publication Security

Before publication, inspect JCL, spool captures, terminal screenshots, documentation, and diagnostic output for:

- credentials and secrets;
- private keys or tokens;
- private IP addresses;
- MAC addresses;
- host adapter identifiers;
- unnecessary hostnames;
- local workstation paths;
- terminal/session identifiers;
- environment-specific network details.

Retain identifiers such as data-set names only when they materially support the evidence and are appropriate for public publication.

## Engineering Principle

`JCL_LABS` should answer four questions for every capability:

```text
What was submitted?
What did JES2 / the utility actually do?
What observable evidence proves the result?
Who owns the next layer of behavior?
```

That keeps the repository useful as both a learning track and a professional engineering evidence base.

---

[Back to repository README](../README.md) · [Workload Automation](https://github.com/P-dot/zos-batch-scheduler) · [Master Engineering Laboratory](https://github.com/P-dot/zos-adcd-hercules-engineering-lab) · [Portfolio](https://github.com/P-dot/P-dot)
