#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
BBLUE='\033[1;44m'
RESET='\033[0m'

menu() {
echo
echo -e "${BBLUE}=======Special Number Calculator=======${RESET}"
echo
echo "Generate primes.                  --(1)"
echo "Generate perfect numbers.         --(2)"
echo "Find prime factors of a number.   --(3)"
echo "Check if a number is prime.       --(4)"
echo "Check if a number is perfect.     --(5)"
echo "Find all factors a number.        --(6)"
echo "Start a calculation shell.        --(7)"
echo "Exit the program.                 --(8)"
echo
echo -n "Enter a option to continue: "
read ANSWER



if [[ "$ANSWER" = "1" ]]; then
read_input_prime
prime_generate_save $n
elif [[ "$ANSWER" = "2" ]]; then
read_input_perfect
perfect_generate_save $count
elif [[ "$ANSWER" = "3" ]]; then
read_input
prime_factorize $n
elif [[ "$ANSWER" = "4" ]]; then
read_input
check_prime $n
elif [[ "$ANSWER" = "5" ]]; then
read_input
check_perfect $n
elif [[ "$ANSWER" = "6" ]]; then
read_input
factor_all $n
elif [[ "$ANSWER" = "7" ]]; then
number_shell
elif [[ "$ANSWER" = "8" ]]; then
echo -e "${YELLOW}Exiting now...${RESET}"
else
echo -e "${RED}Invalid response! Exiting now...${RESET}"
fi


}

read_input_prime() {

echo "Enter the number of primes you wish to calculate:"
read n

while [[ ! $n =~ ^[1-9][0-9]*$ ]]; do
    echo -e "${RED}Invalid input, positive integer only!${RESET}"
    echo "Enter the number of primes you wish to calculate:"
    read n
done



}

read_input() {

echo "Enter your number:"
read n

while [[ ! $n =~ ^[1-9][0-9]*$ ]]; do
    echo -e "${RED}Invalid input, positive integer only!${RESET}"
    echo "Enter your number:"
    read n
done



}

read_input_perfect() {

echo -e "${YELLOW}Note: Please do not try numbers larger than 8 unless you wish to wait a couple of years for the result.${RESET}"
echo "Enter the number of perfect numbers you wish to calculate:"
read count

while [[ ! $count =~ ^[1-9][0-9]*$ ]]; do
    echo -e "${RED}Invalid input, positive integer only!${RESET}"
    echo "Enter the number of perfect numbers you wish to calculate:"
    read count
done

}




prime_generate_save() {


COUNT=$1
start=$EPOCHREALTIME

primes=(2)
count=1

num=3

echo -e "${YELLOW}Calculating primes...${RESET}"

while (( count < COUNT )); do
    is_prime=1
    limit=$(( num / 2 ))
    
    for p in "${primes[@]}"; do
        if (( p * p > num )); then
            break
        fi
        if (( num % p == 0 )); then
            is_prime=0
            break
        fi
    done

    if (( is_prime )); then
        primes+=("$num")
        ((count++))
    fi


    ((num+=2))
done

end=$EPOCHREALTIME
elapsed=$(printf "%.6f" "$(echo "$end - $start" | bc)")
speed=$(echo "scale=5; ${COUNT} / ${elapsed}" | bc)

printf "%s\n" "${primes[@]}"

echo -e "Elapsed: ${GREEN}${elapsed} seconds${RESET}"
echo -e "Speed: ${GREEN}${speed} calculations per second${RESET}"
echo -e "Primes calculated: ${GREEN}${COUNT}${RESET}"
echo
echo "Save output?(y/n)"
read ANSWER
[[ "$ANSWER" = "y" ]] && touch prime.txt && printf "%s\n" "${primes[@]}" > prime.txt && echo -e "${GREEN}Output saved to prime.txt${RESET}"


}



prime_generate() {


COUNT=$1
start=$EPOCHREALTIME

primes=(2)
count=1

num=3

echo -e "${YELLOW}Calculating primes...${RESET}"

while (( count < COUNT )); do
    is_prime=1
    limit=$(( num / 2 ))
    
    for p in "${primes[@]}"; do
        if (( p * p > num )); then
            break
        fi
        if (( num % p == 0 )); then
            is_prime=0
            break
        fi
    done

    if (( is_prime )); then
        primes+=("$num")
        ((count++))
    fi


    ((num+=2))
done

end=$EPOCHREALTIME
elapsed=$(printf "%.6f" "$(echo "$end - $start" | bc)")
speed=$(echo "scale=5; ${COUNT} / ${elapsed}" | bc)

printf "%s\n" "${primes[@]}"

echo -e "Elapsed: ${GREEN}${elapsed} seconds${RESET}"
echo -e "Speed: ${GREEN}${speed} calculations per second${RESET}"
echo -e "Primes calculated: ${GREEN}${COUNT}${RESET}"
echo


}

prime_factorize() {

n=$1

echo -n "Prime factors of $n: "

num=$n
factor=2

while [ $num -gt 1 ]; do
    while [ $((num % factor)) -eq 0 ]; do
        echo -n "$factor "
        num=$((num / factor))
    done
    factor=$((factor + 1))
done

echo

}

perfect_generate_save() {


is_prime() {
    n=$1
    if [ "$n" -le 1 ]; then
        return 1
    fi
    for ((i=2; i*i<=n; i++)); do
        if (( n % i == 0 )); then
            return 1
        fi
    done
    return 0
}



count=$1

echo -e "${YELLOW}Calculating perfect numbers...${RESET}"
start=$EPOCHREALTIME

perfect_numbers=()
p=2

while [ ${#perfect_numbers[@]} -lt $count ]; do
    mersenne=$(echo "2^$p - 1" | bc)
    if is_prime $mersenne; then
        perfect=$(echo "2^($p-1) * ($mersenne)" | bc)
        perfect_numbers+=("$perfect")
        echo "Perfect number #${#perfect_numbers[@]}: $perfect"
    fi
    p=$((p + 1))
done

end=$EPOCHREALTIME
elapsed=$(printf "%.6f" "$(echo "$end - $start" | bc)")
speed=$(echo "scale=5; ${count} / ${elapsed}" | bc)


echo -e "Elapsed: ${GREEN}${elapsed} seconds${RESET}"
echo -e "Speed: ${GREEN}${speed} calculations per second${RESET}"
echo -e "Perfect numbers calculated: ${GREEN}${count}${RESET}"
echo
echo "Save output?(y/n)"
read ANSWER
[[ "$ANSWER" = "y" ]] && touch perfect.txt && printf "%s\n" "${perfect_numbers[@]}" > perfect.txt && echo -e "${GREEN}Output saved to perfect.txt${RESET}"

}



perfect_generate() {

is_prime() {
    n=$1
    if [ "$n" -le 1 ]; then
        return 1
    fi
    for ((i=2; i*i<=n; i++)); do
        if (( n % i == 0 )); then
            return 1
        fi
    done
    return 0
}



count=$1

echo -e "${YELLOW}Calculating perfect numbers...${RESET}"
start=$EPOCHREALTIME

perfect_numbers=()
p=2

while [ ${#perfect_numbers[@]} -lt $count ]; do
    mersenne=$(echo "2^$p - 1" | bc)
    if is_prime $mersenne; then
        perfect=$(echo "2^($p-1) * ($mersenne)" | bc)
        perfect_numbers+=("$perfect")
        echo "Perfect number #${#perfect_numbers[@]}: $perfect"
    fi
    p=$((p + 1))
done

end=$EPOCHREALTIME
elapsed=$(printf "%.6f" "$(echo "$end - $start" | bc)")
speed=$(echo "scale=5; ${count} / ${elapsed}" | bc)

echo -e "Elapsed: ${GREEN}${elapsed} seconds${RESET}"
echo -e "Speed: ${GREEN}${speed} calculations per second${RESET}"
echo -e "Perfect numbers calculated: ${GREEN}${count}${RESET}"
echo

}

check_prime() {

prm=''
n=$1

if [[ $(factor "$n") == "$n:"* && $(factor "$n") == *" $n" ]]; then
    echo -e "${GREEN}$n is prime.${RESET}"
else
    echo -e "${RED}$n is not prime.${RESET}"
fi

}

check_perfect() {


n=$1

if (( n < 2 )); then
    echo "${RED}$n is not a perfect number.${RESET}"
    exit
fi

sum=0

for (( i=1; i<=n/2; i++ )); do
    if (( n % i == 0 )); then
        (( sum += i ))
    fi
done


if (( sum == n )); then
    echo -e "${GREEN}$n is a perfect number.${RESET}"
else
    echo -e "${RED}$n is not a perfect number.${RESET}"
fi

}

factor_all() {

n=$1


echo "Factors of $n:"
factors=$(
for (( i=1; i*i<=n; i++ )); do
  if (( n % i == 0 )); then
    echo "$i"
    if (( i != n/i )); then
      echo $(( n/i ))
    fi
  fi
done | sort -n

)
if [[ "$n" == "1" ]]; then
    echo "1"
else
    echo "$factors"
fi

}

number_shell() {
echo "${YELLOW}This shell is still in developement, some features may not work perfectly or may not work at all.${RESET}"
echo 'Interactive number shell, type "h" to view command usage, type "q" to quit.'

user=$(whoami)
prompt="${GREEN}${user}@number_shell${RESET}> "

declare -a HISTORY=()
history_index=0

while true; do
    COMMAND=""
    history_index=${#HISTORY[@]}

    echo -ne "$prompt"

    while true; do
        IFS= read -rsn1 key

        if [[ $key == "" ]]; then
            echo
            break
        fi

        if [[ $key == $'\e' ]]; then
            read -rsn2 key2
            key+="$key2"

            case "$key" in
                $'\e[A')
                    if (( history_index > 0 )); then
                        ((history_index--))
                        COMMAND="${HISTORY[$history_index]}"
                    fi
                    ;;
                $'\e[B')
                    if (( history_index < ${#HISTORY[@]}-1 )); then
                        ((history_index++))
                        COMMAND="${HISTORY[$history_index]}"
                    else
                        history_index=${#HISTORY[@]}
                        COMMAND=""
                    fi
                    ;;
            esac

            echo -ne "\r\033[K$prompt$COMMAND"
            continue
        fi

        if [[ $key == $'\x7f' ]]; then
            COMMAND="${COMMAND%?}"
            echo -ne "\r\033[K$prompt$COMMAND"
            continue
        fi

        COMMAND+="$key"
        echo -n "$key"
    done

    [[ "$COMMAND" == "q" ]] && break

    if [[ -n "$COMMAND" ]]; then
        HISTORY+=("$COMMAND")
    fi

    if [[ "$COMMAND" != "q" ]]; then
        ($COMMAND 2> /dev/null || echo -e "${RED}Invalid command!${RESET}")
    fi

done




}

h() {

echo -e "prime_generate     generates prime numbers
perfect_generate   generates perfect numbers
check_prime        checks if a number is prime
check_perfect      checks if a number is perfect
prime_factorize    finds all prime factors of a number
factor_all         finds all factors of a number
h                  displays this help panel
q                  closes the interactive shell

Provide a number as an argument after the command.
For example: ${BLUE}factor_all 60${RESET} finds all factors of 60.
"

}

menu
