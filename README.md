# dotfiles

As many dotfiles as I could automate with reasonable effort.

My approach uses a makefile which invokes small scripts that take care of various different parts of the setup process. The scripts are idempotent, but not in a perfect way. It's just too much effort given how rarely this will be used. 

## How to use

```bash
cd dotfiles
make help
make all
```

## Capabilities

* Install XCode command line tools
* Install brew itself and packages defined in Brewfile
* Download SSH key for github from bitwarden (opinionated)
* Configure VS Code plugins
* Configure basic MacOS settings
* Symlink all dotfiles at the root of this repo