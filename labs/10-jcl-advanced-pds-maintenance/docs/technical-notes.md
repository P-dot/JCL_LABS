# Technical Notes
IEFBR14 is used for allocation through DD statements; IEBGENER creates test
members; IEBCOPY performs COMPRESS, library merge and selected-member copy with
a new name.

## Troubleshooting lesson
A Phase 4 conversion failure was caused by a missing comma after `UNIT=SYSDA`.
Without the comma, the DD continuation ended early and subsequent lines led to
misleading `IEFC605I UNIDENTIFIED OPERATION FIELD` messages. The final JCL uses
`UNIT=SYSDA,` and executed successfully.
