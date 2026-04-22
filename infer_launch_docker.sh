#!/bin/bash

docker run \
  --shm-size=8G \
  --gpus all \
  -it \
  --rm \
  --name anodapter \
  -v ${PWD}/datasets:/workspace/datasets \
  -v ${PWD}/save_dir:/workspace/save_dir \
  -v ${PWD}:/workspace/code \
  anodapter_env_image \
  infer dents 40000 test-40000
 
#  infer missing_fasteners 40000 test-40000
