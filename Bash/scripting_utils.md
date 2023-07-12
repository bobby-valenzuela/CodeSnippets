 Bash Scripting Utils
----------------------

Contents:
1. [Permissions](#permissions)
2. [File Manipulation](#file-permissions)
3. [Numbers and Arithmetic](#numbers-and-arithmetic)
4. [Programs and Packages](#programs-and-packages)
5. [Printing and Formatting Output](#printing-and-formatting-output)
6. [Processes and Services](#processes-and-services)


#  Permissions

__Exit if not root or a sudoer__
```bash
{ [[ $(id -u) -eq 0 ]] || $(sudo -v &>/dev/null) ; } || { echo -e "Please run with sudo privileges.\nExiting..." ; exit 1 ; } 
```

<br />

# File Manipulation
__Rename files (Add '.sh' extension)__
```bash
find . -maxdepth 1 -type f -exec mv '{}' '{}.sh' \;
```

<br />

__Cut file in half - keep the latter half__
```bash
half_file(){
    LINE_COUNT=$(wc -l ${1} 2> /dev/null | cut -d " " -f1)
    LINE_COUNT_HALF=$((LINE_COUNT/2))
    [[ ${LINE_COUNT_HALF} -gt 0 ]] && sed -in "1,${LINE_COUNT_HALF}d" ${1}
}
```

<br />

# Numbers and Arithmetic

__Determine numeric parity (even/odd)__
```bash
even_or_odd()
{
    integertest='^[0-9]+$'
    [[ ! $1 =~ $integertest ]] && echo "Not an integer!" && return 1
    [[ $(( $1 % 2 )) == 0 ]] && echo "Even" || echo "Odd"
}
```

<br />


__Validate IP__
```bash
CNC_IP_SAVED=0

while [[ ${CNC_IP_SAVED} -ne 1 ]] 
do

    read -p "Enter CNC server IP: " CNC_IP
    [[ ${CNC_IP} =~ ([0-9]{1,3}\.){3}[0-9]{1,3} ]] && CNC_IP_SAVED=1
    
    # Can also do ip and port 0.0.0.0:8080
    # [[ ${CNC_IP} =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}\:[0-9]{1,4}$ ]] && CNC_IP_SAVED=1

done

echo "Saved: ${CNC_IP}"
```

<br />


# Programs and Packages

__Determine whether we're using netstat vs ss__
```bash
using_netstat=$({ netstat --version &> /dev/null && echo 1 ; } || echo 0)
```

<br />

# Printing and Formatting Output


___ANSI Escape Codes__
```
Black        0;30     Dark Gray     1;30
Red          0;31     Light Red     1;31
Green        0;32     Light Green   1;32
Brown/Orange 0;33     Yellow        1;33
Blue         0;34     Light Blue    1;34
Purple       0;35     Light Purple  1;35
Cyan         0;36     Light Cyan    1;36
Light Gray   0;37     White         1;37
```

<br />

__Get count of characters wide the terminal is__
```bash
COLUMNS=$(tput cols)
```

<br />

__Printing Headers__
```bash
prHeader(){

    for each in $(seq 1 $COLUMNS)
    do
        echo -n $1
    done
}

prHeaderLeftHalf(){
    for each in $(seq 1 $(($COLUMNS/2)))
    do
          echo -n $1
    done
    echo
}

prHeaderLeftThird(){
    for each in $(seq 1 $(($COLUMNS/3)))
    do
          echo -n $1
    done
    echo
}

prHeaderLeftQuarter(){
    for each in $(seq 1 $(($COLUMNS/4)))
    do
          echo -n $1
    done
    echo
}

prtxtCentre(){

    title=$1
    printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"

}
```

<br />

__print colored text__
```bash
print_colored()
{

    [[ -z "$1" ||  -z "$2" ]] && echo "Usage: print_colored <color> <text>" && exit 1
    
    auto_print_newline=''
    [[ "$3" == 'no' ]] && auto_print_newline='-n' 

    case "$1" in
        "grey" | "GREY")        echo -e ${auto_print_newline} "\033[90m$2 \033[00m" ;;
        "red" | "RED")          echo -e ${auto_print_newline} "\033[91m$2 \033[00m" ;;
        "green" | "GREEN")      echo -e ${auto_print_newline} "\033[92m$2 \033[00m" ;;
        "yellow" | "YELLOW")    echo -e ${auto_print_newline} "\033[93m$2 \033[00m" ;;
        "blue" | "BLUE")        echo -e ${auto_print_newline} "\033[94m$2 \033[00m" ;;
        "purple" | "PURPLE")    echo -e ${auto_print_newline} "\033[95m$2 \033[00m" ;;
        "cyan" | "CYAN")        echo -e ${auto_print_newline} "\033[96m$2 \033[00m" ;;
        "white" | "WHITE")      echo -e ${auto_print_newline} "\033[96m$2 \033[00m" ;;
        *   )               echo -e ${auto_print_newline} "\033[96m$2 \033[00m" ;;
    esac


}

# Examples
print_colored 'red' 'my message'
print_colored 'red' 'my message\n\n' 'no'
```

<br />

# Processes and Services

__Check if a service/process is already running - if not start it up (checks every 60s)__
```bash
while :
do

    # Check if already running
    already_running=$(ps aux | grep 'HiveAPI/index.pl' | awk '/perl/{ print $11 }' | xargs)

    # Start if not already running
    { [[ "${already_running,,}" =~ perl ]] && echo "Hive API Running" ; } || { echo "Not running. Starting Up...." && $(which perl) /home/control-io/www/HiveAPI/inde$
    sleep 60
done
```
