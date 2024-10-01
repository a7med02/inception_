# Variables
DOCKER_COMPOSE = docker compose
WORK_DIR = --project-directory ./srcs
DOCKER_COMPOSE_FILE = -f srcs/docker-compose.yml
DOCKER_COMPOSE_OVERRIDE = -f srcs/docker-compose.override.yml
BUILD = $(DOCKER_COMPOSE) $(WORK_DIR) build
REBUILD = $(DOCKER_COMPOSE) $(WORK_DIR) build --no-cache
UP = $(DOCKER_COMPOSE) $(WORK_DIR) up 
DOWN = $(DOCKER_COMPOSE) $(WORK_DIR) down
LOGS = $(DOCKER_COMPOSE) $(WORK_DIR) logs
RESTART = $(DOCKER_COMPOSE) $(WORK_DIR) restart
CONFIG = $(DOCKER_COMPOSE) $(WORK_DIR) config
PS = $(DOCKER_COMPOSE) $(WORK_DIR) ps

# Targets
.PHONY: all build up down logs restart config ps clean

all: build up

volumes:
	rm -rf /home/ahmed/data/wordpress 
	rm -rf /home/ahmed/data/mariadb
	mkdir /home/ahmed/data/wordpress
	mkdir /home/ahmed/data/mariadb

re:  down volumes build up
	

dev:
	$(DOCKER_COMPOSE) $(DOCKER_COMPOSE_FILE) $(DOCKER_COMPOSE_OVERRIDE)

build:
	$(BUILD)

rebuild:
	$(REBUILD)
	$(UP)

up: build
	$(UP)

down:
	$(DOWN)

logs:
	$(LOGS)

restart:
	$(RESTART)

config:
	$(CONFIG)

ps:
	$(PS)

clean:
	$(DOWN) --volumes
	rm -f srcs/requirements/nginx/logs/*
	docker system prune -f

check-override:
	$(CONFIG) | grep -q "- ./requirements/nginx/logs:/var/log/nginx" && echo "Override file applied" || echo "Override file not applied"

nginx_container=nginx
wordpress_container=wordpress
mariadb_container=mariadb

# all:
# 	docker-compose -f srcs/docker-compose.yml build
# 	docker-compose -f srcs/docker-compose.yml up -d

# stop :
# 	docker-compose -f srcs/docker-compose.yml down	

# re: clean
# 	docker-compose -f srcs/docker-compose.yml build --no-cache
# 	docker-compose -f srcs/docker-compose.yml up -d

# clean:
# 	docker-compose -f srcs/docker-compose.yml down --volumes --remove-orphans
# 	echo y | docker image prune


# log:
# 	docker-compose -f srcs/docker-compose.yml logs

test:
	docker exec -it $(wordpress_container) mysql -u nmaazouz -ppass -h mariadb wordpress

reload:
	docker exec -it $(nginx_container) nginx -s reload
	docker exec -it $(wordpress_container) service php7.4-fpm reload

bash_nginx:
	docker exec -it $(nginx_container) bash

bash_mariadb:
	docker exec -it $(mariadb_container) bash
	
mysql_mariadb:
	docker exec -it $(mariadb_container) mysql -u root -proot wordpress
	
bash_wordpress:
	docker exec -it $(wordpress_container) bash

# 	curl -v --tlsv1.2 https://localhost
# test: