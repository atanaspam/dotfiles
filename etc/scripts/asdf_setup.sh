#!/usr/bin/env bash

asdf plugin add golang https://github.com/asdf-community/asdf-golang.git || true
asdf plugin add golangci-lint https://github.com/hypnoglow/asdf-golangci-lint.git || true
asdf plugin add helm https://github.com/Antiarchitect/asdf-helm.git || true
asdf plugin add kubectl https://github.com/asdf-community/asdf-kubectl.git || true
asdf plugin add packer https://github.com/asdf-community/asdf-hashicorp.git || true
asdf plugin add python https://github.com/asdf-community/asdf-python.git || true
asdf plugin add terraform-docs https://github.com/looztra/asdf-terraform-docs || true
asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git || true
asdf plugin add vault https://github.com/asdf-community/asdf-hashicorp.git || true
asdf plugin add tflint https://github.com/skyzyx/asdf-tflint.git || true
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
asdf plugin add goreleaser https://github.com/kforsthoevel/asdf-goreleaser.git || true
asdf plugin add parliament https://github.com/amrox/asdf-pyapp.git || true
asdf plugin add minikube https://github.com/alvarobp/asdf-minikube.git || true
asdf plugin add argocd https://github.com/beardix/asdf-argocd.git || true
asdf plugin add poetry https://github.com/asdf-community/asdf-poetry.git || true
asdf plugin add bun https://github.com/cometkim/asdf-bun.git || true
asdf plugin add azure-cli https://github.com/EcoMind/asdf-azure-cli || true


asdf install
