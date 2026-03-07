DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules .github
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
BREW_BIN   := /opt/homebrew/bin/brew
export PATH := /opt/homebrew/bin:/opt/homebrew/sbin:$(PATH)

.DEFAULT_GOAL := help

all: bootstrap brew install app_setup

bootstrap: ## Install XCode developer tools and other prerequisites
	@sh ./etc/scripts/install_command_line_tools.sh

brew: ## Install brew and run brew bundle
	@sh ./etc/scripts/homebrew_setup.sh

app_setup: ## Set up all applications
	@sh ./etc/scripts/fetch_secrets.sh </dev/tty
	@sh ./etc/scripts/gpg_setup.sh </dev/tty
	@sh ./etc/scripts/asdf_setup.sh </dev/tty
	@sh ./etc/scripts/code_setup.sh </dev/tty
	@sh ./etc/scripts/macos_setup.sh </dev/tty
	@sh ./etc/scripts/wifi_toggle_setup.sh </dev/tty

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

install: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

clean: ## Clean the symlinks
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)
	@echo 'Dotfiles cleaned'

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
