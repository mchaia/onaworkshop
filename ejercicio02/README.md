    $ docker pull nicopaez/pingapp:3.0.0
    $ docker login -u mchaia --password-stdin  ## ingreso mi password
    $ docker tag nicopaez/pingapp:3.0.0 mchaia/pingapp:3.0.0
    $ docker push mchaia/pingapp:3.0.0
    $ docker image rm mchaia/pingapp:3.0.0  ## la borro para probar que descargue bien
    $ docker pull mchaia/pingapp:3.0.0

