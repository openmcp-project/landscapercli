#!/bin/bash -eu

WORK_DIR="dist"
mkdir -p "${WORK_DIR}"

# show help if requested
for _arg in "$@"; do
  case "${_arg:-}" in
    -h|--help)
      cat <<'USAGE'
Usage: hack/crossbuild.sh [OS_LIST] [ARCH_LIST] [EXCLUDE_LIST]

Positional parameters (comma-separated):
  OS_LIST        Target OSes (default: linux,darwin,windows)
  ARCH_LIST      Target architectures (default: amd64,arm64)
  EXCLUDE_LIST   Comma-separated os,arch pairs to skip (e.g. windows,amd64)

Environment variables (alternative to positional params):
  BUILD_OS       Comma-separated OS list
  BUILD_ARCH     Comma-separated ARCH list
  BUILD_EXCLUDE  Comma-separated exclude pairs

Other:
  EFFECTIVE_VERSION   Use this env var to override VERSION file value

Examples:
  ./hack/crossbuild.sh                                        # build default OS/ARCH combos
  ./hack/crossbuild.sh linux,windows amd64                    # build two OSes for amd64
  ./hack/crossbuild.sh linux,darwin amd64,arm64 windows,amd64 # exclude windows/amd64

Options:
  -h, --help     Show this help and exit
USAGE
      exit 0
      ;;
  esac
done

set -euo pipefail
source "$(realpath "$(dirname $0)/common/environment.sh")"

PROJECT_ROOT="$(realpath $(dirname $0)/..)"

if [[ -z ${EFFECTIVE_VERSION:-} ]]; then
  EFFECTIVE_VERSION=$(cat $PROJECT_ROOT/VERSION)
fi

(
  cd "$PROJECT_ROOT"

  # Accept OS and ARCH as positional params (comma-separated) or via env vars BUILD_OS/BUILD_ARCH.
  # Defaults: linux,darwin,windows and amd64,arm64
  if [[ -n "${1:-}" ]]; then
    IFS=',' read -r -a build_os <<< "$1"
  elif [[ -n "${BUILD_OS:-}" ]]; then
    IFS=',' read -r -a build_os <<< "$BUILD_OS"
  else
    build_os=("linux" "darwin" "windows")
  fi

  if [[ -n "${2:-}" ]]; then
    IFS=',' read -r -a build_arch <<< "$2"
  elif [[ -n "${BUILD_ARCH:-}" ]]; then
    IFS=',' read -r -a build_arch <<< "$BUILD_ARCH"
  else
    build_arch=("amd64" "arm64")
  fi

  if [[ -n "${3:-}" ]]; then
    IFS=',' read -r -a build_exclude <<< "$3"
  elif [[ -n "${BUILD_EXCLUDE:-}" ]]; then
    IFS=',' read -r -a build_exclude <<< "$BUILD_EXCLUDE"
  else
    build_exclude=("none")
  fi

  for os in "${build_os[@]}"; do
    for arch in "${build_arch[@]}"; do
      if [[ " ${build_exclude[*]} " == *"$os,$arch"* ]]; then
        echo "Skipping excluded build for $os/$arch"
        continue
      fi
      echo "Building $os/$arch version ${EFFECTIVE_VERSION}..."
      bin_path="${WORK_DIR}/landscapercli-$os-$arch"

      CGO_ENABLED=0 GOOS=$os GOARCH=$arch GO111MODULE=on \
      go build -o $bin_path \
        -ldflags "-s -w \
        -X github.com/openmcp-project/landscapercli/pkg/version.LandscaperCliVersion=$EFFECTIVE_VERSION \
        -X github.com/openmcp-project/landscapercli/pkg/version.gitTreeState=$([ -z git status --porcelain 2>/dev/null ] && echo clean || echo dirty) \
        -X github.com/openmcp-project/landscapercli/pkg/version.gitCommit=$(git rev-parse --verify HEAD)" \
        ${PROJECT_ROOT}/cmd/landscapercli
    # create zipped file
    gzip -f -k "$bin_path"
    # -f --force           force overwriting & compress links
    # -k --keep            don't delete input files during operation

    done

  done
  binfiles=$(ls dist/*.gz)
  echo -e "Created binaries:\n$binfiles"
)
