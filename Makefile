include .env

start:
	docker start ${CONTAINER_NAME}

stop:
	docker stop ${CONTAINER_NAME}

create:
	docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
	@if ! docker network inspect ${NETWORK_NAME} >/dev/null 2>&1; then \
			echo "Creating Docker network ${NETWORK_NAME}"; \
			docker network create ${NETWORK_NAME}; \
	fi
	docker run -d -p ${PORT}:80 --name ${CONTAINER_NAME} --network ${NETWORK_NAME} ghcr.io/${IMAGE_NAME}

remove:
	docker rm -f ${CONTAINER_NAME}

build:
	docker build -t ghcr.io/${IMAGE_NAME} .

network:
	# docker network create ${NETWORK_NAME}
	@if ! docker network inspect ${NETWORK_NAME} >/dev/null 2>&1; then \
			echo "Creating Docker network ${NETWORK_NAME}"; \
			docker network create ${NETWORK_NAME}; \
	fi

init: build network create
