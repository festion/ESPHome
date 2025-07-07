# ESPHome Development Environment

## Project Overview
This is an ESPHome development environment for creating and managing ESP32/ESP8266 device configurations. The project contains YAML configuration files for various IoT devices including voice assistants, BLE proxies, and sensor devices.

## Environment Setup
- **Location**: `/home/dev/workspace/ESPHome`
- **Platform**: ESPHome firmware development
- **Date**: 2025-07-07 (Updated)

## Current Device Configurations

### Active Devices
- **M5Stack Atom Echo** (`m5stack-atom-echo-fdb254.yaml`): Voice assistant with wake word detection
- **Voice PE** (`voice-pe.yaml`): ESP32-S3 based voice processing device  
- **WRoom Micro USB** (`wroommicrousb.yaml`): Generic ESP32 development board
- **Water Level Sensor** (`waterlevelsensor.yaml`): Sensor device for water monitoring

### NEW: Xiao ESP32-C6 BLE Proxy Network
**Purpose**: Bermuda BLE Trilateration for precise indoor location tracking
**Hardware**: 3x Seeed Studio Xiao ESP32-C6 with external UFL antennas

#### Device Configurations:
- **`xiao-ble-proxy-1.yaml`**: Primary BLE proxy (192.168.1.120)
- **`xiao-ble-proxy-2.yaml`**: Secondary BLE proxy  
- **`xiao-ble-proxy-3.yaml`**: Tertiary BLE proxy

#### Key Features:
- **External Antenna Support**: `CONFIG_ESP_PHY_EXTERNAL_ANT_ENABLE: y` for UFL connectors
- **Optimized BLE Scanning**: 320ms interval, 300ms window for Bermuda compatibility
- **High WiFi Power**: 20dB output power for extended range
- **ESP32-C6 Specific**: ESP-IDF framework with C6 variant optimizations
- **Compiler Fixes**: Build flags to handle reorder warnings
- **Diagnostic Monitoring**: WiFi signal strength, uptime, temperature sensors

#### Troubleshooting Notes:
- **Build Issue**: Added `-Wno-error=reorder` and `-Wno-reorder` flags for ESP32-C6 compilation
- **BLE Compatibility**: Removed `power_save_mode: none` (incompatible with BLE operations)
- **External Antenna**: Automatic detection via UFL connector on Seeed Studio boards
- **Framework**: Uses latest ESP-IDF with proven stability settings

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

# Upload to device (USB)
esphome upload device_name.yaml --device /dev/ttyACM0

# Upload to device (OTA)
esphome upload device_name.yaml --device IP_ADDRESS

# Monitor logs
esphome logs device_name.yaml
```

### Xiao ESP32-C6 Specific Workflow
```bash
# Put device in bootloader mode
# 1. Hold BOOT button
# 2. Press and release RESET button
# 3. Release BOOT button

# Flash via ESPHome GUI (recommended)
# Home Assistant → Settings → Add-ons → ESPHome → Open Web UI

# Direct esptool flashing (alternative)
python -m esptool --port /dev/ttyACM0 --baud 460800 write_flash 0x0 firmware.bin
```

### Project Structure
```
ESPHome/
├── *.yaml              # Active device configurations
├── xiao-ble-proxy-*.yaml  # NEW: BLE proxy network configs
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
- **Home Assistant**: Direct API integration for device control and BLE proxy services
- **Bermuda BLE Trilateration**: Location tracking integration (requires HACS)
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

## Hardware Setup Notes

### Xiao ESP32-C6 External Antenna Setup
1. **Hardware**: Seeed Studio Xiao ESP32-C6 with UFL connector
2. **Antenna**: External antenna connected to UFL connector
3. **Auto-detection**: No manual switching required, UFL connector auto-switches
4. **Range**: Significantly improved BLE/WiFi range with external antenna

### WSL2 USB Device Access
```powershell
# Windows PowerShell (Admin)
usbipd list
usbipd attach --wsl --busid [DEVICE_BUS_ID]
```

```bash
# WSL2
ls -la /dev/ttyACM*  # Verify device access
```

## File Management Best Practices
- Keep active configurations in root directory
- Archive old/experimental configs in `/archive/`
- Use descriptive naming conventions for device files
- Maintain SSL certificates in `/cert/` directory
- Document device-specific configuration in comments
- Test configurations with external antennas for optimal performance

## Notes
- All YAML files use ESPHome configuration syntax
- Secrets are referenced via `!secret` directive
- SSL certificates enable secure API communication
- OTA updates allow wireless firmware deployment
- Archive directory preserves configuration history
- ESP32-C6 requires specific build flags and framework settings
- External antennas provide significant range improvements for BLE proxies