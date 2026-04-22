#!/usr/bin/env bash
#set -e

CODE_DIR=/workspace/code

if [ ! -d "$CODE_DIR" ]; then
    echo "ERROR: /workspace/code not mounted"
    exit 1
fi

cd "$CODE_DIR"

COMMAND=$1
shift

case "$COMMAND" in
    train)
        cd examples/anodapter
        exec ./train_anodapter.sh "$@"
        ;;
    infer)
        exec ./inference.sh "$@"
        ;;
    *)
        echo "Usage: train | infer dataset_name"
        exec bash
        ;;
esac

exec bash
