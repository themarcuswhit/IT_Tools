#!/bin/bash
#
# Name: offboard-gsuite-users.sh
# Purpose: Suspend users in G Suite, remove from groups, transfer G Drive to Hiring Manager, transfer Calendar to Hiring Manager, 
# Created by Marcus Whitaker
# Date: May 24, 2018
# Notes: 
# 1. This script uses GAM (Google Apps Manager CLI) to connect with G Suite. Please ensure you have this installed before using this script.
#    * visit https://github.com/jay0lee/GAM/wiki for documentation on GAM 
# 2. This script has a log function built into it. You can designate the desired location of this log to your choosing.
# 3. There are formatted texts in this script. Review below for format codes:
# \033[101m = red background 
# \033[37m  = light grey 
# \033[4m   = underlined 
# \033[93m  = yellow
# \033[32m  = dark green text
# To change these colors, visit https://misc.flogisoft.com/bash/tip_colors_and_formatting to view other formatting codes


# Setting script to fail if you’re trying to reference a variable that hasn’t been set.
set -u
# Setting script to exit immediately if a command fails.
set -e
# Setting pipeline to fail if any of the commands in the pipeline failed.
set -o pipefail

#Setting log information

function logAction {
    logTime=$(date "+%Y-%m-%d - %H:%M:%S:")
    echo "$logTime" "$1" >> /<path to log>/`date '+%m-%d-%Y'`-offboard-gsuite-users.log
}

#Setting time script was ran at for audit purposes
  SCRIPT_RUN_TIME=`date '+%m-%d-%Y %H:%M:%S'`
        printf -- "\033[37m offboard-gsuite-users.sh began at \033[101m $SCRIPT_RUN_TIME \033[0m\n"

#Logging time script was started
  logAction "Offboarding script initiated."
  printf "."
  printf "."
  printf "."
  printf "."

#Setting variable of the account that needs to be suspended
        printf -- "\033[4m Enter in the username of the account you are suspending \033[0m\n:"
        read USERNAME
        
#Logging username entered for suspension
    logAction "Offboarding Employee: $USERNAME"

#Setting variable for the username of the hiring manager for suspended employee
        printf -- "\033[4m Enter in the Hiring Manager's username of the offboarding employee \033[0m\n:"
        read HIRING_MANAGER
        
 #Logging hiring manager entered for offboarding employee
    logAction "Hiring Manager: $HIRING_MANAGER"
    printf "."
    printf "."
    printf "."

#Suspending user specified in $USERNAME variable in G Suite and moving to Suspended Accounts OU
        printf -- "\033[93m Suspending $USERNAME in G Suite ... \033[0m\n"
        gam update user $USERNAME suspended on org Suspended/ Accounts
    wait
        printf -- "\033[32m Suspension completed at `date '+%m-%d-%Y %H:%M:%S'` \033[0m\n"
        
#Logging time suspension completed
    logAction "$USERNAME suspended"
    printf "."
    printf "."
    printf "."

    wait

#Deleting groups of account specified in $USERNAME variable is a member of in G Suite
        printf -- "\033[93m Deleting groups $USERNAME is a member of... \033[0m\n"
        gam user $USERNAME delete groups
    wait
        printf "\033[32m Groups removed at `date '+%m-%d-%Y %H:%M:%S'` \033[0m\n"
   
#Logging time groups were removed from suspended user
    logAction "Google Groups removed from $USERNAME"
    printf "."
    printf "."
    printf "."

    wait

#Transferring all G Drive data from suspended user to their Hiring Manager
        printf -- "\033[93m Transferring $USERNAME's Google Drive data to $HIRING_MANAGER... \033[0m\n"
        gam create datatransfer $USERNAME gdrive $HIRING_MANAGER privacy_level shared,private
    wait
        printf -- "\033[32m Google Drive transfer request completed at `date '+%m-%d-%Y %H:%M:%S'` \033[0m\n"
     
 #Logging time G Drive data transfer was submitted
    logAction "$USERNAME's Google Drive data transferred to $HIRING_MANAGER"
    printf "."
    printf "."
    printf "."

  wait

#Transferring all calendar data from suspended user to their Hiring Manager
        printf -- "\033[93m Transferring $USERNAME's Google Calendar data to $HIRING_MANAGER... \033[0m\n"
        gam create datatransfer $USERNAME calendar $HIRING_MANAGER release_resources true
    wait
        printf -- "\033[32m Google Calendar transfer request completed at `date '+%m-%d-%Y %H:%M:%S'` \033[0m\n"
    
#Logging time Calendar data transfer was submitted
    logAction "$USERNAME's calendar transferred to $HIRING_MANAGER"
    printf "."
    printf "."
    printf "."

  wait

        printf -- "\033[32m Offboarding process has completed for $USERNAME at `date '+%m-%d-%Y %H:%M:%S'` \033[0m\n"
#Logging time offboard-gsuite-users.sh finished
   logAction "Offboarding Script finished"
   
#
#
#End of script
