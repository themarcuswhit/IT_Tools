#!/bin/bash
#Created by: Marcus Whitaker
#Date: April 16, 2018


#Set variables for the city and asset tag tumber
echo "Setting variables for computer name..."

CITY=`/usr/bin/osascript <<'EOT'
set theCityChoices to {"atl", "sf", "nyc", "den", "blr"}
set theCity to choose from list theCityChoices with prompt "Select the city this computer will be in:" default items {"atl"}
theCity                                                  
EOT`

ASSET_NUMBER=`/usr/bin/osascript <<'EOT'
tell application "System Events"
activate
set ASSET_NUMBER to text returned of (display dialog "Please input the asset number for this computer" default answer "" with icon 2)
end tell
EOT`


COMPUTER_NAME=${CITY}-${ASSET_NUMBER}-osx

#Renaming computer
echo "Renaming Computer..."

sudo scutil --set HostName $COMPUTER_NAME
sudo scutil --set LocalHostName $COMPUTER_NAME
sudo scutil --set ComputerName $COMPUTER_NAME

echo "You have renamed this computer to $COMPUTER_NAME ..."

#Bind computer to Kabbage domain
echo "Binding computer to Kabbage domain"
sudo adjoin --enableAppleIDGenScheme --workstation --user <user here> --password <password here>  <domain name>
