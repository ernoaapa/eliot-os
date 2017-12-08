NAME = rsync

# Where to push the docker image.
REGISTRY ?= ernoaapa

# Which architecture to build
ARCH ?= amd64
OS ?= linux

# This version-strategy uses git tags to set the version string
GIT_HASH ?= $(shell git describe --tags --always --dirty)
VERSION := $(GIT_HASH)-$(ARCH)

###
### These variables should not need tweaking.
###

PLATFORMS := linux-amd64 linux-arm64

IMAGE := $(REGISTRY)/$(NAME)

all: all-push push-manifest

container-%:
	@$(MAKE) --no-print-directory ARCH=$(word 2,$(subst -, ,$*)) OS=$(word 1,$(subst -, ,$*))  container

push-%:
	@$(MAKE) --no-print-directory ARCH=$(word 2,$(subst -, ,$*)) OS=$(word 1,$(subst -, ,$*))  push

all-container: $(addprefix container-, $(PLATFORMS))

all-push: $(addprefix push-, $(PLATFORMS))

DOTFILE_IMAGE = $(subst :,_,$(subst /,_,$(IMAGE))-$(VERSION))

container: .container-$(DOTFILE_IMAGE) container-name
.container-$(DOTFILE_IMAGE): Dockerfile.in
	@sed \
			-e 's|ARG_OS|$(OS)|g' \
			-e 's|ARG_ARCH|$(ARCH)|g' \
	    Dockerfile.in > .dockerfile-$(ARCH)
	@docker build -t $(IMAGE):$(VERSION) -f .dockerfile-$(ARCH) .
	@docker images -q $(IMAGE):$(VERSION) > $@

container-name:
	@echo "container: $(IMAGE):$(VERSION)"

push: .push-$(DOTFILE_IMAGE) push-name
.push-$(DOTFILE_IMAGE): .container-$(DOTFILE_IMAGE)
ifeq ($(findstring gcr.io,$(REGISTRY)),gcr.io)
	@gcloud docker -- push $(IMAGE):$(VERSION)
else
	@docker push $(IMAGE):$(VERSION)
endif
	@docker images -q $(IMAGE):$(VERSION) > $@

push-name:
	@echo "pushed: $(IMAGE):$(VERSION)"

push-manifest:
	manifest-tool \
		--username $(username) \
		--password $(password) \
		push from-args \
    --platforms linux/amd64,linux/arm64 \
    --template $(IMAGE):$(GIT_HASH)-ARCH \
    --target $(IMAGE):$(GIT_HASH)

version:
	@echo $(VERSION)

clean: container-clean

container-clean:
	rm -rf .container-* .dockerfile-* .push-*
