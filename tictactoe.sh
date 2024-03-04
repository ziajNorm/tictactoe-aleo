#!/bin/bash

# Function to print the board
print_board() {
    echo " ${board[0]} | ${board[1]} | ${board[2]}"
    echo "---+---+---"
    echo " ${board[3]} | ${board[4]} | ${board[5]}"
    echo "---+---+---"
    echo " ${board[6]} | ${board[7]} | ${board[8]}"
}

# Function to check if there's a winner
check_winner() {
    for i in 0 3 6; do
        if [ "${board[i]}" == "$1" ] && [ "${board[i+1]}" == "$1" ] && [ "${board[i+2]}" == "$1" ]; then
            return 0
        fi
    done
    for i in 0 1 2; do
        if [ "${board[i]}" == "$1" ] && [ "${board[i+3]}" == "$1" ] && [ "${board[i+6]}" == "$1" ]; then
            return 0
        fi
    done
    if [ "${board[0]}" == "$1" ] && [ "${board[4]}" == "$1" ] && [ "${board[8]}" == "$1" ]; then
        return 0
    fi
    if [ "${board[2]}" == "$1" ] && [ "${board[4]}" == "$1" ] && [ "${board[6]}" == "$1" ]; then
        return 0
    fi
    return 1
}

# Initialize the board
board=(1 2 3 4 5 6 7 8 9)

# Main game loop
player="X"
turns=0
while true; do
    clear
    print_board
    echo "Player $player's turn. Enter your move (1-9):"
    read move

    # Check if the move is valid
    if ! [[ "$move" =~ ^[1-9]$ ]]; then
        echo "Invalid move. Please enter a number from 1 to 9."
        sleep 1
        continue
    fi
    index=$((move - 1))
    if [ "${board[index]}" == "X" ] || [ "${board[index]}" == "O" ]; then
        echo "That position is already taken. Please choose another."
        sleep 1
        continue
    fi

    # Update the board
    board[index]=$player

    # Check for a winner
    if check_winner "$player"; then
        clear
        print_board
        echo "Player $player wins!"
        break
    fi

    # Check for a draw
    ((turns++))
    if [ $turns -eq 9 ]; then
        clear
        print_board
        echo "It's a draw!"
        break
    fi

    # Switch players
    if [ "$player" == "X" ]; then
        player="O"
    else
        player="X"
    fi
done

