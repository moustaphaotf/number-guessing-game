#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
echo -e "\n~~Number Guessing Game~~\n"

echo -e "\nEnter your username:"
read USERNAME

# if not input
if [[ -z $USERNAME ]]
then
  echo -e "You should enter your username !"
  exit
fi

# look for user
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username ILIKE '$USERNAME'")
# if user do not exist exist
if [[ -z $USER_ID ]]
then  
  # insert user
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  # get new user id
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username ILIKE '$USERNAME'")
fi

# get user games info
GAMES_INFOS=$($PSQL "SELECT COUNT(*) total_games, MIN(guesses) best_game FROM games WHERE user_id=$USER_ID GROUP BY user_id")
if [[ -z $GAME_INFOS ]]
then
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
else
  echo $GAMES_INFOS | read TOTAL_GAMES BEST_GAME
  echo -e "\nWelcome back, $USERNAME! You have played $TOTAL_GAMES games, and your best game took $BEST_GAME guesses."
fi

# go for the game