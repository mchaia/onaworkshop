> - ¿Cuántos contenedores se están ejecutando? 

2 (`web` y `db`)

> - ¿Cuales son las imágenes en las que están basados los mencionados contenedores?

- web: `nicopaez/jobvacancy-ruby:1.3.0`
- db: `postgres`

> - ¿Puedes leer el docker-compose-jobvacancy.yml y describir lo que hace cada una de sus lineas?

`version: '2'`. Versión de sintáxis para este yaml file.

`services`. Sección donde se enumeran todos los containers que componen la aplicación.

Luego, para cada container (identificado con un nombre):

`image`. Imagen en la que se basa el container.

`environment`. Lista de variables de entorno que la aplicación que corre en el container espera tener definidas

`links`. Permite definir otros aliases por los cuales referenciar a otros servicios por `hostname`. En el ejemplo, el servicio `db` puede ser alcanzado desde `web` a través del hostname `db`. Si se hubiese especificado `db:dbpg`, `web` podría referirse al servicio `db` por medio de los hostnames `db` o `dbpg`.

`ports`. Mapping de ports expuestos entre el container y el host

`depends_on`. Expresa el orden de dependencia entre servicios. Los containers de los servicios enumerados en esta sección deben levantarse **antes** que éste.

> - Dado que cada contenedor corre en forma aislada ¿Cómo es posible que esos contenedores se vean entre sí?

Porque se levantan en la **misma red** de Docker (`network`) de tipo `bridge`. Dos o más containers conectados a la misma red bridge pueden comunicarse entre sí. Para verificarlo:

<pre>
$ docker ps
CONTAINER ID   IMAGE     ....
<b>518a</b>...        nicopaez/jobvacancy-ruby:1.3.0     ....
<b>aa75</b>...        postgres     ....
</pre>

<pre>
$ docker network ls
NETWORK ID     NAME       ....
<b>9bdf...</b>        nico-sessions_default     ....
</pre>

<pre>
$ docker network inspect <b>9bdf</b>... -f "{{json .Containers }}"  | python3 -m json.tool
{
    "<b>518a</b>...": {
        "Name": "nico-sessions-web-1",
        "EndpointID": "5bb1...",
        "MacAddress": "02:42:ac:13:00:03",
        "IPv4Address": "172.19.0.3/16",
        "IPv6Address": ""
    },
    "<b>aa75</b>...": {
        "Name": "nico-sessions-db-1",
        "EndpointID": "6c5c...",
        "MacAddress": "02:42:ac:13:00:02",
        "IPv4Address": "172.19.0.2/16",
        "IPv6Address": ""
    }
}
</pre>
