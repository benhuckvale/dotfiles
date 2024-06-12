# Function to get the current git branch
git_branch() {
    echo $(git rev-parse --abbrev-ref HEAD)
}

# Function to get counts of staged, unstaged, and untracked files
ps1_git_branch() {
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        # Count staged files and trim leading spaces
        staged_count=$(git diff --cached --name-only | wc -l | awk '{print $1}')

        # Count unstaged files and trim leading spaces
        unstaged_count=$(git diff --name-only | wc -l | awk '{print $1}')

        # Count untracked files and trim leading spaces
        untracked_count=$(git ls-files --others --exclude-standard | wc -l | awk '{print $1}')

        # Get current branch name
        branch_name=$(git rev-parse --abbrev-ref HEAD)

        # Output branch name and counts in specified format
        echo "(${branch_name} ${Green}${staged_count}${NoColour}/${unstaged_count}/${Red}${untracked_count}${NoColour})"
    fi
}

# Simple prompt with only the time
simple_ps1 () {
    export PS1='${BGreen}[%*]$ ${NoColour}'
}

# Advanced prompt with the current directory and git branch
advanced_ps1() {
    # Note, use '' not "", otherwise functions are not executed every time
    export PS1='${Yellow}%n@${Cyan}%m:${BGreen}%~${Purple} $(ps1_git_branch)${NoColour} ${BGreen}
[%*]$ ${NoColour}'
}

setopt PROMPT_SUBST
advanced_ps1
