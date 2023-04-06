mkdir -pv /etc/skel

cat > /root/.bashrc << "EOF"
###############################
#    YOCTO DEFAULT .BASHRC    #
###############################

## Colors

Black='\[\e[0;30m\]'    # Black
Red='\[\e[0;31m\]'      # Red
Green='\[\e[0;32m\]'    # Green
Yellow='\[\e[0;33m\]'   # Yellow
Blue='\[\e[0;34m\]'     # Blue
Purple='\[\e[0;35m\]'   # Purple
Cyan='\[\e[0;36m\]'     # Cyan
White='\[\e[0;37m\]'    # White

# Bold
BBlack='\[\e[1;30m\]'   # Black
BRed='\[\e[1;31m\]'     # Red
BGreen='\[\e[1;32m\]'   # Green
BYellow='\[\e[1;33m\]'  # Yellow
BBlue='\[\e[1;34m\]'    # Blue
BPurple='\[\e[1;35m\]'  # Purple
BCyan='\[\e[1;36m\]'    # Cyan
BWhite='\[\e[1;37m\]'   # White

# Background
On_Black='\[\e[40m\]'   # Black
On_Red='\[\e[41m\]'     # Red
On_Green='\[\e[42m\]'   # Green
On_Yellow='\[\e[43m\]'  # Yellow
On_Blue='\[\e[44m\]'    # Blue
On_Purple='\[\e[45m\]'  # Purple
On_Cyan='\[\e[46m\]'    # Cyan
On_White='\[\e[47m\]'   # White

NC='\[\e[m\]'                   # Color Reset

ALERT="${BWhite}${On_Red}" # Bold White on red background

## Color commands
export LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'

PS1="${BRed}\u${Yellow}@${Cyan}\h${BPurple}: ${BRed}\w${Red} "'\$'" ${NC}"
EOF

cat > /root/.bash_profile << "EOF"
source $HOME/.bashrc
EOF

cat > /etc/skel/.bashrc << "EOF"
###############################
#    YOCTO DEFAULT .BASHRC    #
###############################

## Variables for colors

Black='\[\e[0;30m\]'    # Black
Red='\[\e[0;31m\]'      # Red
Green='\[\e[0;32m\]'    # Green
Yellow='\[\e[0;33m\]'   # Yellow
Blue='\[\e[0;34m\]'     # Blue
Purple='\[\e[0;35m\]'   # Purple
Cyan='\[\e[0;36m\]'     # Cyan
White='\[\e[0;37m\]'    # White

# Bold
BBlack='\[\e[1;30m\]'   # Black
BRed='\[\e[1;31m\]'     # Red
BGreen='\[\e[1;32m\]'   # Green
BYellow='\[\e[1;33m\]'  # Yellow
BBlue='\[\e[1;34m\]'    # Blue
BPurple='\[\e[1;35m\]'  # Purple
BCyan='\[\e[1;36m\]'    # Cyan
BWhite='\[\e[1;37m\]'   # White

# Background
On_Black='\[\e[40m\]'   # Black
On_Red='\[\e[41m\]'     # Red
On_Green='\[\e[42m\]'   # Green
On_Yellow='\[\e[43m\]'  # Yellow
On_Blue='\[\e[44m\]'    # Blue
On_Purple='\[\e[45m\]'  # Purple
On_Cyan='\[\e[46m\]'    # Cyan
On_White='\[\e[47m\]'   # White

NC='\[\e[m\]'                   # Color Reset

ALERT="${BWhite}${On_Red}" # Bold White on red background

## Include private user bin directories in PATH
PATH="${HOME}/bin:${HOME}/.local/bin:${PATH}"

## Color commands
export LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'

## Set the prompt
PS1="${Yellow}\u${BRed}@${Cyan}\h${BPurple}: ${BBlue}\w ${Green}"'\$'" ${NC}"

EOF

cat > /etc/skel/.bash_profile << "EOF"
source $HOME/.bashrc
EOF

cat > /root/.zshrc << "EOF"
##############################
#    YOCTO DEFAULT .ZSHRC    #
##############################

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

## Colors

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
Black='\e[1;30m'       # Black
Red='\e[1;31m'         # Red
Green='\e[1;32m'       # Green
Yellow='\e[1;33m'      # Yellow
Blue='\e[1;34m'        # Blue
Purple='\e[1;35m'      # Purple
Cyan='\e[1;36m'        # Cyan
White='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[0m"              # Color Reset

ALERT="${BWhite}${On_Red}" # Bold White on red background

## Color commands
export LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'

PROMPT=$'[\e[1;31m%n\e[0;33m@\e[0;36m%m\e[1;35m:\e[1;31m%~\e[0m]\e[0;31m # \e[0m'
EOF

cat > /root/.zprofile << "EOF"
source $HOME/.zshrc
EOF

cat > /etc/skel/.zshrc << "EOF"
##############################
#    YOCTO DEFAULT .ZSHRC    #
##############################

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

## Variables for colors

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

ALERT="${BWhite}${On_Red}" # Bold White on red background

## Include private user bin directories in PATH
PATH="${HOME}/bin:${HOME}/.local/bin:${PATH}"

## Color commands
export LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'

## Set the prompt
PROMPT=$'[\e[0;33m%n\e[1;31m@\e[0;36m%m\e[1;35m:\e[1;34m%~\e[0m]\e[0;32m $ \e[0m'
EOF

cat > /etc/skel/.zprofile << "EOF"
source $HOME/.zshrc
EOF

cp /etc/skel/.bashrc /home/ydu/.bashrc
cp /etc/skel/.bash_profile /home/ydu/.bash_profile
cp /etc/skel/.zshrc /home/ydu/.zshrc
cp /etc/skel/.zprofile /home/ydu/.zprofile
