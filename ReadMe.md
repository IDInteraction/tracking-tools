# IDInteraction Object Tracking Tools

*Scripts for running the [IDInteraction Object Tracking Pipelines][pipelines] easily, and in a repeatable manner.*

## Prerequisites

The only software needed to run these tools is [Docker][docker]. Please see the [installation instructions for your platform][dockerdocs] to get started.

### Getting the Docker images

All of our Docker images are available from the [Docker Hub][dockerhub] and will be automatically downloaded first time they are needed by one of these tools.

## Running the tools

### `idi-crop-video`

Simply provide the directory with the source videos and the directory where you want the cropped videos to be written to as parameters:

```shell
$ idi-crop-video <input-directory> <output-directory>
```

The `<input-directory>` is mounted read-only to ensure that the original videos are preserved so, even though it is technically possible to supply the same directory for both parameters, it is not recommended.

The output videos are written to a subdirectory within `<output-directory>` for each angle from the original video: front, back and side.

## Acknowledgements

The IDInteraction Processing Pipelines were developed in the IDInteraction project, funded by the Engineering and Physical Sciences Research Council, UK through grant agreement number [EP/M017133/1][gow].

## Licence

Copyright (c) 2015 The University of Manchester, UK.

Licenced under LGPL version 2.1. See LICENCE for details.

[pipelines]: https://github.com/IDInteraction/processing-pipelines
[docker]: https://www.docker.com/
[dockerdocs]: https://docs.docker.com/
[dockerhub]: https://hub.docker.com/u/idinteraction/
[gow]: http://gow.epsrc.ac.uk/NGBOViewGrant.aspx?GrantRef=EP/M017133/1
