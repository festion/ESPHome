# ESPHome Development Makefile

# Default target
.DEFAULT_GOAL := help

# Variables
ESPHOME_CMD := esphome
CONTAINER_CMD := docker-compose
DEVICES := $(wildcard *.yaml)
ACTIVE_DEVICES := $(filter-out secrets.yaml docker-compose.yml, $(DEVICES))

# Help target
help: ## Show this help message
	@echo "ESPHome Development Environment"
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Setup targets
install: ## Install ESPHome locally
	pip install esphome

setup-container: ## Start ESPHome in container
	$(CONTAINER_CMD) up -d

stop-container: ## Stop ESPHome container
	$(CONTAINER_CMD) down

# Development targets
validate: ## Validate all device configurations
	@for device in $(ACTIVE_DEVICES); do \
		echo "Validating $$device..."; \
		$(ESPHOME_CMD) config $$device; \
	done

validate-%: ## Validate specific device (e.g., make validate-voice-pe)
	$(ESPHOME_CMD) config $*.yaml

compile: ## Compile all device configurations
	@for device in $(ACTIVE_DEVICES); do \
		echo "Compiling $$device..."; \
		$(ESPHOME_CMD) compile $$device; \
	done

compile-%: ## Compile specific device (e.g., make compile-voice-pe)
	$(ESPHOME_CMD) compile $*.yaml

upload-%: ## Upload firmware to specific device (e.g., make upload-voice-pe)
	$(ESPHOME_CMD) upload $*.yaml

logs-%: ## Monitor logs for specific device (e.g., make logs-voice-pe)
	$(ESPHOME_CMD) logs $*.yaml

clean-%: ## Clean build files for specific device
	$(ESPHOME_CMD) clean $*.yaml

# Utility targets
list-devices: ## List all available device configurations
	@echo "Available devices:"
	@for device in $(ACTIVE_DEVICES); do \
		echo "  - $$(basename $$device .yaml)"; \
	done

dashboard: ## Start ESPHome dashboard
	$(ESPHOME_CMD) dashboard .

container-dashboard: ## Start ESPHome dashboard in container
	$(CONTAINER_CMD) exec esphome esphome dashboard /config

# Archive management
archive-%: ## Move device configuration to archive
	@if [ -f "$*.yaml" ]; then \
		mv "$*.yaml" archive/; \
		echo "Moved $*.yaml to archive/"; \
	else \
		echo "Device $*.yaml not found"; \
	fi

restore-%: ## Restore device configuration from archive
	@if [ -f "archive/$*.yaml" ]; then \
		mv "archive/$*.yaml" .; \
		echo "Restored $*.yaml from archive"; \
	else \
		echo "Device $*.yaml not found in archive"; \
	fi

# Security targets
generate-secrets: ## Generate secrets.yaml template
	@if [ ! -f "secrets.yaml" ]; then \
		echo "Creating secrets.yaml template..."; \
		cp secrets.yaml.template secrets.yaml 2>/dev/null || echo "secrets.yaml.template not found"; \
	else \
		echo "secrets.yaml already exists"; \
	fi

# Development workflow
dev-setup: install generate-secrets ## Complete development setup
	@echo "ESPHome development environment setup complete!"
	@echo "Edit secrets.yaml with your configuration values."

container-setup: setup-container ## Complete container setup
	@echo "ESPHome container environment setup complete!"
	@echo "Access dashboard at http://localhost:6052"

# Cleaning targets
clean: ## Clean all build artifacts
	@for device in $(ACTIVE_DEVICES); do \
		$(ESPHOME_CMD) clean $$device 2>/dev/null || true; \
	done

clean-all: clean ## Clean all build artifacts and containers
	$(CONTAINER_CMD) down -v 2>/dev/null || true

.PHONY: help install setup-container stop-container validate compile upload logs clean list-devices dashboard archive restore generate-secrets dev-setup container-setup clean-all