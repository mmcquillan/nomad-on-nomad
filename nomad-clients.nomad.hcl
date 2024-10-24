job "nomad-clients" {
  datacenters = ["*"]
  type        = "service"

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }

  update {
    min_healthy_time  = "10s"
    healthy_deadline  = "3m"
    progress_deadline = "10m"
  }

  group "nomad-client-1" {
    count = 1

    task "nomad-ip-create" {
      lifecycle {
        hook = "prestart"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip link add nmdc1 type dummy;
              ip link set dev nmdc1 address 00:2F:95:65:3E:AA;
              ip addr add 10.10.20.1/24 brd + dev nmdc1 label nmdc1:0;
              ip link set dev nmdc1 up;
            EOT
        ]
      }
    }

    task "nomad-ip-destroy" {
      lifecycle {
        hook = "poststop"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip addr del 10.10.20.1/24 brd + dev nmdc1 label nmdc1:0;
              ip link delete nmdc1 type dummy;
            EOT
        ]
      }
    }

    task "nomad-client-1" {
      driver = "raw_exec"
      config {
        command = "/home/matt/code/nomad/bin/nomad"
        args = [
          "agent",
          "-node=nmdc1",
          "-bind=10.10.20.1",
          "-client",
          "-config=local/config.hcl",
          "-data-dir=/tmp/nomad/nmdc1",
          "-dc=dc1",
          "-node-pool=default",
          "-network-interface=nmdc1",
          "-servers=10.10.10.1:4647",
          "-servers=10.10.10.2:4647",
          "-servers=10.10.10.3:4647"
        ]
      }
      template {
        data = "plugin \"raw_exec\" { config { enabled = true } }"
        destination = "local/config.hcl"
      }
      resources {
        cpu    = 10000
        memory = 10000
      }
    }

  }

  group "nomad-client-2" {
    count = 1

    task "nomad-ip-create" {
      lifecycle {
        hook = "prestart"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip link add nmdc2 type dummy;
              ip link set dev nmdc2 address 00:2F:95:65:3E:AB;
              ip addr add 10.10.20.2/24 brd + dev nmdc2 label nmdc2:0;
              ip link set dev nmdc2 up;
            EOT
        ]
      }
    }

    task "nomad-ip-destroy" {
      lifecycle {
        hook = "poststop"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip addr del 10.10.20.2/24 brd + dev nmdc2 label nmdc2:0;
              ip link delete nmdc2 type dummy;
            EOT
        ]
      }
    }

    task "nomad-client-2" {
      driver = "raw_exec"
      config {
        command = "/home/matt/code/nomad/bin/nomad"
        args = [
          "agent",
          "-node=nmdc2",
          "-bind=10.10.20.2",
          "-client",
          "-config=local/config.hcl",
          "-data-dir=/tmp/nomad/nmdc2",
          "-dc=dc1",
          "-node-pool=default",
          "-network-interface=nmdc2",
          "-servers=10.10.10.1:4647",
          "-servers=10.10.10.2:4647",
          "-servers=10.10.10.3:4647"
        ]
      }
      template {
        data = "plugin \"raw_exec\" { config { enabled = true } }"
        destination = "local/config.hcl"
      }
      resources {
        cpu    = 10000
        memory = 10000
      }
    }

  }

  group "nomad-client-3" {
    count = 1

    task "nomad-ip-create" {
      lifecycle {
        hook = "prestart"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip link add nmdc3 type dummy;
              ip link set dev nmdc3 address 00:2F:95:65:3E:AC;
              ip addr add 10.10.20.3/24 brd + dev nmdc3 label nmdc3:0;
              ip link set dev nmdc3 up;
            EOT
        ]
      }
    }

    task "nomad-ip-destroy" {
      lifecycle {
        hook = "poststop"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip addr del 10.10.20.3/24 brd + dev nmdc3 label nmdc3:0;
              ip link delete nmdc3 type dummy;
            EOT
        ]
      }
    }

    task "nomad-client-3" {
      driver = "raw_exec"
      config {
        command = "/home/matt/code/nomad/bin/nomad"
        args = [
          "agent",
          "-node=nmdc3",
          "-bind=10.10.20.3",
          "-client",
          "-config=local/config.hcl",
          "-data-dir=/tmp/nomad/nmdc3",
          "-dc=dc1",
          "-node-pool=default",
          "-network-interface=nmdc3",
          "-servers=10.10.10.1:4647",
          "-servers=10.10.10.2:4647",
          "-servers=10.10.10.3:4647"
        ]
      }
      template {
        data = "plugin \"raw_exec\" { config { enabled = true } }"
        destination = "local/config.hcl"
      }
      resources {
        cpu    = 10000
        memory = 10000
      }
    }

  }

  group "nomad-client-4" {
    count = 1

    task "nomad-ip-create" {
      lifecycle {
        hook = "prestart"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip link add nmdc4 type dummy;
              ip link set dev nmdc4 address 00:2F:95:65:3E:AD;
              ip addr add 10.10.20.4/24 brd + dev nmdc4 label nmdc4:0;
              ip link set dev nmdc4 up;
            EOT
        ]
      }
    }

    task "nomad-ip-destroy" {
      lifecycle {
        hook = "poststop"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip addr del 10.10.20.4/24 brd + dev nmdc4 label nmdc4:0;
              ip link delete nmdc4 type dummy;
            EOT
        ]
      }
    }

    task "nomad-client-4" {
      driver = "raw_exec"
      config {
        command = "/home/matt/code/nomad/bin/nomad"
        args = [
          "agent",
          "-node=nmdc4",
          "-bind=10.10.20.4",
          "-client",
          "-config=local/config.hcl",
          "-data-dir=/tmp/nomad/nmdc4",
          "-dc=dc1",
          "-node-pool=default",
          "-network-interface=nmdc4",
          "-servers=10.10.10.1:4647",
          "-servers=10.10.10.2:4647",
          "-servers=10.10.10.3:4647"
        ]
      }
      template {
        data = "plugin \"raw_exec\" { config { enabled = true } }"
        destination = "local/config.hcl"
      }
      resources {
        cpu    = 10000
        memory = 10000
      }
    }

  }

  group "nomad-client-5" {
    count = 1

    task "nomad-ip-create" {
      lifecycle {
        hook = "prestart"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip link add nmdc5 type dummy;
              ip link set dev nmdc5 address 00:2F:95:65:3E:AE;
              ip addr add 10.10.20.5/24 brd + dev nmdc5 label nmdc5:0;
              ip link set dev nmdc5 up;
            EOT
        ]
      }
    }

    task "nomad-ip-destroy" {
      lifecycle {
        hook = "poststop"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip addr del 10.10.20.5/24 brd + dev nmdc5 label nmdc5:0;
              ip link delete nmdc5 type dummy;
            EOT
        ]
      }
    }

    task "nomad-client-5" {
      driver = "raw_exec"
      config {
        command = "/home/matt/code/nomad/bin/nomad"
        args = [
          "agent",
          "-node=nmdc5",
          "-bind=10.10.20.5",
          "-client",
          "-config=local/config.hcl",
          "-data-dir=/tmp/nomad/nmdc5",
          "-dc=dc1",
          "-node-pool=default",
          "-network-interface=nmdc5",
          "-servers=10.10.10.1:4647",
          "-servers=10.10.10.2:4647",
          "-servers=10.10.10.3:4647"
        ]
      }
      template {
        data = "plugin \"raw_exec\" { config { enabled = true } }"
        destination = "local/config.hcl"
      }
      resources {
        cpu    = 10000
        memory = 10000
      }
    }

  }

  group "nomad-client-6" {
    count = 1

    task "nomad-ip-create" {
      lifecycle {
        hook = "prestart"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip link add nmdc6 type dummy;
              ip link set dev nmdc6 address 00:2F:95:65:3E:AD;
              ip addr add 10.10.20.6/24 brd + dev nmdc6 label nmdc6:0;
              ip link set dev nmdc6 up;
            EOT
        ]
      }
    }

    task "nomad-ip-destroy" {
      lifecycle {
        hook = "poststop"
      }
      driver = "raw_exec"
      config {
        command = "sh"
        args = ["-c",
          <<EOT
              ip addr del 10.10.20.6/24 brd + dev nmdc6 label nmdc6:0;
              ip link delete nmdc6 type dummy;
            EOT
        ]
      }
    }

    task "nomad-client-6" {
      driver = "raw_exec"
      config {
        command = "/home/matt/code/nomad/bin/nomad"
        args = [
          "agent",
          "-node=nmdc6",
          "-bind=10.10.20.6",
          "-client",
          "-config=local/config.hcl",
          "-data-dir=/tmp/nomad/nmdc6",
          "-dc=dc1",
          "-node-pool=default",
          "-network-interface=nmdc6",
          "-servers=10.10.10.1:4647",
          "-servers=10.10.10.2:4647",
          "-servers=10.10.10.3:4647"
        ]
      }
      template {
        data = "plugin \"raw_exec\" { config { enabled = true } }"
        destination = "local/config.hcl"
      }
      resources {
        cpu    = 10000
        memory = 10000
      }
    }

  }

}
