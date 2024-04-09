# Fetching the latest node image on apline linux
FROM public.ecr.aws/docker/library/node:alpine AS builder

# Declaring env
ENV NODE_ENV production

# Setting up the work directory
WORKDIR /app

# Installing dependencies
COPY ./package*.json /app

# RUN npm install --network=host
RUN npm install

# Copying all the files in our project
COPY . .

# Building our application
RUN npm run build

# Fetching the latest nginx image
FROM  public.ecr.aws/docker/library/nginx

# Copying built assets from builder
COPY --from=builder /app/build /usr/share/nginx/html

# Copying our nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf