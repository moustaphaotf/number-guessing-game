#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guessing_game -t --no-align -c"
echo -e "\n~~Number Guessing Game~~\n"

echo -e "\nEnter your username:"
read USERNAME

# if not input
if [[ -z $USERNAME ]]
  echo -e "\nYou should enter your username !"
  exit
fi

# look for user
# if user exist
# go for the game
# if not found
# insert user
# get new user name
# go for the game
