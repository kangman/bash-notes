#/usr/local/bin/env bats

curl -sLI -w "%{http_code}\\n" "http://www.google.com" -o /dev/null
