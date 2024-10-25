FROM ubuntu:24.04 AS gvisor

ENV VERSION=latest
ENV ARCH=x86_64
ENV URL=https://storage.googleapis.com/gvisor/releases/release/${VERSION}/${ARCH}

RUN apt-get update && \
    apt-get install -y systemd \
      wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*4

ENV SYSTEMCTL_FORCE_BUS=1

WORKDIR /artifacts

RUN wget ${URL}/runsc \
    ${URL}/runsc.sha512 \
    ${URL}/containerd-shim-runsc-v1 \
    ${URL}/containerd-shim-runsc-v1.sha512

RUN sha512sum -c runsc.sha512 \
    -c containerd-shim-runsc-v1.sha512 && \
    rm -f *.sha512

RUN chmod a+rx runsc containerd-shim-runsc-v1

COPY --chmod=644 gvisor.toml .
COPY --chmod=755 install.sh .

CMD ["/artifacts/install.sh"]
