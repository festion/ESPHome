# ESPHome Device Templates

This directory contains template configurations for common ESPHome device types.

## Available Templates

### device-template.yaml
Basic template for any ESPHome device with:
- WiFi connectivity
- Home Assistant API integration
- OTA updates
- Basic diagnostics
- Common sensor examples (commented out)

## Using Templates

1. Copy the template:
   ```bash
   cp templates/device-template.yaml my-new-device.yaml
   ```

2. Edit the substitutions section:
   ```yaml
   substitutions:
     device_name: "my-new-device"
     friendly_name: "My New Device"
     device_description: "Custom sensor device"
   ```

3. Uncomment and configure needed components:
   - Sensors (temperature, humidity, etc.)
   - Binary sensors (buttons, motion detectors)
   - Switches (relays, outputs)
   - Lights (LED strips, bulbs)

4. Validate the configuration:
   ```bash
   make validate-my-new-device
   # or
   esphome config my-new-device.yaml
   ```

5. Compile and upload:
   ```bash
   make compile-my-new-device
   make upload-my-new-device
   ```

## Template Customization

### Board Selection
Choose the appropriate board for your hardware:
- **ESP32**: `esp32dev`, `nodemcu-32s`, `wemos_d1_mini32`
- **ESP8266**: `nodemcuv2`, `d1_mini`, `wemos_d1_mini`

### Pin Configuration
Adjust GPIO pins based on your hardware:
- Check your board's pinout diagram
- Ensure pins are not reserved (UART, SPI, etc.)
- Consider pin capabilities (ADC, PWM, etc.)

### Component Examples
Templates include commented examples for:
- DHT temperature/humidity sensors
- GPIO buttons and switches
- Relay outputs
- Status LEDs
- WiFi diagnostics

## Best Practices

1. **Use substitutions** for device-specific values
2. **Keep secrets external** in secrets.yaml
3. **Add meaningful comments** for complex configurations
4. **Test incrementally** - start simple, add features gradually
5. **Document special requirements** in device comments

## Common Configurations

### Sensor Device
Focus on sensor components with minimal power consumption.

### Switch/Relay Device  
Emphasize switch and output components for home automation.

### Voice Assistant
Include microphone, speaker, and wake word detection.

### BLE Proxy
Configure Bluetooth Low Energy proxy for extended range.