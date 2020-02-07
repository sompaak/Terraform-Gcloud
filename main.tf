
  
provider "google" {
  project     = var.project-name
  region      = var.region
}

resource "google_compute_instance" "default" {
  name         = "cloudbuild-vm-1"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  provisioner "local-exec" {
    command = "gcloud compute instances list"
  }
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials hello-cloudbuild --zone us-central1-b --project xyz-abc"
  }
  provisioner "local-exec" {
    command = "kubectl get nodes"
  }
}

  

  

