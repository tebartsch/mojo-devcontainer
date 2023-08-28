. /etc/skel/.bashrc.original

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u @ \h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] 📦$(git_branch)\n\$ '
else
    PS1='\u @ \h:\w $(git_branch)\n\$ '
fi
