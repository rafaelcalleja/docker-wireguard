VERSION ?= $(shell cat VERSION)

IMG_REPO ?= rafaelcalleja
IMG_TAG ?= $(VERSION)
IMG_NAME ?= wireguard

default: image

image: $(BUILD_TARGETS)

push: $(PUSH_TARGETS)

image:
	docker build -t $(IMG_REPO)/$(IMG_NAME):$(IMG_TAG) -f Dockerfile .

push:
	docker push $(IMG_REPO)/$(IMG_NAME):$(IMG_TAG)
