include .env

start:
	docker start ${CONTAINER_NAME}

stop:
	docker stop ${CONTAINER_NAME}

create:
	docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
	docker run -d -p ${PORT}:80 --name ${CONTAINER_NAME} --network ${NETWORK_NAME} ${IMAGE_NAME}

remove:
	docker rm -f ${CONTAINER_NAME}

build:
	docker build -t ${IMAGE_NAME} .

network:
	@if ! docker network inspect ${NETWORK_NAME} >/dev/null 2>&1; then \
			echo "Creating Docker network ${NETWORK_NAME}"; \
			docker network create ${NETWORK_NAME}; \
	fi

init: build network create
