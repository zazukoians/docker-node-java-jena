FROM docker.io/library/ubuntu:22.04

ENV DEBIAN_FRONTEND="noninteractive"
ENV NODE_VERSION="18"
ENV EYE_VERSION="9.6.5"
ENV JENA_VERSION="4.10.0"

WORKDIR /app

# install base tools + Java
RUN apt-get update \
  && apt-get install -y openjdk-19-jre curl vim git jq wget s3cmd unzip gpg lsb-release swi-prolog serdi \
  && apt-get clean

# install NodeJS
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | tee /usr/share/keyrings/nodesource.gpg >/dev/null \
  && gpg --no-default-keyring --keyring /usr/share/keyrings/nodesource.gpg --list-keys \
  && chmod a+r /usr/share/keyrings/nodesource.gpg \
  && DISTRO="$(lsb_release -s -c)" \
  && echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] "https://deb.nodesource.com/node_${NODE_VERSION}.x" "${DISTRO}" main" | tee /etc/apt/sources.list.d/nodesource.list \
  && echo "deb-src [signed-by=/usr/share/keyrings/nodesource.gpg] "https://deb.nodesource.com/node_${NODE_VERSION}.x" "${DISTRO}" main" | tee -a /etc/apt/sources.list.d/nodesource.list \
  && apt-get update \
  && apt-get install -y nodejs \
  && apt-get clean

# install barnard59 globally
RUN npm install -g barnard59

# install Apache Jena tools
RUN curl -fsSL "https://dlcdn.apache.org/jena/binaries/apache-jena-fuseki-${JENA_VERSION}.tar.gz" | tar zxf - \
  && mv apache-jena* /jena \
  && rm -f jena.tar.gz* \
  && cd /jena && rm -rf *javadoc* *src* bat
ENV PATH="${PATH}:/jena/bin"

# install EYE reasoning engine
RUN curl -fsSL "https://github.com/eyereasoner/eye/archive/refs/tags/v${EYE_VERSION}.tar.gz" | tar -xzf - \
  && "./eye-${EYE_VERSION}/install.sh" --prefix=/usr/local \
  && rm -rf "./eye-${EYE_VERSION}"
