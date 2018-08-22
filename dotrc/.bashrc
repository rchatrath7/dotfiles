
# load dev, but only if present and the shell is interactive
if [[ -f /opt/dev/dev.sh ]] && [[ $- == *i* ]]; then
  source /opt/dev/dev.sh
fi

export JAVA_HOME=`/usr/libexec/java_home -v 1.8`


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
