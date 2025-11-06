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

echo -e "${BLUE}🔧 Starting build process for ${PROJECT_NAME}...${NC}"

if [ -d "$SCRIPT_DIR/src/app_ci/writable" ]; then
  echo -e "${BLUE}🔧 Setting permissions for writable directory on host (chmod 775)...${NC}"
  chmod -R 775 "$SCRIPT_DIR/src/app_ci/writable"
fi

# Build and start containers
docker compose -p $PROJECT_NAME -f "$COMPOSE_FILE" up -d --build

echo -e "\n${GREEN}✅ Build completed successfully for ${PROJECT_NAME}.${NC}"
echo -e "${BLUE}🚀 Containers are up and running!${NC}"