#!/usr/bin/env bash

eval "$(/opt/homebrew/bin/brew shellenv)" # TODO: Needs to be in every script
asdf plugin-add golang
asdf plugin-add helm
asdf plugin-add kubectl
asdf plugin-add packer
asdf plugin-add pre-commit
asdf plugin-add python
asdf plugin-add terraform-docs
asdf plugin-add terraform
asdf plugin-add tflint
asdf plugin-add tfsec
asdf plugin-add nodejs
asdf plugin-add goreleaser
asdf plugin-add parliament https://github.com/amrox/asdf-pyapp.git
# asdf plugin-add direnv
# asdf direnv setup --shell zsh --version system

#TODO: Force status code 0 regardless if the plugins succesfully installed. This way the makefile does not fail
exit 0
