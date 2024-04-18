+++
title = 'Run GCloud Docker'
date = 2023-11-30
+++

## Run on Local/Docker service (Google Cloud)

Follow by the link:

- https://cloud.google.com/artifact-registry/docs/docker/store-docker-container-images#gcloud
- https://cloud.google.com/run/docs/deploying#yaml

### Create/Register `Artifact Registry` in GCloud:

- Option 1: By Google Console:
  https://console.cloud.google.com/artifacts?referrer=search&project=hohai-sample-cloud-run
- Option 2: by Google CLI

  ```shell
  # List repositores in GCloud
  gcloud artifacts repositories list

  # Create by script:
  gcloud artifacts repositories create <REPO-NAME> --repository-format=docker --location=<LOCATION> --description="DESCRIPTION"
  # Example
  gcloud artifacts repositories create translation-backend --repository-format=docker --location=asia-east1 --description="DESCRIPTION"

  ```

### Config `Authentication` in Docker

- Purpose: allow Google Cloud CLI to authenticate `Artifact Registry`

```shell
  gcloud auth configure-docker <REGION>-docker.pkg.dev
  # Example
  gcloud auth configure-docker asia-east1-docker.pkg.dev
```

The config will be stored at `.docker\config.json`

### Create docker image

- With tag is <IMAGE-URL>
- Refer to `run-local-docker.md`

### Push the image to Artifact Registry

```shell
docker push us-central1-docker.pkg.dev/<PROJECT>/quickstart-docker-repo/quickstart-image:tag1
# Example
docker push asia-east1-docker.pkg.dev/hohai-sample-cloud-run/translation-backend/translation-backend:tag1
```

### Run on Google Cloud

- Create `service.yaml` to setup setvice information.
  The image is URL in Artifical Registry URI (which we push on the docker repository Cloud).
  **The `containerPort` should be `8080`**

  ```yml
  apiVersion: serving.knative.dev/v1
  kind: Service
  metadata:
    name: translation-backend
  spec:
    template:
      spec:
        containers:
          - image: asia-east1-docker.pkg.dev/hohai-sample-cloud-run/translation-backend/translation-backend:tag1
            ports:
              - name: http1
                containerPort: 8080
  ```

- Deploy new service by the following command:

  ```shell
  gcloud run services replace service.yaml
  ```

If we want to allow unauthenticate API update the `policy`:

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
  gcloud run services set-iam-policy translation-backend policy.yaml
  ```

https://cloud.google.com/run/docs/authenticating/public

### Clean up

- Delete repository

```shell
gcloud artifacts repositories delete translation-backend --location=asia-east1
```
