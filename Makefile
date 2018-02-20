PASS_ENTRY=hub.docker.com
TAG=nicolaspetton/emacs-nodejs-docker

.PHONY: build run push

# Pass --no-cache to docker-build to force new build
build:
	docker build --tag ${TAG} .

run:
	docker run --rm --interactive --tty \
		--workdir /root \
		${TAG} bash

push:
	docker login --username=$$(pass-show-username.sh ${PASS_ENTRY}) --password=$$(pass-show-password.sh ${PASS_ENTRY})
	docker push ${TAG}
