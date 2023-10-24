# Docker Build Commands

Build Command:

```
docker build -t whisperx_image . --load
```

# Example how to run it and mount it on your current working directory

(In mine the docker image is named justinwlin/whisperxmac:1.0)
This mounts your current working directory + then runs the whisperx command on the input.mp3 file

```
docker run --rm -it -v $(pwd):/app justinwlin/whisperxmac:1.0 /bin/bash
whisperx input.mp3 --compute_type int8 --language en
```

# Original Repo:

https://github.com/m-bain/whisperX

# Github Issue:

WhisperX doesn't run on mac due to pyannote.audio upgrading a dependency to a version that doesn't support mac.
https://github.com/pyannote/pyannote-audio/issues/1505

WhisperX Issue:
https://github.com/m-bain/whisperX/issues/499
