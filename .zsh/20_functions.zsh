
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