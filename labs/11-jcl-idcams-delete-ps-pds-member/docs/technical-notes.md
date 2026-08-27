# Technical Notes
IDCAMS receives commands through SYSIN; DELETE is an IDCAMS command, not a JCL
statement. The negative test intentionally repeats DELETE after DELTEST has
already been removed and records the resulting CC 8 as expected evidence.
