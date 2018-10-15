cd ~
cd /Library/Desktop\ Pictures
curl -O <URL to image>
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Library/Desktop Pictures/<name of image>"'
