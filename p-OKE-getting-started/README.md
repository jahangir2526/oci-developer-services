# OKE - Getting Started



## Objectives

1. Create OKE Cluster (Managed Node)

2. Access Cluster via "Cloud Shell Access" and "Local Access"

3. Deploy a Docker image from OCIR Private Repo

4. Test by accessing the web server deployed behind a LB

   

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
   
   OCIR Repo Name: <OCIRRepo>
   OCIR Repo Tag/Version: <OCIRepoTag>
   
   Docker Secret Name: <DockerSecretName> # to pull private docker image from OCIR
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

5. Create the deployment and Service (LB) 

   ```yaml
   # 1. Create a file (eg: oke-deploy-nginx.yaml) 
   # 2. update the "image" and "imagePullSecrets: -name"
   
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: nginx-web-app-deploy
     labels:
       app: nginx-web-app
       builder: jahangir
   spec:
     replicas: 3
     selector:
       matchLabels:
         app: nginx-web-app
         builder: jahangir
     template:
       metadata:
         labels:
           app: nginx-web-app
           builder: jahangir
       spec:
         containers:
         - name: nginx-web-app
           image: <RegionKey>.ocir.io/<TenancyNamespace>/<OCIRRepo>:<OCIRRepoTag>
           ports:
           - containerPort: 80
         imagePullSecrets:
           - name: <DockerSecretName>
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: nginx-web-app-service
     labels:
       app: nginx-web-app
   spec:
     type: LoadBalancer
     ports:
     - port: 80
       targetPort: 80
       #nodePort: 32001
       #name: nginx-web-app-port
     selector:
       app: nginx-web-app
       builder: jahangir
   
   ```

6. Create the k8s objects

   ```bash
   $ kubectl create -f oke-deploy-nginx.yaml
   $ kubectl get pod,deploy,svc
   ```

7. note public ip & access the nginx web server 
