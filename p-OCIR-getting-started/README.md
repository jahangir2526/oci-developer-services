# Container Registry - Getting Started



## Objectives

1. Create a private OCIR Repo using OCI Console
2. Create a docker image in a developer machine, push image to OCI OCIR Repo then pull the image from OCIR Repo. 



## Prerequisites:

1. Prepare a Developer Machine

   1. Provision OCI Compute (Oracle Linux 9)

   ```bash
   $ sudo dnf install docker git -y
   $ sudo touch /etc/containers/nodocker
   $ docker run hello-world
   $ docker ps
   ```

2. Generate/reuse auth token

3. Note down Info

   1. <TenancyNamespace>
   
   2. <Username>
   
   3. <RegionKey> 
   
      https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm
   
   4. <AuthToken>
   
   5. OCIR Region Endpoint: <RegionKey>.ocir.io
   
   6. Docker Login Username: <TenancyNamespace>/<Username> Password: <AuthToken>
   
   

## Step-by-Step Instructions

1. Clone the github repo 

   ```bash
   $ cd ~
   $ git clone https://github.com/jahangir2526/oci-developer-services.git
   ```

2. OCI Console: Create a OCIR Repo

   <OCIR-Repo> **project01/my-repo-01**

   Region:  **Singapore**

   Compartment **Practice** 

   A. Developer Machine: Create a docker image

   ```bash
   $ cd ~/oci-developer-services/p-OCIR-getting-started/
   $ docker build -t nginx-web-server:v1 .
   $ docker run -d -p 8080:80 nginx-web-server:v1
   $ curl localhost:8080
   
   ```

   B. Push Docker image to OCIR

   ```bash
   ## If all good
   $ docker login <RegionKey>.ocir.io 
   # Login Username: <TenancyNamespace>/<Username>
   # password: <AuthToken>
   
   $ docker tag localhost/nginx-web-server:v1 <RegionKey>.ocir.io/<TenancyNamespace>/<OCIR-Repo>:v1
   $ docker push <RegionKey>.ocir.io/<TenancyNamespace>/<OCIR-Repo>:v1
   
   ## Check if the image upload to OCIR
   ```

   C. Pull Image from OCIR

   ```bash
   ## You may remove the local image
   $ docker rmi <RegionKey>.ocir.io/<TenancyNamespace>/<OCIR-Repo>:v1
   
   $ docker login <RegionKey>.ocir.io 
   # Login Username: <TenancyNamespace>/<Username>
   # password: <AuthToken>
   
   $ docker pull <RegionKey>.ocir.io/<TenancyNamespace>/<OCIR-Repo>:v1
   ```

   

## File Descriptions

| File Name                      | Description                                                  |
| ------------------------------ | ------------------------------------------------------------ |
| **Dockerfile & entrypoint.sh** | These two files are used to build the docker image. The entrypoint.sh generates index.html at /usr/share/nginx/html/ |



