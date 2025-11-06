#!/bin/bash
set -e

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PROJECT_NAME="app" 
SOURCE="${BASH_SOURCE[1]:-${BASH_SOURCE[0]}}"
SCRIPT_DIR="$( cd "$( dirname "$SOURCE" )/.." && pwd )"
COMPOSE_FILE="$SCRIPT_DIR/docker-compose.yml"

echo -e "${BLUE}🧹 Purging all containers, images, volumes, and networks for project: ${PROJECT_NAME} (using $COMPOSE_FILE)${NC}"

echo -e "${BLUE}🛑 Stopping and removing containers, networks, and named volumes...${NC}"
docker compose -p $PROJECT_NAME -f "$COMPOSE_FILE" down -v --remove-orphans || true

echo -e "${BLUE}🔻 Removing local custom Docker image: ci_boilerplate:fpm...${NC}"
docker rmi ci_boilerplate:fpm -f || true

echo -e "${BLUE}🧽 Removing dangling images...${NC}"
docker image prune -f || true

echo -e "${BLUE}🧱 Removing unused Docker volumes...${NC}"
docker volume prune -f || true

echo -e "${BLUE}🕸️ Removing unused Docker networks...${NC}"
docker network prune -f || true

echo -e "\n${GREEN}✅ Purge completed successfully for project: ${PROJECT_NAME}${NC}"
echo -e "${BLUE}🧼 All related containers, image (ci_boilerplate:fpm), volumes, and networks have been removed.${NC}"