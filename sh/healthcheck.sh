#!/bin/bash
set -e

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PROJECT_NAME="app" 
SOURCE="${BASH_SOURCE[1]:-${BASH_SOURCE[0]}}"
SCRIPT_DIR="$( cd "$( dirname "$SOURCE" )/.." && pwd )" 
COMPOSE_FILE="$SCRIPT_DIR/docker-compose.yml"

echo -e "${BLUE}🔎 Checking Healthcheck Status for project ${PROJECT_NAME}...${NC}"

# Check if the docker-compose.yml file is found
if [ ! -f "$COMPOSE_FILE" ]; then
    echo -e "${RED}❌ ERROR: docker-compose.yml file not found at: $COMPOSE_FILE${NC}"
    exit 1
fi

# Get the list of running container IDs
CONTAINERS=$(docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" ps -q 2>/dev/null)

# Check if there are any running containers
if [ -z "$CONTAINERS" ]; then
    echo -e "${YELLOW}⚠️ No running Docker Compose containers found for project ${PROJECT_NAME}.${NC}"
    exit 0
fi

# Looping through each container
for CONTAINER_ID in $CONTAINERS; do
    # Get the container name (remove the leading '/' character)
    CONTAINER_NAME=$(docker inspect --format='{{.Name}}' "$CONTAINER_ID" | sed 's/\///')

    # Get the healthcheck status
    HEALTH_STATUS=$(docker inspect --format='{{.State.Health.Status}}' "$CONTAINER_ID" 2>/dev/null)
    
    # Get the standard status (e.g., 'running', 'exited')
    STANDARD_STATUS=$(docker inspect --format='{{.State.Status}}' "$CONTAINER_ID")

    echo "--------------------------------------------------------"
    echo -e "Container: ${BLUE}**$CONTAINER_NAME**${NC}"
    
    # Display Standard Status
    echo -e "  Container Status: **$STANDARD_STATUS**"

    # Display Healthcheck Status (with color codes)
    if [ "$HEALTH_STATUS" != "<no value>" ] && [ -n "$HEALTH_STATUS" ]; then
        
        # Color code logic
        case "$HEALTH_STATUS" in
            "healthy")
                COLOR=$GREEN
                ;;
            "starting")
                COLOR=$YELLOW
                ;;
            "unhealthy")
                COLOR=$RED
                ;;
            *)
                COLOR=$NC
                ;;
        esac
        
        echo -e "  Healthcheck: ${COLOR}**$HEALTH_STATUS**${NC}"

    else
        echo -e "  Healthcheck: ${YELLOW}N/A (Not configured or not ready yet)${NC}"
    fi
done

echo "--------------------------------------------------------"