# jenkins-tests

Quelques expériences avec Jenkins Pipelines.

## Utilisation


```bash
export PROVISIONING_HOME=$HOME/exp-jenkins
mkdir -p $PROVISIONING_HOME
cd $PROVISIONING_HOME
git clone "https://github.com/Jean-Baptiste-Lasselle/jenkins-tests" . 
chmod +x ./operations.sh
./operations.sh

```

Ou en une seule ligne : 


```bash
export PROVISIONING_HOME=$HOME/exp-jenkins && mkdir -p $PROVISIONING_HOME && cd $PROVISIONING_HOME && git clone "https://github.com/Jean-Baptiste-Lasselle/jenkins-tests" . && chmod +x ./operations.sh && ./operations.sh

```

## Configuration

### Réseau

LE reverse proxy et l'ensembl du réseau privé Docker sont configurés pour que JEnkisn soit accessible via :

http://jenkins.marguerite.io

Tous les postes qui voudront accéder à l'instance, devront résoudre le nom de domaine "jenkins.margurite.io" en l'adresse IP de la machine surlaquelle Marguerite est installée.
Si vous êtes dans un réseau dans lequel vous pouvez "pinger" l'adresse IP de ce serveur, alors il vous suffit d'ajout une ligne à votre `/etc/hosts`, avec l'adresse IP du serveur, et le nom de domaine `jenkins.margurite.io`. Quelque chose du genre :

```bash

127.0.0.1	localhost
127.0.1.1	pc-alienware-jib.kytes.io	pc-alienware-jib
192.168.1.35    jenkins.marguerite.io

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

```



### User initial

```bash
export NOM_DU_CONTEUR_JENKINS=jenkins-marguerite
docker exec -it $NOM_DU_CONTEUR_JENKINS /bin/bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"
```


# Tests réseau 


On pourra vérifier que les conteneurs sont dans un réseau docker-compose, et que le nom des conteneurs peut être utilisé pour résoudre les adresses IP dans ce réseau : 

```bash
export NOM_DU_CONTEUR_REVERSE_PROXY=reverse-proxy-marguerite
export NOM_DU_CONTEUR_JENKINS=jenkins-marguerite

docker exec -it $NOM_DU_CONTEUR_REVERSE_PROXY bash -c "apot-get update -y && aptget install -y iputils-ping"

docker exec -it $NOM_DU_CONTEUR_REVERSE_PROXY bash -c "ping -c 4 $NOM_DU_CONTEUR_JENKINS"

docker inspect $NOM_DU_CONTEUR_JENKINS |grep Address
```

Exemple de résultat (regardez bien 192.168.16.2 ....) : 

```bash
[jibl@pc-100 ~]$ docker exec -it exp-jenkins_nginx_1 bash -c "ping -c 4 jenkins-marguerite"
PING jenkins-marguerite (192.168.16.2) 56(84) bytes of data.
64 bytes from jenkins-marguerite.exp-jenkins_reseaumarguerite (192.168.16.2): icmp_seq=1 ttl=64 time=0.097 ms
64 bytes from jenkins-marguerite.exp-jenkins_reseaumarguerite (192.168.16.2): icmp_seq=2 ttl=64 time=0.147 ms
64 bytes from jenkins-marguerite.exp-jenkins_reseaumarguerite (192.168.16.2): icmp_seq=3 ttl=64 time=0.127 ms
^C
--- jenkins-marguerite ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2001ms
rtt min/avg/max/mdev = 0.097/0.123/0.147/0.024 ms

Return low-level information on Docker objects
[jibl@pc-100 ~]$ export NOM_DU_CONTEUR_REVERSE_PROXY=exp-jenkins_nginx_1
[jibl@pc-100 ~]$ export NOM_DU_CONTEUR_JENKINS=jenkins-marguerite
[jibl@pc-100 ~]$ docker inspect $NOM_DU_CONTEUR_JENKINS |grep Address
            "LinkLocalIPv6Address": "",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "GlobalIPv6Address": "",
            "IPAddress": "",
            "MacAddress": "",
                    "IPAddress": "192.168.16.2",
                    "GlobalIPv6Address": "",
                    "MacAddress": "02:42:c0:a8:10:02",
[jibl@pc-100 ~]$ 

```






