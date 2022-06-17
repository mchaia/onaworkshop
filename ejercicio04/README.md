## Descripción del `Dockerfile`
    FROM fabric8/java-alpine-openjdk8-jre:1.9.0

Elegí la úlitma imagen java basada en Alpine (1.9.0) que solo contenga el JRE (runtime) ya que el compilador (JDK) no es necesario. 

    COPY passwordapi.jar /deployments/passwordapi.jar

Según la documentación de la imagen utilizada hay que copiar el `jar` en el directorio `/deployments`. Si es el único `jar` en tal directorio (como en este caso) se va a ejecutar ese. 

    EXPOSE 8080

Exponer el puerto 8080 para mapearlo luego desde el host

    USER 405

Ejecutar la aplicación como usuario `guest` (uid=405)

## Construcción de la imagen

    docker build -t passwordapi-mchaia:1.0 .

## Ejecución del container

    docker run -p 8080:8080 passwordapi-mchaia:1.0

## Publicación de la imagen

    docker tag passwordapi-mchaia:1.0 mchaia/passwordapi:1.0
    
    docker push mchaia/passwordapi:1.0

## Link a la imagen publicada en `dockerhub`

https://hub.docker.com/repository/docker/mchaia/passwordapi/general
