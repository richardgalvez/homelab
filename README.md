# 🏡 🎛️ Homelab

Hi there! My name is Richard Galvez and I welcome you to explore the projects I'm currently working on in my own homelab setup. I am a DevOps Engineer by trade who enjoys learning, testing, and implementing new technologies to fit any business or personal need. This is my stomping ground to allow me to sharpen my skills and PoC different services with and beyond the cloud realm.

This homelab is what you get when you repurpose custom-built gaming PC hardware into a pretty solid setup...

## Current Setup and Services

Single-node cluster:

- CPU: 20 x Intel(R) Core(TM) i9-10900K @ 3.70GHz (1 Socket)
- Memory: 64GB DDR5 DIMM (62.65 usable)
- GPU: Sapphire Nitro+ AMD Radeon RX 7900 XTX Vapor-X 24GB GDDR6
- OS: Proxmox VE 8.3.2

Machine provisioning for all VMs (except gaming VM currently) are set up through Terraform (`infrastructure/tf` folder).

## Projects in Progress

*Updated and in order of current priority (as of 1/16/2025).*

Configure/update lab network setup to segment machines as needed into private networks as needed, and allow internet connectivity to isolated networks where required.

### 1. 'Kubernetes The Harder Way' Lab

[Guide/GitHub Repo](https://github.com/ghik/kubernetes-the-harder-way/tree/linux)

Current Specs: 2vCPU, 3GB RAM, 30GB Storage, Ubuntu 24.04.1 Noble Numbat

| hostname   | Description                 |
|------------|-----------------------------|
| rg-k8s-cn1 | Control Plane               |
| rg-k8s-cn2 | Control Plane               |
| rg-k8s-cn3 | Control Plane               |
| rg-k8s-cn4 | Control Plane Load Balancer |
| rg-k8s-cn5 | Worker Node                 |
| rg-k8s-cn6 | Worker Node                 |
| rg-k8s-cn7 | Worker Node                 |

Objectives:

- Deploy ziPPT, Tasked, and more useful open-source apps + required databases (PostgreSQL, MongoDB, Redis).
- Use Helm.
- Use nginx for pods as needed.
- Deploy 3 etcd instances for redundancy (see CKA course video).
- Deploy Kubernetes manually first, creating scripts during the process to automate as much as possible after. Destroy then rebuild the lab using the automated process.
- Monitor pods/containers with Prometheus (App performance monitoring), Nagios (Network and Infrastructure monitoring), and Grafana (data visualization)?
- Use with ArgoCD?

### 2. Red Hat Enterprise Linux (RHEL) Lab

Current Specs: 2vCPU, 4GB RAM, 60GB Storage, RHEL 9.5

| hostname    | Description          |
|-------------|----------------------|
| rg-rhel-vm1 | Ansible Control Node |
| rg-rhel-vm2 | General Purpose Host |
| rg-rhel-vm3 | General Purpose Host |
| rg-rhel-vm4 | General Purpose Host |

Objectives:

- **Set up and use Ansible for configuration management of entire Linux lab environment (and eventually Windows Server).**
- Use podman for containerization.
- Deploy DNS and DHCP server (or manage only via OpenWRT)?
- Deploy Datadog Trial/Splunk Free?
- Deploy Backup solution?
- Deploy SAMBA/File server/shares or TrueNAS Core/OpenMediaVault?
- Deploy databases such as MySQL or MariaDB?

### Gaming VM

*Ongoing project.*

Current Specs: 10vCPU, 16GB RAM, 128GB, Windows 11

Fully re-create original gaming PC with VM by passing through keyboard + mouse, 2TB NVMe storage, and AMD GPU successfully with little/no crashes.

## Upcoming Projects/Ideas

### GitHub Actions/Jenkins Lab

Deploy 2 VMs (2vCPU, 2GB RAM, 50GB) for GitHub Actions Self-Hosted Runners and small Jenkins Server + Nodes setup with SUSE Enterprise Linux (SLES).

### Windows Server Lab - Internals, Active Directory, Linux Integration

Learn along with the Windows Internals book series and deploy an Active Directory domain for user management across Windows and Linux systems.

2 VMs with Windows Server 2025 - Server Core only (2vCPU, 3GB RAM, 60GB), 1 VM (PDC Emulator) with Desktop Experience (2vCPU, 6GB RAM, 100GB). Install Microsoft SQL Server (requires a VM with more RAM)?

### NixOS Workstation/Bastion Host

Create VM (2vCPU, 4GB RAM, 100GB) for Linux workstation environment/bastion host to manage systems in the network after further segmentation and to learn NixOS deeper.

## Completed Projects

['Kubernetes The Hard Way' Lab - *complete*](https://github.com/kelseyhightower/kubernetes-the-hard-way)

Machines were configured with: 1vCPU, 2GB RAM, 20GB Storage, Debian 12 Bookworm
