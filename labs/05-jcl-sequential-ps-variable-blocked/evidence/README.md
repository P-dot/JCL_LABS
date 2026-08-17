# Evidence — Lab 05

## Archivos

1. `01_createvb_jcl_source.png` — source JCL `CREATEVB`.
2. `02_sdsf_joblog_allocation.png` — JES2/SDSF Job Log y allocation de `VBFILE`.
3. `03_sdsf_rc0000_cataloged.png` — CC 0000 y mensaje de catalogación.
4. `04_dataset_info_ps_vb_lrecl80_blksize27998.png` — atributos persistentes del data set.
5. `Lab05_original_evidence.docx` — documento original aportado como evidencia de la ejecución.

## Hechos demostrados

- `IBMUSER.JCLLAB05.VB` fue creado y catalogado.
- `DSORG=PS`.
- `RECFM=VB`.
- `LRECL=80`.
- `BLKSIZE=27998` seleccionado/registrado en la asignación.
- Step finalizado con condition code `0000`.
