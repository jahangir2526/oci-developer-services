# OCI OCIR Getting Started

## Objectives

1. Create an private OCIR Repo using OCI Console
2. Create a docker image in a developer machine, push image to OCI OCIR Repo then pull the image from OCIR Repo

## Prerequisites:

1. Prepare Developer Machine

   1. Provision OCI Compute (Oracle Linux 9)

   ```bash
   $ sudo dnf install docker git -y
   $ sudo touch /etc/containers/nodocker
   $ docker run hello-world
   $ docker ps
   ```

## Step-by-Step Instructions

1. Clone the github repo 

   ```bash
   $ cd ~
   $ git clone https://github.com/jahangir2526/oci-developer-services.git
   ```

2. OCI Console: Create a OCIR Repo

   OCIR repo: **project01/my-repo-01**

   Region:  **Singapore**

   Compartment **Practice** 

   B. Developer Machine: Create a docker image

   ```bash
   $ cd ~/oci-developer-services/p-OCIR-getting-started/
   $ docker build -t nginx-web-server:v1 .
   $ docker run -d -p 8080:80 nginx-web-server:v1
   $ curl localhost:8080
   ## If all good
   $ docker login # Login Username: <TenancyNamespace>/<Username>
   # password: <AuthToken>
   
   $ docker tag localhost/nginx-web-server:v1 sin.ocir.io/<TenancyNamespace>/<project01/my-repo-01:v1>
   $ docker push
   ```



## File Descriptions

| File Name                      | Description                                                  |
| ------------------------------ | ------------------------------------------------------------ |
| **Dockerfile & entrypoint.sh** | These two files are used to build the docker image. The entrypoint.sh generates index.html at /usr/share/nginx/html/ |



