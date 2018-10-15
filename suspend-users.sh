#!/bin/bash
#
# Name: suspend-users.sh
# Purpose: Suspend users in G Suite
# Created by Marcus Whitaker
# Date: May 24, 2018


#Setting log information

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1><path to log directory>`date '+%m-%d-%Y_%H:%M:%S'`-suspend-users.log 2>&1

SCRIPT_RUN_TIME=`date '+%m-%d-%Y %H:%M:%S'`
echo "This script was ran on $SCRIPT_RUN_TIME"
echo "."
echo "."
echo "."
echo "."

  echo "Enter in the name of the account you are suspending"
  read USERNAME
  echo $USERNAME

  echo "Enter in the Hiring Manager's name of the offboarding employee"
  read HIRING_MANAGER
  echo $HIRING_MANAGER

  echo "Suspending $USERNAME in G Suite ..."
  gam update user $USERNAME suspended on
  wait
  echo "Suspension completed at `date '+%m-%d-%Y %H:%M:%S'`"
  echo "."
  echo "."
  echo "."

wait

  echo "Deleting groups $USERNAME is a member of..."
  gam user $USERNAME delete groups
  wait
  echo "Groups removed at `date '+%m-%d-%Y %H:%M:%S'`"
  echo "."
  echo "."
  echo "."

wait

  echo "Transferring $USERNAME's Google Drive data to $HIRING_MANAGER (ran at `date '+%m-%d-%Y %H:%M:%S'`)"
  gam create datatransfer $USERNAME gdrive $HIRING_MANAGER privacy_level shared,private
  wait
  echo "Google Drive transfer request completed at `date '+%m-%d-%Y %H:%M:%S'`"
  echo "."
  echo "."
  echo "."

wait

  echo "Transferring $USERNAME's Google Calendar data to $HIRING_MANAGER..."
  gam create datatransfer $USERNAME calendar $HIRING_MANAGER release_resources true
  wait
  echo "Google Calendar transfer request completed at `date '+%m-%d-%Y %H:%M:%S'`"
  echo "."
  echo "."
  echo "."

wait

  echo "Offboarding process has completed for $USERNAME at `date '+%m-%d-%Y %H:%M:%S'`"
