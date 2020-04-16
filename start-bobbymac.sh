# Set vars
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DATA_DIR="$HOME/blogs/bobbymac/ghost_volume";
CONTAINER_NAME="ghost_bobbymac"

# Stop and remove the existing container if
# it is already running.
docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME

docker run \
	-d \
	--restart=always \
	-v $DATA_DIR/content:/var/lib/ghost/content \
	-v $DATA_DIR/config.json:/var/lib/ghost/config.production.json \
	--expose=2368 \
	--name $CONTAINER_NAME \
	--net nginx-proxy  \
	-e VIRTUAL_HOST=www.bobbymac.rocks \
	ghost
