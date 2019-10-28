# c-d-f
#### Cookiecutter DataScience Flow
  
### What is it?  
  Cookiecutter Data Science Flow is template for personal analytical projects that uses Docker to provide Jupyter notebook with most important libraries and extensions, template of directory structure, with addition of MLflow server for experimentation with ML models.  
   
  Inspired by [cookiecutter-docker-science](https://github.com/docker-science/cookiecutter-docker-science) and [cookiecutter-data-science](https://github.com/drivendata/cookiecutter-data-science) projects.

#### Features:
  1. Reproducibility through Docker
  2. Standardized directory structure
  3. Extensibility and customization

### Why?
  Reproducibility of scientific results is what makes Data Science, well, science. Docker provides that. Being based on official Jupyter image means new projects are created from latest stable release and older ones should be compatible with common setups.  
    
  Directory template provides first line of defense against unstructured and chaotic creation of random notebooks or scripts. It allows more focused approach to solving problem at hand.  
  
  MLflow server and UI makes it easier to compare tested models. Logging parameters, saving and versioning models is easier than ever.
  
  Default image provides extensibility by installing nbextension package for notebooks and few useful extensions for Jupyter Lab as well. Default settings should be familiar to most but advanced users can extend template or edit configuration with ease.

### How to use it?
__Requirements__
  - Python 3.7 or later
  - [Cookiecutter 1.6](https://cookiecutter.readthedocs.io/en/latest/installation.html)
  - [Docker 18](https://docs.docker.com/install/#support)

__To start new project, run:__

``` shell
   cookiecutter https://github.com/lifeofchisqrt/c-d-f
```

### Directory Structure
Initial directory structure will look like:
```
├── Makefile                       <- Makefile with commands
├── README.md                      <- The top-level README
├── requirements.txt               <- Standard pip file for installing packages
├── .gitignore                     <- Git file ignoring folders data and models
├── config
│   ├── jupyter_notebook_config.py <- Configuration file for Jupyter
│   ├── Dockerfile-jupyter         <- Dockerfile for official Jupyter image
│   └── Dockerfile-mlflow          <- Dockerfile for MLflow server
├── data
│   ├── processed                  <- Intermediate data after processing.
│   ├── raw                        <- Raw, immutable dataset.
│   └── train                      <- The final data sets for training models.
├── mlruns                         <- MLflow model runs
├── models                         <- Saved, serialized models
├── notebooks                      <- All notebooks for exploratory analysis
├── references                     <- Data dictionaries
└── scripts                        <- Code for automatic preprocessing or data                                           collection
```
#### Make commands
c-d-f provides few make commands for setup of Docker environments. These can be run by specifiying 'make \[command]'.  

__init-all__  
After creation of directory structure this command will initialize building and creating Docker images and containers. After succesful creation of containers Jupyter Notebook and MLflow services will be started on localhost 127.0.0.1 and their respective ports entered during cookiecutter prompt (default 8890 and 8900).

__build-j-image__  
Builds image of Jupyter notebook from config/Dockerfile-jupyter. Image build will be named <project_name>-j-image.

__build-m-image__  
Builds image of MLflow from config/Dockerfile-mlflow. Image build will be named <project_name>-m-image.

__create-j-container__  
Runs docker container based on j-image, giving it name <project_name>-j-container. Also starts Jupyter notebook or Lab service on host 127.0.0.1 with port specified during cookiecutter project creation - defaults to 8890.

__create-m-container__  
Runs docker container based on m-image, giving it name <project_name>-m-container. Also starts MLflow service on host 127.0.0.1 with port specified during cookiecutter project creation - defaults to 8900.

__open-browser__  
Opens default browser with 2 tabs redirecting to Jupyter notebook and MLflow UI's on localhost 127.0.0.1 and their respective ports.

__enter-m-container__  
Opens SSH connection to docker container with MLflow service. Runs default container's shell.

__enter-j-container__  
Opens SSH connection to docker container with Jupyter service. Runs default container's shell.

__clean-image__  
Removes both docker images.

__clean-container__  
Removes both docker containers.

__git-init__  
Initializes git repository - equivalent to running `git init` (work in progress feature).

#### Planned Features
 - Git integration
 - simple CI/CD integration
 - notebook template at startup
 - remote data source synchronization

