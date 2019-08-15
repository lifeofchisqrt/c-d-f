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



build-j-image:
	docker build -t $(J_IMAGE_NAME) -f $(DOCKER_JUPYTER) \
	--build-arg PROJECT_NAME=$(PROJECT_NAME) --build-arg USER_NAME=$(USER_NAME) .

build-m-image:
	docker build -t $(M_IMAGE_NAME) -f $(DOCKER_MLFLOW) \
	--build-arg USER_NAME=$(USER_NAME) --build-arg PROJECT_NAME=$(PROJECT_NAME) \
	--build-arg UID=$(shell id -u) --build-arg GUID=$(shell id -g) .

create-j-container:
	docker run -i -d -e JUPYTER_ENABLE_LAB=$(JUPYTER_ENABLE_LAB) \
	-e NB_USER=$(USER_NAME) --user root -w /home/$(NB_USER) -v $(PWD):/home/$(USER_NAME)/$(PROJECT_NAME) \
	-p $(JUPYTER_HOST_PORT):$(JUPYTER_DOCKER_PORT) --rm --name $(J_CONTAINER_NAME) $(J_IMAGE_NAME) \
	{%- if cookiecutter.jupyter_enable_lab == 'yes' %}
	start.sh jupyter lab --LabApp.token=''
	{%- else %}
	start.sh jupyter notebook --NotebookApp.token=''
	{% endif %}

create-m-container:
	docker run -i -d -v $(PWD):/home/$(USER_NAME)/$(PROJECT_NAME) \
	-p $(MLFLOW_HOST_PORT):$(MLFLOW_DOCKER_PORT) --name $(M_CONTAINER_NAME) $(M_IMAGE_NAME)

init-all: build-j-image build-m-image create-j-container create-m-container

enter-j-container: 
	docker exec --user $(USER_NAME) -it $(J_CONTAINER_NAME) /bin/bash -m

enter-m-container: 
	docker exec --user $(USER_NAME) -it $(M_CONTAINER_NAME) /bin/bash -m


open-browser:
	python -m webbrowser "127.0.0.1:$(JUPYTER_HOST_PORT)" && \
	python -m webbrowser "127.0.0.1:$(MLFLOW_HOST_PORT)"

clean-container: ## remove Docker container
	docker rm $(J_CONTAINER_NAME) && \
	docker rm $(M_CONTAINER_NAME)

clean-image: ## remove Docker image
	docker image rm $(J_IMAGE_NAME) && \
	docker image rm $(M_IMAGE_NAME)

