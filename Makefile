# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sbelomet <sbelomet@42lausanne.ch>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/02 13:28:59 by sbelomet          #+#    #+#              #
#    Updated: 2024/10/08 11:11:55 by sbelomet         ###   ########.fr        #
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
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb

build: make_dirs
	@echo "$(YELLOW)Building containers...$(DEF_COLOR)"
	@docker-compose -f $(DOCK_COMP) build

up:
	@echo "$(YELLOW)Starting containers...$(DEF_COLOR)"
	@docker-compose -f $(DOCK_COMP) up

down:
	@echo "$(YELLOW)Deleting containers...$(DEF_COLOR)"
	@docker-compose -f $(DOCK_COMP) down

stop:
	@echo "$(YELLOW)Stopping containers...$(DEF_COLOR)"
	@docker-compose -f $(DOCK_COMP) stop

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
	@if [ $(docker ps -aq) ]; then \
		docker rm -f $(docker ps -aq); \
	fi

remove_images:
	@echo "$(RED)Removing all images...$(DEF_COLOR)"
	@if [ $(docker images -q) ]; then \
		docker rmi -f $(docker images -q); \
	fi

remove_volumes:
	@echo "$(RED)Removing all volumes...$(DEF_COLOR)"
	@if [ $(docker volume ls -q) ]; then \
		docker volume rm -f $(docker volume ls -q); \
	fi

remove_networks:
	@echo "$(RED)Removing all networks...$(DEF_COLOR)"
	@if [ $(docker network ls -q) ]; then \
		docker network rm -f $(docker network ls -q); \
	fi

fclean: remove_containers remove_images remove_volumes remove_networks
	@rm -rf /home/$(USER)/data/wordpress
	@rm -rf /home/$(USER)/data/mariadb

prune:
	@echo "$(RED)Pruning all...$(DEF_COLOR)"
	@docker system prune -a

re: fclean all

.PHONY: all build up down stop show remove_containers remove_images remove_volumes remove_networks fclean prune re