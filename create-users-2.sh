#! /bin/bash
#
# Create G Suite Users and add to Google Groups based on Function
# Created by Marcus Whitaker
# Date: May 17, 2018
# Notes:
# 1. This script uses GAM (Google Apps Manager CLI) to connect with G Suite. Please ensure you have this installed before using this script.
#    * visit https://github.com/jay0lee/GAM/wiki for documentation on GAM
# 2. This script has a log function built into it. You can designate the desired location of this log to your choosing.

# Setting script to fail if you’re trying to reference a variable that hasn’t been set.
set -u
# Setting script to exit immediately if a command fails.
set -e
# Setting pipeline to fail if any of the commands in the pipeline failed.
set -o pipefail

##Setting log information
function logAction {
    logTime=$(date "+%Y-%m-%d - %H:%M:%S:")
    echo "$logTime" "$1" >> /<path to log>/`date '+%m-%d-%Y'`-onboard-gsuite-users.log
}

#Establishing what time the script was ran for visibility purposes.
     SCRIPT_RUN_TIME=`date '+%m-%d-%Y %H:%M:%S'`
     printf -- "This script was initiated at $SCRIPT_RUN_TIME"
     
#Logging time onboard-gsuite-users.sh was initiated
logAction "onboard-suite-users script initiated."
echo "."
echo "."
echo "."

# Downloading CSV and creating G Suite accounts with the following attributes: Account Name, Password, First Name, Last Name, Manager, OU, Office Location, Job Title, and Department
    printf -- "Downloading CSV and creating G Suite accounts..."
    gam csv <path to CSV> gam create user "~accountName" password "~password" changepassword on firstname "~firstName" lastname "~lastName" relation manager "~manager" organization location "~location" title "~jobTitle" department "~function" primary org "<specify desired OU" 

#Waiting for user creation to finsh
echo "."
echo "."
echo "."
    printf -- "Waiting for user creation to finsh..."
wait
    printf -- "G Suite account creation finished at `date '+%m-%d-%Y %H:%M:%S'`"

#Logging time that G Suite Account creation finished for users specified in CSV
logAction "G Suite user creation completed for users specified in imported CSV"
echo "."
echo "."
echo "."

#Add newly created users to Google Groups based on job Title
    echo "Adding newly created users to email groups..."

#Parsing CSV to add new users to Google Groups based on job funtion and office location
while read line; do
  accountName=$(echo "$line" | awk -F"," '{print $4}')
  team=$(echo "$line" | awk -F"," '{print $7}')
  location=$(echo "$line" | awk -F"," '{print $1}')

  if [[ "$accountName" != "accountName" ]]; then
          printf "Adding $accountName to All Employees Group...";
          gam update group "All Employees" add member user "$accountName"
          logAction "$accountName added to All Employees group"
  fi

  if [[ "$team" == "Account Executive" ]]; then
          printf "Adding $accountName to Account Executive Groups..."
          gam update group "AE" add member user "$accountName" gam update group "Sales Team" add member user "$accountName"
          logAction "$accountName added to Account Executive group"
 fi

  if [[ "$location" == "Atlanta" ]]; then
          printf "Adding $accountName to Atlanta Employees Group"
          gam update group "Atlanta Employees" add member user "$accountName"
          logAction "$accountName added to Atlanta Employees group"
 fi

    printf -- "Finished adding new users to Google Groups"

#logging time users were finished being added to Google Groups
logAction "Finished added new users specified in CSV to Google Groups"
echo "."
echo "."
echo "."

done < <path to CSV>

    printf -- "G Suite employee onboarding has finished at `date '+%m-%d-%Y %H:%M:%S'`"
logAction "onboard-gsuite-users.sh has completed."

#
#
#End of script
