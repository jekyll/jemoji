#!/bin/bash
set -e

echo "Rubocop $(bundle exec rubocop --version)"
bundle exec rubocop -S -D -E $@
success=$?
if ((success != 0)); then
   echo -e "\nTry running \`script/fmt -a\` to automatically fix errors"
fi
exit $success
