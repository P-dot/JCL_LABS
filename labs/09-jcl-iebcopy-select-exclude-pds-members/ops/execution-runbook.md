# Execution Runbook

1. Preparar IBMUSER.JCLLAB07.PDS con L09PREP.
2. Verificar los cinco miembros del origen.
3. Asegurar que IBMUSER.JCLLAB09.SELECT no existe antes del primer L09SEL.
4. Ejecutar L09SEL y validar ALLOC/COPYSEL, SYSPRINT y member list.
5. Asegurar que IBMUSER.JCLLAB09.EXCLUDE no existe antes del primer L09EXCL.
6. Ejecutar L09EXCL y validar ALLOC/COPYEXC, SYSPRINT y member list.
7. Comparar los resultados SELECT y EXCLUDE.
