# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sbelomet <sbelomet@42lausanne.ch>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/02 13:28:59 by sbelomet          #+#    #+#              #
#    Updated: 2024/10/02 15:19:13 by sbelomet         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RED 		=	\033[1;91m
YELLOW		=	\033[1;93m
GREEN		=	\033[1;92m
BLUE		=	\033[1;94m
PURPLE		=	\033[1;95m
DEF_COLOR	=	\033[0;39m
CYAN		=	\033[1;96m
RAINBOW		=	$(RED)-$(YELLOW)-$(GREEN)-$(CYAN)-$(BLUE)-$(PURPLE)-

DOCK_COMP = ./srcs/docker-compose.yml

all:

create_wordpress_volume:
	@if [ -d "/home/$(USER)/data/wordpress" ]; then \
		echo "$(CYAN)WordPress volume already exist$(DEF_COLOR)"; \
	else \
		mkdir -p /home/$(USER)/data/wordpress; \
		echo "$(GREEN)WordPress volume created$(DEF_COLOR)"; \
	fi

create_mariadb_volume:
	@if [ -d "/home/$(USER)/data/mariadb" ]; then \
		echo "$(CYAN)MariaDB volume already exist$(DEF_COLOR)"; \
	else \
		mkdir -p /home/$(USER)/data/mariadb; \
		echo "$(GREEN)MariaDB volume created$(DEF_COLOR)"; \
	fi

create_volumes: create_wordpress_volume create_mariadb_volume

build:
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
	@docker containers ls -a
	@echo "$(GREEN)List of all images:$(DEF_COLOR)"
	@docker image ls
	@echo "$(GREEN)List of all volumes:$(DEF_COLOR)"
	@docker volume ls
	@echo "$(GREEN)List of all networks:$(DEF_COLOR)"
	@docker network ls

remove_containers:
	@echo "$(RED)Removing all containers...$(DEF_COLOR)"
	@docker rm -f $(docker container ls -aq)

remove_images:
	@echo "$(RED)Removing all images...$(DEF_COLOR)"
	@docker rm -f $(docker image ls -aq)

remove_volumes:
	@echo "$(RED)Removing all volumes...$(DEF_COLOR)"
	@docker rm -f $(docker volume ls -q)

remove_networks:
	@echo "$(RED)Removing all networks...$(DEF_COLOR)"
	@docker rm -f $(docker network ls -q)

fclean: remove_containers remove_images remove_volumes remove_networks

re: fclean all