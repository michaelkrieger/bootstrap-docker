if [ ! "$(docker ps -q -f name=bsdev)" ]; then
  if [ "$(docker ps -aq -f status=exited -f name=bsdev)" ]; then
     # cleanup exited container
     docker rm bsdev
  fi
  # Start a new container and run bash
  docker run -it --name bsdev --entrypoint bash bootstrapdev
else
  # Run bash within existing container
  docker exec -it --name bsdev bash
fi
