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


