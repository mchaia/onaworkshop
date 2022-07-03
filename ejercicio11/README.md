## Pasos para levantar el servicio

<pre>
$ k apply -f configmap1.yaml
configmap/configmap1 created

$ k apply -f configmap2.yaml
configmap/configmap2 created

$ k apply -f secret1.yaml
<b>Error from server (BadRequest): error when creating "secret1.yaml": Secret in version "v1" cannot be handled as a Secret: illegal base64 data at input byte 0</b>

$ echo -n <b>{\"mypass\"\ :\ \"password\!\"}</b> | base64
eyJteXBhc3MiIDogInBhc3N3b3JkISJ9
(Modifico el secret del json para que esté encodeado en base64)

$ k apply -f secret1.yaml
secret/secret1 created

$ k apply -f deployment.yaml
deployment.apps/pingapp created

$ k apply -f service.yaml
service/pingapp created
</pre>

## Probando localmente desde un Pod

<pre>
$ k get pods
NAME                       READY   STATUS    RESTARTS   AGE
pingapp-688dc54bbf-88rkw   1/1     Running   0          2m28s
pingapp-688dc54bbf-cshkc   1/1     Running   0          2m29s
<b>pingapp-688dc54bbf-tfhqw</b>   1/1     Running   0          2m30s

$ k exec -it <b>pod/pingapp-688dc54bbf-tfhqw</b> -- bash

appuser@pingapp-688dc54bbf-tfhqw:/apps/pingapp$ env | grep LOCATION
SECRETS_LOCATION=/mysecrets/secret.json
CONFIG_LOCATION=/mydata/config.json

appuser@pingapp-688dc54bbf-tfhqw:/apps/pingapp$ curl localhost:4567/config
{
  "key1" : "value1"
}

appuser@pingapp-688dc54bbf-tfhqw:/$ curl localhost:4567/secrets
{"mypass" : "password!"}
</pre>

## Probando desde el host (`minikube` en MacOS)

<pre>
$ minikube service --url pingapp

🏃  Starting tunnel for service pingapp.
❗  Because you are using a Docker driver on darwin, the terminal needs to be open to run it.
</pre>

En otra terminal:

<pre>
$ ps -ef | grep docker@127 | grep L
502 88928 88913   0  1:05PM ttys000    0:00.02 ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -N docker@127.0.0.1 -p 58369 -i /Users/Martin/.minikube/machines/minikube/id_rsa -L <b>60600</b>:10.100.251.177:8080

$ curl localhost:60600/config
{
  "key1" : "value1"
}

$ curl localhost:60600/secrets
{"mypass" : "password!"}
</pre>
