#!/bin/bash

# SPDX-FileCopyrightText: Copyright OpenControlPlane contributors.
#
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

PROJECT_ROOT="$(realpath $(dirname $0)/..)"

function revendor() {
  go mod tidy
}

echo "Revendor root module ..."
(
  cd "$PROJECT_ROOT"
  revendor
)
