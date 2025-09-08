# Makefile
# Build a simple "hello-world" kernel module

obj-m += hello-world.o

# Default kernel build directory based on the running kernel version
KDIR ?= /lib/modules/$(shell uname -r)/build

# Current working directory
PWD  := $(shell pwd)

# Fallback: if the default KDIR doesn't exist (common inside containers),
# use the first available kernel headers directory under /usr/src/kernels
ifeq ("$(wildcard $(KDIR))","")
KDIR := /usr/src/kernels/$(shell ls -1 /usr/src/kernels | head -n1)
endif

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
