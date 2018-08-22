# vim: ft=sh
#
# The special hell of .profile, .bash_profile, .bashrc
#
# All info on the web on this topic can probably be replaced by the very
# concise https://github.com/0cjs/sedoc/blob/master/lang/bash/init.md
#
# Here are some true statements about bash config files:
#
# - .bash_profile || .profile is ALWAYS read for login shells
#    - whether interactive or not
# - .bashrc is NEVER read for login shells
#    - (IMO this is the basis for most bash config confusion)
#    - almost everyone "fixes" this by sourcing .bashrc from .*profile
# - ssh/remote connections add an additional dimension to test (see table
#   linked above)
#
# My strategy:
#
# - put as much as possible in .profile, as long as it's not bash-specific
#   - e.g. env vars
#   - sh(1) reads this too
# - put any bash-specific env var setup stuff in .bash_profile
# - source .profile from .bash_profile
# - source .bashrc from .bash_profile
# - put all bash-specific customization stuff in .bashrc, but exit immediately
#   if its non-interactive
#   - the early exit sniffs weird to me, since it seems like .bash_profile
#     would be a better place for config that should non run in non-interactive
#     mode
#   - probably the fact that you have to get a new login shell (in X this means
#     log out/in or reboot) to test changes to .bash_profile has motivated this
#
# Useful reading:
#
# - https://github.com/0cjs/sedoc/blob/master/lang/bash/init.md
# - https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html
# - https://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc

export PATH

add_path() {
  newpath="$1"
  if [ -d "$newpath" ]; then
    PATH="$newpath:$PATH"
  fi
}

add_path ~/bin
add_path ~/go/bin
add_path ~/.cargo/bin
add_path ~/nim-0.17.2/bin
add_path ~/.nimble/bin
add_path ~/.cabal/bin

export EDITOR="vim"

if [ "$0" = "/usr/sbin/lightdm-session" ] && [ "$DESKTOP_SESSION" = "i3" ]; then
  export $(gnome-keyring-daemon -s)
fi

# shellcheck source=/dev/null
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

