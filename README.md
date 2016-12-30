#Framadate Dockerfile

Installs a production-ready instance of [Framadate](https://framadate.org/) in a docker container. Need seperate DB container.

##USAGE
    docker build -t framadate .
    docker run --rm -p 9090:80 -v /your/config/file:/var/www/html/app/inc/config.php framadate
