# zsh-auto-pnpm-use

`zsh-auto-pnpm-use` is a Zsh plugin that automatically loads the Node.js version specified in your project using `.nvmrc` or `.npmrc` files. It works with [PNPM](https://pnpm.io/), but requires a specific installation method and some initial setup.

## Requirements

1. **Uninstall all other Node.js version managers**
  - Remove NVM, Volta, or any other Node.js version manager from your system. This plugin only works with PNPM's built-in Node.js version management.
  - Make sure you do not have conflicting Node.js installations or environment variables.

2. **Install PNPM using the official curl script**
  - You must install PNPM using the method below. Other installation methods (like Homebrew or npm) do not support Node.js version management with `pnpm env use`.
  - Run this command in your terminal:

    ```sh
    curl -fsSL https://get.pnpm.io/install.sh | sh -
    ```

  - For more details, see the [PNPM installation guide](https://pnpm.io/installation).

3. **Restart your terminal**
  - After installing PNPM, close and reopen your terminal to ensure the `pnpm` command is available.

## Plugin Installation

1. **Clone the plugin into your Oh My Zsh custom plugins directory:**

  ```sh
  git clone https://github.com/brunomacedo/zsh-auto-pnpm-use ~/.oh-my-zsh/custom/plugins/zsh-auto-pnpm-use
  ```

2. **Enable the plugin in your `.zshrc` file:**

  Open your `~/.zshrc` and add `zsh-auto-pnpm-use` to the `plugins` list:

  ```sh
  plugins=(
    # other plugins
    zsh-auto-pnpm-use
  )
  ```

3. **Reload your Zsh configuration:**

  ```sh
  source ~/.zshrc
  ```

## First Time Setup

On the first terminal session after installing the plugin, the PNPM configuration for Node.js versions may not exist yet. Initialize it manually:

1. **Set PNPM's default Node.js version (the plugin uses `default-node-version`):**

  ```sh
  pnpm config set default-node-version "$(node --version)"
  ```

2. **Open a new terminal or run `source ~/.zshrc` again.**

## How It Works

When you enter a directory, the plugin checks for a `.nvmrc` file:

- If `.nvmrc` exists, it uses the Node.js version specified in that file.
- If no `.nvmrc` is present, it falls back to PNPM's `default-node-version` setting.

Note: the plugin currently does not parse `node-version` from `.npmrc` files.

### Example `.nvmrc` file:

```
25.7.0
```

## Troubleshooting

- Make sure you do not have NVM or other Node.js managers installed.
- Only the PNPM installed via the official curl script supports Node.js version management.
- If you see errors about missing Node.js versions, check your `.nvmrc` file and your PNPM config.

## Uninstalling

To remove the plugin, delete the plugin directory and remove it from your `.zshrc` plugins list.

---

For more information, see the [PNPM documentation](https://pnpm.io/).
