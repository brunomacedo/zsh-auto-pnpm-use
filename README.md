# zsh-auto-pnpm-use

`zsh-auto-pnpm-use` is a zsh plugin that automatically loads the node version specified in `.nvmrc` or `.npmrc`.

> `.nvmrc` example:

```shell
18.16.0
```

or

> `.npmrc` example:

```shell
node-version=18.16.0
```

## Installation

### As an [Oh My ZSH!](https://github.com/robbyrussell/oh-my-zsh) custom plugin
Clone `zsh-auto-pnpm-use` into your custom plugins repo.

```shell
git clone https://github.com/brunomacedo/zsh-auto-pnpm-use ~/.oh-my-zsh/custom/plugins/zsh-auto-pnpm-use
```

Then load as a plugin in your `.zshrc`

```shell
plugins=(
  # git
  # zsh-autosuggestions
  zsh-auto-pnpm-use
)
```
