# Project name
PROJECT_NAME=app

# Folder Location of scripts
SHELL_SCRIPTS=sh

# Default command
help:
	@echo ""
	@echo "🧩 ${PROJECT_NAME} - Docker CI4 Management"
	@echo ""
	@echo "Available commands:"
	@echo "  make build     	→ Build and start containers"
	@echo "  make start     	→ Start existing containers"
	@echo "  make stop      	→ Stop and remove containers"
	@echo "  make healthcheck	→ check the health of containers"
	@echo "  make purge     	→ Full cleanup (containers, images, volumes, networks)"
	@echo ""
	@echo "Example:"
	@echo "  make build"
	@echo ""

# Build and start (with rebuild)
build:
	@chmod +x $(SHELL_SCRIPTS)/build.sh
	@$(SHELL_SCRIPTS)/build.sh

# Start existing containers
start:
	@chmod +x $(SHELL_SCRIPTS)/start.sh
	@$(SHELL_SCRIPTS)/start.sh

# Stop containers
stop:
	@chmod +x $(SHELL_SCRIPTS)/stop.sh
	@$(SHELL_SCRIPTS)/stop.sh

# Check health of containers
healthcheck:
	@chmod +x $(SHELL_SCRIPTS)/healthcheck.sh
	@$(SHELL_SCRIPTS)/healthcheck.sh

# Purge everything (containers, images, volumes, networks)
purge:
	@chmod +x $(SHELL_SCRIPTS)/purge.sh
	@$(SHELL_SCRIPTS)/purge.sh
