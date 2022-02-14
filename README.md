# `k8s`
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ftcwlab%2Fk8s.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Ftcwlab%2Fk8s?ref=badge_shield)
[![pipeline status](https://gitlab.com/tcwlab.com/saas/baseline/images/k8s/badges/main/pipeline.svg)](https://gitlab.com/tcwlab.com/saas/baseline/images/k8s/-/commits/main)
[![coverage report](https://gitlab.com/tcwlab.com/saas/baseline/images/k8s/badges/main/coverage.svg)](https://gitlab.com/tcwlab.com/saas/baseline/images/k8s/-/commits/main)
[![GitHub tag](https://img.shields.io/github/tag/tcwlab/k8s)](https://github.com/tcwlab/k8s/releases/?include_prereleases&sort=semver "View GitHub releases")
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## tl;dr

This image contains `kubectl`, `kustomize` and `helm` all-in-one alpine image. Every image contains the latest stable version of both tools at build time.
The goal is to make CI/CD tasks as easy as possible.
We only set up this project, because all other projects we found 'in the wild' seems to be somehow orphaned.

## Quick reference

- **Maintained by:** [Sascha Willomitzer](https://thechameleonway.com) [(of the TCWlab project)](https://gitlab.com/sascha_willomitzer)
- **Where to get help:** [file an issue](https://gitlab.com/tcwlab.com/saas/baseline/images/k8s/-/issues)
- **Supported architectures:** linux/amd64
- **Published image artifact details:** [see source code repository](https://gitlab.com/tcwlab.com/saas/baseline/images/k8s/-/tree/main)
- **Documentation:**
  - `kubectl`: [see reference](https://kubectl.docs.kubernetes.io/references/kubectl/)
  - `kustomize`: [SIG documentation](https://kubectl.docs.kubernetes.io/references/kustomize/)
  - `helm`: [official documentation](https://helm.sh/docs/)
  - How everything works together: <https://kubectl.docs.kubernetes.io/>

## Getting started

This image is intended to be used both locally _and_ as a part of a pipeline.
Find the steps how to use it below, depending on your needs.

### Using it locally

#### Using `~/.kube` as volume
We thought it would be easy to just mount all of your kubernetes configs inside the container,
so that you can easily interact with it.
It's as easy as calling:

```bash
docker run --rm -v ~/.kube:/.kube tcwlab/k8s:latest kubectl get no
docker run --rm -v ~/.kube:/.kube tcwlab/k8s:latest helm list
```
or in interactive mode:
```bash
docker run -it --rm -v ~/.kube:/.kube tcwlab/k8s:latest /bin/bash
```

#### Using only one specific `kubeconfig`
Instead of mounting all your kubeconfigs to the container, you could also only set one specific
config as environment variable:
```bash
docker run -e KUBE_CONFIG_B64="$(base64 -i ~/.kube/config)" tcwlab/k8s:latest kubectl version
docker run -e KUBE_CONFIG_B64="$(base64 -i ~/.kube/config)" tcwlab/k8s:latest helm version
```

### Using as CI/CD image
As we are using GitLab ourselves, this only describes the GitLab CI/CD way,
using this `.gitlab-ci.yml` snippet:

```yaml
k8s-example:
  stage: demo
  image: tcwlab/k8s:latest
  variables:
    KUBE_CONFIG_B64: $YOUR_ENV_VAR_CONTAINING_B64_KUBECONFIG
  script:
    - kubectl get nodes
```

If you'd like to see some example configurations, have a look at our [bootstrap project](https://gitlab.com/tcwlab.com/saas/baseline/bootstrap/-/blob/main/.gitlab-ci.yml).

## Roadmap
If you are interested in the upcoming/planned features, ideas and milestones,
please have a look at our [board](https://gitlab.com/tcwlab.com/saas/baseline/images/k8s/-/boards).

## License
This project is licensed under [Apache License v2](./LICENSE).

## Project status
This project is maintained "best effort", which means, we strive for automation as much as we can
A lot of updates will be done "automagically".

We do **not** have a specific dedicated set of people to work on this project.

It absolutely comes with **no warranty**.

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ftcwlab%2Fk8s.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Ftcwlab%2Fk8s?ref=badge_large)
