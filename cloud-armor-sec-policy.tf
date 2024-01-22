
resource "google_compute_security_policy" "policy_site_backendconfig" {
  # provider = google-beta
  project = var.gcloud_project_id
  name    = "security-policy-site-backendconfig"

  advanced_options_config {
    log_level = "VERBOSE" #NORMAL and VERBOSE
  }

  adaptive_protection_config {
    layer_7_ddos_defense_config {
      enable = true
    }
  }

  rule {
    action   = "allow"
    priority = "2147483647"
    preview  = false
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }

  rule {
    action   = "deny(403)"
    priority = "50"
    preview  = false
    match {
      expr {
        expression = "origin.region_code == 'ZZ'"
      }
    }
    #Los códigos de región se basan en los códigos ISO 3166-1 alfa-2 https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
    description = "Deny access to region ZZ"
  }

  rule {
    action   = "deny(403)"
    priority = "51"
    preview  = false
    match {
      expr {
        expression = "origin.region_code == 'RU'"
      }
    }
    #Los códigos de región se basan en los códigos ISO 3166-1 alfa-2 https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
    description = "Deny access to region RU"
  }

  rule {
    action   = "deny(403)"
    priority = "52"
    preview  = false
    match {
      expr {
        expression = "origin.region_code == 'SE'"
      }
    }
    #Los códigos de región se basan en los códigos ISO 3166-1 alfa-2 https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
    description = "Deny access to region SE"
  }

  rule {
    action   = "deny(403)"
    priority = "53"
    preview  = false
    match {
      expr {
        expression = "origin.region_code == 'NL'"
      }
    }
    #Los códigos de región se basan en los códigos ISO 3166-1 alfa-2 https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
    description = "Deny access to region NL"
  }

    rule {
    action   = "allow"
    priority = "10"
    preview  = false
    match {
      expr {
        expression = "origin.region_code == 'NL' && request.path.matches('/login')"
      }
    }
    description = "Allow access to the request.path /login from the NL code"
  }
}




resource "google_compute_security_policy" "policy_wallet_backendconfig" {
  project = var.gcloud_project_id
  name    = "security-policy-wallet-backendconfig"

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
}

resource "google_compute_security_policy" "policy_panel_backendconfig" {
  project = var.gcloud_project_id
  name    = "security-policy-panel-backendconfig"

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
}

resource "google_compute_security_policy" "policy_rt_backendconfig" {
  project = var.gcloud_project_id
  name    = "security-policy-rt-backendconfig"

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
}
