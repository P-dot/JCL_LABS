# Technical Notes

## SYSUT1 y SYSUT2
Son DDNAME utilizados por IEBCOPY para relacionar las bibliotecas físicas con
las instrucciones de control.

## SYSIN
Contiene los control statements que indican a IEBCOPY qué operación debe hacer.

## PDS destino
Los PDS SELECT y EXCLUDE se crean primero con IEFBR14. Después IEBCOPY los abre
como data sets existentes para incorporar los miembros.

## SPACE=(TRK,(2,1,10))
TRK indica que las cantidades de espacio se expresan en tracks. 2 es la cantidad
primaria, 1 la secundaria y 10 la cantidad de directorio especificada para el PDS.

## Evidencia
La validación combina condition codes, mensajes IEBCOPY y member lists; de este
modo se comprueba tanto la ejecución técnica como el resultado funcional.
