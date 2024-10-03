# nomad-on-nomad
Running a Nomad Cluster on a single host linux box with Nomad

Things to change in the files:
- The binding addresses are set for a 10.10.10.x for servers and 10.10.20.x for clients
- The Nomad binary points to what gets built in my home directory
- Tune the resources to your environment

Start with running the host Nomad process:
`sudo nomad agent -dev`

Set the Nomad Address:
`export NOMAD_ADDR=http://127.0.0.1:4646`

Run nomad servers:
`nomad run nomad-servers.nomad.hcl`

Run nomad clients:
`nomad run nomad-clients.nomad.hcl'

Set the Nomad Address:
`export NOMAD_ADDR=http://10.10.10.1:4646`

Proxy to the UI:
`socat tcp4-listen:4649,reuseaddr,fork,bind=192.168.0.131 tcp4:10.10.10.1:4646`
