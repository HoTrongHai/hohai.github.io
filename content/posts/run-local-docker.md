+++
title = 'Run on Local/Docker service (Flask)'
date = 2023-11-30
+++

## Run on Local/Docker service (Flask)

There are 2 options to run at local:

- Deploy/Run directly from host machine: I use this option for debug/development
- Deploy/Run on docker: I will build docker image from base image and source code.

![Image](./imgs/CloudRunDeployment.PNG)

### Run on local:

- We can run by:

```shell
python -m flask run
```

- Or by run directly `app.py`

```shell
python app.py
```

### Build Docker image

- Create `Dockerfile`

  ```dockerfile
  FROM python:3.10.13-alpine3.17

  WORKDIR /translation-backend

  COPY requirements.txt requirements.txt

  RUN pip3 install -r requirements.txt

  COPY . .

  ENV PORT 8080
  # Expose port
  EXPOSE 8080

  # CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
  CMD ["python3", "app.py"]
  ```

- In the case if we want to build the `docker image` then we can use `docker build`.
  Go to the folder (`.` in command line) containing the `Dockerfile` then execute one of options

  ````shell # Free tag
  docker build . --tag <IMAGE_NAME_CAN_HAVE_VERSION>
      # Tag name with format is URL (which can be used for Cloud/Dockerhub services to resolve information in URL
      # <IMAGE_URI> should be format <REGION>-docker.pkg.dev/<PROJECT-ID>/<REPOSITORY>/<IMAGE:TAG>
      docker build . --tag <IMAGE_URI>
      # Example
      docker build . --tag asia-east1-docker.pkg.dev/hohai-sample-cloud-run/translation-backend/translation-backend:tag1

      # Build with other options
      docker buildx build --platform linux/amd64 -t {project-name} .
      # Example
      docker buildx build --platform linux/amd64 -t translation-backend-image .

      ```
  ````

- We can use other parties (like Goole CLI) to build and submit using `gcloud builds`
  ```shell
  gcloud builds submit --tag asia-east1-docker.pkg.dev/hohai-sample-cloud-run/translation-backend/translation-backend:tag1
  ```

### Run Docker image

We can create `docker-compose.yml` to build and provision services

```yml
version: "3.8"

services:
  backend-app:
    container_name: translation-backend
    image: translation-backend-image
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - ./app.py:/translation-backend/app.py
      - ./_config.py:/translation-backend/_config.py
    ports:
      - "5000:5000"
```
