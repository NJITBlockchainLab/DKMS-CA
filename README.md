## FHWA Certificate Authority

The FHWA Certificate Authority (CA) is a crucial system designed to manage and issue digital credentials for secure communications and identity verification within the Federal Highway Administration ecosystem. It enables users to log in, create invitations, and issue credentials related to vehicle information, ensuring that all data exchanges are secure and authenticated. By leveraging the FHWA CA, organizations can confidently share sensitive information, such as vehicle ownership and registration, while ensuring that only verified entities can access and use this data securely.


## Pre-Requisites

- [Docker](https://www.docker.com/products/docker-desktop)

- [s2i](https://github.com/openshift/source-to-image#installation)

- [jq](https://stedolan.github.io/jq)

- [ngrok](https://ngrok.com)


`jq` and `ngrok` are available on package manager systems for different platforms such as [Homebrew](https://brew.sh/) (Mac), [Chocolatey](https://chocolatey.org/) (Windows) and various Linux distribution package managers.

## Running the CA

1. To install the pre-requisites in a Linux environment run start.sh script


`
This Bash script automates the installation and setup of several tools, including Docker, Docker Compose, Go, libdevmapper-dev, libbtrfs-dev, pkg-config, s2i (Source-to-Image), jq, and ngrok. It checks if each tool is already installed, installs it if not, configures necessary environment variables, and adds the default or provided user to the Docker group for permissions. It also guides the user to update visudo with the s2i path for secure execution.
`

2. In the docker folder run 
  ` sudo manage build `

`
This Bash script manages Docker containers for an issuer kit system, providing utility functions and environment configuration for different modes (production, development, and demo). It includes commands to start, stop, build images, and configure services such as Keycloak, MongoDB, and Ngrok. The script checks dependencies like jq, curl, and ngrok, and customizes the environment based on input parameters. It also configures API ports, agent settings, and Keycloak integration with GitHub as an identity provider.
`

3. If you want to run on public IP instead of ngrok environment
  i. Run
    `./editIP ${IP of your computer}`

`
In Keycloak configurations, the IP address is crucial for defining how services interact with Keycloak and ensuring correct routing for authentication, identity management, and service access. The IP is often used in redirect URIs, login flows, and service endpoints. It ensures that Keycloak communicates with the correct hosts, enabling secure token exchanges and proper validation. Updating the IP is necessary when moving to new environments, updating server locations, or changing network configurations to maintain connectivity and service functionality. This script updates IP addresses in several configuration files by replacing old IPs with a new one provided by the user. It ensures the files exist, performs the replacements, and confirms the changes across key configuration files like those for APIs and Keycloak.
`

  ii. Run
    `sudo ./manage start-demo`

`
The start-demo command sets up the demo environment by connecting to the specified device using its IP address. It requires port 8054 to be open to facilitate communication and data transfer. By ensuring this port is available, the command prepares the system for live testing and demonstration, allowing for interactive and real-time validation of the application's functionality. This step is crucial for ensuring that all components are properly linked and operational before proceeding with further testing or presentation.
`

4. If you want to run on ngrok environment

  i. In ngrok/ngrok.yml
    authtoken:

  ii. Run
    `sudo ./manage start`

`
    The start command launches the application and sets up essential services, including initiating Ngrok. Ngrok creates a secure tunnel to expose the local application to the internet via a public URL. This is crucial for remote access, testing, and demonstrating the application, as it allows users to interact with it from any location while maintaining a secure connection.
`
