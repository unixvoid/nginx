micro nginx
-----------

This project is dedicated to making a very small, but fully functional nginx container.
In this repo I will address both a docker and an appc container. Because my aim is to make the
container small, we will be statically compiling an nginx binary first (stage.0), and then moving
on to build the actual containers (stage.1).

- **stage.0**
  to build the stage.0 static binary we use docker. this is also very easy to do on your own box,
  but for the sake of reproducibility I will be using an alpine linux docker container.
