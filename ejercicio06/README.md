## Descripción del `Dockerfile`
    FROM --platform=linux/x86_64 registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift:1.12-1.1655301789

*Me costó encontrar el identificador correcto de la imagen de RH, sobre todo porque hay una registry con autenticación y otra sin. Finalmente lo encontré al pie de [acá](https://catalog.redhat.com/software/containers/redhat-openjdk-18/openjdk18-openshift/58ada5701fbe981673cd6b10?container-tabs=gti&gti-tabs=unauthenticated)*

> También tuve que agregar `--platform=linux/x86_64` en el `FROM` porque estoy trabajando con MacOS chip M1.

    COPY passwordapi.jar /deployments/passwordapi.jar

Se usa la misma convención que la imagen de `fabric8`: hay que copiar el `jar` en el directorio `/deployments`. Si es el único `jar` en tal directorio (como en este caso) se va a ejecutar ese. 

    EXPOSE 8080

Exponer el puerto 8080 para mapearlo luego desde el host

    USER 185

Ejecutar la aplicación como usuario `jboss` (uid=185). El usuario `guest` no existe en este container.

## Construcción de la imagen

    docker build -t passwordapi-redhat:1.0 .

## Ejecución del container

    docker run -p 8080:8080 passwordapi-redhat:1.0

## Publicación de la imagen

    docker tag passwordapi-redhat:1.0 mchaia/passwordapi-redhat:1.0
    
    docker push mchaia/passwordapi-redhat:1.0

## Link a la imagen publicada en `dockerhub`

https://hub.docker.com/repository/docker/mchaia/passwordapi-redhat/general
