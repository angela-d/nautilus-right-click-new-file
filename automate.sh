#!/bin/bash

if [ -f Templates.tar.gz ];
then
	# extract the dummy files
	echo "Extracting files..."
	tar -xvzf Templates.tar.gz

	# if .config/user-dirs.dirs does not exist, create it and append config settings to tell nautilus about our templates and
	# create the custom Templates directory in the home folder, if it does not exist
	if [[ ! -f ~/.config/user-dirs.dirs ]];
		then
			xdg-user-dirs-update
			echo "Config file created..."
		else
			# this config already exists; append the entry
			source ~/.config/user-dirs.dirs
			customPath=$XDG_TEMPLATES_DIR
			echo "Your Templates path for your language is" $customPath
				
				# check if the custom path already exits
				if [ -d "$customPath" ];
				then
					# directory exists; merge
					echo "Custom path already exists. Merging files..."
					mv Templates/* $customPath
					rm -rf Templates
				else
					# directory doesn't exit; creating and moving files
					mkdir $customPath
					mv Templates/* $customPath
					rm -rf Templates
					echo "Created custom Templates folder and added files."
				fi
	fi
else
	echo -e "\nTemplates.tar.gz not found.\nPlease ensure you have the compressed tarball from: https://github.com/angela-d/nautilus-right-click-new-file in the same directory as this script.\nExiting."
	exit 0
fi

echo "Context menu options created..."

# restart nautilus and put it into the background
nautilus -q && nautilus &
echo -e "\nInstallation complete! You should now have context menu options for new files."
