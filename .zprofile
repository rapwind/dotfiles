if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

export EDITOR='vi'
export VISUAL='vi'
export PAGER='less'

if [[ -z "$LANG" ]]; then
  export LANG='ja_JP.UTF-8'
fi

typeset -gU cdpath fpath mailpath path

path=(
  /usr/local/{bin,sbin}
  $path
)

export LESS='-F -g -i -M -R -S -w -X -z-4'

if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
