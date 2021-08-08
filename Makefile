
DOCKERHUB_ID:=ibmosquito
NAME:=waterer-ui
VERSION:=1.0.0
PORT:=80

all: build run

build:
	docker build -t $(DOCKERHUB_ID)/$(NAME):$(VERSION) .

dev: build stop
	-docker rm -f $(NAME) 2> /dev/null || :
	touch ./config.json ./log.json
	docker run -it --privileged \
            --name $(NAME) \
	    -p $(PORT):$(PORT) \
	    -v /etc/localtime:/etc/localtime \
	    -v `pwd`/html://usr/local/apache2/htdocs/outside/ \
	    $(DOCKERHUB_ID)/$(NAME):$(VERSION)

run: stop
	-docker rm -f $(NAME) 2>/dev/null || :
	touch ./config.json ./log.json
	docker run -d --privileged \
            --name $(NAME) --restart unless-stopped \
	    -p $(PORT):$(PORT) \
	    -v /etc/localtime:/etc/localtime \
	    $(DOCKERHUB_ID)/$(NAME):$(VERSION)

exec:
	docker exec -it $(NAME) /bin/sh

push:
	docker push $(DOCKERHUB_ID)/$(NAME):$(VERSION)

stop:
	-docker rm -f $(NAME) 2>/dev/null || :

clean: stop
	-docker rmi $(DOCKERHUB_ID)/$(NAME):$(VERSION) 2>/dev/null || :

.PHONY: all build dev run exec stop clean

