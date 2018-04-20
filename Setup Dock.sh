#!/bin/bash

#######################################
# Script Name: Set Dock for New Users #                             #
# Created by Marcus Whitaker          #
# January 22, 2017                    #
#                                     #
#######################################

#Creating directory for Setup Dock Script
cd ~
mkdir SetupDock
cd SetupDock
#Downloading script from Amazon S3
curl -O https://s3.amazonaws.com/service-desk-utilities/dockutil-2.0.5.pkg
#Installing dockutil pkg
installer -pkg ./dockutil-2.0.5.pkg -target /
#
#
# Removing dafault applications from dock
#
dockutil --remove all --no-restart
#
# Adding Kabbage applications to dock
#
# Adding 'Mail' to dock
dockutil --add /Applications/Mail.app --no-restart
# Adding 'Contacts' to dock
dockutil --add /Applications/Contacts.app --no-restart
# Adding 'Calendar' to dock
dockutil --add /Applications/Calendar.app --no-restart
# Adding 'Notes' to dock
dockutil --add /Applications/Notes.app --no-restart
# Adding 'Reminders' to dock
dockutil --add /Applications/Reminders.app --no-restart
# Adding 'Google Chrome' to dock
dockutil --add /Applications/Google\ Chrome.app --no-restart
# Adding 'HipChat' to dock
dockutil --add /Applications/HipChat.app --no-restart
# Adding 'Outlook' to dock
dockutil --add /Applications/Microsoft\ Outlook.app --no-restart
# Adding 'Excel' to dock
dockutil --add /Applications/Microsoft\ Excel.app --no-restart
# Adding 'Word' to dock
dockutil --add /Applications/Microsoft\ Word.app --no-restart
# Adding 'Powerpoint' to dock
dockutil --add /Applications/Microsoft\ PowerPoint.app --no-restart
# Adding 'FortiClient' to dock
dockutil --add /Applications/FortiClient.app --no-restart
# Adding 'Cisco Proximity' to dock
dockutil --add /Applications/Cisco\ Proximity.app --no-restart
# Adding 'Self Service' to dock
dockutil --add /Applications/Self\ Service.app 
# Adding 'Downloads" to dock
Dockutil --add ~/Downloads --section others --allhomes
#
# Script End
