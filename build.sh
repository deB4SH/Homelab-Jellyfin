#! /bin/bash
# check installed container-cli
cli_cmd=''
if [ -x "$(command -v podman)" ]; then
    cli_cmd="podman"
elif [ -x "$(command -v docker)" ]; then
    cli_cmd="docker"
else
    echo "No container cli tool found! Aborting."
    exit -1
fi

# defaults
REGISTRY="ghcr.io/deb4sh"

# parse options
while getopts :r: flag
do
    case "${flag}" in
        r) REGISTRY=${OPTARG};;
    esac
done

# get current tag information
IS_DEV_BUILD=$(git tag -l --contains HEAD)
GIT_TAG=$(git describe --abbrev=0 --tags HEAD)

if [ -z "$IS_DEV_BUILD" ]
then
    TIMESTAMP=$(date +%s)
    TAG=$(echo "$GIT_TAG"-"$TIMESTAMP")
else 
    TAG=$GIT_TAG
fi

echo "Building image with tag $TAG"

${cli_cmd}  \
    build . \
    -f src/docker/Dockerfile \
    -t $(echo "$REGISTRY/homelab-jellyfin-image:$TAG")
    