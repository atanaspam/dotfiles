source "$(asdf where gcloud)/completion.zsh.inc"

# HashiCorp tools - use asdf shim path so completions work across version upgrades
complete -o nospace -C $ASDF_DATA_DIR/shims/terraform terraform
complete -o nospace -C $ASDF_DATA_DIR/shims/packer packer
complete -o nospace -C $ASDF_DATA_DIR/shims/vault vault
