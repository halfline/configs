# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

[ -f /usr/share/doc/git-1.8.0/contrib/completion/git-completion.sh ] && . /usr/share/doc/git-1.8.0/contrib/completion/git-completion.sh
[ -f /usr/share/doc/git-1.8.0/contrib/completion/git-prompt.sh ] && . /usr/share/doc/git-1.8.0/contrib/completion/git-prompt.sh
[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && . /usr/share/git-core/contrib/completion/git-prompt.sh
[ -f /usr/share/git-core/contrib/completion/git-completion.sh ] && . /usr/share/git-core/contrib/completion/git-completion.sh

function localrpm
{
    rpmbuild -bb *.spec --define "_sourcedir $PWD" --define "_builddir $PWD" --define "_specdir $PWD" --define "_rpmdir $PWD"
}

function scratch-get
{
    wget -e robots=off -nd -np -r -A .$(uname -i).rpm,.noarch.rpm \
         http://koji.fedoraproject.org/scratch/$1/task_$2/
}

function off
{
    sudo sh -c "echo 's' > /proc/sysrq-trigger; echo 'u' > /proc/sysrq-trigger; echo 'o' > /proc/sysrq-trigger"
}

function cd
{
    if [ $# -eq 0 ]; then
        pushd ~ > /dev/null
    elif [ " $1" = " -" ]; then
        pushd "$OLDPWD" > /dev/null
    else
        pushd "$@" > /dev/null
    fi
}
CFLAGS="-ggdb3 -O0 -Wno-deprecated -UG_DISABLE_DEPRECATED -Wall -fstack-protector --param=ssp-buffer-size=4 -Wno-error -fasynchronous-unwind-tables -fno-omit-frame-pointer -rdynamic -fno-inline -Wno-cpp -Wempty-body -fPIC -UG_DISABLE_CAST_CHECKS -Wno-error"
CXXFLAGS="$CFLAGS"
MAKEFLAGS="-j$(($(getconf _NPROCESSORS_ONLN)))"
export CFLAGS CXXFLAGS PS1 MAKEFLAGS

alias %meson="meson build --prefix=/usr --sysconfdir=/etc --localstatedir=/var --mandir=/usr/share/man --infodir=/usr/share/info --libdir=/usr/lib64"
alias %configure="./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --mandir=/usr/share/man --infodir=/usr/share/info --libdir=/usr/lib64"
alias %autogen.sh="./autogen.sh --prefix=/usr --sysconfdir=/etc --localstatedir=/var --mandir=/usr/share/man --infodir=/usr/share/info --libdir=/usr/lib64"
export G_SLICE=always-malloc
alias less="less -R"
export EDITOR=vim

export HISTFILESIZE=8000000
export HISTSIZE=1000000
export HISTTIMEFORMAT="%Y.%m.%d@%H:%M:%S "

export G_MESSAGES_PREFIXED=error,criticals
export PROMPT_COMMAND="find .git -name index -maxdepth 1 -cmin +10 -exec touch {} \; git fetch origin \; 2> /dev/null"
PS1='\r$(__git_ps1 "\n╎[32m%s[0m")\n╎[32m\u[37m@[31m\h[0m〉⎛[34m$(pwd)[0m⎞ ⌜[33m\@[0m⌟\n'
PS1=$PS1'╎❯ '

export PATH=~/bin:$PATH
