# ESPHome Task Completion Guidelines

## Validation Requirements
When completing ESPHome development tasks, always ensure:

1. **Configuration Validation**
   ```bash
   make validate-DEVICE        # or esphome config device.yaml
   ```
   - YAML syntax must be valid
   - All required components properly configured
   - No missing dependencies or references

2. **Compilation Testing**
   ```bash
   make compile-DEVICE         # or esphome compile device.yaml
   ```
   - Firmware must compile without errors
   - All libraries and dependencies resolved
   - Binary size within device memory limits

3. **Security Verification**
   - API encryption keys properly configured
   - WiFi credentials in secrets.yaml (not hardcoded)
   - OTA passwords set for secure updates
   - SSL certificates valid for secure communication

## Quality Assurance Checklist

### Before Committing Changes
- [ ] Device configuration validates successfully
- [ ] Firmware compiles without errors or warnings
- [ ] Secrets properly externalized to secrets.yaml
- [ ] Documentation updated (CLAUDE.md, device comments)
- [ ] Old configurations archived if replaced

### Device-Specific Testing
- [ ] Test device connectivity (ping, logs)
- [ ] Verify Home Assistant integration
- [ ] Confirm OTA update capability
- [ ] Validate sensor/actuator functionality

### Project Maintenance
- [ ] Makefile targets work correctly
- [ ] Container setup functional
- [ ] Git repository clean and organized
- [ ] Archive directory properly maintained

## Documentation Standards
- Update CLAUDE.md with new devices/changes
- Add descriptive comments in YAML configurations
- Document any special setup requirements
- Maintain device naming conventions

## Error Resolution
Common issues and solutions:
- Compilation errors: Check component compatibility
- Upload failures: Verify device connectivity/ports
- API errors: Confirm encryption keys match HA
- WiFi issues: Check secrets.yaml credentials