# ContainerLab Network Topology Scenarios

This repository contains a collection of ContainerLab network topology scenarios for testing and demonstration purposes.

## Directory Structure

```
clab/
├── README.md               # This file
├── [scenario-name]/        # Each scenario has its own directory
│   ├── [scenario].clab.yaml  # ContainerLab topology definition
│   ├── README.md           # Scenario-specific documentation
│   └── ...                 # Other scenario-specific files
```

## Available Scenarios

### 1. DHCPv4 Direct Assignment
Location: `dhcp4-direct/`

A simple topology demonstrating direct DHCPv4 address assignment using KEA DHCP server.

Key files:
- `dhcp-direct.clab.yaml` - Topology definition
- `start-dhcp-server.sh` - Startup script
- `server-config/kea-dhcp4.conf` - DHCP server configuration

## Usage

1. Install ContainerLab: https://containerlab.dev/install/
2. Navigate to desired scenario directory
3. Deploy topology: `sudo containerlab deploy -t [scenario].clab.yaml`
4. Destroy topology when done: `sudo containerlab destroy -t [scenario].clab.yaml`

## Adding New Scenarios

1. Create a new directory with descriptive name
2. Add topology definition file (`[scenario].clab.yaml`)
3. Include a README.md explaining the scenario
4. Add any necessary configuration/script files
5. Update this main README.md to list the new scenario
