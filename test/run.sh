#!/bin/bash
set -e

cd "$(dirname "$0")/.."

echo "Building tada template verification image..."
docker build -f test/Dockerfile -t tada-test .

echo ""
echo "All verification checks passed."
echo "To inspect the generated projects:"
echo "  docker run -it tada-test bash"
