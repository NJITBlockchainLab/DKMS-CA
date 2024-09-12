
## Pre-Requisites

- [Docker](https://www.docker.com/products/docker-desktop)

- [s2i](https://github.com/openshift/source-to-image#installation)

- [jq](https://stedolan.github.io/jq)

- [ngrok](https://ngrok.com)


`jq` and `ngrok` are available on package manager systems for different platforms such as [Homebrew](https://brew.sh/) (Mac), [Chocolatey](https://chocolatey.org/) (Windows) and various Linux distribution package managers.

## Running the CA

1. To install the pre-requisites in a Linux environment run start.sh script
2. In the docker folder run 
  ` sudo manage build `

3. If you want to run on public IP instead of ngrok environment
  i. Run
    `./editIP ${IP of your computer}`
  ii. Run
    `sudo ./manage start-demo`

4. If you want to run on ngrok environment
  i. In ngrok/ngrok.yml
    authtoken:
  ii. Run
    `sudo ./manage start`
