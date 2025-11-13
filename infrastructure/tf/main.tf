terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.86.0"
    }
  }
  required_version = ">= 1.2.0"
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

resource "proxmox_virtual_environment_vm" "ubuntu_lab" {     # Ubuntu Lab
  name            = "us-ubu-${count.index + 1}"
  description     = "Managed by Terraform."
  node_name       = var.node_name
  vm_id           = "20${count.index + 1}"
  count           = 1

  machine         = "q35"
  bios            = "ovmf"
  scsi_hardware   = "virtio-scsi-single"

  stop_on_destroy = true

  initialization {
    user_account {    # TODO: Configure SSH key + passwordless auth
      username = var.ubuntuuser
      password = var.ubuntupassword
    }

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    datastore_id  = var.datastore
  }

  cpu {
    cores        = 8
    type         = "x86-64-v2-AES"
  }

  memory {
    dedicated = 16384
    floating  = 16384
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
    size         = 100
    ssd          = true
  }

  network_device {
    model     = "virtio"
    bridge    = "vmbr0"
    enabled   = true
  }
}

# TODO: Windows Server Lab - Internals, Active Directory, Linux Integration

# TODO: NixOS Workstation/Bastion Host
