#!/bin/bash

set -euo pipefail

CONTAINER_BASE_DIR=/tmp/test
CONTAINER_ENGINE=${CONTAINER_ENGINE:-'docker'}
IMG=${IMG:-'quay.io/rogreen/bookmark-generator:latest'}
OUTPUT_HTML_FILE=${OUTPUT_FILE:-'bookmark.html'}

${CONTAINER_ENGINE} run \
    --rm \
    --interactive \
    --tty \
    --volume \
        $(pwd):${CONTAINER_BASE_DIR}/data \
    ${IMG} \
    python3 \
    	bookmark_generator.py \
	data/sample.yaml > ${OUTPUT_HTML_FILE}
