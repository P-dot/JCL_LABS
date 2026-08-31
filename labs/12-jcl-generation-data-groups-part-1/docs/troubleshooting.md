# Troubleshooting and Diagnosis

## Initial IDCAMS failure

The first GDG definition produced messages including:

```text
IDC3208I LEFT PARENTHESIS MISSING FOLLOWING KEYWORD 'GDG'
IDC3202I ... CONDITION CODE IS 12
IDC3219I ... UNKNOWN
IDC0002I ... MAXIMUM CONDITION CODE WAS 12
```

The primary error was the command structure immediately after `DEFINE GDG`. IDCAMS expected the opening parenthesis after `GDG`.

Incorrect:

```text
DEFINE GDG -
       (NAME(...)
```

Corrected:

```text
DEFINE GDG ( -
       NAME(...) -
       LIMIT(3) -
       NOEMPTY -
       SCRATCH )
```

After correction, the GDG base definition completed with maximum condition code 0.

## Engineering lesson

IDCAMS continuation syntax inside `SYSIN DD *` must not be confused with JCL continuation rules. The retained failure demonstrates the repository methodology of observing, diagnosing, correcting, and validating rather than publishing only a clean final job.
