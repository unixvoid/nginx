micro nginx
-----------

This project is dedicated to making a very small, but fully functional nginx container.
In this repo I will address both a docker and an appc container. Because my aim is to make the
container small, we will be statically compiling an nginx binary first (stage.0), and then moving
on to build the actual containers (stage.1).

- **quickstart**
  if you dont really care how this works, make sure all dependencies are met and follow the below steps
  - aci  
    `make stage`  
    `make aci`

  - docker  
    `make stage`  
    `make docker`

- **configuration**
  this build of nginx takes 3 mounts to get running. the conf, ssl (if needed), and data.
  these can be mounted to the following directories inside of the container.
  ```
  /cryo/conf/   : nginx.conf goes here
  /cryo/ssl     : ssl certs go here
  /cryo/data    : and shared content to be served goes here
  ```

- **dependencies**  
  if you only care about the nginx docker, only `docker` is required  
  if you want to build the aci container, you will need `docker` and `actools`

- **stage.0**  
  to build the stage.0 static binary we use docker. this is also very easy to do on your own box
  instead of on docker, but for the sake of reproducibility I will be using an alpine linux docker container.

  when `make stage` is executed, `stage.0/build.sh` is run. this script is just a easy way to compile
  nginx from source (with openssl source). we will use alpine linux as our base due to its small size and
  package manager. the script then builds nginx and copies it back to the host os. after the nginx binary is
  copied we move it to `stage.1/aci/` and `stage.1/docker/`.

- **stage.1**  
  in stage.1, the nginx binary has already been build and we build the containers. building the containers is
  simple, and you can easily read the Makefile for more verbose documentation. the following commands
  are supported in the Makefile

  ```
  make stage    : this will create the static nginx and stage it in stage.1/aci/ and stage.1/docker/
  make aci      : depends on 'make stage' being run, will build nginx aci image and copy it to the root of the project
  make docker   : depends on 'make stage' being run, will build the nginx docker
  make clean    : cleans all nginx binaries and aci images from this project
  ```
