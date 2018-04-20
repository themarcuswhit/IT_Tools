cd ~
cd /Library/Desktop\ Pictures
curl -O https://s3.amazonaws.com/service-desk-utilities/Steve_jobs_UX_quote.jpg
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Library/Desktop Pictures/Steve_jobs_UX_quote.jpg"'
