resource "google_compute_firewall" "allow_http_3000" {
  count       = var.var_count
  name        = "${var.app_name}-allow-${count.index}"
  network     = google_compute_network.vpc[count.index].id
  direction   = "INGRESS"
  priority    = 1000
  target_tags = ["http-server"]

  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }

  allow {
    protocol = "tcp"
    ports    = ["3001"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "deny_ssh" {
  count     = var.var_count
  name      = "${var.app_name}-deny-ssh-${count.index}"
  network   = google_compute_network.vpc[count.index].id
  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

