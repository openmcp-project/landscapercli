#!/bin/bash
#
# SPDX-FileCopyrightText: Copyright OpenControlPlane contributors.
#
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

PROJECT_ROOT="$(realpath $(dirname $0)/..)"

GITTREESTATE=`([ -z "$(git status --porcelain 2>/dev/null)" ] && echo clean || echo dirty)`

go install \
  -ldflags "-X github.com/openmcp-project/landscapercli/pkg/version.LandscaperCliVersion=$EFFECTIVE_VERSION \
            -X github.com/openmcp-project/landscapercli/pkg/version.gitTreeState=$GITTREESTATE \
            -X github.com/openmcp-project/landscapercli/pkg/version.gitCommit=$(git rev-parse --verify HEAD)" \
  ${PROJECT_ROOT}/cmd/landscapercli
