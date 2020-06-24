VERSION ?= $(shell cat VERSION)

IMG_REPO ?= rafaelcalleja
IMG_TAG ?= $(VERSION)
IMG_NAME ?= wireguard

default: image

image: $(BUILD_TARGETS)

push: $(PUSH_TARGETS)

image:
	docker build -t $(IMG_REPO)/$(IMG_NAME):$(IMG_TAG) -f Dockerfile .

mac-image:
	docker build -t $(IMG_REPO)/$(IMG_NAME):$(IMG_TAG)-mac -f Dockerfile.mac .

mac-alpine-image:
	docker build -t $(IMG_REPO)/$(IMG_NAME):$(IMG_TAG)-mac-alpine -f Dockerfile.mac-alpine .

push:
	docker push $(IMG_REPO)/$(IMG_NAME):$(IMG_TAG)
