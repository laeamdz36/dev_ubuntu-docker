#!/usr/bin/env bash
# Provisiona .gitignore e inicializa el repo git en el directorio data de Ignition,
# luego delega al entrypoint original de la imagen.
set -e

DATA_DIR=/usr/local/bin/ignition/data
GITIGNORE_SRC=/usr/local/share/ignition-provisioning/gitignore

if [ ! -f "${DATA_DIR}/.gitignore" ]; then
    cp "${GITIGNORE_SRC}" "${DATA_DIR}/.gitignore"
    echo "init-git-data: .gitignore provisionado en ${DATA_DIR}"
fi

if [ ! -d "${DATA_DIR}/.git" ]; then
    git init -b main "${DATA_DIR}"
    echo "init-git-data: repositorio git inicializado en ${DATA_DIR}"
fi

exec docker-entrypoint.sh "$@"
