# ESPHome Development Project Overview

## Project Purpose
ESPHome development environment for creating, managing, and deploying ESP32/ESP8266 device configurations. This project serves as a dedicated workspace for IoT device firmware development using the ESPHome framework.

## Tech Stack
- **ESPHome Framework**: YAML-based configuration for ESP devices
- **Docker**: Containerized development environment
- **Python**: ESPHome CLI and build system
- **YAML**: Device configuration format
- **SSL/TLS**: Secure communication with Home Assistant
- **WiFi/OTA**: Wireless firmware updates

## Project Structure
- **Root Directory**: Active device configurations (*.yaml)
- **archive/**: Historical/experimental configurations
- **cert/**: SSL certificates for secure communication
- **.github/**: GitHub workflows and issue templates
- **docker-compose.yml**: Container orchestration
- **Makefile**: Development automation
- **secrets.yaml**: Sensitive configuration (not tracked in git)

## Current Devices
- M5Stack Atom Echo (voice assistant)
- Voice PE (ESP32-S3 voice processing)
- WRoom Micro USB (development board)
- Water Level Sensor (monitoring device)

## Development Workflow
1. Create/edit YAML configurations
2. Validate with `esphome config`
3. Compile firmware with `esphome compile`
4. Upload via USB or OTA
5. Monitor device logs
6. Archive old configurations