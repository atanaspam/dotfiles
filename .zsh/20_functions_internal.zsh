# docs:ignore
function _init_gpg_ssh_agent {
  export GPG_TTY=$(tty)
  unset SSH_AGENT_PID
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  echo UPDATESTARTUPTTY | gpg-connect-agent > /dev/null
}

# docs:ignore
function check_for_pre_commit() {
  find ./.git/hooks -type f ! -name "*.sample" | grep . > /dev/null
  hooks_exist=$?
  find . -type f -name ".pre-commit-config.yaml" | grep . > /dev/null
  pre_commit_file_exists=$?

  if [[ $pre_commit_file_exists -eq 0 && $hooks_exist -ne 0 ]]; then
    YELLOW='\x1b[33m'
    RESET='\x1b[39m'
    WHITE='\x1b[37m'
    echo "$(tput bold)${YELLOW}Detected missing hooks.$(tput sgr0) Consider running $(tput bold)pre-commit install${RESET}"
  fi
}
