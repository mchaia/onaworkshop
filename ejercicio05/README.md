### `HEALTHCHECK`

Indica la forma (implementación) de cómo verificar que un container está funcionando correctamente (su estado de salud).

El criterio para determinar el estado de un container es dependiente de cada aplicación y típicamente es obtener una respuesta HTTP 200 de alguna URL, verificar la existencia de un file particular, que un puerto esté escuchando, que un proceso particular esté levantado, etc.

En general:

    HEALTHCHECK [OPTIONS] CMD check_cmd || exit 1

El comando especificado se ejecutará al momento de levantar el container (y potencialmente en reiteradas oportunidades dependiendo de las opciones) para que Docker determine si el container está funcionando bien o no.

### `ONBUILD`

Especifica acciones que deben ejecutarse durante el proceso de building de otra imagen en la que se utilice la imagen actual (donde está el `ONBUILD`) como base.

Resulta útil para asegurarse que todas las imágenes derivadas cumplan ciertas precondiciones como ya contar con archivos agregados al file system o ya tengan determinados comandos ejecutados

Ejemplo:

    ONBUILD COPY . /app

### `VOLUME`

Especifica directorios **dentro del container** en los que se montarán volúmenes que se crearán al momento de correr el container.

Ejemplo:

    FROM busybox
    VOLUME /vol1 /vol2

Crear la imagen con:

    docker build -t my-busybox .

Al levantar el container e ingresar en él:

    docker run --rm -it my-busybox

se podrán ver los directorios `/vol1` y `/vol2` en los que se encontrarán montados los volúmenes creados.

Los cuales se pueden ver en el host:

    docker inspect -f '{{ json .Mounts }}' containerid | python -m json.tool 

(hay que averiguar el `containerid` del container mientras está corriendo con `docker ps`)

    [
        {
            "Type": "volume",
            "Name": "abf8...",
            "Source": "/var/lib/docker/volumes/abf8.../_data",
            "Destination": "/vol1",
            "Driver": "local",
            "Mode": "",
            "RW": true,
            "Propagation": ""
        },
        {
            "Type": "volume",
            "Name": "e4f6...",
            "Source": "/var/lib/docker/volumes/e4f6.../_data",
            "Destination": "/vol2",
            "Driver": "local",
            "Mode": "",
            "RW": true,
            "Propagation": ""
        }
    ]
