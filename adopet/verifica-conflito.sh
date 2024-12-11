#!/bin/bash

arquivo=$1

if [ $# -ne 1 ]; then
        echo "Uso: $0 arquivo"
        exit 1  # encerra o script devido algum erro
fi


if [ ! -f "$arquivo" ] ; then
        echo "O arquivo $arquivo não existe"
        exit 1

fi


if grep -q -E '<<<<<<<|=======|>>>>>>>' $arquivo; then
        echo "O arquivo $arquivo contém marcacoes de conflito de merge"
else
        echo "O arquivo $arquivo não contém marcacoes de conflito de merge"
fi
