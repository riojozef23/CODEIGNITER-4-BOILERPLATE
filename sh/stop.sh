#!/bin/bash
set -e

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
PROJECT_NAME="app"
SOURCE="${BASH_SOURCE[1]:-${BASH_SOURCE[0]}}"
SCRIPT_DIR="$( cd "$( dirname "$SOURCE" )/.." && pwd )"
COMPOSE_FILE="$SCRIPT_DIR/docker-compose.yml"

echo -e "${BLUE}🛑 Stopping and removing containers for ${PROJECT_NAME}...${NC}"

# Stop and remove containers, networks, and anonymous volumes
docker compose -p $PROJECT_NAME -f "$COMPOSE_FILE" down

echo -e "\n${GREEN}✅ Containers stopped and removed for ${PROJECT_NAME}.${NC}"
