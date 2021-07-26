# Create a container from bootstrapdev if not exist
if [ ! "$(docker ps -q -f name=bsdev)" ]; then
  if [ "$(docker ps -aq -f status=exited -f name=bsdev)" ]; then
     # cleanup exited container
     docker rm bsdev
  fi
  # Start a new container and run bash
  docker create -ti --name bsdev bootstrapdev bash
fi

# Start the container
docker start bsdev

# Update customizations and recompile changes
docker exec -ti -w /home/bootstrap/bootstrap/bootstrap bsdev bash -c "git reset --hard"
docker exec -ti -w /home/bootstrap/bootstrap/bootstrap bsdev bash -c "git pull --no-rebase"

# Update the 'starter' custom files
docker cp ./bootstrap.scss bsdev:/home/bootstrap/bootstrap/scss/bootstrap.scss
docker cp ./custom.scss bsdev:/home/bootstrap/bootstrap/scss/custom.scss
docker cp ./package.json bsdev:/home/bootstrap/bootstrap/package.json

docker exec -ti -w /home/bootstrap/bootstrap bsdev bash -c "git checkout tags/v5.0.2"
docker exec -ti -w /home/bootstrap/bootstrap bsdev bash -c "npm run dist"

# Export Files to Host
rm -Rf ./dist
mkdir ./dist
docker cp bsdev:/home/bootstrap/bootstrap/dist/css ./dist/css
docker cp bsdev:/home/bootstrap/bootstrap/dist/js ./dist/js
cd dist
DATESTAMP=`date "+%Y-%m-%d.%H:%M:%S"`
zip -r dist-$DATESTAMP.zip css js
mv dist-$DATESTAMP.zip ..
cd ..

# Delete container
docker rm -f bsdev


