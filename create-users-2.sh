#! /bin/bash
#
# Created by Marcus Whitaker
# Date: May 17, 2018

# Downloading CSV and creating G Suite accounts with the following attributes: Account Name, Password, First Name, Last Name, Manager, OU, Office Location, Job Title, and Department
echo "Downloading CSV and creating G Suite accounts..."
gam csv /Volumes/GoogleDrive/My\ Drive/IT\ Ops\ Repo/Onboarding/new-hire.csv gam create user "~accountName" password "~password" changepassword on firstname "~firstName" lastname "~lastName" relation manager "~manager" organization location "~location" title "~jobTitle" department "~function" primary org "Employees"

#Waiting for user creation to finsh
echo "."
echo "."
echo "."
echo "."
echo "Waiting for user creation to finsh..."
wait

#Add newly created users to Google Groups based on job Title

echo "."
echo "."
echo "."
echo "."
echo "Adding newly created users to email groups..."

while read line; do
  accountName=$(echo "$line" | awk -F"," '{print $4}')
  team=$(echo "$line" | awk -F"," '{print $7}')
  location=$(echo "$line" | awk -F"," '{print $1}')

  if [[ "$accountName" != "accountName" ]]; then
            echo "Adding $accountName to Terminators Group...";
            gam update group "Terminators" add member user "$accountName"
  fi

  if [[ "$team" == "Account Executive" ]]; then
          echo "Adding $accountName to Account Executive Group..."
          gam update group "AE" add member user "$accountName" gam update group "Sales Team" add member user "$accountName"
  fi

  if [[ "$team" == "SDR" ]]; then
          echo "Adding $accountName to SDR and Sales Team Groups..."
          gam update group "SDR" add member user "$accountName" gam update group "Sales Team" add member user "$accountName"
  fi

  if [[ "$team" == "CSM" ]]; then
          echo "Adding $accountName to Customer Success amd Ops Team Groups..."
          gam update group "Customer Success" add member user "$accountName" gam update group "Ops Team" add member user "$accountName"
  fi

  if [[ "$team" == "Marketing" ]]; then
          echo "Adding $accountName to Marketing Group..."
          gam update group "Marketing" add member user "$accountName"
  fi

  if [[ "$team" == "Engineering" ]]; then
          echo "Adding $accountName to Engineering and Dev Groups..."
          gam update group "Engineering" add member user "$accountName" gam update group "Dev" add member user "$accountName"
  fi

  if [[ "$team" == "AdOps" ]]; then
          echo "Adding $accountName to AdOps Group..."
          gam update group "AdOps" add member user "$accountName"
  fi

  if [[ "$team" == "Operations" ]]; then
          echo "Adding $accountName to Special Ops Group..."
          gam update group "SpecialOps" add member user "$accountName"
  fi

  if [[ "$location" == "Atlanta" ]]; then
          echo "Adding $accountName to Atlanta Terminators Group"
          gam update group "AtlTerminators" add member user "$accountName"
  fi

  if [[ "$location" == "San Francisco" ]]; then
          echo "Adding $accountName to San Francisco Terminators Group"
          gam update group "SFTerminators" add member user "$accountName"
  fi

  if [[ "$team" == "Support" ]]; then
          echo "Adding $accountName to Customer Success and Support Groups"
          gam update group "Customer Success" add member user "$accountName" gam update group "Support" add member user "$accountName"
  fi



done < /Volumes/GoogleDrive/My\ Drive/IT\ Ops\ Repo/Onboarding/new-hire.csv

echo "G Suite user creation has finished"
