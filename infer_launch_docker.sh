#!/bin/bash

usage() {
    echo "Usage : $0 <defect_type> <n_step_model> <experiment_name>"
    exit 1
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

if [ "$#" -ne 3 ]; then
    usage
fi


docker run \
  --shm-size=8G \
  --gpus all \
  -it \
  --rm \
  --name anodapter_infer \
  -v ${PWD}/datasets:/workspace/datasets \
  -v ${PWD}/save_dir:/workspace/save_dir \
  -v ${PWD}:/workspace/code \
  anodapter_env_image \
  infer "$@"
  
