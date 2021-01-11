# bootstrap-docker

This set of scripts can be used to easily compile a customized version of Bootstrap, handling all dependencies and tools.

## TL;DR Instructions
- First Run (Skip this on subsequent runs)
  - Clone this GIT with `git clone https://github.com/michaelkrieger/bootstrap-docker.git`
  - Enter the repository with `cd bootstrap-docker`
  - Run `./IMAGE-BUILD.sh` to build the Docker image
  - Rename *custom.scss.sample* to *custom.scss* and incorporate your changes
- Run `./BS-BUILD.sh` to import your custom.scss and output a *dist* folder and a zip file.

## Commands
#### ./IMAGE-BUILD.sh
Builds a docker image from the Dockerfile. The Dockerfile installs all necessary tools (and vim) needed to compile Bootstrap from its source, as well as does an initial clone from GitHub. All dependencies are also pulled.

#### ./BS-BUILD.sh
Updates Bootstrap from GitHub, Imports your bootstrap.scss file from the current folder, Recompiles Bootstrap CSS and JS, and Outputs a dist folder and zip file of the compiled source. The instance is deleted after it is executed.

#### ./IMAGE-DELETE.sh
Frees the disk space used by the image created with ./IMAGE-BUILD.sh

#### ./IMAGE-RUN.sh
Provides a shell within the Docker Image which can be used to debug any error messages
