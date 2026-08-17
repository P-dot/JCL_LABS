# DISP Delete Lifecycle

```text
IBMUSER.JCLLAB06.DELETE
          |
          v
       DISP=OLD
          |
          v
     step execution
       /       \
   normal     abnormal
     |           |
     v           v
   DELETE      DELETE
```

La evidencia del laboratorio muestra el data set antes de la operacion y la
ausencia posterior en ISPF 3.4.
