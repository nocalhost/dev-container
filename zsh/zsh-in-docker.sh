#!/bin/sh
set -e

THEME=powerlevel10k/powerlevel10k
PLUGINS=""
ZSHRC_APPEND=""

while getopts ":t:p:a:" opt; do
    case ${opt} in
        t)  THEME=$OPTARG
            ;;
        p)  PLUGINS="${PLUGINS}$OPTARG "
            ;;
        a)  ZSHRC_APPEND="$ZSHRC_APPEND\n$OPTARG"
            ;;
        \?)
            echo "Invalid option: $OPTARG" 1>&2
            ;;
        :)
            echo "Invalid option: $OPTARG requires an argument" 1>&2
            ;;
    esac
done
shift $((OPTIND -1))

echo
echo "Installing Oh-My-Zsh with:"
echo "  THEME   = $THEME"
echo "  PLUGINS = $PLUGINS"
echo

zshrc_template() {
    _HOME=$1;
    _THEME=$2; shift; shift
    _PLUGINS=$*;

    cat <<EOM
export LANG='en_US.UTF-8'
export LANGUAGE='en_US:en'
export LC_ALL='en_US.UTF-8'
export TERM=xterm

##### Zsh/Oh-my-Zsh Configuration
export ZSH="$_HOME/.oh-my-zsh"

ZSH_THEME="${_THEME}"
plugins=($_PLUGINS)

EOM
    printf "$ZSHRC_APPEND"
    printf "\nsource \$ZSH/oh-my-zsh.sh\n"
}

powerline10k_config() {
    cat <<"EOM"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
EOM
}

powerline10k_config_end() {
    cat <<"EOM"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOM
}


cd /tmp

# Install On-My-Zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
   yes | sh -c "$(curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --unattended
fi

# Generate plugin list
plugin_list=""
for plugin in $PLUGINS; do
    if [ "`echo $plugin | grep -E '^http.*'`" != "" ]; then
        plugin_name=`basename $plugin`
        git clone $plugin $HOME/.oh-my-zsh/custom/plugins/$plugin_name
    else
        plugin_name=$plugin
    fi
    plugin_list="${plugin_list}$plugin_name "
done

# Handle themes
if [ "`echo $THEME | grep -E '^http.*'`" != "" ]; then
    theme_repo=`basename $THEME`
    THEME_DIR="$HOME/.oh-my-zsh/custom/themes/$theme_repo"
    git clone $THEME $THEME_DIR
    theme_name=`cd $THEME_DIR; ls *.zsh-theme | head -1`
    theme_name="${theme_name%.zsh-theme}"
    THEME="$theme_repo/$theme_name"
fi

echo "--THEME: $THEME"
echo

# Generate .zshrc
zshrc_template "$HOME" "$THEME" "$plugin_list" > $HOME/.zshrc

# Install powerlevel10k if no other theme was specified
if [ "$THEME" = "powerlevel10k/powerlevel10k" ]; then
    git clone https://github.com/romkatv/powerlevel10k $HOME/.oh-my-zsh/custom/themes/powerlevel10k
    powerline10k_config | cat - $HOME/.zshrc > temp && mv temp $HOME/.zshrc
    powerline10k_config_end >> $HOME/.zshrc
fi
