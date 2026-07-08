autoload -Uz add-zsh-hook

# Remembers the "default" (system) Node.js version for the current shell
# session. We no longer rely on `pnpm config set/get default-node-version`
# because pnpm stopped accepting that key in the global config.yaml (and it
# is not a documented/supported pnpm-workspace.yaml key either) — see
# https://pnpm.io/settings. Using a plain shell variable avoids the
# "ERR_PNPM_CONFIG_SET_UNSUPPORTED_YAML_CONFIG_KEY" warning entirely.
typeset -g AUTO_PNPM_DEFAULT_NODE_VERSION=""

load-pnpmrc() {
  if (( ! $+commands[pnpm] )); then
    return
  fi

  local global_node_version=$(node --version)
  global_node_version=${global_node_version/v/}

  if [[ -z "$AUTO_PNPM_DEFAULT_NODE_VERSION" ]]; then
    AUTO_PNPM_DEFAULT_NODE_VERSION="$global_node_version"
  fi

  local nvmrc_file=".nvmrc"
  local default_node_version="$AUTO_PNPM_DEFAULT_NODE_VERSION"
  local local_node_version=""

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
