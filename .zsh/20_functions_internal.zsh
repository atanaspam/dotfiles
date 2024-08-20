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

function _profile_to_account_id() {
  if [ $# -ne 1 ]; then
    echo "Usage: $funcstack[1] <profile>"
    return
  fi
  aws sts get-caller-identity --profile $1 --output json | jq -r '.Account'
}

function _ecrauth () {
  if [ $# -ne 2 ]; then
    echo "Usage $funcstack[1] <region> <profile>"
    exit 1
  fi
  account_id=$(_profile_to_account_id $2)
  aws ecr get-login-password --region $1 --profile $2 | docker login --username AWS --password-stdin $account_id.dkr.ecr.$1.amazonaws.com
}

