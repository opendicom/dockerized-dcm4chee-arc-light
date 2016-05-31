#!/bin/bash

# test mariadb dockerfile for dcm4chee-arc-5
# remove existing image, build new image, start, inspect and remove container

image_name='mariadb-for-dcm4chee-arc'
image_tag='5.2.1'
image_id=`docker images -q mariadb-for-dcm4chee-arc`
testing_container_name='testing_mariadb_'`date +%Y%m%d_%H%M%S`

# purgue existing image
if [ -n "$image_id" ]; then
    echo "- Image '$image_name' (id: $image_id) exists, deleting..."
    docker rmi -f $image_id
else
    echo "- Image '$image_name' does not exists, nothing to delete"
fi

# build new image
echo '- Building new image...'
docker build -t $image_name:$image_tag .

# start container
echo "- Starting (detached) container..."
docker run \
  -e MYSQL_ROOT_PASSWORD='secure' \
  -e MYSQL_DATABASE='awesome' \
  --name $testing_container_name \
  --detach \
  $image_name:$image_tag

# inspect container
echo "- Inspecting container..."
docker exec -ti $testing_container_name /bin/bash

# stop and delete container
echo "- Deleting container..."
docker rm -f $testing_container_name
