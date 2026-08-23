# Execution Runbook — Lab 08 Part 1

## 1. Create/load input

Submit:

    IBMUSER.JCL.LAB(L08DATA)

Validate in SDSF:

    CREATE ... COND CODE 0000

Browse:

    IBMUSER.JCLLAB08.INPUT

Confirm the five expected records.

## 2. Copy input to output

Submit:

    IBMUSER.JCL.LAB(L08COPY)

Validate in SDSF:

    COPYPS ... COND CODE 0000

Confirm allocation messages show the source kept and the output cataloged.

Browse:

    IBMUSER.JCLLAB08.OUTPUT

Confirm the five expected records.

## 3. Stop point

Do not delete the Lab 08 data sets as part of Part 1. They can be retained for
the continuation into Part 2.
