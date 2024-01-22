resource "kubernetes_service_v1" "site" {
  metadata {
    name = "miwebsite"
    annotations = {
      # Container-native load balancing for improved performance.
      # @see https://cloud.google.com/kubernetes-engine/docs/concepts/container-native-load-balancing
      "cloud.google.com/neg" : "{\"ingress\": true}"
      "cloud.google.com/backend-config" : "{\"default\": \"site-backendconfig\"}"
    }
  }
  spec {
    type = "ClusterIP"
    selector = {
      app = "miwebsite"
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_manifest" "site-backendconfig" {
  manifest = {
    "apiVersion" = "cloud.google.com/v1"
    "kind"       = "BackendConfig"
    "metadata" = {
      "name"      = "site-backendconfig"
      "namespace" = "default"
    }
    "spec" = {
      #Add Security polici in Service BackendConfig
      "securityPolicy" = {
        "name" = "security-policy-site-backendconfig"
      }
      "timeoutSec" = "120" # 2 min in seconds.
    }
  }
}
