#/bin/bash

# create the Templates directory in the home folder, if it does not exist
if [ -f Templates.tar.gz ];
then
	# extract the dummy files
	echo "Extracting.."
	tar -xvzf Templates.tar.gz

	# check if ~/Templates already exists
	if [ ! -d ~/Templates ];
	then
		mv Templates ~/Templates
		echo -e "\nTemplates directory created.."
	else
		# directory exists; merge, instad
		rsync -a Templates/ ~/Templates/
		rm -rf Templates
	fi

else
	echo -e "\nTemplates.tar.gz not found.\nPlease ensure you have the compressed tarball from: https://github.com/z0m8i3/nautilus-right-click-new-file in the same directory as this script.\nExiting."
	exit 0
fi
echo "Context menu options created.."

# if .config/user-dirs.dirs does not exist, create it and append config settings to tell nautilus about our templates
if [[ ! -f ~/.config/user-dirs.dirs ]];
	then
		xdg-user-dirs-update
		echo "Config file created.."
	else

		# this config already exists; append the entry
		source ~/.config/user-dirs.dirs
		if [[ $XDG_TEMPLATES_DIR = "$HOME/Templates" ]]
		then
			echo "Configuration already exists; skipping.."
		fi

fi

# restart nautilus and put it into the background
nautilus -q && nautilus &
echo -e "\nInstallation complete!  You should now have context menu options for new files."
