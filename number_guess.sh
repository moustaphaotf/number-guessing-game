#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
# echo -e "\n~~Number Guessing Game~~\n"

echo -e "Enter your username:"
read USERNAME

# # if not input
# if [[ -z $USERNAME ]]
# then
#   echo -e "You should enter your username !"
#   exit
# fi

# look for user
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username ILIKE '$USERNAME'")
# if user do not exist exist
if [[ -z $USER_ID ]]
then  
  # # insert user
  # INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  # # get new user id
  # USER_ID=$($PSQL "SELECT user_id FROM users WHERE username ILIKE '$USERNAME'")
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
else
  GAMES_INFOS=$($PSQL "SELECT COUNT(*) games_played, MIN(guesses) best_game FROM games WHERE  user_id=$USER_ID GROUP BY user_id")
  IFS="|" read -r GAMES_PLAYED BEST_GAME <<< $GAMES_INFOS
  echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  # echo -e "Welcome back, $USERNAME! You have played $TOTAL_GAMES games, and your best game took $BEST_GAME guesses."
fi

# go for the game
# get random number
NUMBER_GUESS=$(($RANDOM%1000+1))
# echo -e "Guess the secret number between 1 and 1000:"
echo -e "Guess the secret number between 1 and 1000:"
read USER_INPUT
GUESSES=1
while [[ $NUMBER_GUESS -ne $USER_INPUT ]]
do
  if [[ ! $USER_INPUT =~ ^[0-9]+$ ]]
  then
    echo -e "That is not an integer, guess again:"
  elif [[ $NUMBER_GUESS -lt $USER_INPUT ]]
  then
    echo -e "It's lower than that, guess again:"
  else
    echo -e "It's higher than that, guess again:"
  fi
  read USER_INPUT
  GUESSES=$((GUESSES+1))
done

echo -e "You guessed it in $GUESSES tries. The secret number was $NUMBER_GUESS. Nice job!"
