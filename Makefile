IMAGE_TAG=1.0.0
all: clean build
.PHONY: all

clean:
	IMAGE_TAG=$(IMAGE_TAG) docker-compose down || true
.PHONY: clean

build: clean
	IMAGE_TAG=$(IMAGE_TAG) docker-compose up
.PHONY: build