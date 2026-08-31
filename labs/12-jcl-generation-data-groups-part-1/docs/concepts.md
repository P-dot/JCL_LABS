# GDG Concepts

## Administration

A GDG base is maintained in catalog services and defines generation-management attributes. `LIMIT(3)` establishes the maximum number of cataloged generations to retain under the group policy. `NOEMPTY` and `SCRATCH` are also attributes of the base. Part 1 validates that these attributes exist; rollover behavior is deferred to Part 2 until it is actually executed.

## Operations

Batch JCL can request a new generation with `(+1)` rather than hard-coding a name such as `G0003V00`. This allows the same operational pattern to be reused as the chronological data set history evolves.

## Engineering

Relative generation references decouple stable JCL logic from absolute generation names. After three successful allocations:

```text
G0001V00 = (-2)
G0002V00 = (-1)
G0003V00 = (0)
```

The identity of each GDS remains fixed while its relative chronological position changes.

## Catalog and physical storage

The GDG base is a catalog-managed definition. Each GDS is a real data set with ordinary allocation characteristics such as `DSORG=PS`, `RECFM=FB`, and `LRECL=80`.
