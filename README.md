# Dockerized Minecraft Java Server
This project is a simple dockerized environment in which to run a minecraft java vanilla server. The main goals vs existing solutions are simple persistence (bind mounts to easily modify+backup world and config data), keeping a slim image (alpine based, minimal layers), and easy iterability (change one URL to rebuild to build a new version or texture pack).

The Docker Hub page can be found at [this link](https://hub.docker.com/repository/docker/tarfeef101/mc_java_vanilla).

## Anatomy
```
.
config/
docker-compose.yaml
Dockerfile
README.md
worlds/
```
### config/
This directory is what will be bind-mounted into the container to house your config files. You should put your personalized, `banned-ips.json`, `banned-players.json`, `ops.json`, `server.properties`, and `whitelist.json` files in this directory.

### docker-compose.yaml
This file is what defines the runtime state of your container. This is a very simple setup, so just ensure to  select whatever port you wish to expose for your host port, and remember to keep this project in a folder mounted on a drive where you want those persisted directories to store data.

### Dockerfile
The Dockerfile tries to keep the image as simple and slim as possible. A slim base image is used to reduce size, minimal packages are installed, and all `RUN` commands are kept into one layer to reduce size.

### worlds/
This is the bind-mounted directory which will house your world data. This should be empty unless you have a pre-existing world you want to import. If you want to add resource packs, this is the place to put them.

## Building
To build a new version edit the `docker-compose.yaml` file, and set the `VERSION` argument to the version you wish to build. Then, run `docker-compose build` or `docker-compose up --build -d` (to just build, or build and start the server).
