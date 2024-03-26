#!/bin/sh
export INSTALLATION_NAME=
export NAMESPACE=
export GITHUB_CONFIG_URL=
export GITHUB_PAT=
helm install "${INSTALLATION_NAME}"     --namespace "${NAMESPACE}"     --create-namespace     --set githubConfigUrl="${GITHUB_CONFIG_URL}"     --set githubConfigSecret.github_token="${GITHUB_PAT}"     oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set