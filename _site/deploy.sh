#!/bin/bash

echo " "
read -e -p 'Enter commit: ' -i "$message" message
echo " " 
echo "Sending changes to remote.." 
echo " "
git add .
git commit -m "$message"
git push -u origin main
echo "  "
echo "Building site... "
echo " "
hugo
echo " "
echo "Pushing public.. "
echo " "
cd public
git add .
git commit -m "$message"
git push origin main
echo " "
echo "All Done ;) "
