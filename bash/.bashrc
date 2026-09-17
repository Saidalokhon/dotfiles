#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Helper functions
# OpenConnect - connect to Georgia Institute of Technology VPN
gaconn() {
    sudo openconnect \
        --protocol=gp \
        --background \
        --user="ssaydakhmedov3" \
        --authgroup="DC Gateway" \
        vpn.gatech.edu
}

# Documents all defined functions
explain() {
    echo "gaconn - connect to Georgia Institute of Technology VPN"
}
