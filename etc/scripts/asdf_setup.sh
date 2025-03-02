#!/usr/bin/env bash

eval "$(/opt/homebrew/bin/brew shellenv)" # TODO: Needs to be in every script
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf plugin add golangci-lint https://github.com/hypnoglow/asdf-golangci-lint.git
asdf plugin add helm https://github.com/Antiarchitect/asdf-helm.git
asdf plugin add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf plugin add packer https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add pre-commit
asdf plugin add python https://github.com/asdf-community/asdf-python.git
asdf plugin add terraform-docs https://github.com/looztra/asdf-terraform-docs
asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin add vault https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin add tflint https://github.com/skyzyx/asdf-tflint.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add goreleaser https://github.com/kforsthoevel/asdf-goreleaser.git
asdf plugin add parliament https://github.com/amrox/asdf-pyapp.git
asdf plugin add minikube https://github.com/alvarobp/asdf-minikube.git
asdf plugin add argocd https://github.com/beardix/asdf-argocd.git

# asdf plugin-add direnv
# asdf direnv setup --shell zsh --version system

#TODO: Force status code 0 regardless if the plugins succesfully installed. This way the makefile does not fail
exit 0
