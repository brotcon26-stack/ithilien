ARG BASE_IMAGE=quay.io/almalinuxorg/almalinux-bootc:9
FROM ${BASE_IMAGE}

#Update base image
RUN dnf update && dnf clean all
