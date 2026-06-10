ARG BASE_IMAGE=quay.io/almalinuxorg/almalinux-bootc:9
FROM ${BASE_IMAGE}

#Copy and trust caddy cert
COPY root.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

#Update base image
RUN dnf update -y && dnf clean all

#Random packages
#RUN dnf install \
#   fastfetch

#Cockpit stuff
RUN dnf install -y\
    cockpit \
    cockpit-selinux \
    #cockpit-zfs \
    && dnf clean all

#Installing zfs
RUN dnf install -y https://zfsonlinux.org/epel/zfs-release-2-3.el9.noarch.rpm && \
    dnf install -y dnf-plugins-core && \
    dnf config-manager --disable zfs && \
    dnf config-manager --enable zfs-kmod && \
    dnf install -y zfs && \
    dnf clean all

RUN systemctl enable zfs-import-cache zfs-import-scan zfs-mount zfs.target

#NFS installation
RUN dnf install -y nfs-utils && dnf clean all
RUN systemctl enable nfs-server rpcbind

#Samba installation
RUN dnf install -y samba samba-client
RUN systemctl enable smb nmb

#Cockpit file sharing - 45drives package, somewhat experimental
#RUN curl -sSL https://repo.45drives.com/setup | bash \
#    && dnf install cockpit-file-sharing

