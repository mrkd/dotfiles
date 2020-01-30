# Add `~/bin` to the `$PATH`
PATH="$HOME/bin:$PATH";

# Fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

echo '.bash_profile'
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

if [ -f ~/.profile ]; then
   source ~/.profile
fi

# Docker

## docker-compose
alias ddb='docker-compose down && docker-compose build'

## Docker Cleanup
function docker-cleanup {
    docker rm $(docker ps -a -q);
    docker rmi $(docker images | grep "^<none>" | awk '{print $3}');
}

# Android Home Setup
export ANDROID_HOME=~/Library/Android/sdk/

# Xcode
alias simDir="/Users/$(whoami)/Library/Developer/CoreSimulator/Devices/"
alias provisioningProfilesDir="~/Library/MobileDevice/Provisioning\ Profiles/"
## Xcode helper commands
if [ -f ~/.xcode_bash.sh ]; then
  source ~/.xcode_bash.sh
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;


source ~/.bashrc

export PATH
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
