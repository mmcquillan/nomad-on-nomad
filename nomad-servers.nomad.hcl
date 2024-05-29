job "nomad-servers" {
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

  group "nomad-server-1" {
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
              ip link add nmds1 type dummy;
              ip link set dev nmds1 address 00:2F:95:65:2E:AA;
              ip addr add 10.10.10.1/24 brd + dev nmds1 label nmds1:0;
              ip link set dev nmds1 up;
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
              ip addr del 10.10.10.1/24 brd + dev nmds1 label nmds1:0;
              ip link delete nmds1 type dummy;
            EOT
        ]
      }
    }

    task "nomad-server-1" {
      driver = "raw_exec"
      config {
        command = "/home/matt/code/nomad/bin/nomad"
        args = [
          "agent",
          "-node=nmds1",
          "-bind=10.10.10.1",
          "-bootstrap-expect=3",
          "-data-dir=/tmp/nomad/nmds1",
          "-dc=dc1",
          "-network-interface=nmds1",
          "-server",
          "-join=10.10.10.2",
          "-join=10.10.10.3"
        ]
      }
      resources {
        cpu    = 5000
        memory = 5000
      }
    }

  }

  group "nomad-server-2" {
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
              ip link add nmds2 type dummy;
              ip link set dev nmds2 address 00:2F:95:65:2E:AB;
              ip addr add 10.10.10.2/24 brd + dev nmds2 label nmds2:0;
              ip link set dev nmds2 up;
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
              ip addr del 10.10.10.2/24 brd + dev nmds2 label nmds2:0;
              ip link delete nmds2 type dummy;
            EOT
        ]
      }
    }

    task "nomad-server-2" {
      driver = "raw_exec"
      config {
        command = "/home/matt/code/nomad/bin/nomad"
        args = [
          "agent",
          "-node=nmds2",
          "-bind=10.10.10.2",
          "-bootstrap-expect=3",
          "-data-dir=/tmp/nomad/nmds2",
          "-dc=dc1",
          "-network-interface=nmds2",
          "-server",
          "-join=10.10.10.1",
          "-join=10.10.10.3"
        ]
      }
      resources {
        cpu    = 5000
        memory = 5000
      }
    }

  }

  group "nomad-server-3" {
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
              ip link add nmds3 type dummy;
              ip link set dev nmds3 address 00:2F:95:65:2E:AC;
              ip addr add 10.10.10.3/24 brd + dev nmds3 label nmds3:0;
              ip link set dev nmds3 up;
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
              ip addr del 10.10.10.3/24 brd + dev nmds3 label nmds3:0;
              ip link delete nmds3 type dummy;
            EOT
        ]
      }
    }

    task "nomad-server-3" {
      driver = "raw_exec"
      config {
        command = "/home/matt/code/nomad/bin/nomad"
        args = [
          "agent",
          "-node=nmds3",
          "-bind=10.10.10.3",
          "-bootstrap-expect=3",
          "-data-dir=/tmp/nomad/nmds3",
          "-dc=dc1",
          "-network-interface=nmds3",
          "-server",
          "-join=10.10.10.1",
          "-join=10.10.10.2"
        ]
      }
      resources {
        cpu    = 5000
        memory = 5000
      }
    }

  }

}
