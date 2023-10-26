# Local Installation

You can clone this repo, and install this directly as a python package instead of using the one off of the main repo. The setup.py is changed to support arm64 vs the main repo. You will need to specify the compute type and language.

```
cd whisperx
pip3 install .
whisperx input.mp3 --compute_type int8 --language en
```

# DockerHub Image:

https://hub.docker.com/repository/docker/justinwlin/whisperxmac/general

# Docker Build Commands

Build Command:

```
docker build -t whisperx_image .
```

# Example how to run it and mount it on your current working directory

(In mine the docker image is named justinwlin/whisperxmac:1.0)
This mounts your current working directory + then runs the whisperx command on the input.mp3 file

```
docker run --rm -it -v $(pwd):/app justinwlin/whisperxmac:1.0 /bin/bash
whisperx input.mp3 --compute_type int8 --language en
whisperx output.mp3 --compute_type int8 --language en --highlight_words True
```

# Depot

I'm using Depot to build my Dockerfile, to build for mac / arm64:

```
depot build -t whisperx_image . --platform linux/arm64 --load
```

# Original Repo:

https://github.com/m-bain/whisperX

# Github Issue:

WhisperX doesn't run on mac due to pyannote.audio upgrading a dependency to a version that doesn't support mac.
https://github.com/pyannote/pyannote-audio/issues/1505

WhisperX Issue:
https://github.com/m-bain/whisperX/issues/499
