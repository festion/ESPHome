# ESPHome Development Commands

## Makefile Targets (Recommended)
```bash
# Setup and validation
make dev-setup              # Complete local development setup
make container-setup         # Complete container setup
make validate               # Validate all device configurations
make validate-DEVICE        # Validate specific device
make list-devices           # List all available devices

# Development workflow
make compile-DEVICE         # Compile firmware for device
make upload-DEVICE          # Upload firmware to device
make logs-DEVICE           # Monitor device logs
make clean-DEVICE          # Clean build artifacts for device

# Container operations
make setup-container        # Start ESPHome container
make stop-container         # Stop ESPHome container
make dashboard             # Start local dashboard
make container-dashboard   # Start dashboard in container

# Archive management
make archive-DEVICE        # Move device to archive
make restore-DEVICE        # Restore from archive
```

## Direct ESPHome Commands
```bash
# Basic operations
esphome config device.yaml     # Validate configuration
esphome compile device.yaml    # Compile firmware
esphome upload device.yaml     # Upload to device
esphome logs device.yaml       # Monitor logs
esphome clean device.yaml      # Clean build files

# Development utilities
esphome dashboard .            # Start web dashboard
esphome wizard device.yaml     # Create new device config
esphome run device.yaml        # Compile and upload
```

## Container Commands
```bash
# Container management
docker-compose up -d           # Start ESPHome container
docker-compose down            # Stop container
docker-compose logs -f         # View container logs

# Execute commands in container
docker-compose exec esphome esphome config device.yaml
docker-compose exec esphome esphome compile device.yaml
```

## Development Utilities
```bash
# File management
ls *.yaml                     # List device configurations
find . -name "*.yaml" -type f  # Find all YAML files
grep -r "sensor:" *.yaml      # Search configurations

# Git operations
git add device.yaml           # Add new device config
git commit -m "Add new device" # Commit changes
git push origin main          # Push to repository
```