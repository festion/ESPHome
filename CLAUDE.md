# ESPHome Development Environment

## Project Overview
This is an ESPHome development environment for creating and managing ESP32/ESP8266 device configurations. The project contains YAML configuration files for various IoT devices including voice assistants, BLE proxies, and sensor devices.

## Environment Setup
- **Location**: `/home/dev/workspace/ESPHome`
- **Platform**: ESPHome firmware development
- **Date**: 2025-07-03

## Current Device Configurations

### Active Devices
- **M5Stack Atom Echo** (`m5stack-atom-echo-fdb254.yaml`): Voice assistant with wake word detection
- **Voice PE** (`voice-pe.yaml`): ESP32-S3 based voice processing device  
- **WRoom Micro USB** (`wroommicrousb.yaml`): Generic ESP32 development board
- **Water Level Sensor** (`waterlevelsensor.yaml`): Sensor device for water monitoring

### Archived Devices
Located in `/archive/` directory:
- Various water level sensor iterations
- Original Atom Echo configurations
- Home Assistant voice device configs

## Development Workflow

### Device Configuration Management
```bash
# Validate configuration
esphome config device_name.yaml

# Compile firmware
esphome compile device_name.yaml

# Upload to device
esphome upload device_name.yaml

# Monitor logs
esphome logs device_name.yaml
```

### Project Structure
```
ESPHome/
├── *.yaml              # Active device configurations
├── archive/             # Archived/old configurations  
├── cert/               # SSL certificates for secure communication
├── .github/            # GitHub workflows and templates
└── README.md           # Project documentation
```

## Security Configuration
- SSL certificates stored in `/cert/` directory
- WiFi credentials managed through secrets
- API encryption keys for secure Home Assistant communication

## Integration Points
- **Home Assistant**: Direct API integration for device control
- **WiFi Network**: Device connectivity and OTA updates
- **Development Environment**: Local compilation and upload

## Development Commands

### ESPHome CLI Operations
```bash
# Install ESPHome
pip install esphome

# Create new device configuration
esphome wizard device_name.yaml

# Flash device via USB
esphome run device_name.yaml

# Flash device via network (OTA)
esphome upload device_name.yaml --device IP_ADDRESS
```

### Container-based Development
```bash
# Run ESPHome in container
docker run --rm -v "${PWD}":/config -it esphome/esphome

# Compile in container
docker run --rm -v "${PWD}":/config esphome/esphome compile device_name.yaml
```

## File Management Best Practices
- Keep active configurations in root directory
- Archive old/experimental configs in `/archive/`
- Use descriptive naming conventions for device files
- Maintain SSL certificates in `/cert/` directory
- Document device-specific configuration in comments

## Notes
- All YAML files use ESPHome configuration syntax
- Secrets are referenced via `!secret` directive
- SSL certificates enable secure API communication
- OTA updates allow wireless firmware deployment
- Archive directory preserves configuration history