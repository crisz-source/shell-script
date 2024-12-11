# Começando com bash 



# verificando o status de uma aplicação no terminal
```bash
# instale o curl
sudo apt install curl

# testando uma aplicação no terminal
curl --write-out %{http_code} --silent --output /dev/null https://adopet-frontend-cypress.vercel.app/

# retorno:
200
```

- verificando o status de uma aplicação em um arquivo .sh
```bash
#Criado um arquivo sh 

#!/bin/bash
codigo_http=$(curl --write-out %{http_code} --silent --output /dev/null https://adopet-frontend-cypress.vercel.app/)
echo $codigo_http
```
- neste código, foi criado uma variáveil **codigo_http** e ela esta recebendo tudo que estiver dentro de **$( ... )** pois quando é uma linha de comando, geralmente é adicionado dentro de **$( ... )** e para verificar o conteúdo dessa variável, coloquei o echo **$código_http** para verificar no terminal o conteúdo da variavel.
- para executar o código, **sh monitoramento-servidor.sh** no terminal ou se estiver no mesmo diretório do arquivo.sh **./monitramento-servidor.sh**
- se der erro de permissão, deixe-o executado com:
```bash
chmod 777 monitoramento-servidor.sh
```




# Monitorando o disco de uma aplicação
- no terminal do linux, utilize o **df -h** para verificar as informações do sistema. No meu caso, como estou utilizando o WSL ao executar o df -h, obtive este retorno:
```bash 
Filesystem      Size  Used Avail Use% Mounted on
none            4.4G     0  4.4G   0% /usr/lib/modules/5.15.167.4-microsoft-standard-WSL2
none            4.4G  4.0K  4.4G   1% /mnt/wsl
drivers         681G  491G  191G  73% /usr/lib/wsl/drivers
/dev/sdc        251G   19G  220G   8% /
none            4.4G   84K  4.4G   1% /mnt/wslg
none            4.4G     0  4.4G   0% /usr/lib/wsl/lib
rootfs          4.4G  2.2M  4.4G   1% /init
none            4.4G  1.1M  4.4G   1% /run
none            4.4G     0  4.4G   0% /run/lock
none            4.4G     0  4.4G   0% /run/shm
tmpfs           4.0M     0  4.0M   0% /sys/fs/cgroup
none            4.4G   96K  4.4G   1% /mnt/wslg/versions.txt
none            4.4G   96K  4.4G   1% /mnt/wslg/doc
C:\             681G  491G  191G  73% /mnt/c
snapfuse        128K  128K     0 100% /snap/bare/5
snapfuse         64M   64M     0 100% /snap/core20/2379
snapfuse         64M   64M     0 100% /snap/core20/2434
snapfuse         74M   74M     0 100% /snap/core22/1663
snapfuse         74M   74M     0 100% /snap/core22/1722
snapfuse         67M   67M     0 100% /snap/core24/490
snapfuse         67M   67M     0 100% /snap/core24/609
snapfuse         92M   92M     0 100% /snap/gtk-common-themes/1535
snapfuse         19M   19M     0 100% /snap/helm/430
snapfuse         19M   19M     0 100% /snap/helm/435
snapfuse         13M   13M     0 100% /snap/kubeadm/3501
snapfuse         13M   13M     0 100% /snap/kubeadm/3513
snapfuse         13M   13M     0 100% /snap/kubectl/3446
snapfuse         13M   13M     0 100% /snap/kubectl/3464
snapfuse         18M   18M     0 100% /snap/kubelet/3439
snapfuse         18M   18M     0 100% /snap/kubelet/3468
snapfuse         39M   39M     0 100% /snap/snapd/21759
snapfuse         45M   45M     0 100% /snap/snapd/23258
snapfuse        132M  132M     0 100% /snap/ubuntu-desktop-installer/1276
snapfuse        132M  132M     0 100% /snap/ubuntu-desktop-installer/1286
```
- Neste caso, para receber informação do disco que é C:\ foi utilziado o **grep** para filtrar algo específico da partição que foi aumentada, e buscando uma coluna específica com o **awk**
```bash 
df -h | grep /mnt/c

# retorno
C:\             681G  491G  191G  73% /mnt/c

# buscando uma informação de uma determinada coluna 
df -h | grep /mnt/c | awk '{print $5}'
```
- Caso aconteça de usar o mesmo script em um SO diferente, fiz uma pequena modificação que consiste em criar uma variável para extrair informação de um ponto de montagem por exemplo. Dessa forma, só alterar o caminho de ponto de montagem de acordo com o SO que irá executar

```bash
#!/bin/bash


ponto_montagem="/mnt/c"

uso_disco=$(df -h | grep $ponto_montagem | awk '{print $5}')
echo "uso de disco em $uso_disco"
```

### Criando logs de uso do disco

- no terminal do linux, quando digita **date** ele mostra tudo atual, ano, dia, mês. Com o **date +%F** aparece no formato amerciando AAAA/MM/DD e com o **date +%F-%H:%M** mostra as horas
- no arquivo de monitoramento de disco, foi adicionado **> $nome_log.log** para gerar um arquivo de log 
```bash
#!/bin/bash


ponto_montagem="/mnt/c"
nome_log=$(date +%F-%H:%M)

uso_disco=$(df -h | grep $ponto_montagem | awk '{print $5}')
echo "uso de disco em $uso_disco" > $nome_log.log

# execute o arquivo monitoramento-disco.sh e verifique na raiz do projeto a log gerada
sh monitoramento-disco.sh 

```

- Agendando tarefas com o **contrab**, antes de fazer uma tarefa com o crontab, eu fiz uma variável diretorio para pegar o diretório atual para mais organização **diretorio=$(pwd)**
```bash
#!/bin/bash


ponto_montagem="/mnt/c"
nome_log=$(date +%F-%H:%M)
diretorio=$(pwd)

uso_disco=$(df -h | grep $ponto_montagem | awk '{print $5}')
echo "uso de disco em $uso_disco" > "$diretorio/$nome_log.log"
```
- Crontab, verifique se o serviço do contrab esta rodando, no terminal do linux digite:
```bash
service cron status

# retorno que esta ativado
cron.service - Regular background program processing daemon
     Loaded: loaded (/lib/systemd/system/cron.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2024-12-10 19:27:06 -03; 37min ago
       Docs: man:cron(8)
   Main PID: 308 (cron)
      Tasks: 1 (limit: 10627)
     Memory: 412.0K
     CGroup: /system.slice/cron.service
             └─308 /usr/sbin/cron -f -P

Dec 10 19:27:06 cris systemd[1]: Started Regular background program processing daemon.
Dec 10 19:27:06 cris cron[308]: (CRON) INFO (pidfile fd = 3)

# se nao tiver ativado, execute:
sudo service cron start
```

- depois da verificação do cron, execute abaixo o comando no terminal do linux para abrir um arquivo editável do cron 
```bash
sudo crontab -e 

# ecolha 1 para abrir com o nano
# explicação do crontab
m= minutos h= horas dom= dia do mês mon= mês dow= semana command= comando a ser configurado

# abaixo, com o nano aberto, vai ser executado de 2 em 2 minutos
*/2 * * * * /mnt/c/Users/crist/OneDrive/Área de Trabalho/Shell Script /mnt/c/Users/crist/OneDrive/Área de Trabalho/Shell Script # origem do caminho do script e o caminho aonde a log vai ser gerada, salve o arquivo com ctrl+S e ctrl+x e verifique se deu tudo certo no diretório especificado de destino

# ou seja, [ */2 * * * * ] vai ser executado a cada 2 minutos em todas as horas, todo mês, todo dia da semana e o command, é o caminho do script
```

- caso deseja desativar o crontab, basta ir ao arquivo do contrab e comentar a linha inserida