#!/bin/sh
# Fix ownership of mounted volumes so agent user can write to them
if [ "$(stat -c '%u' /home/agent/.opencode)" != "999" ]; then
    chown -R agent:agent /home/agent/.opencode
fi

if [ -d /home/agent/.local/share/opencode ]; then
    chown -R agent:agent /home/agent/.local/share/opencode
fi

if [ -d /home/agent/.config/opencode ]; then
    chmod -R a+rw /home/agent/.config/opencode
    find /home/agent/.config/opencode -type d -exec chmod a+rwx {} +
fi

exec gosu agent "$@"
