+++
title = 'Deploy and run on Google Cloud'
date = 2023-11-30
+++

## Deploy and run on Google Cloud

https://cloud.google.com/run/docs/internet-proxy-nginx-sidecargcloud components update

https://github.com/GoogleCloudPlatform/cloud-run-samples/blob/02a123881ba33801ec6609c4f81f163a14ee2636/multi-container/hello-nginx-sample/README.md

- Add/Change `nginx.conf`:

```yml
  server {
    # Listen at port 8080
    listen 8080;
    # Server at localhost
    server_name _;
    # Enables gzip compression to make our app faster
    gzip on;

    location / {
        # Passes initial requests to port 8080 to `hello` container at port 8888
        # proxy_pass   http://127.0.0.1:8888;
        # Passes initial requests to port 8080 to `hello` container at port 80
        proxy_pass   http://127.0.0.1:80;
    }
}
```

- Create secret with content of `nginx.conf` file (will be created on Gcloud `nginx_config`)

```shell
gcloud secrets create nginx_config --replication-policy='automatic' --data-file='./nginx.conf'
```

In the case we want to delete the secrete:

```shell
gcloud secrets delete <SECRETE-ID>
```

- Grant compute service account to have access new created secret

```shell
# PROJECT_NUMBER should be 650237971555 (hohai-sample-cloud-run)
export PROJECT_NUMBER=$(gcloud projects describe $(gcloud config get-value project) --format='value(projectNumber)')

gcloud secrets add-iam-policy-binding nginx_config --member=serviceAccount:650237971555-compute@developer.gserviceaccount.com --role='roles/secretmanager.secretAccessor'
```

- Create docker image by using Dockerfile

```shell
  docker build . --tag asia-east1-docker.pkg.dev/hohai-sample-cloud-run/translation-frontend/translation-frontend:tag1 --file Dockerfile.prod
```

- Create Artifact Registry:

```shell
gcloud artifacts repositories create translation-frontend --repository-format=docker --location=asia-east1 --description="DESCRIPTION"

```

- Push the docker image to Artifact Registry (repository)

```shell
  docker push asia-east1-docker.pkg.dev/hohai-sample-cloud-run/translation-frontend/translation-frontend:tag1
```

- Deploy new service by the following command:

```shell
gcloud run services replace service.yaml
```

- If we want to allow unauthenticate API update the `policy`:

  - Create `policy.yml`:

    ```yml
    bindings:
      - members:
          - allUsers
        role: roles/run.invoker
    ```

  - Run the command

    ```shell
    gcloud run services set-iam-policy <SERVICE> policy.yaml
    gcloud run services set-iam-policy translation-frontend policy.yaml
    ```
