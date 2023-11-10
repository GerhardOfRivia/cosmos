#!/bin/sh

# TODO: Can this script be replaced by https://github.com/docker/build-push-action

# From this directory, to locally build x86 from an ARM machine (Mac Apple Silicon):
#   Uncomment OPENC3_REGISTRY line below
# Start the local registry. Note MacOS reserves port 5000 for Airdrop receiver.
# Search for Airdrop in System Prefs and disable Airdrop Receiver, then:
#   % docker run -d -p 5000:5000 --restart=always --name registry registry:2
# Ensure the ENV vars are correct. You probably want defaults:
#   docker.io/openc3inc/<image>:latest
# Export the ENV vars:
#   % export $(grep -v '^#' .env | xargs)
# Create the other necessary ENV vars:
#   % export OPENC3_UPDATE_LATEST=false
# Create the tag version which will be pushed. Something other than latest!!!
#   % export OPENC3_RELEASE_VERSION=gcp
# Create the env and perform the build
#   % docker buildx create --use --name openc3-builder2 --driver-opt network=host
#   % ./build_multi_arch.sh

set -eux
OPENC3_PLATFORMS=linux/amd64,linux/arm64
cd ../..
eval $(sed -e '/^#/d' -e 's/^/export /' -e 's/$/;/' .env) ;
# OPENC3_REGISTRY=localhost:5000 # Uncomment for local builds

# Setup cacert.pem
echo "Downloading cert from curl"
curl -q -L https://curl.se/ca/cacert.pem --output ./cacert.pem
if [ $? -ne 0 ]; then
  echo "ERROR: Problem downloading cacert.pem file from https://curl.se/ca/cacert.pem" 1>&2
  echo "openc3_setup FAILED" 1>&2
  exit 1
else
  echo "Successfully downloaded ./cacert.pem file from: https://curl.se/ca/cacert.pem"
fi

cp ./cacert.pem openc3-ruby/cacert.pem
cp ./cacert.pem openc3-redis/cacert.pem
cp ./cacert.pem openc3-traefik/cacert.pem
cp ./cacert.pem openc3-minio/cacert.pem

cd openc3-ruby
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
  --build-arg ALPINE_BUILD=${ALPINE_BUILD} \
  --build-arg APK_URL=${APK_URL} \
  --build-arg RUBYGEMS_URL=${RUBYGEMS_URL} \
  --build-arg OPENC3_DEPENDENCY_REGISTRY=${OPENC3_DEPENDENCY_REGISTRY} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-ruby:${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-ruby:${OPENC3_RELEASE_VERSION} .

if [ $OPENC3_UPDATE_LATEST = true ]
then
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
  --build-arg ALPINE_BUILD=${ALPINE_BUILD} \
  --build-arg APK_URL=${APK_URL} \
  --build-arg RUBYGEMS_URL=${RUBYGEMS_URL} \
  --build-arg OPENC3_DEPENDENCY_REGISTRY=${OPENC3_DEPENDENCY_REGISTRY} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-ruby:latest \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-ruby:latest .
fi

cd ../openc3
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-base:${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-base:${OPENC3_RELEASE_VERSION} .

if [ $OPENC3_UPDATE_LATEST = true ]
then
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-base:latest \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-base:latest .
fi

cd ../openc3-node
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-node:${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-node:${OPENC3_RELEASE_VERSION} .

if [ $OPENC3_UPDATE_LATEST = true ]
then
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-node:latest \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-node:latest .
fi

# Note: Missing OPENC3_REGISTRY build-arg intentionally to default to docker.io
cd ../openc3-redis
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_DEPENDENCY_REGISTRY=${OPENC3_DEPENDENCY_REGISTRY} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-redis:${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-redis:${OPENC3_RELEASE_VERSION} .

if [ $OPENC3_UPDATE_LATEST = true ]
then
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_DEPENDENCY_REGISTRY=${OPENC3_DEPENDENCY_REGISTRY} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-redis:latest \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-redis:latest .
fi

cd ../openc3-minio
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_DEPENDENCY_REGISTRY=${OPENC3_DEPENDENCY_REGISTRY} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-minio:${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-minio:${OPENC3_RELEASE_VERSION} .

if [ $OPENC3_UPDATE_LATEST = true ]
then
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_DEPENDENCY_REGISTRY=${OPENC3_DEPENDENCY_REGISTRY} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-minio:latest \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-minio:latest .
fi

cd ../openc3-cosmos-cmd-tlm-api
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-cosmos-cmd-tlm-api:${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-cosmos-cmd-tlm-api:${OPENC3_RELEASE_VERSION} .

if [ $OPENC3_UPDATE_LATEST = true ]
then
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-cosmos-cmd-tlm-api:latest \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-cosmos-cmd-tlm-api:latest .
fi

cd ../openc3-cosmos-script-runner-api
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-cosmos-script-runner-api:${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-cosmos-script-runner-api:${OPENC3_RELEASE_VERSION} .

if [ $OPENC3_UPDATE_LATEST = true ]
then
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-cosmos-script-runner-api:latest \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-cosmos-script-runner-api:latest .
fi

cd ../openc3-operator
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-operator:${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-operator:${OPENC3_RELEASE_VERSION} .

if [ $OPENC3_UPDATE_LATEST = true ]
then
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-operator:latest \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-operator:latest .
fi

# Note: Missing OPENC3_REGISTRY build-arg intentionally to default to docker.io
cd ../openc3-traefik
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_DEPENDENCY_REGISTRY=${OPENC3_DEPENDENCY_REGISTRY} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-traefik:${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-traefik:${OPENC3_RELEASE_VERSION} .

if [ $OPENC3_UPDATE_LATEST = true ]
then
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-arg OPENC3_DEPENDENCY_REGISTRY=${OPENC3_DEPENDENCY_REGISTRY} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-traefik:latest \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-traefik:latest .
fi

cd ../openc3-cosmos-init
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-context docs=../docs.openc3.com \
  --build-arg NPM_URL=${NPM_URL} \
  --build-arg OPENC3_DEPENDENCY_REGISTRY=${OPENC3_DEPENDENCY_REGISTRY} \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-cosmos-init:${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-cosmos-init:${OPENC3_RELEASE_VERSION} .

if [ $OPENC3_UPDATE_LATEST = true ]
then
docker buildx build \
  --platform ${OPENC3_PLATFORMS} \
  --progress plain \
  --build-context docs=../docs.openc3.com \
  --build-arg NPM_URL=${NPM_URL} \
  --build-arg OPENC3_DEPENDENCY_REGISTRY=${OPENC3_DEPENDENCY_REGISTRY} \
  --build-arg OPENC3_REGISTRY=${OPENC3_REGISTRY} \
  --build-arg OPENC3_NAMESPACE=${OPENC3_NAMESPACE} \
  --build-arg OPENC3_TAG=${OPENC3_RELEASE_VERSION} \
  --push -t ${OPENC3_REGISTRY}/${OPENC3_NAMESPACE}/openc3-cosmos-init:latest \
  --push -t ${OPENC3_ENTERPRISE_REGISTRY}/${OPENC3_ENTERPRISE_NAMESPACE}/openc3-cosmos-init:latest .
fi
