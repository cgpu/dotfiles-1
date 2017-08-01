## -----------------------
## Aliases
## -----------------------
  eval "$(thefuck --alias)"

 # Listing, directories, and motion
 alias ls="ls --color"
 alias ll="ls -alrtF --color"
 alias la="ls -A --color"
 alias l="ls -CF --color"
 alias dir='ls --color=auto --format=vertical'
 alias vdir='ls --color=auto --format=long'
 alias m='less'
 alias ..='cd ..'
 alias ...='cd ..;cd ..'
 alias md='mkdir'
 alias cl='clear'
 alias du='du -ch --max-depth=1'

 # Text and editor commands
 alias sus="sort | uniq -c | sort -k1 -rn"
 alias coldiff='colordiff -W 180 --suppress-common-lines -d -y'

 # Better defaults for common commands
 alias emacs='emacs -nw'
 alias ackx="ack -vg '.*migrations.*|.*log|.*json|.*yaml|.*sql' | ack -x"
 alias ackv="ack --ignore-dir vendor --ignore-dir work --ignore-dir .glide --ignore-dir .ensime_cache --ignore-dir target"
 
## -----------------------
## Colors
## -----------------------

 # Grep colors
 export GREP_OPTIONS='--color=auto' #default grep colorization
 export GREP_COLOR='1;31'  #sets color to green

 # LS colors (dircolors ~/.dircolors.conf)
 # 00;30;1 = dark black/bold
 # 00;31;1 = red
 # 00;32;1 = green
 # 00;33;1 = yellow
 # 00;34;1 = dark blue (directory color)
 # 00;35;1 = magenta
 # 00;36;1 = light blue
 # 00;37;1 = gray (this is what we want for .pyc, etc. files)
 # 00;38;1 = light blue

 LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;
31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:*.do=00;35:*Makefile=00;35:*.o=00;37;1:*.pyc=00;37;1:*~=00;37;1:*.tmp=00;37;1:*.redo*=00;37:*TAGS=00;37;1:*.pyo=00;37;1:*.DS_Store=00;37;1"

 # Colorized pygments (sudo easy_install pygments)
 alias less='LESSOPEN="|pygmentize -g %s" less -R'
