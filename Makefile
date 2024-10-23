# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sbelomet <sbelomet@42lausanne.ch>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/02 13:28:59 by sbelomet          #+#    #+#              #
#    Updated: 2024/10/23 10:47:24 by sbelomet         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RED 		=	\033[1;91m
YELLOW		=	\033[1;93m
GREEN		=	\033[1;92m
BLUE		=	\033[1;94m
PURPLE		=	\033[1;95m
CYAN		=	\033[1;96m
DEF_COLOR	=	\033[0;39m
RAINBOW		=	$(RED)-$(YELLOW)-$(GREEN)-$(CYAN)-$(BLUE)-$(PURPLE)-

DOCK_COMP = ./srcs/docker-compose.yml

all: build up

make_dirs:
	@echo "$(YELLOW)Creating directories...$(DEF_COLOR)"
	mkdir -p /home/sbelomet/data/wordpress
	mkdir -p /home/sbelomet/data/mariadb

build: make_dirs
	@echo "$(YELLOW)Building containers...$(DEF_COLOR)"
	@docker-compose -f $(DOCK_COMP) build

up:
	@echo "$(YELLOW)Starting containers...$(DEF_COLOR)"
	@docker-compose -f $(DOCK_COMP) up -d

down:
	@echo "$(YELLOW)Stopping and deleting containers...$(DEF_COLOR)"
	@docker-compose -f $(DOCK_COMP) down

stop:
	@echo "$(YELLOW)Stopping containers...$(DEF_COLOR)"
	@docker-compose -f $(DOCK_COMP) stop

start:
	@echo "$(YELLOW)Starting containers...$(DEF_COLOR)"
	@docker-compose -f $(DOCK_COMP) start

show:
	@echo "$(GREEN)List of all containers:$(DEF_COLOR)"
	@docker container ls -a
	@echo "$(GREEN)List of all images:$(DEF_COLOR)"
	@docker image ls
	@echo "$(GREEN)List of all volumes:$(DEF_COLOR)"
	@docker volume ls
	@echo "$(GREEN)List of all networks:$(DEF_COLOR)"
	@docker network ls

remove_containers:
	@echo "$(RED)Removing all containers...$(DEF_COLOR)"
	@if [ $(shell docker ps -aq) ]; then \
		docker container rm -fv $(shell docker ps -aq); \
	fi

remove_images:
	@echo "$(RED)Removing all images...$(DEF_COLOR)"
	docker image ls -q
	@if [ $(shell docker image ls -q) ]; then \
		docker image rm -f $(shell docker image ls -q); \
	fi

remove_volumes:
	@echo "$(RED)Removing all volumes...$(DEF_COLOR)"
	@rm -rf $(HOME)/data/wordpress
	@rm -rf $(HOME)/data/mariadb
	@if [ $(shell docker volume ls -q) ]; then \
		docker volume rm -f $(shell docker volume ls -q); \
	fi

clean: remove_containers remove_images remove_volumes

fclean: clean
	@rm -rf /home/sbelomet/data
	@echo "$(RED)Removing all...$(DEF_COLOR)"
	@docker system prune -a

re: fclean all

.PHONY: all build up down stop show remove_containers remove_images remove_volumes fclean prune re