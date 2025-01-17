terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.69.1"
    }
  }
}

provider "proxmox" {
  endpoint  = var.PROXMOX_ENDPOINT
  api_token = var.PROXMOX_API_TOKEN
  insecure  = true
  ssh {
    agent    = true
    username = var.PROXMOX_VE_SSH_USERNAME
  }
}

# TODO: Add SSH key + passwordless auth, apply/check DNS, network segmentation, Graceful startup (running all at once may crash PVE host briefly)

resource "proxmox_virtual_environment_vm" "rhel-lab" {     # 4 RHEL VMs
  name            = "rg-rhel-vm${count.index + 1}"
  description     = "Managed/Created by Terraform."
  node_name       = var.node_name
  vm_id           = "20${count.index + 1}"
  count           = 4

  machine         = "q35"
  bios            = "ovmf"
  scsi_hardware   = "virtio-scsi-single"

  stop_on_destroy = true

  initialization {
    user_account {    # TODO: Configure SSH key + passwordless auth
      username = var.rheluser
      password = var.rhelpassword
    }
    
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    
    datastore_id  = var.datastore
  }

  cpu {
    cores        = 2
    type         = "x86-64-v2-AES"
  }

  memory {
    dedicated = 4096
    floating  = 4096
  }

  efi_disk {
    datastore_id  = var.datastore
    type          = "4m"
  }

  disk {
    datastore_id = var.datastore
    file_id      = "local:iso/rhel_9.5-plus-key.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 60
    ssd          = true
  }

  network_device {
    model     = "virtio"
    bridge    = "vmbr0"
    enabled   = true
  }
}

resource "proxmox_virtual_environment_vm" "k8s-lab" {     # 7 Kubernetes Cluster Nodes
  name            = "rg-k8s-cn${count.index + 1}"
  description     = "Managed/Created by Terraform."
  node_name       = var.node_name
  vm_id           = "80${count.index + 1}"
  count           = 7

  machine         = "q35"
  bios            = "ovmf"
  scsi_hardware   = "virtio-scsi-single"

  stop_on_destroy = true

  initialization {
    user_account {    # TODO: Configure SSH key + passwordless auth
      username = var.k8suser
      password = var.k8spassword
    }
    
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    
    datastore_id  = var.datastore
  }

  cpu {
    cores        = 2
    type         = "x86-64-v2-AES"
  }

  memory {
    dedicated = 3072
    floating  = 3072
  }

  efi_disk {
    datastore_id  = var.datastore
    type          = "4m"
  }

  disk {
    datastore_id = var.datastore
    file_id      = "local:iso/noble-server-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 30
    ssd          = true
  }

  network_device {
    model     = "virtio"
    bridge    = "vmbr0"
    enabled   = true
  }
}

# TODO: GitHub Actions/Jenkins Lab

# TODO: Windows Server Lab - Internals, Active Directory, Linux Integration

# TODO: NixOS Workstation/Bastion Host