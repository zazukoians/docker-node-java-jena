#   Licensed to the Apache Software Foundation (ASF) under one or more
#   contributor license agreements.  See the NOTICE file distributed with
#   this work for additional information regarding copyright ownership.
#   The ASF licenses this file to You under the Apache License, Version 2.0
#   (the "License"); you may not use this file except in compliance with
#   the License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# Derived from Stains Alpine based image at https://github.com/stain/jena-docker

FROM zazukoians/node-java:3.0.0
LABEL maintainer="Adrian Gschwend <adrian.gschwend@zazuko.com>"

# Packages from Debian itself
RUN apt-get update && apt-get install -y unzip raptor2-utils s4cmd jq httpie rclone libxml2-utils vim-tiny
RUN ln -s /usr/bin/s4cmd /usr/bin/s3cmd

# serdi install (Debian version is too old)

RUN cd /tmp && curl -L http://download.drobilla.net/serd-0.30.10.tar.bz2 | tar xj
RUN cd /tmp/serd-* && ./waf configure && ./waf && ./waf install
RUN cd / && rm -rf /tmp/serd-*
RUN serdi -v

# Update below according to https://jena.apache.org/download/
# and .sha1 from https://www.apache.org/dist/jena/binaries/
ENV JENA_SHA1 48a3459216a5298fd99695ce6347c8a5739f3e34
ENV JENA_VERSION 3.17.0
ENV JENA_MIRROR http://www.eu.apache.org/dist/
ENV JENA_ARCHIVE http://archive.apache.org/dist/
#

WORKDIR /tmp
# sha1 checksum
RUN echo "$JENA_SHA1  jena.tar.gz" > jena.tar.gz.sha1
# Download/check/unpack/move in one go (to reduce image size)
RUN     wget -q -O jena.tar.gz $JENA_MIRROR/jena/binaries/apache-jena-$JENA_VERSION.tar.gz || \
        wget -q -O jena.tar.gz $JENA_ARCHIVE/jena/binaries/apache-jena-$JENA_VERSION.tar.gz && \
  sha1sum -c jena.tar.gz.sha1 && \
  tar zxf jena.tar.gz && \
  mv apache-jena* /jena && \
  rm jena.tar.gz* && \
  cd /jena && rm -rf *javadoc* *src* bat

# Add to PATH
ENV PATH $PATH:/jena/bin
# Print verson to validate
RUN riot  --version

# Default dir /rdf, can be used with
# --volume
RUN mkdir /rdf
WORKDIR /rdf
#VOLUME /rdf
#CMD ["/jena/bin/riot"]
