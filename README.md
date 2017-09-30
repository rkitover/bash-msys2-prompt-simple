# bash-msys2-prompt-simple

![how the prompt looks in a window](/screenshots/bash-msys2-prompt-simple-screenshot.png?raw=true)

This is a simple, lightweight, and nice looking bash prompt that runs quickly
even in very slow shells like MSys2 and Cygwin.

It's colorful and shows the git branch when in a git checkout, as well as the
last command exit status (checkmark for success and X mark for non-zero error.)

On MSys2 it also shows the current value of `$MSYSTEM`, that is either `MSYS`,
`MINGW32` or `MINGW64`.

It is also compatible with many versions of ksh.

It's based on the [Solarized
Extravagant](https://github.com/magicmonty/bash-git-prompt/blob/master/themes/Solarized_Extravagant.bgptheme)
theme in [bash-git-prompt](https://github.com/magicmonty/bash-git-prompt), but
it doesn't have any of the bash-git-prompt features except the git branch and
the nice colors.

Enjoy!

## installation

```shell
mkdir -p ~/src
cd ~/src
git clone https://github.com/rkitover/bash-msys2-prompt-simple.git
```

Somewhere in your `~/.bashrc` put something like this:

```bash
shopt -s checkwinsize
export PROMPT_COMMAND='history -a'
source ~/src/bash-msys2-prompt-simple/prompt.sh
```
