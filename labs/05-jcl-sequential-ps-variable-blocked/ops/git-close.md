# Git Close — Lab 05

Destino del laboratorio dentro del repositorio:

```text
JCL_LABS/labs/05-jcl-sequential-ps-variable-blocked
```

Commit recomendado:

```text
Complete Lab 05 variable-blocked sequential dataset
```

Verificar siempre antes del commit:

```bash
git status --short
git diff --cached --stat
```

Después del push verificar el árbol remoto con:

```bash
git fetch origin
git ls-tree -r --name-only origin/main | grep '^labs/05-jcl-sequential-ps-variable-blocked/'
```
