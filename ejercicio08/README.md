## Puntos relevantes en el descriptor

- Service `password-api`
  - Se incluye la sección `deploy.replicas` para especificar la cantidad de instancias/containers a levantar (el ejercicio pedía **2**).

  - Se utiliza `expose` en lugar de `ports` porque no queremos publicar el servicio hacia el host. Este servicio sólo será accesible desde el load balancer. 

- Service `nginx` (load balancer)
  - Se especifica un **bind** a través de la sección `volumes` para que la configuración de `nginx` se tome desde un archivo ubicado en el file system del host.

  - Se utiliza `ports` para exponer el port 8080 hacia el host  

## Cómo levantar los containers

    $ docker-compose up

Existe la posibilidad de hacer override de la sección `deploy.replicas` al momento de levantar los containers especificando una cantidad distinta de instancias a través de la opción `--scale`. Por ejemplo, si se quieren levantar 5 instancias del servicio `password-api` (en lugar de 2):

<pre>
$ docker-compose up <b>--scale password-api=5</b>
</pre>

## Verificando el balanceo (desde el host)

<pre>
$ docker ps
CONTAINER ID   IMAGE     ....
<b>4290659af331</b>   nginx     ....
<b><span style="color:blue">779b8ca6b992</span></b>   nicopaez/password-api     ....
<b><span style="color:red">b43e94cdf451</span></b>   nicopaez/password-api     ....
</pre>

    while true; do curl localhost:8080; echo "\r"; sleep 1; done

<pre>
{"host":"<b><span style="color:blue">779b8ca6b992</span></b>","loadavg":[0,0.0029296875,0],"freemem":1417592832,"appversion":"1.0.0"}
{"host":"<b><span style="color:red">b43e94cdf451</span></b>","loadavg":[0,0.0029296875,0],"freemem":1416204288,"appversion":"1.0.0"}
{"host":"<b><span style="color:blue">779b8ca6b992</span></b>","loadavg":[0,0.0029296875,0],"freemem":1413832704,"appversion":"1.0.0"}
{"host":"<b><span style="color:red">b43e94cdf451</span></b>","loadavg":[0,0.00244140625,0],"freemem":1414172672,"appversion":"1.0.0"}
{"host":"<b><span style="color:blue">779b8ca6b992</span></b>","loadavg":[0,0.00244140625,0],"freemem":1414430720,"appversion":"1.0.0"}
{"host":"<b><span style="color:red">b43e94cdf451</span></b>","loadavg":[0,0.00244140625,0],"freemem":1414430720,"appversion":"1.0.0"}
...
</pre>

*Desde el browser observé dos compartamientos distintos: con Chrome responde siempre el mismo host mientras que con Safari se van alternando. Calculo que es alguna cuestión de política de "stickiness" entre el browser y el nginx.*
