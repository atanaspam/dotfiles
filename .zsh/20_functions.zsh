
# docs:ignore
function aliases() {
    printf "💡 Aliases:\n" 
    grep -E '^## .*$$' ~/.zsh/30_aliases.zsh \
    | sort \
    | awk 'BEGIN {FS = ": "}; {printf "\033[36m%-30s\033[0m %s\n", $1, $2}'
    printf "💡 Functions:\n"
    grep -E '^## .*$$' ~/.zsh/20_functions.zsh \
    | sort \
    | awk 'BEGIN {FS = ": "}; {printf "\033[36m%-30s\033[0m %s\n", $1, $2}'
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

## urlencode: url encode the input passed in stdin
function urlencode {
    python3 -c "import sys, urllib.parse as ul; print (ul.quote_plus(sys.stdin.read()[:-1]))"
}


## urldecode: url decode the input passed in stdin
function urldecode {
	python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()), end='')"
}

## checkip: Show current ip addresses
function checkip() {
    local wifi=$(ipconfig getifaddr $(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2}'))
    local docking_station=$(ipconfig getifaddr $(networksetup -listallhardwareports | awk '/Hardware Port: Thunderbolt Ethernet Slot 2/{getline; print $2}'))
    local public=$(curl http://checkip.amazonaws.com)
    printf "💡 IP Addresses:\n"
    printf "🛜 ${wifi}\n"
    printf "🔌 ${docking_station}\n"
    printf "🌍🔌 ${public}\n"
}

## dynamodb: Spins up and down a local DynamoDB instance
dynamodb() {
    if [ "$1" = "up" ]; then
        current_status=$(docker compose -f ~/bin/local-dynamodb-docker-compose.yml ps --format json | jq '.[].State')
        if [ "$current_status" = '"running"' ]; then
            export DYNAMO_ENDPOINT=http://localhost:8000
            echo "DynamoDB is already running. DYNAMO_ENDPOINT еnv var is now set to "http://localhost:8000""
        else 
            docker compose -f ~/bin/local-dynamodb-docker-compose.yml $1 --detach
            export DYNAMO_ENDPOINT=http://localhost:8000
            echo "DynamoDB is now available at http://localhost:8000"
            echo "DynamoDB Admin is available at http://localhost:8001"
        fi
    elif [ "$1" = "down" ]; then
        docker compose -f ~/bin/local-dynamodb-docker-compose.yml $1
        echo "DynamoDB has been stopped"
    else
        echo "Usage: $funcstack[1] <up/down>"

    fi
}

## openjira: Open the specified jira key in the browser
openjira() {
    if [ $# -lt 1 ]
    then
        echo "Usage: $funcstack[1] <jira key>"
        return
    fi
    open "https://jumbo-supermarkten.atlassian.net/browse/$1"
}

## loadenv: Load the contents of the .env in the current directory into the shell session
function loadenv() {
    if [ -f .env ]; then
        env_vars=$(sed -n 's/export \([^=]*\)=.*/\1/p' .env | tr '\n' ' ')
        source .env
        echo "Loaded $env_vars"
    else
        echo 'No .env file found' 1>&2
        return 1
    fi
}

## secret: Encrypt the contents of the input file. Usage: secret <input_file_name>
secret () {
        output=~/"${1}".$(date +%s).enc
        gpg --encrypt --armor --output ${output} -r 0x0000 -r 0x0001 -r 0x0002 "${1}" && echo "${1} -> ${output}"
}

## reveal: Decrypt the contents of the input file. Usage: reveal <input_file_name>
reveal () {
        output=$(echo "${1}" | rev | cut -c16- | rev)
        gpg --decrypt --output ${output} "${1}" && echo "${1} -> ${output}"
}

# docs:ignore
function _init_gpg_ssh_agent {
  export GPG_TTY=$(tty)
  unset SSH_AGENT_PID
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  echo UPDATESTARTUPTTY | gpg-connect-agent > /dev/null
}