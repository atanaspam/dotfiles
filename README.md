# dotfiles

As many dotfiles as I could automate with reasonable effort.

My approach uses a makefile which invokes small scripts that take care of various different parts of the setup process. The scripts are idempotent, but not in a perfect way. It's just too much effort given how rarely this will be used. 


## How to use

### Pre-run checklist
1. Generate a new GPG subkey and store it in Bitwrden
2. 

```bash
cd dotfiles
make help
make all
```

## Capabilities

* Install XCode command line tools
* Install brew itself and packages defined in Brewfile
* Download PGP key for github from bitwarden (opinionated)
* Setup new SSH key to be used for GitHub
* Configure VS Code plugins
* Configure basic MacOS settings
* Symlink all dotfiles at the root of this repo