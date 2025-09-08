# Dockerfile
# Start with a Red Hat Universal Base Image 9, which is similar to RHEL
FROM registry.redhat.io/ubi9/ubi

# Install the build tools: the kernel headers for the latest kernel, make, and gcc
RUN dnf install -y kernel-devel make gcc elfutils-libelf-devel

# Create a directory for our source code inside the container
WORKDIR /usr/src/app

# Copy all our local files (hello-world.c, Makefile) into the container
COPY . .

# Run the build command inside the container
RUN make