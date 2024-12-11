<div id='top'>

# Adopet: site de adoção | 4º Challenge Front-end Alura

</div>


Olá!

A **AdoPet** é uma empresa fictícia que funciona como intermediária entre adotantes de pets e ONGs com foco em retirar animais das ruas. A proposta da AdoPet é trazer mais usuários e aumentar a interação entre possíveis adotantes e representantes dessas ONGs e para isso, o objetivo do projeto é implementar uma plataforma e levar a empresa pro mundo digital.

A base deste projeto foi desenvolvido como resultado de um Desafio Front-End (4ª edição) exclusivo para alunos da escola de tecnologia [Alura](https://www.alura.com.br).

O projeto foi desenvolvido em React pela aluna e desenvolvedora  [Angela Caldas @sucodelarangela 🍊](https://angelacaldas.vercel.app), que gentilmente cedeu sua versão para fins de ensino e aprendizado em cursos da plataforma.

A versão foi refatorada para atender às necessidades do curso e trabalhar com Back-End em Nest.js.

O projeto possui a biblioteca React, React Hook Form na validação dos formulários, o Framer Motion para a animação das transições de tela e o Headless UI para a criação do menu do cabeçalho.

# Adaptei esse projeto para o uso de scripts, verificando conflitos de merge
- o Script em questão, verifica se em algum lugar do projeto existe conflitos de merge que caso tenha passado algo despercebido
- para verificar se em algum lugar do projeto existe algum conflito, usei uma estrutura de condição
- No arquivo atual, possui um conflito no arquivo index.js
```bash
<<<<<<< HEAD
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';
=======
import './index.css';
import App from './App';
import React from 'react';
import ReactDOM from 'react-dom/client';
>>>>>>> 4bd3f83ad926b0dbc195ab09bf43e40ac47a64d5
```
- no terminal do linux, é possível buscar por esses caracters especiais da seguinte forma: **grep -q -E '<<<<<<<|=======|>>>>>>>' src/index.js** 
- **-q** para ser executado em modo silencioso
- **-E** busca por expressões especiais
- execute o comando grep, e depois execute **echo $?** se retornar **0** indica que foi encontrado esses caracteres, se retornar **1** significa que não foi encontrado

- no arquivo verifica-conflito.sh ficou da seguinte forma: 
- cd adopet/
```bash
#!/bin/bash

arquivo="src/index.js"

if grep -q -E '<<<<<<<|=======|>>>>>>>' $arquivo; then
        echo "O arquivo $arquivo contém marcacoes de conflito de merge"
else
        echo "O arquivo $arquivo não contém marcacoes de conflito de merge"
fi

# permissão, chmod 777 verifica-conflito.sh
# execute: sh verifica-conflito.sh
```

- Parametros, ao inves de ficar modificação a linha da variavel **arquivo** caso outros arquivos também possui conflitos de merge, é utilizados passagem de parametros ficando da seguinte forma
```bash
#!/bin/bash

arquivo=$1

if grep -q -E '<<<<<<<|=======|>>>>>>>' $arquivo; then
        echo "O arquivo $arquivo contém marcacoes de conflito de merge"
else
        echo "O arquivo $arquivo não contém marcacoes de conflito de merge"
fi

```
- o **$1** significa que é preciso passar um parametro no momento de executação do script
```bash 
sh verifica-conflito.sh <nome-do-arquivo>
sh verifica-conflito.sh src/index.js

```
- **[ $# -ne 1 ]** verifica a quantidade de parametros passados, se for diferente de 1 vai retornar uma mensagem 
- **echo "Uso: $0 arquivo"** esse echo basicamente informa na tela a forma de uso do parametro, o **$0** é nome do arquivo

- verificando se o arquivo passado como parametro existe
- ! negação, tudo que for falso vira verdadeiro e tudo que for verdadeiro vira falso, **-f** verifica se o arquivo existe: **[ ! -f "$arquivo" ]**
- lista com os operadores condicionais mais comuns em bash
```bash
-eq: igual a
-ne: diferente de
-gt: maior que
-lt: menor que
-ge: maior ou igual a
-le: menor ou igual a
-z: string vazia
-n: string não vazia
=: comparação de strings (também ==)
!=: diferente de (strings)
&&: e lógico
||: ou lógico
!: negação lógica
``` 

- laços de repetição, verificando todos os arquivos de um diretório
```bash 
#! /bin/bash
diretorio=$1

for arquivo in "$diretorio"/*; do

    if [ -f "$arquivo" ]; then

            if grep -q -E '<<<<<<<|=======|>>>>>>>' $arquivo; then
                    echo "O arquivo $arquivo contém marcacoes de conflito de merge"
             else
                    echo "O arquivo $arquivo não contém marcacoes de conflito de merge"
            fi
    fi


done
```
- laço de repetição for, então pra cada **arquivo** em **diretório**, ele vai fazer algo... que é a verificação se os arquivos possui conflitos de merge e **/** siginifca tudo que estiver dentro do diretório passado por parametro por conta do coringa [ * ] 
```bash
# executando o arquivo criado
sh verifica-conflito-diretorio.sh src

# note que vai retornar tudo que estiver dentro de src os conflitos de merge
O arquivo src/App.js contém marcacoes de conflito de merge
O arquivo src/axios.config.js não contém marcacoes de conflito de merge
O arquivo src/index.css não contém marcacoes de conflito de merge
O arquivo src/index.js contém marcacoes de conflito de merge


# testando um diretório que não possui conflitos
sh verifica-conflito-diretorio.sh public

# note que vai retornar tudo que estiver dentro de public os arquivos que não possui conlitos de merge
O arquivo public/Amora.png não contém marcacoes de conflito de merge
O arquivo public/Dunga.png não contém marcacoes de conflito de merge
O arquivo public/Felicia.png não contém marcacoes de conflito de merge
O arquivo public/Fiona.png não contém marcacoes de conflito de merge
O arquivo public/Lua.png não contém marcacoes de conflito de merge
O arquivo public/Sid.png não contém marcacoes de conflito de merge
O arquivo public/Sirius.png não contém marcacoes de conflito de merge
O arquivo public/Yoda.png não contém marcacoes de conflito de merge
O arquivo public/Zelda.png não contém marcacoes de conflito de merge
O arquivo public/adopet-icon.png não contém marcacoes de conflito de merge
O arquivo public/index.html não contém marcacoes de conflito de merge
O arquivo public/logo-blue.svg não contém marcacoes de conflito de merge
O arquivo public/logo-clear.svg não contém marcacoes de conflito de merge
O arquivo public/og-image.png não contém marcacoes de conflito de merge
O arquivo public/pets.svg não contém marcacoes de conflito de merge
O arquivo public/robots.txt não contém marcacoes de conflito de merge
O arquivo public/screen.JPG não contém marcacoes de conflito de merge
```

- funções, isolando a parte de verificação dos conflitos de merge em uma função
```bash 
#!/bin/bash

function verifica_conflito() {
    local arquivo="$1"
    if grep -q -E '<<<<<<<|=======|>>>>>>>' "$arquivo"; then
        echo "O arquivo $arquivo contém marcacoes de conflito de merge"
    else
        echo "O arquivo $arquivo não contém marcacoes de conflito de merge"
    fi
}

diretorio="$1"

for arquivo in "$diretorio"/*; do
    if [ -f "$arquivo" ]; then
        verifica_conflito "$arquivo" # chamando a função e passando o $arquivo para dentro de função
    fi
done

# executando
bash verifica-conflito-diretorio.sh src

```

- usando funções recursivos ou seja, função que chama a si mesmo, caso um diretório tenha subs diretórios e arquivos. Transformando o laço de repetição for em função
```bash
function verifica_diretorio() {
    local diretorio="$1"
    local arquivo
    
    for arquivo in "$diretorio"/*; do
        if [ -f "$arquivo" ]; then
            verifica_conflito "$arquivo" # chamando a função e passando o $arquivo para dentro de função

        elif [ -d "$arquivo" ]; then
                verifica_diretorio "$arquivo" # chamando a função que verifica se existe subdiretorios
        fi
    done

}

verifica_diretorio "$1"

# executando o script, e note que agora possui muito mais arquivo informando quais possui a marcação de conflito de merge e quais não possui
O arquivo src/App.js contém marcacoes de conflito de merge
O arquivo src/Components/AnimatedRoutes.js não contém marcacoes de conflito de merge
O arquivo src/Components/Button.js não contém marcacoes de conflito de merge
O arquivo src/Components/CardPet.js não contém marcacoes de conflito de merge
O arquivo src/Components/Footer.js não contém marcacoes de conflito de merge
O arquivo src/Components/Header.js não contém marcacoes de conflito de merge
O arquivo src/Components/Home.js contém marcacoes de conflito de merge
O arquivo src/Components/Initial.js não contém marcacoes de conflito de merge
O arquivo src/Components/Input.js não contém marcacoes de conflito de merge
O arquivo src/Components/LoginForm.js não contém marcacoes de conflito de merge
O arquivo src/Components/Message.js não contém marcacoes de conflito de merge
O arquivo src/Components/Profile.js não contém marcacoes de conflito de merge
O arquivo src/Components/RegisterForm.js não contém marcacoes de conflito de merge
O arquivo src/assets/adopet-icon.png não contém marcacoes de conflito de merge
O arquivo src/assets/body-bg.svg não contém marcacoes de conflito de merge
O arquivo src/assets/eye-hover.svg não contém marcacoes de conflito de merge
O arquivo src/assets/eye.svg não contém marcacoes de conflito de merge
O arquivo src/assets/header-bg.svg não contém marcacoes de conflito de merge
O arquivo src/assets/home-hover.svg não contém marcacoes de conflito de merge
O arquivo src/assets/home.svg não contém marcacoes de conflito de merge
O arquivo src/assets/logged-user.png não contém marcacoes de conflito de merge
O arquivo src/assets/message-hover.svg não contém marcacoes de conflito de merge
O arquivo src/assets/message.svg não contém marcacoes de conflito de merge
O arquivo src/assets/messages-hover.svg não contém marcacoes de conflito de merge
O arquivo src/assets/messages.svg não contém marcacoes de conflito de merge
O arquivo src/assets/paws-1.svg não contém marcacoes de conflito de merge
O arquivo src/assets/paws.svg não contém marcacoes de conflito de merge
O arquivo src/assets/user.svg não contém marcacoes de conflito de merge
O arquivo src/axios.config.js não contém marcacoes de conflito de merge
O arquivo src/contexts/auth.js contém marcacoes de conflito de merge
O arquivo src/data/data.js contém marcacoes de conflito de merge
O arquivo src/hooks/useMediaQuery.js não contém marcacoes de conflito de merge
O arquivo src/index.css não contém marcacoes de conflito de merge
O arquivo src/index.js contém marcacoes de conflito de merge

```

- foi criado duas variáveis local para funcionar apenas da função, primeira variável **diretorio** recebe pelo menos 1 parametro, variável **arquivo** para percorrer no for se existe conflito de merge
- foi criado um **elif**, para verificar se o arquivo passado como parametro possui sub diretorios, se tiver, ele vai chamar a propria função e passar o **arquivo** como argumento e chama-lo novamente informando quais arquivos possui e não possui conflitos de merge

- garantindo que durante a execução do script passe pelo menos 1 parametro e que seja um diretório
```bash
if [ $# -ne 1 ]; then
    echo "Uso: $0 <diretorio>"
    exit 1
fi

# Verifica se o diretório existe
if [ ! -d "$1" ]; then
    echo "Diretorio nao encontrado: $1"
    exit 1
fi
```