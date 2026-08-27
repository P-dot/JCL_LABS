# Technical Notes
This part deliberately uses a classic PDS (DSORG=PO). Replacing members creates
the maintenance scenario; IEBCOPY then reorganizes the same library in place.
`DISP=OLD` requests exclusive use during COMPRESS. CC 0000 proves successful
step completion, while SYSPRINT proves the actual member movement and utility
result.
