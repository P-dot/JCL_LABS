# Lab 13 Data Flow

```text
Instream records
      |
      v
L13INPUT / IEBGENER
      |
      v
IBMUSER.JCLLAB13.INPUT
      |
      v
L13COPY / IEBGENER
      |
      v
GDG(+1) -> G0007V00
      |
      +---- GDG(0)  -> G0007V00
      +---- GDG(-1) -> G0006V00

L13NEXT
      |
      v
GDG(+1) -> G0008V00
      |
      +---- same GDG(0)  -> G0008V00
      +---- same GDG(-1) -> G0007V00
```
