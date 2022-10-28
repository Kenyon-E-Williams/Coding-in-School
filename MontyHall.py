#!/usr/bin/env python
# coding: utf-8

# In[36]:


import random
import math
import numpy as np
import matplotlib.pyplot as plt

#While True
def monty_hall(num_doors):
   doors = np.zeros(num_doors) 
# Initializing an array depending on the number of total doors (parameter)
   num_car = random.randrange(num_doors) 
# Creates a random integer that will be used as the index for the correct door
   doors[num_car] = 1 
# Sets the prize door to 1, every other index will have a 0
  
   user_door = int(input('Which door will you pick? Must be an integer between 1 and ' + str(num_doors)+'\n'))-1 
# Asks the user to enter a number for the door, adjusts because arrays start at index 0
   while user_door not in range(num_doors): 
# Adjustment for incorrect input
     user_door = int(input('Invalid input, try again\n'))-1
    
   other_door = 0 
# This code block initializes a random door based off if the first guess was correct, this door will be used as the possible switch
   if user_door == num_car:
     while other_door == user_door:
       other_door = random.randrange(num_doors)
   else:
     other_door = num_car
  
   switch = input('We will change the problem now, every door has no prize except for either your door ('+str(user_door+1)+') or door '+str(other_door+1)+ ', will you switch doors? Enter y or n\n')
   while switch != 'y' and switch != 'n': 
# Adjustment for incorrect input
     switch = input('Invalid input, try again\n')
   if switch == 'y':
     user_door = other_door 
# Makes door switch depending on input answer
  
   if user_door == num_car: 
# Prints the result of whether you won or not
     print('Congrats, you won the prize')
   else:
     print('Sorry, you lost')
 
def monty_hall_test(num_doors): 
# This function is slightly modified from the above one, it is used to test if the statistics end up being right
   doors = np.zeros(num_doors)
   num_car = random.randrange(num_doors)
   doors[num_car] = 1
   user_door = 0
   other_door = 0
   if user_door == num_car:
     while other_door == user_door:
       other_door = random.randrange(num_doors)
   else:
     other_door = num_car
   switch = 'y'
   if switch == 'y':
     user_door = other_door
  
   if user_door == num_car:
     return 1
   else:
     return -1
def monty_plot(num_successes,num_failures):
    num_successes = 0
    num_failures = 0
    num_tries=0
for i in range(1000000):
 if monty_hall_test(3) > 0:
   num_successes += 1  
 else:
   num_failures += 1 
#plotting the success rates and the failure rates 
plt.bar(num_successes/1000000,num_failures/1000000)


print('Failure percentage:', num_failures / (num_successes+num_failures)) 
# Should output something close to .333
print('Success percentage:', num_successes / (num_successes+num_failures)) 
# Should output something close to .666

    


# In[ ]:




