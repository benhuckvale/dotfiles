Dotfiles
========

File are as follows:

```
dotfiles/
├── zsh/
│   └── interactive/
│       ├── aliases.zsh
│       ├── env.zsh
│       ├── prompt.zsh
│       └── settings.zsh
├── zshrc
└── setup.zsh
```


How to use
----------


Clone this project, somewhere.
Then run:
```
setup.zsh
```

This will create a .zshrc if it doesn't exist, or otherwise move the existing
one aside, and then create a link named .zshrc which points to the zshrc file
in this project, wherever you have checked it out.
The zshrc in this project sources additional scripts in the `zsh/interactive`
directory to create a richer shell environment.

