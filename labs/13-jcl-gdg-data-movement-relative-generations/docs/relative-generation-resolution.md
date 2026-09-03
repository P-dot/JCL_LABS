# Relative Generation Resolution

A relative GDG reference describes a logical position, not a permanent absolute generation name.

During this lab:

```text
Initial:
GDG(0)  -> G0007V00
GDG(-1) -> G0006V00

After creating G0008V00:
GDG(0)  -> G0008V00
GDG(-1) -> G0007V00
```

The same JCL members were resubmitted without changing the relative DSN references. JES evidence showed that z/OS resolved those references to different absolute GDS names as the GDG advanced.

This decouples recurring batch JCL from physical generation numbering.
