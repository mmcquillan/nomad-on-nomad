# nomad-on-nomad
Running a Nomad Cluster on a single host linux box with Nomad

Things to change in the files:
- The binding addresses are set for a 10.10.10.x for servers and 10.10.20.x for clients
- The Nomad binary points to what gets built in my home directory
- The host process for Nomad is bound to my internal network port
- Tune the resources to your environment

Start with running the host Nomad process:
`sudo nomad agent -dev -bind=192.168.1.131`

Run nomad servers:
`nomad run nomad-servers.nomad.hcl`

Run nomad clients:
`nomad run nomad-clients.nomad.hcl'

Set the Nomad Address:
`export NOMAD_ADDR=http://10.10.10.1:4646`
