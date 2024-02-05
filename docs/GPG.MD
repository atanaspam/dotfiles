# GPG Setup
Some personal notes on the GPG setup used in this repo.

## Key generation
The keys are created by following this amazing guide: https://github.com/drduh/YubiKey-Guide
I generated an extra subkey for Git signing which is different from the standard set of keys.
Rougly I followed the steps described below:

1. As part of standard key creation process create a new signing key
2. Note the key ID for yur key intended for git
3. Export key using `gpg --armor --export-secret-subkeys <key_id>! > git.asc`
4. Create a new gpg workspace 
```bash
mkdir ~/.gnupg.1
cd  ~/.gnupg.1
wget wget https://raw.githubusercontent.com/drduh/config/master/gpg.conf
```
1. Import Git subkey in new gpg workspace. Authenticate with the master key for your maing PGP Key
```bash
gpg --homedir ~/.gnupg.1 --import github.asc
```
2. Edit the key in the new workspace: 
```bash
gpg --homedir ~/.gnupg.1 --edit-key
```bash
  * Type `passwd`
  * Set new password that is easier to type daily as you sign your git commits
3. Export the key with new password: 
```bash
gpg --homedir ~/.gnupg.1 --armor --export-secret-subkeys <key_id>! > github_new.asc
```
4. Re-import the new key into your main keychain (now the key has a more "managable" password)
```bash
gpg --import github_new.asc
```

## Key Installation
Since I have a yubikey (that I don't want to use for sgning my commits) I have to follow a fairly complicated set of steps when I configure GPG on a new computer. I actually have multiple yubikeys which makes this even more complicated :(


## Git Config
I couldnt figure out a way to dynamically set the signing key id yet.
Perhaps running a git config command every time?
The signing key referenced in the git config should end with an exclamation mark.
https://stackoverflow.com/a/48240076