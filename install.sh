#!/bin/bash

set -x

IMPORTS_DIR="/mnt/host/etc/containerd/config.d"
BIN_DIR="/mnt/host/usr/local/bin"

mkdir -p ${IMPORTS_DIR}

cp /artifacts/runsc ${BIN_DIR}
cp /artifacts/containerd-shim-runsc-v1 ${BIN_DIR}
cp /artifacts/gvisor.toml ${IMPORTS_DIR}/gvisor.toml

systemctl stop containerd
systemctl start containerd
