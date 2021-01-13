#!/bin/bash

set -euo pipefail
set -x

CONTAINER_BASE_DIR=/tmp/test
CONTAINER_ENGINE=${CONTAINER_ENGINE:-'docker'}
IMG=${IMG:-'quay.io/rogreen/bookmark-generator:latest'}
OUTPUT_HTML_FILE=${OUTPUT_FILE:-'bookmark.html'}
ADDITIONAL_CONTAINER_ENGINE_ARGS=${ADDITIONAL_CONTAINER_ENGINE_ARGS:-}

if [[ "${CONTAINER_ENGINE}" == 'podman' ]]; then
	ADDITIONAL_CONTAINER_ENGINE_ARGS="${ADDITIONAL_CONTAINER_ENGINE_ARGS} --net=host"
fi

${CONTAINER_ENGINE} run \
    --rm \
    --interactive \
    --tty \
    --volume \
        "$(pwd)":${CONTAINER_BASE_DIR}/data \
    "${ADDITIONAL_CONTAINER_ENGINE_ARGS}" \
    "${IMG}" \
    python3 \
    	bookmark_generator.py \
	data/sample.yaml > "${OUTPUT_HTML_FILE}"
