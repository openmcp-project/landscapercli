#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright OpenControlPlane contributors.
#
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

PROJECT_ROOT="$(realpath $(dirname $0)/..)"
mod="$1"

version="$(cat "$PROJECT_ROOT/go.mod" | grep "$mod ")" # fetch line containing the version
version=${version%%//*} # remove potential comment at end of line
version=$(sed -r 's@^[[:blank:]]+|[[:blank:]]+$@@g' <<< $version) # remove leading and trailing whitespace
version=${version#$mod' '}

if [[ ${NO_PREFIX:-"false"} != "false" ]]; then
  version=${version#v}
fi

echo "$version"