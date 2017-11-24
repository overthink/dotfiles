# FFS: http://unix.stackexchange.com/questions/10689/how-can-i-tell-if-im-in-a-tmux-session-from-a-bash-script
if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac


if [ -e /home/mark/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mark/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
