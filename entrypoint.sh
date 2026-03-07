#!/bin/sh
# Fix ownership of mounted .opencode volume so agent user can write to it
if [ "$(stat -c '%u' /home/agent/.opencode)" != "999" ]; then
    chown -R agent:agent /home/agent/.opencode
fi

exec gosu agent "$@"
