#!/bin/bash

# Função que varre o diretório
function verifica_diretorio() {
    # local diretorio="$1"
    # local arquivo

    # for arquivo in "$diretorio"/*; do
    #     if [ -f "$arquivo" ]; then
    #         verifica_conflito "$arquivo" # chamando a função e passando o $arquivo para dentro de função

    #     elif [ -d "$arquivo" ]; then
    #             verifica_diretorio "$arquivo" # chamando a função que verifica se existe subdiretorios
    #     fi
    # done

    # outra maneira de fazer um laço de repetição utilizando o while
    local diretorio="$1" 
    local arquivo
    local arquivos=("$diretorio"/*)
    local i=0
    
    while [ $i -lt ${#arquivos[@]} ]; do # ${#arquivos[@]} = tamanho do diretório
        arquivo="${arquivos[$i]}" # arquivo= recebe o tamanho do diretório a cada iteração

        if [ -f "$arquivo" ]; then
            verifica_conflito "$arquivo"

        elif [ -d "$arquivo" ]; then
            verifica_diretorio="$arquivo"

        fi
        ((i++))
    done

}

# Função que faz a verificação de conflito de merge
function verifica_conflito() {
    local arquivo="$1"
    if grep -q -E '<<<<<<<|=======|>>>>>>>' "$arquivo"; then
        echo "O arquivo $arquivo contém marcacoes de conflito de merge"
    else
        echo "O arquivo $arquivo não contém marcacoes de conflito de merge"
    fi
}

# Verifica se a quantidade de parâmetros passada está correta
if [ $# -ne 1 ]; then
    echo "Uso: $0 <diretorio>"
    exit 1
fi

# Verifica se o diretório existe
if [ ! -d "$1" ]; then
    echo "Diretorio nao encontrado: $1"
    exit 1
fi


verifica_diretorio "$1" # passando o parametro informado durante a execução do script como argumento para a função verifica_diretorio

