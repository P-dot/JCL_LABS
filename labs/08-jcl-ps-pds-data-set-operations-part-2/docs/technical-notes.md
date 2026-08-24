# Technical Notes

## PDS member notation
`DATA.SET(MEMBER)` selects one member inside a PDS. The PDS is the allocated
data set; the member is contained within it.

## IEBGENER phases
`L08M2PS` reads a selected member and creates a PS. `L08PS2M` performs the
complementary operation by reading the PS and writing a member in an existing PDS.

## PDS allocation
`L08PDSCP` first creates the destination with `DSORG=PO`, FB records and LRECL 80.
`SPACE=(TRK,(2,1,10))` supplies primary, secondary and directory quantities.

## IEBCOPY phase
The second step passes the whole source PDS as SYSUT1 and the destination PDS as
SYSUT2. `COPY OUTDD=SYSUT2,INDD=SYSUT1` directs IEBCOPY to perform the library copy.

## Validation
The lab validates both condition codes and resulting objects/content. This avoids
treating RC 0000 alone as proof that the intended data result exists.
