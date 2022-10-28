#!/usr/bin/env python
# coding: utf-8

# In[20]:


import numpy as np
import random

# Function that takes in an integer input to set the number of doors the player will play with
def set_doors():
    num_doors = -1
    while num_doors <= 1:
      try:
        num_doors = int(input('How many doors would you like to play with? Must be an integer greater than 1.\n'))
        if num_doors <= 1:
          print('Must be an integer greater than 1, try again')
        else:
          break
      except:
        print('Wrong type of input, must be a positive integer, try again')
        num_doors = -1
    return num_doors

# Class called game that holds variables and functions related to the game: like which door has the winner, number of losses and wins, multiple functions
class Game: 
  def __init__(self):
    self.num_doors = set_doors()
    self.stage = np.zeros(self.num_doors)
    self.choice = -1
    self.winner = random.randrange(self.num_doors)
    self.stage[self.winner] = 1
    self.losses = 0
    self.wins = 0
  
  def set_choice(self, num):
    self.choice = num

# Creates the other door offered in the game 
  def other_door(self):
    if self.choice == self.winner:
      other = -1
      while other == self.choice or other < 0:
        other = random.randrange(self.num_doors)
    else:
      other = self.winner
    return other

# Returns a boolean  
  def check_win(self): 
    if self.choice == self.winner:
      self.wins += 1
      return True
    else: 
      self.losses += 1
      return False

  def reset(self):
    self.stage = np.zeros(self.num_doors)
    self.choice = -1
    self.winner = random.randrange(self.num_doors)
    self.stage[self.winner] = 1
    stat = (self.wins/(self.wins+self.losses))*100
    print('Win percentage: '+str(stat)+'%')
    print('Loss percetange: '+str(100-stat)+'%')
    print()

def play_monty_hall(game):

# Input of door choice
  choice = -1
  while choice not in range(game.num_doors):
    try:
      choice = int(input('Which door will you pick? Must be an integer between 1 and ' + str(game.num_doors)+'\n'))-1
      if choice in range(game.num_doors):
        break
      else:
        print('Not an integer between 1 and ' + str(game.num_doors) + ', try again')
    except:
      print('Wrong type of input, try again')
      choice = -1
  print('You have chosen door ' + str(choice+1))
  print()

# Set the game class variable to what was inputted, utilizes other_door() function
  game.set_choice(choice)
  other = game.other_door()

# Input of door switch, yes or no
  print('We have opened every door that has a goat except yours and ' + str(other+1) + '. One of them has a car behind it.')
  print('You now have to decide whether or not to stick with your original door or switch to door ' + str(other+1) + '.')
  print('Would you like to switch? Enter \'yes\' or \'no\'')
  switch = input()
  while switch not in {'yes', 'no'}: 
    print('Invalid input, try again')
    print('Would you like to switch? Enter \'yes\' or \'no\'')
    switch = input(str())
  if switch == 'yes': 
    choice = other  
  game.set_choice(choice)

# Checks to see if the user wins or not
  print()
  print('Your final choice was door ' + str(choice+1) + '. Now let\'s see if you won.')
  if game.check_win():
    print('Congratulations, you won a car!')
  else:
    print('Sorry, your door was another goat. Better luck next time.')

# Asks the user if they would like to replay the game
  print()
  print('Would you like to play again? Enter \'yes\' or \'no\'')
  play_again = input()
  while play_again not in {'yes', 'no'}: 
    print('Invalid input, try again')
    print('Would you like to play again? Enter \'yes\' or \'no\'')
    play_again = input(str())
  game.reset()
  if play_again == 'yes':
    play_monty_hall(game)
  else:
    print('Thanks for playing!')
    return

game = Game()
play_monty_hall(game)


# In[ ]:




