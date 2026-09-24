#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias yay='yay --noconfirm'
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

# Print directory contents with its structure
printd() {
  local -a ignores=(obj bin .git "$@")
  local -a tree_args=()
  local -a find_expr=()
  local pattern

  for pattern in "${ignores[@]}"; do
    [[ -n "$pattern" ]] || continue

    tree_args+=(-I "$pattern")

    if ((${#find_expr[@]})); then
      find_expr+=(-o)
    fi

    find_expr+=(-name "$pattern")
  done

  printf 'Directory structure:\n'
  tree . -a "${tree_args[@]}"

  printf '\nFile contents:\n'
  find . \
    \( "${find_expr[@]}" \) -prune -o \
    -type f -exec sh -c '
            for file do
                printf "\n===== %s =====\n" "$file"

                if [ ! -s "$file" ] || LC_ALL=C grep -Iq . "$file"; then
                    cat -- "$file"
                else
                    printf "[binary file omitted]\n"
                fi
            done
        ' sh {} +
}

# Documents all defined functions
explain() {
  echo "gaconn - connect to Georgia Institute of Technology VPN"
  echo "printd - print directory structure and contents. First argument is a regex of files and directories to ignore."
}
