VERSION ?= $(shell cat VERSION)

IMG_REPO ?= rafaelcalleja
IMG_TAG ?= $(VERSION)
IMG_NAME ?= wireguard

BUILD_REF ?= library/alpine:3.10
KERNEL_REF ?= $(shell docker run --privileged -it --rm --pid host busybox nsenter -t1 -m -- cat /etc/linuxkit.yml | docker run -i karlkfi/yq -r '.kernel.image')

default: image

image: $(BUILD_TARGETS)

push: $(PUSH_TARGETS)

image:
	docker build -t $(IMG_REPO)/$(IMG_NAME):$(IMG_TAG) -f Dockerfile .

mac-image:
	docker build -t $(IMG_REPO)/$(IMG_NAME):$(IMG_TAG)-mac -f Dockerfile.mac \
		--build-arg BUILD_REF=$(BUILD_REF) \
		--build-arg KERNEL_REF=$(KERNEL_REF) \
		.

push:
	docker push $(IMG_REPO)/$(IMG_NAME):$(IMG_TAG)
