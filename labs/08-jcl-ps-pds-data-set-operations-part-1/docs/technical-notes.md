# Technical Notes — Lab 08 Part 1

## IEBGENER

IEBGENER is used here in its basic sequential-copy role.

The four DD names used are:

- `SYSUT1`: input
- `SYSUT2`: output
- `SYSPRINT`: utility messages
- `SYSIN`: control statements

For the simple copies in this lab, no control statements are required, so
`SYSIN DD DUMMY` is used.

## In-stream input

`SYSUT1 DD *` means that the records following the DD statement are supplied
inside the JCL stream. `/*` terminates the in-stream data.

## SPACE=(TRK,(1,1))

`TRK` says that allocation quantities are measured in DASD tracks.

The first `1` is the primary quantity: one track is requested when the new data
set is allocated.

The second `1` is the secondary quantity: if more space is required, the system
can request another extent using a one-track secondary quantity.

It does **not** mean that two tracks are immediately allocated.

For this small lab the allocation is intentionally modest; the five 80-byte
logical records require very little data space.

## DISP

`DISP=(NEW,CATLG,DELETE)`:

- NEW: the data set is to be created.
- CATLG: catalog it if the step ends normally.
- DELETE: delete it if the step ends abnormally.

`DISP=SHR` on the input copy data set indicates an existing data set that may be
shared by compatible concurrent users. In this lab it is used as a read source.

## DCB attributes

`DSORG=PS` identifies a physical sequential data set.

`RECFM=FB` means fixed-length records stored in blocks.

`LRECL=80` specifies an 80-byte logical record.

`BLKSIZE=0` asks the system to determine a suitable block size.

## Why validation uses both SDSF and ISPF

A zero condition code proves that the utility step completed successfully, but
the lab also validates the resulting data set and its records. This gives stronger
evidence than an RC alone.
