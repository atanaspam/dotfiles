# dotfiles

As many dotfiles as I could automate with reasonable effort.

My approach uses a makefile which invokes small scripts that take care of various different parts of the setup process. The scripts are idempotent, but not in a perfect way. It's just too much effort given how rarely this will be used.


## Capabilities

* Install XCode command line tools
* Install brew itself and packages defined in the `Brewfile`
* Fetch secrets from Bitwarden (GPG public key, Spotify credentials)
* Setup GPG by importing the public key and configuring trust
* Setup new SSH key to be used for GitHub
* Configure VS Code plugins
* Configure basic MacOS settings
* Configure zsh environment using `zinit`
* Symlink all folders and files starting with `.` to the home directory. (with a few exceptions)
* Automatically toggle Wi-Fi off/on based on ethernet connection status (via launchd)

### Batteries included
My dotfiles roughly contain the following goodies

* Helper functions in `.zsh/25_functions.zsh`
* Aliases in `.zsh/30_aliases.zsh`
* DevOps related terminal plugins setup using zinit
* Completions for a few tools
* Pre-configured P10K prompt

## How to use

### Pre-run checklist
1. Make sure the following secrets exist in Bitwarden:
   - An item named `GPG` with:
     - An attachment whose filename starts with `gpg` (your public key)
     - A custom field named `KeyId` containing your GPG key ID
   - An item named `Spotify` with custom fields `Client ID` and `Client Secret`
2. Download the repo to a location that you won't accidentally delete. For me that's:
```bash
mkdir ~/projects
# Git clone this repo or download its contents from the github UI
cd ~/projects && git clone git@github.com:atanaspam/dotfiles.git
```

Afterwards just do:
```bash
cd dotfiles
make help
make all
```

> **Note:** If XCode command line tools are not installed, `make all` will launch the installer and exit. Complete the installation, then re-run `make all`.

> **Note:** `fetch_secrets.sh` will interactively ask whether to connect to Bitwarden. You can skip it and run the script manually later.


## Ignore files
You can ignore files on a single machine by doing:
```
git update-index --assume-unchanged Brewfile
```
