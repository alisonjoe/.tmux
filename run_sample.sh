#!/bin/sh

#set -x
cmd=$(which tmux) # tmux path
session=codefun # session name
dev_session='DEVELOP'


if [ -z $cmd ]; then
echo "You need to install tmux."
exit 1
fi

function godev() {
    tmux send-keys -t $dev_session:1 'source ~/.bashrc' C-m
}


$cmd has -t $dev_session 
if [ $? == 0 ]; then
    echo "$cmd has session -s "$dev_session
    $cmd at -d -t $dev_session
else
    echo "$cmd not have session: "$dev_session
    $cmd -2 new-session -d -s $dev_session -n SRC
    godev
fi

tmux select-window -t $dev_session:1
tmux attach-session -t $dev_session
