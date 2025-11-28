######################################################################################
#   _______  __   __  _______  _______  ______           ___      _______  _______   #
#  |       ||  | |  ||       ||       ||    _ |         |   |    |       ||       |  #
#  |  _____||  | |  ||    _  ||    ___||   | ||   ____  |   |    |    ___||   _   |  #
#  | |_____ |  |_|  ||   |_| ||   |___ |   |_||_ |____| |   |    |   |___ |  | |  |  #
#  |_____  ||       ||    ___||    ___||    __  |       |   |___ |    ___||  |_|  |  #
#   _____| ||       ||   |    |   |___ |   |  | |       |       ||   |___ |       |  #
#  |_______||_______||___|    |_______||___|  |_|       |_______||_______||_______|  #
#                                                                                    #
######################################################################################

# Se não for um bash interativo, não faz nada
[[ $- != *i* ]] && return

#      .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.      #
# `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.' #

						
#                              .d888 d8b                   
#                             d88P"  Y8P                   
#                             888                          
#    .d8888b .d88b.  88888b.  888888 888  .d88b.  .d8888b  
#   d88P"   d88""88b 888 "88b 888    888 d88P"88b 88K      
#   888     888  888 888  888 888    888 888  888 "Y8888b. 
#   Y88b.   Y88..88P 888  888 888    888 Y88b 888      X88 
#    "Y8888P "Y88P"  888  888 888    888  "Y88888  88888P' 
#                                             888          
#                                        Y8b d88P          
#                                         "Y88P"           

# Histórico
HISTSIZE=500
HISTFILESIZE=1000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=history:'man *':*-help:*-version:cls:clear

# Editor padrão
EDITOR=nvim

# Autocomplete aceita maiúsculas e minúsculas
bind 'set completion-ignore-case on'


#      .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.      #
# `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.' #


#           888 d8b                   
#           888 Y8P                   
#           888                       
#   8888b.  888 888  8888b.  .d8888b  
#      "88b 888 888     "88b 88K      
#  .d888888 888 888 .d888888 "Y8888b. 
#  888  888 888 888 888  888      X88 
#  "Y888888 888 888 "Y888888  88888P' 

# Comandos com cores
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias la='ls -la --color=auto'
alias li='ls -li --color=auto'
alias l1='ls -1 --color=auto'
alias ll='ls -l --color=auto'

# Encurtador de comandos
alias cls='clear'
alias bye='sudo shutdown -h now'
alias py='python3'

# Navegação
alias nn='cd "$(sfd)"'
alias np='pd "$(sfd)"'

#      .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.      #
# `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.' #


#  888      d8b               888          
#  888      Y8P               888          
#  888                        888          
#  88888b.  888 88888b.   .d88888 .d8888b  
#  888 "88b 888 888 "88b d88" 888 88K      
#  888  888 888 888  888 888  888 "Y8888b. 
#  888 d88P 888 888  888 Y88b 888      X88 
#  88888P"  888 888  888  "Y88888  88888P'  

# Ctrl + n => cd para diretorio escollhido com fzf a partir da $HOME,
#             para outros diretorios utilize ** e suas variações
bind '"\C-n":"nn;\C-m"'

# Alt + n => mesma função do Ctrl+n
bind '"\en":"nn;\C-m"'

# Alt + l => Abrir fzf comlista de diretorios a partir da $HOME
#            e insere na linha de comando
bind -x '"\el":"_inserir_diretorio"'
bind -x '"\ek":"_procurar_arquivo"'


#      .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.      #
# `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.' #


#   .d888                                     
#  d88P"                                      
#  888                                        
#  888888 888  888 88888b.   .d8888b .d8888b  
#  888    888  888 888 "88b d88P"    88K      
#  888    888  888 888  888 888      "Y8888b. 
#  888    Y88b 888 888  888 Y88b.         X88 
#  888     "Y88888 888  888  "Y8888P  88888P' 

# Criar um diretório e "entrar" nele
mkcd ()
{
	for folder in "$@"; do
		mkdir -p "$folder" &&
		cd "$folder"
	done
}

# Encurtador do comando nvim
vi()
{
	if [ $# -eq 0 ]; then
		nvim .
	else
		nvim $*
	fi
}

# Facilitar pushd e popd (manipular stack de diretórios)
pd()
{
	if [ $# -eq 0 ]; then
		popd > /dev/null
	elif [[ "$1" =~ ^[0-9]+$ ]]; then
		pushd +"$1" > /dev/null
	else
		pushd "$1" > /dev/null
	fi
	dirs -v
}

# Definir o título do terminal através de sequencia de escape
titulo()
{
	printf "\033]0;$1\007":
}

# Procurar diretórios (a partir do parametro ou da home)
sfd()
{
    local root_search found

    if [ $# -eq 0 ]; then
        root_search="$HOME"
    else
        root_search="$1"
    fi
    found=$(fd . "$root_search" -td | sed 's/.$//' | fzf --prompt="Escolha o diretorio > ")
    echo -n "$found"    
}

# Procurar arquivos (a partir do parametro ou da home)
sfl()
{
    local root_search found

    if [ $# -eq 0 ]; then
        root_search="$HOME"
    else
        root_search="$1"
    fi
    found=$(fd . "$root_search" -tf | fzf --prompt="Escolha o arquivo > ")
    echo -n "$found"    
}

# Função chamada pela bind, busca um diretório a partir da $HOME e insere na linha de comando
_inserir_diretorio()
{
	local dir
	dir=$(sfd)
	READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}$dir${READLINE_LINE:READLINE_POINT}"
    READLINE_POINT=$(( READLINE_POINT + ${#dir} ))
}

# Função chamada pela bind, busca um arquivo em um diretório a partir da $HOME e insere na linha de comando
_procurar_arquivo()
{
	local fil
	fil=$(sfl)
	READLINE_LINE="${READLINE_LINE:0:READLINE_POINT}$fil${READLINE_LINE:READLINE_POINT}"
    READLINE_POINT=$(( READLINE_POINT + ${#fil} ))
}

#      .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.      #
# `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.' #


#  888  888  8888b.  888d888 .d8888b  
#  888  888     "88b 888P"   88K      
#  Y88  88P .d888888 888     "Y8888b. 
#   Y8bd8P  888  888 888          X88 
#    Y88P   "Y888888 888      88888P' 

# Cores (usadas no PS1)
RED='\[\e[31;1m\]'
GREEN='\[\e[92;1m\]'
YELLOW='\[\e[93;1m\]'
BLUE='\[\e[94;1m\]'
MAGENTA='\[\e[95;1m\]'
CYAN='\[\e[96;1m\]'
RESET='\[\e[0m\]'

#      .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.      #
# `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.' #


#                                                  888    
#                                                  888    
#                                                  888    
#  88888b.  888d888 .d88b.  88888b.d88b.  88888b.  888888 
#  888 "88b 888P"  d88""88b 888 "888 "88b 888 "88b 888    
#  888  888 888    888  888 888  888  888 888  888 888    
#  888 d88P 888    Y88..88P 888  888  888 888 d88P Y88b.  
#  88888P"  888     "Y88P"  888  888  888 88888P"   "Y888 
#  888                                    888             
#  888                                    888             
#  888                                    888             

# Deixar vazio para desabilitar o padrao
PROMPT_COMMAND=

# PS1
PS1="${BLUE} \t » Exit Status: \$? \n\n${RESET}${GREEN}┌[ ${CYAN}\u ${RESET}@ ${MAGENTA}\h ${GREEN}]-[ ${YELLOW}\w ${GREEN}]\n└ >>${RESET} "


#      .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.     .-.      #
# `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.'   `._.' #


#  88888b.  888d888 .d88b.   .d88b.  .d8888b  
#  888 "88b 888P"  d88""88b d88P"88b 88K      
#  888  888 888    888  888 888  888 "Y8888b. 
#  888 d88P 888    Y88..88P Y88b 888      X88 
#  88888P"  888     "Y88P"   "Y88888  88888P' 
#  888                           888          
#  888                      Y8b d88P          
#  888                       "Y88P"     

# Habilitar o fzf
eval "$(fzf --bash)"
