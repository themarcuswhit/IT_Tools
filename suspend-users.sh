#!/bin/bash
#
# Name: suspend-users.sh
# Purpose: Suspend users in G Suite
# Created by Marcus Whitaker
# Date: May 24, 2018


# Setting script to fail if you’re trying to reference a variable that hasn’t been set.
set -u
# Setting script to exit immediately if a command fails.
set -e
# Setting pipeline to fail if any of the commands in the pipeline failed.
set -o pipefail

#Setting log information

function logAction {
    logTime=$(date "+%Y-%m-%d - %H:%M:%S:")
    echo "$logTime" "$1" >> /Volumes/GoogleDrive/My\ Drive/IT\ Ops\ Repo/Offboarding/Offboarding\ Log/`date '+%m-%d-%Y'`-suspend-users.log
}

#Setting time script was ran at for audit purposes
  SCRIPT_RUN_TIME=`date '+%m-%d-%Y %H:%M:%S'`
  printf -- "\033[37m offboard-gsuite-users.sh began at \033[101m $SCRIPT_RUN_TIME \033[0m\n"
  logAction "Offboarding script initiated."
  echo "."
  echo "."
  echo "."
  echo "."

  #Retrieving username of account that needs to be suspended
    printf -- "\033[4m Enter in the username of the account you are suspending \033[0m\n:"
    read USERNAME
    logAction "Offboarding Employee: $USERNAME"

  #Retrieving username of hiring manager for suspended employee
    printf -- "\033[4m Enter in the Hiring Manager's username of the offboarding employee \033[0m\n:"
    read HIRING_MANAGER
    logAction "Hiring Manager: $HIRING_MANAGER"
    echo "."
    echo "."
    echo "."

    printf -- "\033[93m Suspending $USERNAME in G Suite ... \033[0m\n"
    gam update user $USERNAME suspended on
    wait
    printf -- "\033[32m Suspension completed at `date '+%m-%d-%Y %H:%M:%S'` \033[0m\n"
    logAction "$USERNAME suspended"
    echo "."
    echo "."
    echo "."

  wait

    printf -- "\033[93m Deleting groups $USERNAME is a member of... \033[0m\n"
    gam user $USERNAME delete groups
    wait
    printf "\033[32m Groups removed at `date '+%m-%d-%Y %H:%M:%S'` \033[0m\n"
    logAction "Google Groups removed from $USERNAME"
    echo "."
    echo "."
    echo "."

  wait

    printf -- "\033[93m Transferring $USERNAME's Google Drive data to $HIRING_MANAGER... \033[0m\n"
    gam create datatransfer $USERNAME gdrive $HIRING_MANAGER privacy_level shared,private
    wait
    printf -- "\033[32m Google Drive transfer request completed at `date '+%m-%d-%Y %H:%M:%S'` \033[0m\n"
    logAction "$USERNAME's Google Drive data transferred to $HIRING_MANAGER"
    echo "."
    echo "."
    echo "."

  wait

    printf -- "\033[93m Transferring $USERNAME's Google Calendar data to $HIRING_MANAGER... \033[0m\n"
    gam create datatransfer $USERNAME calendar $HIRING_MANAGER release_resources true
    wait
    printf -- "\033[32m Google Calendar transfer request completed at `date '+%m-%d-%Y %H:%M:%S'` \033[0m\n"
    logAction "$USERNAME's calendar transferred to $HIRING_MANAGER"
    echo "."
    echo "."
    echo "."

  wait

    printf -- "\033[32m Offboarding process has completed for $USERNAME at `date '+%m-%d-%Y %H:%M:%S'` \033[0m\n"
    logAction "Offboarding Script finished"
