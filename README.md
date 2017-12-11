Native builder for AWS Lambda + NodeJS modules
----------------------------------------------

This project allows users to easily install NodeJS modules,
including those written as addons with gyp in C/C++ for AWS Lambda.

## Installation

The easiest way to use this is via a shell alias installed as such:

`$ echo 'alias awslambda-npm-install="docker run -v \$PWD:/var/task iopipe/awslambda-npm-install"' >> ~/.bashrc`

## Usage

From your project directory:

`$ awslambda-npm-install`

This will build C/C++ modules and install them into your `node_modules` directory using
the latest verison of NodeJS.

That's it!

## Selecting version of NodeJS

Specify a Docker tag on the image name. Supported tags include:

* v6
* v4
* v6.10.2
* v4.3.2

The tag may be specified as in the following command:

`docker run -v $PWD:/var/task iopipe/awslambda-npm-install:v4 <npm-path>`

## Building this Docker image

Build for NodeJS v4.3.2:

`docker build --build-arg NODE_VERSION=4.3.2 -t awslambda-npm-install .`

Build for NodeJS v6.10.2:

`docker build --build-arg NODE_VERSION=6.10.2 -t awslambda-npm-install .`

## Example project

The following example will create a new Serverless Framework project and add the native protocol buffers module.

```
$ serverless create -t aws-nodejs
$ docker run -v $PWD:/var/task iopipe/awslambda-npm-install protobuf
$ cat <<EOF > handler.js
var protobuf = require('protobuf')
module.exports.hello = (event, context, callback) => {
  callback()
}
EOF
$ serverless deploy
```

## Technical details

This image is built on AWS Linux and builds its own versions
of NodeJS based on the versions used by AWS. None of these files
have been copied from the AWS Lambda environment, but are publicly
and legally available sources and binaries provided by AWS and the
NodeJS foundation for public and open use.

## License

Apache-2.0 see [LICENSE](https://www.apache.org/licenses/LICENSE-2.0.html)

Copyright 2017  IOpipe, Inc.
