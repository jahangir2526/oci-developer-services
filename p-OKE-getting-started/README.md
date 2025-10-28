# OKE - Getting Started



## Objectives

1. Create OKE Cluster (Managed Node)

2. Access Cluster via "Cloud Shell Access" and "Local Access"

3. Deploy a Docker image from OCIR Private Repo

   

## Prerequisites:

1. Follow https://github.com/jahangir2526/oci-developer-services/tree/main/p-OCIR-getting-started and complete all tasks. At this point you have docker image in the container Registry.

   

2. Generate/reuse auth token

3. Note down Info

   ```null
   # To be captured
   Tenancy Namespace: <TenancyNamespace>
   OCI Username: <Username>
   Region Key: <RegionKey> 
   https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm
   
   Auth Token: <AuthToken>
   
   OCI Repo Name: <OCIRRepo>
   
   Docker Secret Name: <DockerSecretName> # docker secret to pull private docker image from OCIR
   Docker Email: <DockerEmail>
   
   # Generated
   OCIR Region Endpoint: <RegionKey>.ocir.io
   Docker Login Username: <TenancyNamespace>/<Username> 
   Docker Login Password: <AuthToken>
   ```



## Step-by-Step Instructions

1. Create an OKE cluster

2. Access Cluster  via "Cloud Shell Access"

   1. OKE Cluster -> Action -> Access Cluster
   2. Select "Cloud Shell Access"
   3. Launch Cloud Shell
   4. Copy and run the access command generated
   5. **Note: May need to change the Cloud Shell Network to Public**
   6. Check using command

   ```bash
   $ kubectl get nodes
   ```

3. Acess Cluster  via "Local Access"

   1. Follow the onscreen instruction
   2. Check using command

   ```bash
   $ kubectl get nodes
   ```

4. Create a docker secret

   ```bash
   $ kubectl create secret docker-registry <DockerSecretName> --docker-server=<RegionKey>.ocir.io --docker-username='<TenancyNamespace>/<Username>' --docker-password='<AuthToken>' --docker-email='<DockerEmail>'
   ```

5. 

6. OCI Console: Create a OCIR Repo (select the desire region and compartment)

   A. Developer Machine: Create a docker image

   ```bash
   $ cd ~/oci-developer-services/p-OCIR-getting-started/
   $ docker build -t nginx-web-server:v1 .
   $ docker run -d -p 8080:80 nginx-web-server:v1
   $ curl localhost:8080
   
   # in case you are trying to connect from outside the host, make sure to add firewall-cmd rule as follows
   sudo firewall-cmd --permanent --add-port=8080/tcp
   sudo firewall-cmd --reload
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

   C. Pull Docker Image from OCIR

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



