# Node with Java JRE & Apache Jena distro Docker Image

Based on our [node & Java](https://github.com/zazukoians/docker-node-java) image, which itself is based on the official node image.

The whole installation of Jena is taken from Stains excellent image at [Github](https://github.com/stain/jena-docker/tree/master/jena). The only difference is that the official `node` image is still based on Debian and not Alpine Linux. Stains Dockerfile carries an Apache License header so does this image. The dockerfile is pretty much a 1:1 copy of Stains, except the `FROM` part.
 
If you have any problems with this image please report issues on Github. Pull requests & suggestions are also welcome.

We use the image for some pipelines where we need both Node and Jena to create & validate RDF data.

### Versioning

We provide tags for the according Jena version and also a latest version pointing to the most recent tag. In case we have to re-release a version we add `_1` or alike to the version, for example `3.13.1_1`

### Use the pre built image

The pre built image can be downloaded using Docker.

    docker pull zazukoians/node-java-jena


### Build the Docker image by yourself

You can also adjust and build the image according to your needs. Just clone the repository and then execute the build command.

    docker build -t zazukoians/node-java-jena .


