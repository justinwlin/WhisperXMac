ARG WHISPER_MODEL=small
ARG LANG=en
ARG TORCH_HOME=/cache/torch
ARG HF_HOME=/cache/huggingface
ARG PLATFORM

FROM python:3.10-slim as dependencies

# Upgrade pip and setuptools
RUN pip install --upgrade pip setuptools

# PyTorch installation 
RUN pip install torch==2.0.0 torchvision==0.15.0 torchaudio==2.0.0 -f https://download.pytorch.org/whl/cu118/torch_stable.html

# Copy the modified whisperX directory into the Docker image
COPY ./whisperX /whisperX
RUN cd /whisperX && pip install .

FROM python:3.10-slim

# Install system dependencies in the final stage
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libsndfile1 \
    libgomp1 \
    libjpeg-dev \
    libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Set LD_LIBRARY_PATH for library location (if still necessary)
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/aarch64-linux-gnu/

# Copy Python site-packages from dependencies stage
COPY --from=dependencies /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages

# Environment variables
ENV TORCH_HOME=${TORCH_HOME}
ENV HF_HOME=${HF_HOME}
ENV WHISPER_MODEL=${WHISPER_MODEL}
ENV LANG=${LANG}

WORKDIR /app

STOPSIGNAL SIGINT
ENTRYPOINT ["/bin/bash", "-c"]
