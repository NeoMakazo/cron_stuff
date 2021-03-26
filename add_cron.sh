#!/bin/bash

# make $tmpfile
tmpfile=$(mktemp)
#create directory to store the scripts
mkdir /home/$USER/.scripts
cd /home/$USER/.scripts
#ensure git is installed, and install if not
if git --version ; then
	git clone https://github.com/NeoMakazo/cron_stuff.git
else
	echo "git is not installed. Proceed?"
	select yn in "yes" "no"; do
		case $yn in
			Yes ) sudo apt-get install git; break;;
			no ) exit;;
		esac
	done
# change directories to the repo
cd cron_stuff
#cron stuff
crontab -l > $tmpfile
chmod +x *
echo "@daily cd /home/$USER/.scripts/cron_stuff && sh auto-cron.sh" >> $tmpfile
crontab $tmpfile
rm $tmpfile
