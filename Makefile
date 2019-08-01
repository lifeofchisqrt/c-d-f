export PWD=`pwd`
export USER_NAME=`whoami`
export PROJECT_NAME={{ cookiecutter.project_slug }}
export JUPYTER_HOST_PORT={{ cookiecutter.jupyter_host_port }}
export JUPYTER_DOCKER_PORT=8888
export MLFLOW_HOST_PORT={{ cookiecutter.mlflow_host_port }}
export MLFLOW_DOCKER_PORT=5000
export DOCKER_JUPYTER=config/Dockerfile-jupyter
export DOCKER_MLFLOW=config/Dockerfile-mlflow
export J_CONTAINER_NAME=$(PROJECT_NAME)-j-container
export J_IMAGE_NAME=$(PROJECT_NAME)-j-image
export M_CONTAINER_NAME=$(PROJECT_NAME)-m-container
export M_IMAGE_NAME=$(PROJECT_NAME)-m-image
export JUPYTER_ENABLE_LAB={{cookiecutter.jupyter_enable_lab}}

# TO-DO add github clone repo, set remote based on user

init-j-docker:
	echo "Initializing Jupyter docker image for $(USER_NAME), in project $(PROJECT_NAME)"
	docker build -t $(J_IMAGE_NAME) -f $(DOCKER_JUPYTER) -e PWD=$PWD --build-arg USER_NAME=$(USER_NAME) .

init-m-docker:
	echo "Initializing MLflow docker image for $(USER_NAME), in project $(PROJECT_NAME)"
	docker build -t $(M_IMAGE_NAME) -f $(DOCKER_MLFLOW) -e PWD=$PWD --build-arg USER_NAME=$(USER_NAME) .

create-j-container:
	docker run -it -v $PWD:/home/$(USER_NAME) -p $(JUPYTER_HOST_PORT):$(JUPYTER_DOCKER_PORT) --name $(J_CONTAINER_NAME) $(J_IMAGE_NAME)

create-m-container:
	docker run -it -v $PWD:/home/$(USER_NAME) -p $(MLFLOW_HOST_PORT):$(MLFLOW_DOCKER_PORT) --name $(M_CONTAINER_NAME) $(M_IMAGE_NAME)

start-j-container:
	docker start $(J_CONTAINER_NAME)

start-m-container:
	docker start $(M_CONTAINER_NAME)

jupyter-notebook:
	jupyter-notebook --port=8888

jupyter-lab:
	jupyter lab --port=8888

