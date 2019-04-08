# Montar base de datos Mysql (experiencia controlada)
```
$ sudo apt-get update

$ sudo apt-get install mysql-server

$ sudo mysql -u root -p
// Cambiar password
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

mysql> USE mysql;

mysql> GRANT ALL PRIVILEGES ON *.* TO 'hackabos'@'localhost' IDENTIFIED BY 'password';


mysql> FLUSH PRIVILEGES;
mysql> exit;
https://dev.mysql.com/doc/refman/5.7/en/grant.html

mysql> SELECT user FROM mysql.user GROUP BY user;

mysql> DELETE FROM mysql.user WHERE user = 'username';


// si el servicio se para o para reiniciar
$ service mysql restart
$ mysql -u hackabos

$

$ sudo apt-get install mysql-workbench
```