[![REUSE status](https://api.reuse.software/badge/github.com/openmcp-project/landscapercli)](https://api.reuse.software/info/github.com/openmcp-project/landscapercli)

# Landscaper CLI

## About this project

The Landscaper CLI supports users to develop, maintain, and test components processed by the [Landscaper](https://github.com/openmcp-project/landscaper). This comprises the handling of objects like component descriptors, blueprints, installations, etc.

## Requirements and Setup

Install the latest release via [Nix](https://nixos.org), download binaries directly from [GitHub Releases](https://github.com/openmcp-project/landscapercli/releases), or build and install directly from source.

**Remark:** This version of the Landscaper CLI requires that you have installed helm version 3.7 or higher
due to some fundamental API changes especially with respect to the handling of helm charts stored as OCI resources.

### Install using Nix (with [Flakes](https://nixos.wiki/wiki/Flakes))

```bash
# Nix (macOS, Linux, and Windows)
# ad hoc cmd execution
nix run github:gardener/landscapercli -- --help

# install development version
nix profile install github:gardener/landscapercli
# or release <version>
nix profile install github:gardener/landscapercli/<version>

#check installation
nix profile list | grep landscapercli

# optionally, open a new shell and verify that cmd completion works
landscaper-cli --help
```

### Install from Github Release

If you install via GitHub releases, you need to

- download the correct binary artifact for your os and architecture
- unpack and put the `landscapercli` binary on your path

You can use this boilerplate:
```bash
# set operating system and architecture
os=darwin # choose between darwin, linux
arch=amd64 # choose between amd64

# Get latest version, unzip, make executable
curl -LO "https://github.com/openmcp-project/landscapercli/releases/latest/download/landscapercli-${os}-${arch}.gz"
gunzip landscapercli-${os}-${arch}.gz
chmod +x ./landscapercli-${os}-${arch}

# Move the binary in to your PATH
sudo mv ./landscapercli-${os}-${arch} /usr/local/bin/landscaper-cli
```

### Build from source

Instructions can be found [here](docs/installation.md).

## Documentation

Detailed descriptions for commands could be found [here](docs/commands).

The command reference is located [here](docs/reference/landscaper-cli.md).

The Landscaper CLI support the installation of the [Docker OCI registry](https://hub.docker.com/_/registry/)
with the [quickstart command](docs/commands/quickstart).

A description how to access an OCI registry which requires authentication with the Landscaper CLI can be found [here](docs/login-to-oci-registry.md).

Other examples:
https://github.com/openmcp-project/landscaper/blob/master/docs/tutorials/02-simple-import.md

## Support, Feedback, Contributing

This project is open to feature requests/suggestions, bug reports etc. via [GitHub issues](https://github.com/openmcp-project/landscapercli/issues). Contribution and feedback are encouraged and always welcome. For more information about how to contribute, the project structure, as well as additional contribution information, see our [Contribution Guidelines](CONTRIBUTING.md).

## Security / Disclosure
If you find any bug that may be a security problem, please follow our instructions at [in our security policy](https://github.com/openmcp-project/landscapercli/security/policy) on how to report it. Please do not create GitHub issues for security-related doubts or problems.

## Code of Conduct

We as members, contributors, and leaders pledge to make participation in our community a harassment-free experience for everyone. By participating in this project, you agree to abide by its [Code of Conduct](https://github.com/SAP/.github/blob/main/CODE_OF_CONDUCT.md) at all times.

## Licensing

Copyright 2025 SAP SE or an SAP affiliate company and landscapercli contributors. Please see our [LICENSE](LICENSE) for copyright and license information. Detailed information including third-party components and their licensing/copyright information is available [via the REUSE tool](https://api.reuse.software/info/github.com/openmcp-project/landscapercli).

## Information About this Fork

This repository is a fork of https://github.com/gardener/landscaper. The support for the Landscaper project is sunsetting in the _Gardener_ organization.
Maintainenance and development of the Landscaper project will continue in the https://github.com/openmcp-project/landscaper repository.
This doesn't affect any feature or functionality of the Landscaper project.
OCI images and OCM components can be consumed directly from within this repository GitHub Container Registry.
