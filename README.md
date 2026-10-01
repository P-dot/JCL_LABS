# JCL Engineering Labs — z/OS Batch Execution

Hands-on **Job Control Language (JCL)** engineering labs for z/OS ADCD / Hercules, built around reproducible JES2 execution, return-code analysis, data-set lifecycle operations, IBM utilities, and evidence-driven troubleshooting.

> **Validated scope:** Labs 01–14
> **Latest validated capability:** DFSORT character-key ascending sort
> **Architecture:** Portfolio Navigation V2 / Engineering Control

## Navigate

- [Labs](#validated-lab-progression)
- [Ecosystem Integration](docs/ECOSYSTEM-INTEGRATION.md)
- [MVS TSO/ISPF](https://github.com/P-dot/MVS_TSO_ISPF)
- [Workload Automation](https://github.com/P-dot/zos-batch-scheduler)
- [z/OS Engineering Laboratory](https://github.com/P-dot/zos-adcd-hercules-engineering-lab)
- [Portfolio](https://github.com/P-dot/P-dot)

## Repository Role

`JCL_LABS` owns the **general batch workload-description and execution patterns** used throughout the portfolio.

It demonstrates how JCL describes work submitted to JES2, how programs and IBM utilities receive their resources through DD statements, how data sets move through controlled lifecycles, and how execution results are validated from return codes, messages, spool output, and final data state.

```text
MVS_TSO_ISPF
     |
     | interactive creation / editing / submission
     v
 JCL_LABS
     |
     | JOB / EXEC / DD / PROC / utility control
     v
   JES2
     |
     | execution / spool / RC / messages
     v
 workload or utility
```

The repository does **not** own scheduler orchestration, application logic, RACF policy, VSAM organization, Db2 behavior, CICS runtime administration, REXX language semantics, or system-level JES2 administration.

## Batch Execution Boundary

The portfolio separates orchestration, workload description, and execution:

```text
zos-batch-scheduler
        |
        | when / dependencies / operational state
        v
       JCL
        |
        | what is executed and with which resources
        v
      JES2
        |
        | batch execution / spool
        v
 program / utility
```

This boundary prevents the scheduler repository, JCL repository, and application repositories from duplicating one another.

## Capability Progression

```text
JCL FUNDAMENTALS
  Lab 01
      |
      v
PROCEDURES
  Labs 02-03
      |
      v
SEQUENTIAL DATA SETS
  Labs 04-06
      |
      v
PDS / MEMBER OPERATIONS
  Labs 07-10
      |
      v
IDCAMS
  Lab 11
      |
      v
GDG WORKFLOWS
  Labs 12-13
      |
      v
DFSORT
  Lab 14
      |
      v
CROSS-DOMAIN HANDOFF
  scheduler / applications / data / automation
```

## Validated Lab Progression

| Lab | Capability | Evidence state |
| --- | --- | --- |
| [01](labs/01-jcl-fundamentals/) | JOB / EXEC / DD fundamentals and JES2 submission | VALIDATED |
| [02](labs/02-jcl-cataloged-procedures-symbolic-overrides/) | Cataloged procedures, symbolic parameters and overrides | VALIDATED |
| [03](labs/03-jcl-instream-procedures/) | In-stream procedures | VALIDATED |
| [04](labs/04-jcl-sequential-ps-fixed-block/) | Sequential PS allocation — fixed block | VALIDATED |
| [05](labs/05-jcl-sequential-ps-variable-blocked/) | Sequential PS allocation — variable blocked | VALIDATED |
| [06](labs/06-jcl-sequential-dataset-delete/) | Controlled sequential data-set deletion | VALIDATED |
| [07](labs/07-jcl-pds-allocation-member-management/) | PDS allocation and member management | VALIDATED |
| [08 Part 1](labs/08-jcl-ps-pds-data-set-operations-part-1/) | PS / PDS data-set operations | VALIDATED |
| [08 Part 2](labs/08-jcl-ps-pds-data-set-operations-part-2/) | Continued PS / PDS data-set operations | VALIDATED |
| [09](labs/09-jcl-iebcopy-select-exclude-pds-members/) | IEBCOPY select / exclude member operations | VALIDATED |
| [10 Part 1](labs/10-jcl-advanced-pds-maintenance-part-1-compress/) | PDS compression | VALIDATED |
| [10](labs/10-jcl-advanced-pds-maintenance/) | Advanced PDS maintenance | VALIDATED |
| [11](labs/11-jcl-idcams-delete-ps-pds-member/) | IDCAMS delete operations | VALIDATED |
| [12 Part 1](labs/12-jcl-generation-data-groups-part-1/) | GDG fundamentals and generation creation | VALIDATED |
| [12 Part 2](labs/12-jcl-generation-data-groups-part-2/) | GDG rollover and limit management | VALIDATED |
| [13](labs/13-jcl-gdg-data-movement-relative-generations/) | GDG data movement and relative generations | VALIDATED |
| [14](labs/14-jcl-dfsort-fundamentals-character-ascending-sort/) | DFSORT positional character-key ascending sort | VALIDATED |

The numbering reflects the historical lab sequence; Labs 08, 10 and 12 contain multiple repository parts.

## Lab 14 — DFSORT Validation

Lab 14 extends the repository from data-set lifecycle mechanics into deterministic record processing.

The validated control statement is:

```text
SORT FIELDS=(1,5,CH,A)
```

The lab deliberately retained a failed first execution caused by an incorrect IEBGENER input DDNAME:

```text
SYSUT instead of SYSUT1
    |
    v
CC=0012
    |
    v
diagnose DDNAME failure
    |
    v
correct JCL and remove failed NEW data set
    |
    v
CC=0000
```

The corrected DFSORT run then validated:

```text
6 FB 80 records
      |
      v
480 bytes processed
      |
      v
ascending five-byte character key
      |
      v
output order verified in ISPF Browse
```

The failure is part of the engineering evidence rather than being removed from the history.

## Data Lifecycle Progression

A major repository thread is the transition from individual data sets to repeatable batch data patterns:

```text
PS
 |
 v
PDS
 |
 v
member-level utility operations
 |
 v
IDCAMS-driven lifecycle operations
 |
 v
GDG
 |
 v
relative generations
 |
 v
recurring batch data
 |
 v
DFSORT processing
```

Specialized repositories retain ownership of their own data models. For example, `vsam01` owns VSAM-specific behavior even when JCL and IDCAMS are used to execute the work.

## Execution and Evidence Model

The repository uses the common engineering cycle:

```text
BUILD
  ->
REVIEW
  ->
EXECUTE
  ->
OBSERVE
  ->
DIAGNOSE
  ->
CORRECT
  ->
RERUN
  ->
VALIDATE
  ->
DOCUMENT
```

Evidence may include JCL source, JES2 job identifiers, SDSF output, step return codes, utility messages, allocation/catalog results, ISPF views, final data state, failure diagnosis, and corrected reruns.

A successful job is not treated as proven merely because it was submitted. The relevant step result and resulting system or data state must be verified.

## Failure and Recovery

Batch failures are retained when they contribute engineering value.

Examples across this domain can include:

```text
JCL ERROR
RC / condition code > 0
ABEND
allocation failure
catalog failure
utility-specific diagnostic
record-format mismatch
```

The documentation should connect the observable symptom to the correction and final validation rather than presenting only the successful rerun.

## Architecture V2

Architecture V2 classifies capabilities individually rather than assigning one maturity label to an entire repository.

Typical capability progression:

```text
M0 Exploratory
 -> M1 Foundational
 -> M2 Operational
 -> M3 Resilient
 -> M4 Automated
 -> M5 Integrated
```

Integration progression:

```text
I0 Standalone
 -> I1 Cross-component
 -> I2 Cross-repository
 -> I3 Production-like
```

A locally validated JCL capability does not automatically prove an end-to-end cross-repository integration.

## Cross-Domain Handoffs

The repository provides reusable batch mechanics to specialized domains:

```text
JCL / JES2
   |
   +--> COBOL        application batch execution
   +--> VSAM         utility and application data workflows
   +--> Db2          utilities / application execution
   +--> PL/I         compile / link / execute workflows
   +--> HLASM        assemble / link / execute workflows
   +--> REXX         IRXJCL batch execution
   +--> USS          BPXBATCH-oriented future integration
```

The target repository owns validation of the target-domain behavior.

The scheduler boundary is the inverse relationship: `zos-batch-scheduler` consumes JCL workloads and owns ordering, dependencies, calendars, active-job state, and orchestration.

## Validation States

Use these states consistently:

```text
VALIDATED LOCALLY
    capability proven inside JCL_LABS

VALIDATED IN TARGET REPOSITORY
    integration or workload behavior proven by another repository

CROSS-DOMAIN / REQUIRES EVIDENCE
    architecture is defined but the end-to-end path needs dedicated evidence

PLANNED
    roadmap capability, not completed work
```

Existence of a related repository is not evidence that an integration path has been validated.

## Repository Structure

```text
.
├── README.md
├── docs/
│   └── ECOSYSTEM-INTEGRATION.md
└── labs/
    ├── 01-jcl-fundamentals/
    ├── ...
    ├── 13-jcl-gdg-data-movement-relative-generations/
    └── 14-jcl-dfsort-fundamentals-character-ascending-sort/
```

Individual lab directories own their implementation, evidence, operational notes, and supporting material.

## Publication Security

Before publishing evidence, review it for credentials, secrets, private keys, private network details, MAC addresses, host adapter identifiers, unnecessary hostnames, local paths, terminal/session identifiers, and other environment-specific information that does not contribute to the technical proof.

z/OS identifiers and data-set names should remain only when they are technically relevant and suitable for public documentation.

## Current Boundary

Validated locally:

```text
JCL fundamentals
procedures and overrides
PS / PDS lifecycle operations
IEBCOPY / PDS maintenance
IDCAMS operations
GDG workflows
DFSORT character-key ascending sort
```

Cross-domain integration must be classified separately.

The strategic continuation is not to duplicate application logic inside `JCL_LABS`, but to expose stable batch patterns that can be consumed by application, automation, scheduler, security, and recovery tracks.

## Continue Through the Portfolio

```text
MVS_TSO_ISPF
      |
      v
JCL_LABS
      |
      v
zos-batch-scheduler
      |
      +--> automation
      +--> application/data workloads
      +--> security
      +--> diagnostics/recovery
```

- [Ecosystem Integration](docs/ECOSYSTEM-INTEGRATION.md)
- [Workload Automation](https://github.com/P-dot/zos-batch-scheduler)
- [Master z/OS Engineering Laboratory](https://github.com/P-dot/zos-adcd-hercules-engineering-lab)
- [IBM z/OS Engineering Portfolio](https://github.com/P-dot/P-dot)
