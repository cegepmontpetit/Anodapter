#!/bin/bash

usage() {
    echo "Usage: $0 <dataset_path> <defect_type>"
    exit 1
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

if [ "$#" -ne 2 ]; then
    usage
fi

docker run \
  --shm-size=8G \
  --gpus all \
  -it \
  --rm \
  --name anodapter \
  -v ${PWD}/datasets:/workspace/datasets \
  -v ${PWD}/save_dir:/workspace/save_dir \
  -v ${PWD}/models:/workspace/models \
  -v ${PWD}:/workspace/code \
  anodapter_env_image \
  train $@
  
#newdata.v8-9-juin-full-res.yolo26_mvtec_tiled dents
  
#fasteners.v4-test-all-drone.yolo26_mvtec_tiled missing_fasteners
