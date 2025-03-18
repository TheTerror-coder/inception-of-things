
CLUSTER_CONFIG_FILES = tools/iot-cluster-config.yaml
MANIFESTS_DIR = manifests
ARGOCD_ACCOUNT_PASSWORD = 42@ilove
all : create

create :
	CLUSTER_CONFIG_FILES=$(CLUSTER_CONFIG_FILES) MANIFESTS_DIR=$(MANIFESTS_DIR) ARGOCD_ACCOUNT_PASSWORD=$(ARGOCD_ACCOUNT_PASSWORD) bash tools/init.sh

clean :
	k3d cluster delete --all
fclean : clean

ps :
	-docker ps -a
ls :
	-docker image ls
	-docker container ls

re : fclean all