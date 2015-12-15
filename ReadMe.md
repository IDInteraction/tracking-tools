# IDInteraction Object Tracking Tools

*Scripts for running the [IDInteraction Object Tracking Pipelines][pipelines] easily, and in a repeatable manner.*

## Prerequisites

The only software needed to run these tools is [Docker][docker]. Please see the [installation instructions for your platform][dockerdocs] to get started.

### Getting the Docker images

All of our Docker images are available from the [Docker Hub][dockerhub] and will be automatically downloaded first time they are needed by one of these tools.

## Installing the tools

To install these tools for just the current user, just run `make`:

```shell
$ make
```

This will install everything into `$HOME/bin`. To install the tools for all users on the system, run make as root:

```shell
$ sudo make
```

This will install everything into `/usr/local/bin`.

## Running the tools

These tools hide the complexities of running Docker images and present a more user friendly interface than `docker run ...`. You may need to run them as `root` if you have not set up your users to be able to run Docker without administrator privileges.

### `idi-crop-video`

This tool takes a directory full of participant video streams and crops out the front, back and side quarters into separate files in preparation for object tracking.

Simply provide the directory with the source videos and the directory where you want the cropped videos to be written to as parameters:

```shell
$ idi-crop-video <input-directory> <output-directory>
```

The `<input-directory>` is mounted read-only to ensure that the original videos are preserved so, even though it is technically possible to supply the same directory for both parameters, it is not recommended.

The output videos are written to a subdirectory within `<output-directory>` for each angle from the original video: front, back and side.

### `idi-init-tracking`

This tool uses the outputs from the previous tool, `idi-crop-video`, and gathers the information needed to initialize object tracking. It needs access to the cropped input videos and a directory to save the tracking setup data to:

```shell
$ idi-init-tracking <videos-directory> <output-directory>
```

The `<videos-directory>` is mounted read-only to ensure that the cropped videos are preserved so, even though it is technically possible to supply the same directory for both parameters, it is not recommended.

For each video in the `videos-directory` this tool asks the user for two bits of essential information:

* The start time of the experiment, in milliseconds, *from the start of the video*. In other words, if the experiment contained in this video does not start right at the start of the video, you can input the amount of time to skip before object tracking starts. Simply enter `0` if the experiment does start right at the beginning of the video.
* The bounding box of the object to be tracked. A window is opened showing the first frame of video from the experiment and a bounding box is defined by clicking with the mouse, first, the top-left corner and, second, the bottom-right corner of the box to used. The bounding box can be refined with the following keys:
 * `i` - zoom in
 * `o` - zoom out
 * `a` - move box left one pixel
 * `d` - move box right one pixel
 * `w` - move box up one pixel
 * `s` - move box down one pixel
 * `A` - make box wider by one pixel
 * `D` - make box narrower by one pixel
 * `W` - make box taller by one pixel
 * `S` - make box shorter by one pixel
 * `enter` - finish editing bounding box

The information collected by this tool is saved to files in the `output-directory`. The time to skip at the start of a video can be found in `<video-name>.skip` and the bounding box coordinates can be found in `<video-name>.bbox`.

### `idi-track`

This is the core object tracking tool in this collection. It takes *exactly* the same two parameters as `idi-init-tracking`; that is, `videos-directory` points to a directory of cropped input videos and `output-directory` points to a directory with the generated `skip` and `bbox` outputs already present:

```shell
$ idi-track <videos-directory> <output-directory>
```

The `<videos-directory>` is mounted read-only to ensure that the cropped videos are preserved so, even though it is technically possible to supply the same directory for both parameters, it is not recommended.

For each input video the `output-directory` will gain a file with object tracking data in it - `<video-name>.csv`.

### `idi-replay-tracking`

This tool takes all the data generated in the previous steps and combines it into a single video output; the object-tracked bounding box and bounding box center point are drawn into each video. As with the previous two tools, `videos-directory` points to a directory of cropped input videos and `output-directory` points to a directory with the generated `skip`, `bbox` and `csv` outputs already present:

```shell
$ idi-replay-tracking <videos-directory> <output-directory>
```

The `<videos-directory>` is mounted read-only to ensure that the cropped videos are preserved so, even though it is technically possible to supply the same directory for both parameters, it is not recommended.

For each input video the `output-directory` will gain a video with object tracking data superimposed into it - `<video-name>_out.avi`.

## Acknowledgements

The IDInteraction Object Tracking Tools were developed in the IDInteraction project, funded by the Engineering and Physical Sciences Research Council, UK through grant agreement number [EP/M017133/1][gow].

## Licence

Copyright (c) 2015 The University of Manchester, UK.

Licenced under LGPL version 2.1. See LICENCE for details.

[pipelines]: https://github.com/IDInteraction/processing-pipelines
[docker]: https://www.docker.com/
[dockerdocs]: https://docs.docker.com/
[dockerhub]: https://hub.docker.com/u/idinteraction/
[gow]: http://gow.epsrc.ac.uk/NGBOViewGrant.aspx?GrantRef=EP/M017133/1
