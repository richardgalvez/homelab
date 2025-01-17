variable "PROXMOX_ENDPOINT" {
  description = "Endpoint for Proxmox server access."
  type        = string
}

variable "PROXMOX_API_TOKEN" {
  description = "API token for Proxmox access."
  type        = string
}

variable "PROXMOX_VE_SSH_USERNAME" {
  description = "Username for SSH access to Proxmox via Terraform provider."
  type        = string
}

variable "node_name" {
  description = "Name of Proxmox VE node the machine(s) to be placed on."
  type        = string
}

variable "rheluser" {
  description = "Temporary username for server login."
  type        = string
}

variable "rhelpassword" {
  description = "Temporary password for server login."
  type        = string
}

variable "k8suser" {
  description = "Temporary username for server login."
  type        = string
}

variable "k8spassword" {
  description = "Temporary password for server login."
  type        = string
}

variable "datastore" {
  description = "Datastore to contain storage/disk of machine(s)."
  type        = string
}