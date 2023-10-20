
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

## urlencode: url encode the input passed in stdin
function urlencode {
	python -c "import sys; from urllib.parse import quote_plus; print(quote_plus(sys.stdin.read()))"
}


## urldecode: url decode the input passed in stdin
function urldecode {
	python -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()), end='')"
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