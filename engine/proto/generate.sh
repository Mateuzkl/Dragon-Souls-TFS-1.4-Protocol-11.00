#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
protoc -I=. --cpp_out=../src/protobuf shared.proto appearances.proto
