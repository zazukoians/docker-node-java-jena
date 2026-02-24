# RDF Pipeline Docker Image (Node + Java + Jena)

This Docker image is designed for RDF-related tasks in automated pipelines (ETL/ELT). It packages the Apache Jena stack, Node.js, and a comprehensive set of CLI tools for RDF processing, scripting, and reasoning.

It is particularly useful for:
- Automating RDF extraction, transformation, and loading (ETL).
- Running RDF validation and reasoning in CI/CD pipelines.
- Scripting complex RDF processing workflows using Node.js and specialized CLI tools.

## Included Tools

The image contains a rich set of tools for working with RDF data:

### Core Runtimes
- **Node.js (v24)**: For JavaScript/TypeScript-based RDF processing and pipeline logic.
- **Java (OpenJDK 21)**: Required for running Apache Jena and other JVM-based tools.

### RDF Frameworks & Reasoning
- **[Apache Jena](https://jena.apache.org/)(v6.x)**: A complete framework for building Semantic Web and Linked Data applications. Includes CLI tools like `riot`, `sparql`, etc.
- **[EYE Reasoning Engine](https://github.com/eyereasoner/eye/)(v11.x)**: A performant reasoning engine for N3 (Notation3).
- **[sophia-cli (`sop`)](https://github.com/pchampin/sophia-cli)**: A versatile CLI tool for RDF processing based on the Sophia toolkit.

### Specialized RDF Tooling
- **[barnard59](https://github.com/zazuko/barnard59)**: A streaming RDF middleware for Node.js pipelines.
- **[serdi](http://drobilla.net/software/serd/)**: A fast read/write library for Turtle and NTriples.
- **[raptor2-utils](https://librdf.org/raptor/)**: Includes `rapper` for RDF parsing and serialization.

### Utilities
- **Minio Client (`mc`)**: For interacting with S3-compatible storage (useful for fetching/storing RDF dumps).
- **jq**: A lightweight and flexible command-line JSON processor.
- **s3cmd**: Command line tool for S3.

## Usage

### Use the pre-built image

The image is available on Docker Hub:

```sh
docker pull zazukoians/node-java-jena
```

### Build the Docker image manually

You can adjust and build the image according to your needs:

```sh
docker build -t zazukoians/node-java-jena .
```

## Feedback

If you encounter any problems, please report issues on GitHub. Pull requests and suggestions are also welcome.
