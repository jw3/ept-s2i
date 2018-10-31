IMAGE_NAME = ept-s2i
TAG_NAME=latest

.PHONY: build
build:
	docker build --build-arg TAG=$(TAG_NAME) --build-arg http_proxy --build-arg https_proxy -t $(IMAGE_NAME) .

.PHONY: test
test:
	docker build --build-arg TAG=$(TAG_NAME) --build-arg http_proxy --build-arg https_proxy -t $(IMAGE_NAME)-candidate .
	IMAGE_NAME=$(IMAGE_NAME)-candidate test/run
