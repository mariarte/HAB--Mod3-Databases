# Instalar Mongo DB en Ubuntu 18.04

[Documentación](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/)

## Instalación

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
```
## Verificar instalación
```
sudo service mongod start
```
Ver el fichero para confirmar el funcionamiento
```
sudo cat /var/log/mongodb/mongod.log

[initandlisten] waiting for connections on port 27017
```

Parar el servicio
```
sudo service mongod stop
```
Reiniciar el servicio 
```
sudo service mongod restart
```

## Ejecutar
```
mongo
```