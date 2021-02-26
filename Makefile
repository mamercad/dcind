.PHONY: build run

build:
	docker build -t mamercad/dcind:ansible .

run:
	docker run --rm --privileged -it mamercad/dcind:ansible sh

push:
	docker push mamercad/dcind:ansible
