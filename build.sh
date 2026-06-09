#!/bin/bash
TARGET=${1:-'staging'}

if [ "$TARGET" = "canary" ]; then
    podman build -t registry.lab/ithilien:canary \
        -f Containerfile \
        --build-arg BASE_IMAGE=quay.io/centos-bootc/centos-bootc:stream9 \
        && podman push registry.lab/ithilien:canary

else
    podman build -t registry.lab/ithilien:staging \
        -f Containerfile \
        && podman push registry.lab/ithilien:staging

fi

