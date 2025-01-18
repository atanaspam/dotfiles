# dotfiles

As many dotfiles as I could automate with reasonable effort.

My approach uses a makefile which invokes small scripts that take care of various different parts of the setup process. The scripts are idempotent, but not in a perfect way. It's just too much effort given how rarely this will be used.


## Capabilities

* Install XCode command line tools
* Install brew itself and packages defined in the `Brewfile`
* Setup Gnupg with public and privatekey from bitwarden (opinionated)
* Setup new SSH key to be used for GitHub
* Configure VS Code plugins
* Configure basic MacOS settings
* Configure zsh environment using `zinit`
* Symlink all folders and files starting with `.` to the home directory. (with a few exceptions)

### Batteries included
My dotfiles roughly contain the following goodies

* Helper functions in `.zsh/20_functions.zsh`
* Aliases in `.zsh/30_aliases.zsh`
* DevOps related terminal plugins setup using zinit
* Complitions for a few tools
* Pre-configured PL10K prompt

## How to use

### Pre-run checklist
1. Make sure that a secret named `PGP` exists in bitwarden and contains at least two attachements
   1. Your public key in an attachent starting with `gpg`
   2. Your private key intened for signing github commits (opinioned) named after the key signature
2. Download the repo to a location that you won't accidentally delete ;) For me that's:
```bash
cd ~/projects && git clone git@github.com:atanaspam/dotfiles.git
```

Afterwords just do
```bash
cd dotfiles
make help
make all
```
## Ignore files
You can ignore files on a single machine by doing:
```
git update-index --asume-unchanged Brewfile
```
