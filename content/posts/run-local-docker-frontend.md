+++
title = 'Run Local Docker for Frontend'
date = 2023-11-30
+++

## Run in Local/Docker

We can run directly from source or build the docker image

### Run from source

- Run by `npm run`

  ```shell
  npm run dev
  ```

The above command will lookup `scripts` section

```shell
  "scripts": {
    "dev": "vite",
    "dev-host": "vite --host",
    "build": "vite build",
    "lint": "eslint . --ext js,jsx --report-unused-disable-directives --max-warnings 0",
    "preview": "vite preview",
    "docker-dev-up": "docker-compose -f docker-compose.dev.yml up",
    "docker-dev-down": "docker-compose -f docker-compose.dev.yml down"
  }
```

- In the case we want to specify exposed port:

  ```shell
  npx vite --port=4000
  ```

### Deploy/Run in Docker (Development environment)

- Create `Dockerfile` for example `Dockerfile.dev` for development only
  - Expose port 5173 (for example) in docker container
  - Run the conmand to allow on host machine
  ```dockerfile
  CMD [ "npm", "run", "dev-host" ]
  ```
  The above command will refer to the command in `scripts` section in `package.json`
  ```json
  "scripts": {
    "dev": "vite",
    "dev-host": "vite --host",
  ```

```dockerfile
# Follow the link: https://blog.vishnuprasaath.dev/dockerize-react-app-for-dev-and-prod

FROM node:14-alpine as dev
ENV NODE_ENV dev

# set/create current working directory (on container docker machine)
WORKDIR /tranlation-frontend

# Cache and install dependencies
COPY package.json .

# Try to
RUN npm config set strict-ssl false

# RUN intall
RUN npm i

# COPY all app files
COPY . .

# Expose port
EXPOSE 5173

# Start the app
# CMD [ "yarn", "start" ]
CMD [ "npm", "run", "dev-host" ]
```

- Build and create docker image and service by using `docker-compose.yml`
  - Map host's port with port's docker (3000:5173 example)
    ```yml
    version: "3.8"
    services:
    app:
    container_name: translation-ui
    image: translation-ui-image
    build:
    context: .
    dockerfile: Dockerfile.dev
    volumes: - ./src:/tranlation-chakra/frontend/src - ./package.json:/tranlation-chakra/frontend/package.json - ./vite.config.js:/tranlation-chakra/frontend/vite.config.js
    ports: - "3000:5173"
    ```

### Deploy/Run in Docker (Production environment)

In production we need to add new proxy server to handle request (load balancing,...).
We can use `nginx` web server.

- Create new `Dockerfile.prod` for production

  - Include nginx as proxy server
  - Expose port 80 in docker container
  - Copy nginx.conf (which is created above) to docker container

  ```dockerfile
    FROM node:14-alpine as builder
    ENV NODE_ENV production

    # set/create current working directory (on container docker machine)
    WORKDIR /tranlation-frontend

    # Cache and install dependencies
    COPY package.json .

    COPY vite.config.js .

    RUN npm config set strict-ssl false

    # RUN npm cache clean --force
    # RUN npm i
    RUN npm i && npm cache clean --force

    COPY . .

    # Build the app
    RUN npm run build

    # Bundle static assets with nginx
    FROM nginx:1.21.0-alpine as production
    ENV NODE_ENV production

    # Copy built assets from builder
    COPY --from=builder /tranlation-frontend/dist /usr/share/nginx/html

    # Add your nginx.conf
    COPY nginx.conf /etc/nginx/conf.d/default.conf

    # Expose port
    EXPOSE 80

    # Start nginx
    CMD ["nginx", "-g", "daemon off;"]
  ```

- Add new `nginx.conf` for configuration

  ```yml
  server {
  listen 80;
  root /usr/share/nginx/html;
  index index.html;

  location / {
  try_files $uri $uri/ /index.html;
  }
  }
  ```

- Build and create docker image and service using `docker-compose.yml`

  - Map host's port with port's docker (8080:80 example)

  ```yml
  version: "3.8"

  services:
  app:
    container_name: translation-ui-prod
    image: translation-ui-prod-image
    build:
    context: .
    dockerfile: Dockerfile.prod
    ports:
      - "8080:80"
  ```
