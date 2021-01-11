FROM debian:bullseye-slim

# Set the locale
# Download NODE and GIT
RUN apt-get clean && apt-get -y update && \
    apt-get install -y locales curl && locale-gen en_CA.UTF-8 && \
    curl -sL https://deb.nodesource.com/setup_15.x | bash - && \
    apt-get install -y nodejs && \
    apt-get install -y vim git && \
    apt-get clean

# Create a build folder and copy our files
WORKDIR /home/bootstrap/bootstrap
COPY ["package.json", "/home/bootstrap/bootstrap/"]
COPY ["bootstrap.scss", "custom.scss", "/home/bootstrap/bootstrap/scss/"]

# Get Bootstrap from GitHub
# Install the required loaders and postcss plugins for compiling and bundling Bootstrap precompiled Sass files.
# Install all dependencies
RUN npm run get && npm install autoprefixer css-loader node-sass postcss-loader sass-loader style-loader exports-loader && npm run setup

# A sane starting environment for subsequent scripts
WORKDIR /home/bootstrap
