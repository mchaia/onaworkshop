### `HEALTHCHECK`

Indica la forma (implementación) de cómo verificar que un container está funcionando correctamente (su estado de salud).

El criterio para determinar el estado de un container es dependiente de cada aplicación y típicamente es obtener una respuesta HTTP 200 de alguna URL, verificar la existencia de un file particular, que un puerto esté escuchando, que un proceso particular esté levantado, etc.

En general:

    HEALTHCHECK [OPTIONS] CMD check_cmd || exit 1
 
### `ONBUILD`

Especifica acciones que deben ejecutarse durante el proceso de building de otra imagen en la que se utilice la imagen actual (donde está el `ONBUILD`) como base.

Resulta útil para asegurarse que todas las imágenes derivadas cumplan ciertas precondiciones como ya contar con archivos agregados al file system o ya tengan determinados comandos ejecutados

Ejemplo:

    ONBUILD COPY . /app

### `VOLUME`
