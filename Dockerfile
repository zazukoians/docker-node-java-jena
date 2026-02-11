FROM docker.io/library/node:24-trixie-slim

ENV DEBIAN_FRONTEND="noninteractive"
ENV EYE_VERSION="11.23.7"
ENV JENA_VERSION="6.0.0"

WORKDIR /app

# Install base tools + Java
RUN apt-get update \
  && apt-get install -y openjdk-21-jre curl vim git jq wget s3cmd unzip gpg lsb-release swi-prolog serdi raptor2-utils \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Minio client
COPY --from=minio/mc:latest /usr/bin/mc /usr/bin/mc

# Install barnard59 globally
RUN npm install -g barnard59

# Install Apache Jena tools
RUN curl -fsSL "https://archive.apache.org/dist/jena/binaries/apache-jena-${JENA_VERSION}.tar.gz" | tar zxf - \
  && mv apache-jena* /jena \
  && rm -f jena.tar.gz* \
  && cd /jena && rm -rf *javadoc* *src* bat
ENV PATH="${PATH}:/jena/bin"

# Install EYE reasoning engine
RUN curl -fsSL "https://github.com/eyereasoner/eye/archive/refs/tags/v${EYE_VERSION}.tar.gz" | tar -xzf - \
  && "./eye-${EYE_VERSION}/install.sh" --prefix=/usr/local \
  && rm -rf "./eye-${EYE_VERSION}"
