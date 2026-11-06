#!/bin/bash

# =====================================
# This is meant to be a quick demonstration
# It is neither complicated nor is it long
# If you would like to test your skills try
#  - Using user input to use other directories
#  - Keeping track of files and make a log
# =====================================

# Directory to clean and sort as well as to send
SORT_DIR="$HOME/Downloads"
DEST_DIR="$HOME/Documents/sorted"
NUM_MV=0

# Loop through files and directories
for sorting in "$SORT_DIR"/*; do
	
	# Make sure there are files in the directory
	[ -e "$sorting" ] || continue

	# Basename is a function that removes directories from text to isolate the name
	# the reason for the outer and inner $
	# 	outer is for command substitution
	# 	it runs the command and stores the output
	name="$(basename "$sorting")"

	# get the extensions
	if [[ "$name" == *.* && "$name" != .*  ]] then
		# the ## basically says to delete the longest matching pattern
		# the pattern is specified to be "*." of the name
		ext="${name##*.}"
	else
		ext="ext_missing"
	fi

	# The -p makes the dirrectory if nothing is found (including parent directories)
	mkdir -p "$DEST_DIR/$ext"
	# The -n is to make sure files are not overwritten
	if mv -n "$sorting" "$DEST_DIR/$ext/"; then	
		(( ++NUM_MV  ))
	fi

done

echo "Finished cleaning "$SORT_DIR": Moved "$NUM_MV" items!"
