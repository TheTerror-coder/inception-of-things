
PORTS = -p 1880:80

IMAGE = theterror/iot-app-three:latest
CONTAINER = iot-app-c

all : build run

build :
	-docker build ../ -t  $(IMAGE)
run :
	-docker run -d --rm --name $(CONTAINER) $(PORTS) $(IMAGE)
exec :
	-docker exec -it  $(CONTAINER) sh
clean :
	-docker image rm $(IMAGE)
fclean : stop
	-docker image rm $(IMAGE)
stop :
	-docker stop  $(CONTAINER)
ps :
	-docker ps -a
ls :
	-docker image ls
	-docker container ls
logs :
	-docker logs $(CONTAINER)
logsf : # follow log output
	-docker logs --follow $(CONTAINER)

restart :
	-docker restart $(CONTAINER)

re : fclean all