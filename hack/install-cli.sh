#!/bin/bash
#
# SPDX-FileCopyrightText: 2025 SAP SE or an SAP affiliate company and openmcp-project contributors
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
