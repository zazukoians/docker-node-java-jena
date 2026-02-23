ARG SOPHIA_CLI_VERSION="2cf13ac19e4f1e61b502267a2f6381e84993d1b1"

FROM rust:bookworm AS sophia-cli-builder

WORKDIR /app

ARG SOPHIA_CLI_VERSION

# Fetch source code of sophia-cli, in order to build it and have it available in the final image
RUN git init \
  && git remote add origin https://github.com/pchampin/sophia-cli.git \
  && git fetch --depth 1 origin "${SOPHIA_CLI_VERSION}" \
  && git checkout FETCH_HEAD \
  && rm -rf .git
RUN cargo build --release

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

# Add sophia-cli to the image
COPY --from=sophia-cli-builder /app/target/release/sop /usr/bin/sop

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
