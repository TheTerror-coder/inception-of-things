
CLUSTER_CONFIG_FILES = tools/iot-cluster-config.yaml
MANIFESTS_DIR = manifests
all : create

create :
	CLUSTER_CONFIG_FILES=$(CLUSTER_CONFIG_FILES) MANIFESTS_DIR=$(MANIFESTS_DIR) bash tools/init.sh

clean :
	k3d cluster delete --all
fclean : clean

ps :
	-docker ps -a
ls :
	-docker image ls
	-docker container ls

re : fclean all