# Node with Java JRE & Apache Jena distro Docker Image

This Docker image contains NodeJS, Apache Jena, EYE reasoning engine and some useful tools.

If you have any problems with this image please report issues on GitHub.
Pull requests & suggestions are also welcome.

We use the image for some pipelines where we need both Node and Jena to create & validate RDF data.

### Use the pre built image

The pre built image can be downloaded using Docker.

```sh
docker pull zazukoians/node-java-jena
```

### Build the Docker image by yourself

You can also adjust and build the image according to your needs.
Just clone the repository and then execute the build command.

```sh
docker build -t zazukoians/node-java-jena .
```
