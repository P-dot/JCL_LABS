# Validation - Lab 06

## Acceptance criteria

- [x] JCL de creacion preservado
- [x] Data set de prueba identificado como `IBMUSER.JCLLAB06.DELETE`
- [x] Existencia previa demostrada en ISPF
- [x] JCL de eliminacion preservado
- [x] `DISP=(OLD,DELETE,DELETE)` demostrado
- [x] Ausencia posterior demostrada: `No data set names found`
- [x] Evidencias PNG preservadas
- [x] DOCX original preservado
- [ ] RC/MAXCC del DELPS demostrado mediante captura SDSF/JES

## Conclusion

La eliminacion funcional queda demostrada por el cambio de estado persistente
EXISTS -> NOT FOUND. No se atribuye un RC no visible en la evidencia aportada.
