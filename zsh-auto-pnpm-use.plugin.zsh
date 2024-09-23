autoload -Uz add-zsh-hook

load-pnpmrc() {
  if (( ! $+commands[pnpm] )); then
    return
  fi

  local global_node_version=$(node --version)
  global_node_version=${global_node_version/v/}

  # Need to be set before get it.
  # pnpm config set use-node-version $global_node_version
  # pnpm config set node-version ""

  local nvmrc_file=".nvmrc"
  local default_node_version=$(pnpm config get use-node-version)
  local local_node_version=$(pnpm config get node-version)

  if [[ -z "$local_node_version" && -f "$nvmrc_file" && -r "$nvmrc_file" ]]; then
    local_node_version=$(cat "$nvmrc_file")
  fi

  if [[ ! -z "$local_node_version" ]]; then
    echo "Node.js $local_node_version is activated"
    pnpm env use --global "$local_node_version" > /dev/null
    return
  fi

  if [[ "$global_node_version" != "$default_node_version" ]]; then
    echo "Reverting to default node version $default_node_version"
    pnpm env use --global "$default_node_version" > /dev/null
    return
  fi
}

auto-load-pnpmrc() {
  local current_dir=$(pwd -P)

  if [[ "$current_dir" != "$PREV_PWD" ]]; then
    PREV_PWD="$current_dir"
    load-pnpmrc
  fi
}

add-zsh-hook precmd auto-load-pnpmrc
