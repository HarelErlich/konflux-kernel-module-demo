# Dockerfile
# Use CentOS Stream 9 so we can install kernel headers without a Red Hat subscription.
FROM quay.io/centos/centos:stream9 AS build

# Install toolchain and kernel headers that match the container's kernel.
# NOTE: The module will match the kernel inside the container, not your host.
RUN dnf -y update && \
    dnf -y install gcc make elfutils-libelf-devel kernel-devel && \
    dnf clean all

# Workdir for the module sources
WORKDIR /usr/src/app

# Copy sources
# Expect: hello-world.c and Makefile in the build context
COPY . .

# Build the kernel module (.ko)
# The Makefile uses uname -r; inside the container it matches the installed kernel-devel.
RUN make && \
    # (Optional) sanity check the built artifact
    /usr/sbin/modinfo hello-world.ko || exit 1

# Produce a minimal image that just carries the built artifact
FROM scratch AS artifact
COPY --from=build /usr/src/app/hello-world.ko /hello-world.ko
