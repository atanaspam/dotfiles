
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

## localip: Show local ip
function localip() {
    local wifi=$(ipconfig getifaddr en0)
    local docking_station=$(ipconfig getifaddr en7)
    printf "💡 IP Addresses:\n"
    printf "🛜 ${wifi}\n"
    printf "🔌 ${docking_station}\n"
}

## dynamodb: Controls the local dynamodb instance
dynamodb() {
    if [ $# -lt 1 ]
    then
        echo "Usage: $funcstack[1] <up/down>"
        return
    fi

    docker compose -f ~/bin/local-dynamodb-docker-compose.yml $1 --detach
    echo "Dynamodb is now available at http://localhost:8000"
    echo "You might want to run export DYNAMO_ENDPOINT=http://localhost:8000 and use dynamodb-admin"
}

## openjira Open the specified jira key in the browser
openjira() {
    if [ $# -lt 1 ]
    then
        echo "Usage: $funcstack[1] <jira key>"
        return
    fi
    open "https://jumbo-supermarkten.atlassian.net/browse/$1"
}
