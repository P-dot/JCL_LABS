# IEBGENER vs IEBCOPY in this lab

| Operation | Utility |
|---|---|
| PDS(member) -> PS | IEBGENER |
| PS -> PDS(member) | IEBGENER |
| PDS -> PDS | IEBCOPY |

This is the operational distinction demonstrated by Lab 08: the first two
operations move sequential records to or from one member; the last performs a
partitioned-library copy.
