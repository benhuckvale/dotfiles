
# Finders
alias g="grep --exclude-dir=.svn --exclude-dir=.git --exclude-dir=_dep_files --exclude-dir='venv*' --exclude-dir='.venv*' --color=auto -nriI"

# Git conveniences
alias gl="git log --pretty=\"%C(Yellow)%h %C(Cyan)%an%C(Red)%d %C(reset)%s\""
alias gs="git status"
alias gdc="git diff --cached"
alias gd="git diff"
alias vall="vim \$(git status --porcelain -uno | grep -v '^ D' | sed -e 's/^...//')"

